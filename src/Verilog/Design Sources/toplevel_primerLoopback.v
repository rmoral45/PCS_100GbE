module toplevel_primerLoopback
	#(
	parameter							LEN_DATA_BLOCK 	= 64,
	parameter							LEN_CTRL_BLOCK 	= 8,
	parameter							LEN_CODED_BLOCK	= 66,
	parameter							TX_NMODULES		= 2,
	parameter							RX_NMODULES 	= 2
	)
	(
	input 								i_clock,
	input 								i_reset,
	input 								i_enable_frameGenerator,
	input 								i_enable_frameChecker,
	input		[TX_NMODULES-1 : 0]		i_enable_tx,
	input		[RX_NMODULES-1 : 0]		i_enable_rx,
	output wire	[LEN_DATA_BLOCK-1 : 0]	o_rx_raw_data,
	output wire	[LEN_CTRL_BLOCK-1 : 0]	o_rx_raw_ctrl	
	);

	wire		[LEN_DATA_BLOCK-1 : 0]	encoder_data_input;
	wire		[LEN_CTRL_BLOCK-1 : 0]	encoder_ctrl_input;
	wire		[LEN_CODED_BLOCK-1 : 0]	scrambled_data;
	wire								match_data;
	wire								match_ctrl;

top_level_frameGenerator
	#(
	.LEN_DATA_BLOCK(LEN_DATA_BLOCK),
	.LEN_CTRL_BLOCK(LEN_CTRL_BLOCK)
	)
u_top_level_frameGenerator
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(i_enable_frameGenerator),
	.o_tx_data(encoder_data_input),
	.o_tx_ctrl(encoder_ctrl_input)
	);

tx_modules
	#(
	)
u_tx_modules
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_tx_data(encoder_data_input),
	.i_tx_ctrl(encoder_ctrl_input),
	.i_enable(i_enable_tx),
	.o_scrambled_data(scrambled_data)
	);

rx_modules
	#(
	)
u_rx_modules
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(i_enable_rx),
	.i_scrambled_data(scrambled_data),
	.o_rx_raw_data(o_rx_raw_data),
	.o_rx_raw_ctrl(o_rx_raw_ctrl)
	);

frameChecker#(
	)
u_frameChecker
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(i_enable_frameChecker),
	.i_tx_data(encoder_data_input),
	.i_tx_ctrl(encoder_ctrl_input),
	.i_rx_raw_data(o_rx_raw_data),
	.i_rx_raw_ctrl(o_rx_raw_ctrl),
	.o_match_data(match_data),
	.o_match_ctrl(match_ctrl)
	);

endmodule
