/*
	Top level de los modulos del transmisor.
*/

module tx_modules
	#(
    parameter                           NMODULES        = 2,
	parameter 							LEN_CODED_BLOCK	= 66,
	parameter							LEN_DATA_BLOCK	= 64,
	parameter							LEN_CTRL_BLOCK	= 8,
	parameter							LEN_TYPE		= 4,
	parameter							SEED			= 58'd0
	)
	(
	input      							i_clock,
	input      							i_reset,
	input      	[LEN_DATA_BLOCK-1 : 0]	i_tx_data,
	input  	    [LEN_CTRL_BLOCK-1 : 0]	i_tx_ctrl,
	input      	[NMODULES-1 : 0]       	i_enable,
	output wire	[LEN_CODED_BLOCK-1 : 0]	o_scrambled_data
	);

    localparam                          ENCODER_ENB     = 0;
    localparam                          SCRAMBLER_ENB   = 1;

	wire		[LEN_TYPE-1 : 0]		o_tx_type;
	wire		[LEN_CODED_BLOCK-1 : 0]	o_tx_coded;
	wire		[LEN_CODED_BLOCK-1 : 0] o_fsm_tx_coded;
	wire                                bypass;
    
    assign                              bypass = 1'b0;


encoder_comparator
	#(
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK),
    .LEN_DATA_BLOCK(LEN_DATA_BLOCK),
    .LEN_CTRL_BLOCK(LEN_CTRL_BLOCK)
    )
u_encoder_comparator
    (
    .i_clock    (i_clock)               ,
    .i_reset    (i_reset)               ,
    .i_tx_data  (i_tx_data)             ,
    .i_tx_ctrl  (i_tx_ctrl)             ,
    .i_enable   (i_enable[ENCODER_ENB]) ,
    .o_tx_type  (o_tx_type)             ,
    .o_tx_coded (o_tx_coded)
    );

encoder_fsm
	#(
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK)
    )
u_encoder_fsm
    (
    .i_clock   (i_clock)                ,
    .i_reset   (i_reset)                ,
    .i_enable  (i_enable[ENCODER_ENB])  ,
    .i_tx_type (o_tx_type)              ,
    .i_tx_coded(o_tx_coded)             ,
    .o_tx_coded(o_fsm_tx_coded)
    );

scrambler
	#(
    .SEED(SEED)
    )
u_scrambler
    (
    .i_clock (i_clock)                  ,
    .i_reset (i_reset)                  ,
    .i_enable(i_enable[SCRAMBLER_ENB])  ,
    .i_bypass(bypass)                   ,
    .i_data  (o_fsm_tx_coded)           ,
    .o_data  (o_scrambled_data)
    );

endmodule
