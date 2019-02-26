`timescale 1ns/100ps

module tb_top_level_frameGenerator;

localparam	LEN_TX_DATA	= 64;
localparam	LEN_TX_CTRL	= 8;

reg							tb_clock;
reg							tb_reset;
wire	[LEN_TX_DATA-1 : 0]	tb_o_tx_data;
wire	[LEN_TX_CTRL-1 : 0]	tb_o_tx_ctrl;

initial begin
		tb_clock	= 1'b0;
		tb_reset	= 1'b0;
#1		tb_reset	= 1'b1;
#1		tb_reset	= 1'b0;
#1000000 $finish;		
end

always #1 tb_clock = ~tb_clock;

top_level_frameGenerator#()
test_top_level_frameGenerator
	(
	.i_clock(tb_clock),
	.i_reset(tb_reset),
	.o_tx_data(tb_o_tx_data),
	.o_tx_ctrl(tb_o_tx_ctrl)	
	);

endmodule