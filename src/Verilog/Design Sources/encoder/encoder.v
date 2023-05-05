`timescale 1ns/100ps


module encoder
#(
    parameter   NB_DATA_CODED = 66,
    parameter   NB_DATA_RAW   = 64,
    parameter   NB_CTRL_RAW   = 8
)
(
    input wire                              i_clock,
    input wire                              i_reset,
    input wire                              i_enable,
    input wire                              i_valid,
    input wire      [NB_DATA_RAW-1 : 0]     i_data,
    input wire      [NB_CTRL_RAW-1 : 0]     i_ctrl,
    input wire                              i_rf_broke_data_sh,
    
    output wire     [NB_DATA_CODED-1 : 0]   o_tx_coded,
    output wire                             o_valid
);

    localparam  N_DATA_TYPES    = 4;

    //connection wires between comparator and fsm
    wire        [N_DATA_TYPES-1 : 0]        comparator_type_fsm;
    wire        [NB_DATA_CODED-1 : 0]       comparator_data_fsm;

    //regs to solve timing issues
    wire        [NB_DATA_CODED-1 : 0]       tx_coded;
    reg         [NB_DATA_CODED-1 : 0]       tx_coded_data_d;
    reg         [NB_DATA_CODED-1 : 0]       tx_coded_data_2d;
    wire                                    tx_coded_valid;
    reg                                     tx_coded_valid_d;
    reg                                     tx_coded_valid_2d;

    //data output registring
    always @(posedge i_clock) begin
        if(i_reset) begin
            tx_coded_data_d     <= {NB_DATA_CODED{1'b0}};
            tx_coded_data_2d    <= {NB_DATA_CODED{1'b0}};
        end
        if(i_valid) begin
            tx_coded_data_d     <= tx_coded;
            tx_coded_data_2d    <= tx_coded_data_d;
        end
        else begin
            tx_coded_data_d     <= tx_coded_data_d;
            tx_coded_data_2d    <= tx_coded_data_2d;
        end
    end

    //valid output registring
    always @(posedge i_clock) begin
        if(i_reset) begin
            tx_coded_valid_d    <= 1'b0;
            tx_coded_valid_2d   <= 1'b0;
        end
        if(i_valid) begin
            tx_coded_valid_d    <= tx_coded_valid;
            tx_coded_valid_2d   <= tx_coded_valid_d;
        end
        else begin
            tx_coded_valid_d    <= tx_coded_valid_d;
            tx_coded_valid_2d   <= tx_coded_valid_2d;
        end
    end

//encoder modules
encoder_comparator
#(
    .NB_DATA_CODED(NB_DATA_CODED)   ,
    .NB_DATA_RAW(NB_DATA_RAW)     ,
    .NB_CTRL_RAW(NB_CTRL_RAW)
)
u_encoder_comparator
(
    .i_clock    (i_clock)               ,
    .i_reset    (i_reset)               ,
    .i_enable   (i_enable)              ,
    .i_valid    (i_valid)               ,
    .i_tx_data  (i_data)                ,
    .i_tx_ctrl  (i_ctrl)                ,
    .i_rf_broke_data_sh(i_rf_broke_data_sh),
    .o_tx_type  (comparator_type_fsm)   ,
    .o_tx_coded (comparator_data_fsm)
);

encoder_fsm
#(
    .NB_DATA_CODED(NB_DATA_CODED)
)
u_encoder_fsm
(
    .i_clock   (i_clock)                ,
    .i_reset   (i_reset)                ,
    .i_enable  (i_enable)               ,
    .i_valid   (i_valid)                ,
    .i_tx_type (comparator_type_fsm)    ,
    .i_tx_coded(comparator_data_fsm)    ,
    .o_tx_coded(tx_coded)               ,
    .o_valid   (tx_coded_valid)
);

//outputs
assign o_tx_coded   = tx_coded_data_2d;
assign o_valid      = tx_coded_valid_2d;

endmodule