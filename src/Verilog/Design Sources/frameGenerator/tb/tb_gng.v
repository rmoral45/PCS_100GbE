`timescale 1ns/100ps

module tb_gng;

reg	tb_clock;
reg tb_reset;
reg tb_clockEnable;
wire tb_valid_out;
wire [15:0] tb_data_out;

wire [2:0]  nterm;
wire [7:0]  ndata;
wire [7:0]  nidle;

assign nterm = tb_data_out[(15-7) -: 3];
assign ndata = tb_data_out[(15-4) -: 8];
assign nidle = tb_data_out[(15-8) -: 6];

initial begin
		tb_clock 		= 1'b0;
		tb_clockEnable 	= 1'b0;
		tb_reset		= 1'b1;
#1		tb_reset		= 1'b0;
#1		tb_reset		= 1'b1;
#1		tb_clockEnable	= 1'b1;
#10000000 $finish;
end

always #1 tb_clock = ~tb_clock;

gng#()
test_gng
	(
	.clk(tb_clock),
	.rstn(tb_reset),
	.ce(tb_clockEnable),
	.valid_out(tb_valid_out),
	.data_out(tb_data_out)
	);

endmodule