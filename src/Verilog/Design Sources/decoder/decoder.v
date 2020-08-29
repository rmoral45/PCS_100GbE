`timescale 1ns/100ps

module decoder
#(
    parameter                                   NB_DATA_CODED   = 66,
    parameter                                   NB_DATA_RAW     = 64,
    parameter                                   NB_CTRL_BLOCK   = 8,
    parameter                                   NB_BLOCK_TYPE   = 4  
)
(
    input   wire                                i_clock,
    input   wire                                i_reset,
    input   wire                                i_enable,
    input   wire    [NB_DATA_CODED-1    :   0]  i_data,

    output  wire    [NB_DATA_RAW-1      :   0]  o_data,
    output  wire    [NB_DATA_RAW-1      :   0]  o_ctrl,
    output  wire    [NB_BLOCK_TYPE-1    :   0]  o_fsm_control
);

//-----------------  module connect wires  ------------------//
//decoder_comparator --> decoder_fsm_interface
    wire            [NB_BLOCK_TYPE-1    :   0]  comparator_type_fsminterface;
//decoder_comparator --> decoder_fsm
    wire            [NB_DATA_RAW-1      :   0]  comparator_data_fsm;
    wire            [NB_CTRL_BLOCK-1    :   0]  comparator_ctrl_fsm;
//decoder_fsm_interface --> decoder_fsm
    wire            [NB_BLOCK_TYPE-1    :   0]  fsminterface_type_fsm;
    wire            [NB_BLOCK_TYPE-1    :   0]  fsminterface_type_next_fsm;
//decoder_fsm --> rx_toplevel
    wire            [NB_DATA_RAW-1      :   0]  decoderfsm_data_rxtoplevel;
    wire            [NB_DATA_RAW-1      :   0]  decoderfsm_ctrl_rxtoplevel;
//decoder_fsm --> clock_comp_rx
    wire            [NB_BLOCK_TYPE-1    :   0]  decoderfsm_type_clockcomp;
    

decoder_comparator
u_decoder_comparator
(
    .i_clock            (i_clock),
    .i_reset            (i_reset),
    .i_enable           (i_enable),
    .i_rx_coded         (i_data),

    .o_rx_data          (comparator_data_fsm),
    .o_rx_ctrl          (comparator_ctrl_fsm),
    .o_rx_type          (comparator_type_fsminterface)
);

decoder_fsm_interface
u_decoder_fsm_interface
(
    .i_clock            (i_clock),
    .i_reset            (i_reset),
    .i_enable           (i_enable),
    .i_r_type           (comparator_type_fsminterface),
    
    .o_r_type           (fsminterface_type_fsm),
    .o_r_type_next      (fsminterface_type_next_fsm)
);

decoder_fsm
u_decoder_fsm
(
    .i_clock            (i_clock),
    .i_reset            (i_reset),
    .i_enable           (i_enable),
    .i_r_type           (fsminterface_type_fsm),
    .i_r_type_next      (fsminterface_type_next_fsm),
    .i_rx_data          (comparator_data_fsm),
    .i_rx_control       (comparator_ctrl_fsm),

    .o_rx_raw_data      (decoderfsm_data_rxtoplevel),
    .o_rx_raw_control   (decoderfsm_ctrl_rxtoplevel),
    .o_fsm_state        (decoderfsm_type_clockcomp)
);

    assign              o_data          = decoderfsm_data_rxtoplevel;
    assign              o_ctrl          = decoderfsm_ctrl_rxtoplevel;
    assign              o_fsm_control   = decoderfsm_type_clockcomp;
endmodule