module PCS_modules
  #(
	parameter                            LEN_CODED_BLOCK = 66,            //HABRIA QUE TENER PARAMETROS PARA DATA y CTRL y no dividirlos en TX/RX
    parameter                            LEN_DATA_BLOCK  = 64,
    parameter                            LEN_CTRL_BLOCK  = 8,
    parameter                            LEN_TYPE        = 4,
    parameter                            SEED            = 58'd0
    )
	(
	input wire                           i_clock,
    input wire                           i_reset,

 	/*--------------------ENCODER INPUTS & OUTPUTS-------------------*/
 	input wire                           i_enable_encoder,               //bit to enable encoder and encoder_fsm
 	input wire    [LEN_DATA_BLOCK-1 : 0] i_tx_data,
 	input wire    [LEN_CTRL_BLOCK-1 : 0] i_tx_ctrl,
 	
    /*-------------------SCRAMBLER INPUTS & OUTPUTS------------------*/
    input wire                           i_enable_scrambler,
    input wire                           i_bypass,              

    /*-----------------DESCRAMBLER INPUTS & OUTPUTS------------------*/
    input wire                           i_enable_descrambler,         

    /*--------------------DECODER INPUTS & OUTPUTS-------------------*/
    input wire                           i_enable_decoder,
    output wire   [LEN_DATA_BLOCK-1 : 0] o_rx_raw_data,
    output wire   [LEN_CTRL_BLOCK-1 : 0] o_rx_raw_ctrl
    );



//REGISTROS Y WIRES SETEADOS LOCALMENTE
wire            [LEN_TYPE-1 : 0]          o_tx_type;
wire            [LEN_CODED_BLOCK-1 : 0]   o_tx_coded;
wire            [LEN_CODED_BLOCK-1 : 0]   o_fsm_tx_coded;
wire            [LEN_CODED_BLOCK-1 : 0]   o_scrambled_data;
wire            [LEN_CODED_BLOCK-1 : 0]   o_descrambled_data;
wire            [LEN_DATA_BLOCK-1 : 0]    o_rx_data;
wire            [LEN_CTRL_BLOCK-1 : 0]    o_rx_ctrl;
wire            [LEN_TYPE-1 : 0]          o_rx_type;
wire            [LEN_TYPE-1 : 0]          o_rx_type_fsm;
wire            [LEN_TYPE-1 : 0]          o_rx_typenext_fsm;


encoder_comparator#(
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK),
    .LEN_DATA_BLOCK(LEN_DATA_BLOCK),
    .LEN_CTRL_BLOCK(LEN_CTRL_BLOCK)
    )
u_encoder_comparator
    (
    .i_clock    (i_clock)         ,
    .i_reset    (i_reset)         ,
    .i_tx_data  (i_tx_data)       ,
    .i_tx_ctrl  (i_tx_ctrl)       ,
    .i_enable   (i_enable_encoder),
    .o_tx_type  (o_tx_type)       ,
    .o_tx_coded (o_tx_coded)
    );

encoder_fsm#(
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK)
    )
u_encoder_fsm
    (
    .i_clock   (i_clock)         ,
    .i_reset   (i_reset)         ,
    .i_enable  (i_enable_encoder),
    .i_tx_type (o_tx_type)       ,
    .i_tx_coded(o_tx_coded)      ,
    .o_tx_coded(o_fsm_tx_coded)
    );

scrambler#(
    .SEED(SEED)
    )
u_scrambler
    (
    .i_clock (i_clock)           ,
    .i_reset (i_reset)           ,
    .i_enable(i_enable_scrambler),
    .i_bypass(i_bypass)          ,
    .i_data  (o_fsm_tx_coded)    ,
    .o_data  (o_scrambled_data)
    );

descrambler#(
    .SEED(SEED) 
    )
u_descrambler
    (
    .i_clock (i_clock)           ,
    .i_reset (i_reset)           ,
    .i_enable(i_enable_descrambler),
    .i_bypass(i_bypass)          ,
    .i_data  (o_scrambled_data)  ,
    .o_data  (o_descrambled_data)
    );

decoder_comparator#(
    .LEN_CTRL_BLOCK(LEN_CTRL_BLOCK)  ,
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK),
    .LEN_DATA_BLOCK(LEN_DATA_BLOCK)
    )
u_decoder_comparator
    (
    .i_clock    (i_clock)           ,
    .i_reset    (i_reset)           ,
    .i_enable   (i_enable_decoder)  ,
    .i_rx_coded (o_descrambled_data),
    .o_rx_data  (o_rx_data)         ,
    .o_rx_ctrl  (o_rx_ctrl)         ,  
    .o_rx_type  (o_rx_type)
    );

decoder_fsm_interface#(
    .LEN_TYPE(LEN_TYPE)
    )
u_decoder_fsm_interface
    (
    .i_clock        (i_clock)          ,
    .i_reset        (i_reset)          ,
    .i_enable       (i_enable_decoder) ,
    .i_r_type       (o_rx_type)        ,
    .o_r_type       (o_rx_type_fsm)    ,
    .o_r_type_next  (o_rx_typenext_fsm) 
    );
    
decoder_fsm#(
    .LEN_DATA_BLOCK(LEN_DATA_BLOCK),
    .LEN_CTRL_BLOCK(LEN_CTRL_BLOCK)
    )
u_decoder_fsm
    (
    .i_clock          (i_clock)          ,
    .i_reset          (i_reset)          ,
    .i_enable         (i_enable_decoder) ,
    .i_r_type         (o_rx_type_fsm)    ,
    .i_r_type_next    (o_rx_typenext_fsm),
    .i_rx_data        (o_rx_data)        ,
    .i_rx_control     (o_rx_ctrl)        ,
    .o_rx_raw_data    (o_rx_raw_data)    ,
    .o_rx_raw_control (o_rx_raw_ctrl)
    );

endmodule

