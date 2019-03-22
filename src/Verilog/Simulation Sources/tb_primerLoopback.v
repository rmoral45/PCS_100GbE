`timescale 1ns/100ps

module tb_primerLoopback;

localparam	NMODULES		= 2; 	
localparam	LEN_DATA_BLOCK	= 64;
localparam	LEN_CTRL_BLOCK	= 8;


reg tb_clock, tb_reset, tb_enable_frameGenerator, tb_enable_frameChecker;

reg [NMODULES-1 : 0] tb_enable_tx, tb_enable_rx;
wire [LEN_DATA_BLOCK-1 : 0] tb_data_out;
wire [LEN_CTRL_BLOCK-1 : 0] tb_ctrl_out;

initial begin
	tb_clock 				 = 0;
	tb_reset 				 = 0;
	tb_enable_frameGenerator = 1'b0;
	tb_enable_frameChecker	 = 1'b0;
	tb_enable_tx			 = 2'b00;
	tb_enable_rx			 = 2'b00;
#2	tb_reset				 = 1;
#2	tb_reset				 = 0;
	tb_enable_frameGenerator = 1'b1;
	tb_enable_frameChecker	 = 1'b1;
	tb_enable_tx			 = 2'b11;
	tb_enable_rx			 = 2'b11;
#10000000 $finish;
end


always #1 tb_clock = ~tb_clock;

toplevel_primerLoopback
	#()
u_toplevel_primerLoopback
	(
	.i_clock(tb_clock),
	.i_reset(tb_reset),
	.i_enable_frameGenerator(tb_enable_frameGenerator),
	.i_enable_frameChecker(tb_enable_frameChecker),
	.i_enable_tx(tb_enable_tx),
	.i_enable_rx(tb_enable_rx),
	.o_rx_raw_data(tb_data_out),
	.o_rx_raw_ctrl(tb_ctrl_out)
	);
endmodule