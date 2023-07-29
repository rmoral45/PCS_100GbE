`timescale 1ns/100ps


/*
        Cada AM_BLOCK_PERIOD se debe realizr la insercion de un alineador en cada lane, como todavia el flujo de datos
        es unico(no se distribuyo ne la LANES) esto implica que cada AM_BLOCK_PERIOD*N_LANES se debe generar el espacio
        para insertar tantos alineadores como lanes tengamos, y a su vez se debe compensar dicha insercion eliminando 
        bloques idle cuando estos lleguen desde la MII.
        Cuando genero el lugar para los alineadores, lo que hago es insertar bloques idle junto con un 'tag' el cual
        le indica al scrambler que debe hacer bypass de estos datos (para no modificar su estado) y al bloque de
        insercion de alineadores le indica que debe reemplazar dicho bloque con el alineador correspondiente.
        Por lo tanto, cuando estoy insertando idles taggeados debo escribir los datos recibidos de la MII en la
        fifo, pero no debo leer ningun dato de esta, osea read_enable = 0. Cuando elimino idles para compensar debo
        leer datos de la fifo pero no escribir los idles recibidos desde la MII, es decir write_enable = 0.

*/

module clock_comp_tx
#(
        parameter                               NB_DATA_CODED           = 66,
        parameter                               N_LANES                 = 20,
        parameter                               AM_BLOCK_PERIOD         = 16383
        
 )
 (
        input  wire                             i_clock,
        input  wire                             i_reset,
        input  wire                             i_enable,
        input  wire                             i_valid,
        input  wire [NB_DATA_CODED-1 : 0]       i_data,
      
        output wire [NB_DATA_CODED-1 : 0]       o_data,
        output wire                             o_aligner_tag,
        output wire                             o_valid
 );

localparam                                      NB_ADDR                 = 5;
localparam                                      NB_PERIOD_CNT           = $clog2(AM_BLOCK_PERIOD*N_LANES)+1;
localparam                                      NB_IDLE_CNT             = $clog2(N_LANES);
localparam          [NB_DATA_CODED-1 : 0]       PCS_IDLE                = 'h2_78_00_00_00_00_00_00_00;
localparam                                      WR_PTR_AFTER_RST        = 1;
localparam                                      NB_AM_ENCODING          = 24;

//------------ Internal Signals -----------------//

reg [NB_PERIOD_CNT-1 : 0]       period_counter;
reg [NB_IDLE_CNT-1  : 0]        am_counter;
wire                            am_count_done;
reg [NB_IDLE_CNT-1 : 0]         idle_counter;

wire                            idle_detected;
wire                            idle_count_full;
wire                            period_done;
wire                            idle_insert;
wire                            fifo_read_enable;
wire                            fifo_write_enable;
wire [NB_DATA_CODED-1 : 0]      fifo_output_data;
wire                            fifo_empty;
reg                             valid_d;

//LANE_MARKERS'S MATRIX
localparam [(NB_AM_ENCODING*N_LANES)-1 : 0] AM_ENCODING_LOW    = { 24'h83_16_84, 
                                                                   24'hB9_8E_71, 
                                                                   24'h9A_D2_17, 
                                                                   24'hB2_A9_DE, 
                                                                   24'hAF_E0_90,
                                                                   24'hBB_28_43, 
                                                                   24'h59_52_64, 
                                                                   24'hDE_A2_66, 
                                                                   24'h05_24_6E, 
                                                                   24'h16_93_DF,
                                                                   24'hBF_36_99, 
                                                                   24'h9D_89_AA, 
                                                                   24'h3A_9D_4D, 
                                                                   24'h58_1F_BD, 
                                                                   24'hC1_E3_53,
                                                                   24'hAC_6C_B3, 
                                                                   24'h23_8C_32, 
                                                                   24'hB5_6B_ED, 
                                                                   24'hFA_66_54, 
                                                                   24'h03_0F_A7}; 
localparam [(NB_AM_ENCODING*N_LANES)-1 : 0] AM_ENCODING_HIGH    = {~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-1 -: NB_AM_ENCODING],
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(1*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(2*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(3*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(4*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(5*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(6*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(7*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(8*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(9*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(10*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(11*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(12*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(13*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(14*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(15*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(16*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(17*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(18*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(19*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]}; 

//----------- Algorithm ------------------------//
always @ (posedge i_clock)
begin
    if(i_reset)
        valid_d <= 1'b0;
    else
        valid_d <= i_valid;     
end

always @ (posedge i_clock)
begin
        if (i_reset || am_count_done)
                am_counter = {NB_IDLE_CNT{1'b0}};
        else if (i_enable && i_valid && idle_insert)
                am_counter <= am_counter + 1'b1;
end

assign am_count_done = (am_counter == (N_LANES-1));

always @ (posedge i_clock)
begin
        if (i_reset || period_done)
                period_counter = {NB_PERIOD_CNT{1'b0}};
        else if (i_enable && i_valid)
                period_counter <= period_counter + 1'b1;
end

assign period_done = (period_counter == ((AM_BLOCK_PERIOD*N_LANES) - 1)) ? 1'b1 : 1'b0;


always @ (posedge i_clock)
begin
        if (i_reset || period_done)
                idle_counter = {NB_IDLE_CNT{1'b0}};
        else if (i_enable && i_valid && idle_detected && !idle_count_full)
                idle_counter <= idle_counter + 1'b1;
end

assign idle_detected       = (i_data == PCS_IDLE)        ? 1'b1 : 1'b0;
assign idle_count_full     = ((idle_counter >= N_LANES)) ? 1'b1 : 1'b0;
assign idle_insert         = (period_counter < N_LANES)  ? 1'b1 : 1'b0; 

//Fifo enables

assign fifo_read_enable  = (period_counter < N_LANES)           ? 1'b0 : 1'b1 ;                                               
assign fifo_write_enable = ((idle_detected && !idle_count_full) || i_reset) ? 1'b0 : 1'b1 ; 


//-------- Ports -------------------------------//
assign o_data           = (idle_insert) ? {2'b10,AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-1 - am_counter*NB_AM_ENCODING -: NB_AM_ENCODING],
                                           8'h00,AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-1 - am_counter*NB_AM_ENCODING -: NB_AM_ENCODING],8'h00} 
                                           : fifo_output_data;
assign o_aligner_tag    = (idle_insert) ? 1'b1     : 1'b0;
assign o_valid          = i_valid;

//------- Instances ---------------------------//

sync_fifo
        #(
                .NB_DATA(NB_DATA_CODED),
                .NB_ADDR(NB_ADDR),
                .WR_PTR_AFTER_RESET(WR_PTR_AFTER_RST)
         )
         u_sync_fifo
         (
                .i_clock        (i_clock),
                .i_reset        (i_reset),
                .i_enable       (i_enable),
                .i_valid        (i_valid),
                .i_write_enb    (fifo_write_enable),
                .i_read_enb     (fifo_read_enable),
                .i_data         (i_data),
                
                .o_empty        (fifo_empty),
                .o_data         (fifo_output_data)
         );

endmodule
