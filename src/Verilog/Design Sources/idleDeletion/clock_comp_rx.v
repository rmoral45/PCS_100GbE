`timescale 1ns/100ps
/*
        Each lanes recibes an aligner marker every AM_BLOCK_PERIOD, this must be bypassed by the scrambler and deleted in
        order to avoid breaking the normal data flow.In this stage we have already reorder each lane into a single one, therefore
        we will receive an amount of N_LANES aligner markers every AM_BLOCK_PERIOD*N_LANES.
        We detect aligner markers by checking the sol_tag signals which is asserted by previous stages when aligner markers are detected.
        To delete this aligner markers we simply dont write them into the fifo, but to compensate for this deletion we must
        insert the same amount of idle blocks, but this can only be done if the receiver fsm is waiting to receive control blocks
        (i.e RX_C state) otherwise it will enter into error state (i.e RX_E state).
*/

module clock_comp_rx
#(
        parameter                               NB_DATA_CODED       = 66,
        parameter                               AM_BLOCK_PERIOD     = 16383, //[CHECK]
        parameter                               N_LANES             = 20,
        parameter                               N_FSM_DECO_STATES   = 4
 )
 (
        input  wire                             i_clock,
        input  wire                             i_reset,
        input  wire                             i_rf_enable,
        input  wire                             i_valid,
        input  wire                             i_sol_tag,
        input  wire [NB_DATA_CODED-1 : 0]       i_data,

        output wire [NB_DATA_CODED-1 : 0]       o_data,
        output wire                             o_valid
 );

localparam                                      WR_PTR_AFTER_RST    = 1;                    
localparam                                      NB_ADDR             = 5;

localparam                                      NB_PERIOD_CNT       = $clog2(AM_BLOCK_PERIOD*N_LANES);
localparam                                      NB_IDLE_CNT         = $clog2(N_LANES); //se insertaran tantos idle como lineas se tengan
localparam [NB_DATA_CODED-1 : 0]                PCS_IDLE            = 'h2_1e_00_00_00_00_00_00_00;

//------------ Internal Signals -----------------//

reg         [NB_PERIOD_CNT-1 : 0]               period_counter;
reg         [NB_IDLE_CNT-1 : 0]                 idle_counter;

wire                                            period_done;
wire                                            idle_insert;
wire                                            fifo_read_enable;
wire                                            fifo_write_enable;
wire        [NB_DATA_CODED-1 : 0]               fifo_output_data;
wire                                            fifo_empty;
wire                                            idle_detected;

reg                                             trigger_insertion;


//----------- Algorithm ------------------------//

assign idle_detected = (fifo_output_data  ==  PCS_IDLE);

always @ (posedge i_clock)
begin
    if(i_reset || i_sol_tag || ~i_rf_enable)
    begin
        trigger_insertion <= 1'b0;
    end
    else if(idle_counter < N_LANES && idle_detected)
    begin
        trigger_insertion <= 1'b1;
    end
    else if (idle_counter >= N_LANES)
        trigger_insertion <= 1'b0;
end


always @ (posedge i_clock)
begin
        if (i_reset || i_sol_tag || ~i_rf_enable)
                period_counter = {NB_PERIOD_CNT{1'b0}};
        else if (i_valid)
                period_counter <= period_counter + 1'b1;
end

assign                                      period_done         = (period_counter == ((AM_BLOCK_PERIOD*N_LANES))) ? 1'b1 : 1'b0;


always @ (posedge i_clock)
begin
        if (i_reset || i_sol_tag || ~i_rf_enable)
                idle_counter = {NB_IDLE_CNT{1'b0}};
        else if (i_valid && idle_insert)
                idle_counter <= idle_counter + 1'b1;
end

assign                                     idle_insert         = ((idle_counter < N_LANES ) && ~i_sol_tag && trigger_insertion); //si fsm del receptor esta en el estado de
                                                                                                                            //control puedo insertar los idles necesarios


//Fifo enables

assign                                      fifo_read_enable    = ~idle_insert; // si estoy insertando idles no debo sacar datos de la fifo
assign                                      fifo_write_enable   = ~i_sol_tag | idle_insert  ; // elimino los idle con los cuales se "pisaron" los aligner markers


//-------- Ports -------------------------------//

assign                                      o_data              = (idle_insert) ? PCS_IDLE : fifo_output_data;
assign                                      o_valid             = i_valid;


//------- Instances ---------------------------//

    sync_fifo
    #(
        .NB_DATA      (NB_DATA_CODED),
        .NB_ADDR            (NB_ADDR),
        .WR_PTR_AFTER_RESET (WR_PTR_AFTER_RST)
    )
    u_sync_fifo
    (
        .i_clock            (i_clock),
        .i_reset            (i_reset),
        .i_enable           (i_rf_enable),
        .i_valid            (i_valid),
        .i_write_enb        (fifo_write_enable),
        .i_read_enb         (fifo_read_enable),
        .i_data             (i_data),
            
        .o_empty            (fifo_empty),
        .o_data             (fifo_output_data)
    );

endmodule
