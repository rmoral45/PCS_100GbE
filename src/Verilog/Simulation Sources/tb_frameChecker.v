`timescale 1ns/100ps

module tb_frameChecker;

parameter 						LEN_TX_CTRL 	= 8;
parameter 						LEN_TX_DATA		= 64;
parameter						LEN_CODED_BLOCK = 66;
parameter                       NMODULES        = 2;




reg								tb_clock;
reg								tb_reset;
reg		[NMODULES-1 : 0]       	tb_enable;
reg		[NMODULES-1 : 0]       	tb_enable_rx;

wire	[LEN_TX_DATA-1 : 0]		tb_o_tx_data;
wire	[LEN_TX_CTRL-1 : 0]		tb_o_tx_ctrl;
wire	[LEN_TX_DATA-1 : 0]		tb_o_rx_raw_data;
wire	[LEN_TX_CTRL-1 : 0]		tb_o_rx_raw_ctrl;
wire	[LEN_CODED_BLOCK-1 : 0]	tb_scrambled_data;
wire							tb_match_data;
wire							tb_match_ctrl;



initial begin
		tb_clock	= 1'b0;
		tb_reset	= 1'b0;
		tb_enable	= 2'b00;
		tb_enable_rx = 2'b00;
#1		tb_reset	= 1'b1;
#5		tb_reset	= 1'b0;
        tb_enable   = 2'b11;
#7		tb_enable_rx = 2'b11;
#1000000 $finish;			
end



always #1 tb_clock = ~tb_clock;

top_level_frameGenerator
	#(
	.LEN_DATA_BLOCK(LEN_TX_DATA),
	.LEN_CTRL_BLOCK(LEN_TX_CTRL)
	)
u_top_level_frameGenerator
	(
	.i_clock(tb_clock),
	.i_reset(tb_reset),
	.i_enable(tb_enable[0]),
	.o_tx_data(tb_o_tx_data),
	.o_tx_ctrl(tb_o_tx_ctrl)
	);

frameChecker
	#(
	)
u_frameChecker
	(
	.i_enable(tb_enable[0]),
	.i_tx_data(tb_o_tx_data),
	.i_tx_ctrl(tb_o_tx_ctrl),
	.i_rx_raw_data(tb_o_rx_raw_data),
	.i_rx_raw_ctrl(tb_o_rx_raw_ctrl),
	.o_match_data(tb_match_data),
	.o_match_ctrl(tb_match_ctrl)
	);

tx_modules
	#(
	)
u_tx_modules
	(
	.i_clock(tb_clock),
	.i_reset(tb_reset),
	.i_tx_data(tb_o_tx_data),
	.i_tx_ctrl(tb_o_tx_ctrl),
	.i_enable(tb_enable[NMODULES-1:0]),
	.o_scrambled_data(tb_scrambled_data)
	);

rx_modules
	#(
	)
u_rx_modules
	(
	.i_clock(tb_clock),
	.i_reset(tb_reset),
	.i_enable(tb_enable_rx[NMODULES-1:0]),
	.i_scrambled_data(tb_scrambled_data),
	.o_rx_raw_data(tb_o_rx_raw_data),
	.o_rx_raw_ctrl(tb_o_rx_raw_ctrl)
	);

endmodule