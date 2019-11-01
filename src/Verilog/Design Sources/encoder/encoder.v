`timescale 1ns/100ps


module encoder
#(
    parameter   NB_DATA_CODED = 66,
    parameter   NB_DATA_RAW   = 64,
    parameter   NB_CTRL_RAW   = 8
)
(
    input wire      i_clock,
    input wire      i_reset,
    input wire      i_enable,
    input wire      i_valid,
    input wire   [NB_DATA_RAW-1 : 0]    i_data,
    input wire      [NB_CTRL_RAW-1 : 0] i_ctrl,
    
    output wire [NB_DATA_CODED-1 : 0]  o_tx_coded
);

    localparam  N_DATA_TYPES    = 4;

    //connection wires between comparator and fsm
    wire        [N_DATA_TYPES-1 : 0]    comparator_type_fsm;
    wire        [NB_DATA_CODED-1 : 0]   comparator_data_fsm;        

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
    .o_tx_coded(o_tx_coded)
);

endmodule