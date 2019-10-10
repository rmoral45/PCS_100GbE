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
        parameter NB_DATA          = 66,
        parameter AM_BLOCK_PERIOD  = 16383, //[CHECK]
        parameter N_LANES          = 20
 )
 (
        input  wire                     i_clock,
        input  wire                     i_reset,
        input  wire                     i_enable,
        input  wire                     i_valid,
        input  wire [NB_DATA-1 : 0]     i_data,
      
        output wire [NB_DATA-1 : 0]     o_data,
        output wire                     o_aligner_tag
 );

localparam                      NB_ADDR       = 5;
localparam                      NB_PERIOD_CNT = $clog2(AM_BLOCK_PERIOD*N_LANES);
localparam                      NB_IDLE_CNT   = $clog2(N_LANES); //se insertaran tantos idle como lineas se tengan
localparam [NB_DATA-1 : 0]      PCS_IDLE      = 'h2_e0_00_00_00_00_00_00_00;

//------------ Internal Signals -----------------//

reg [NB_PERIOD_CNT-1 : 0]       period_counter;
reg [NB_IDLE_CNT-1 : 0]         idle_counter;

wire                            idle_detected;
wire                            idle_count_full;
wire                            period_done;
wire                            idle_insert;
wire                            fifo_read_enable;
wire                            fifo_write_enable;
wire [NB_DATA-1 : 0]            fifo_output_data;




//----------- Algorithm ------------------------//


always @ (posedge i_clock)
begin
        if (i_reset || period_done)
                period_counter = {NB_PERIOD_CNT{1'b0}};
        else if (i_enable && i_valid)
                period_counter <= period_counter + 1'b1;
end

assign period_done = (period_counter == ((AM_BLOCK_PERIOD*N_LANES)-1)) ? 1'b1 : 1'b0;


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

assign o_data           = (idle_insert) ? PCS_IDLE : fifo_output_data;
assign o_aligner_tag    = (idle_insert) ? 1'b1     : 1'b0; // si inserto idle le agrego el tag para que sea "pisado" con un alineador


//------- Instances ---------------------------//

sync_fifo
        #(
                .NB_DATA(NB_DATA),
                .NB_ADDR(NB_ADDR),
                .WR_PTR_AFTER_RESET('d1)
         )
         u_sync_fifo
         (
                .i_clock        (i_clock),
                .i_reset        (i_reset),
                .i_enable       (i_enable),
                .i_write_enb    (fifo_write_enable),
                .i_read_enb     (fifo_read_enable),
                .i_data         (i_data),
                
                .o_empty        (fifo_empty),
                .o_data         (fifo_output_data)
         );

endmodule
