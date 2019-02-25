`timescale 1ns/100ps

module tb_dataGenerator;

localparam			DATA_BLOCK_LEN = 64;

reg							tb_clock;
reg							tb_reset;
reg	    					tb_enable;
reg 						tb_valid;
wire [DATA_BLOCK_LEN-1:0]	tb_out_data_block;


initial begin
		tb_clock	= 1'b0;
		tb_reset	= 1'b0;
		tb_enable	= 1'b0;
		tb_valid	= 1'b0;
#1		tb_reset	= 1'b1;
#1		tb_reset	= 1'b0;
#4		tb_enable	= 1'b1;
		tb_valid	= 1'b1;
#10000000 $finish; 
end


always #1 tb_clock = ~tb_clock;

dataGenerator#()
test_dataGenerator
	(
	.i_clock(tb_clock),
	.i_reset(tb_reset),
	.i_enable(tb_enable),
	.i_valid(tb_valid),
	.o_data_block(tb_out_data_block)
	);

endmodule