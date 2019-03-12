module frameChecker
	#(
	parameter								LEN_TX_DATA 	= 64,
	parameter								LEN_TX_CTRL 	= 8,
	parameter								LEN_GNG			= 16,
	parameter								NB_TERM			= 3,
	parameter								NB_DATA			= 8,
	parameter								NB_IDLE			= 5
	)
	(
	input									i_enable,
	input 	wire	[LEN_TX_DATA -1 : 0]	i_tx_data,
	input 	wire	[LEN_TX_CTRL -1 : 0]	i_tx_ctrl,
	input	wire	[LEN_TX_DATA -1 : 0]	i_rx_raw_data,
	input	wire	[LEN_TX_CTRL -1 : 0]	i_rx_raw_ctrl,
	output 	wire							o_match_data,
	output	wire							o_match_ctrl
	);

assign o_match_data = (i_tx_data == i_rx_raw_data) ? 1 : 0;
assign o_match_ctrl = (i_tx_ctrl == i_rx_raw_ctrl) ? 1 : 0;

endmodule

