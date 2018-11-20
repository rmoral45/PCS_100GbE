

module tb_bip_calc;

localparam LEN_CODED_BLOCK = 66;
reg [9:0] counter;
reg clock;
reg reset;
reg enable;
reg [LEN_CODED_BLOCK-1 : 0] data;
wire [7:0] bip3, bip7;


initial begin
	clock = 0;
	reset = 1;
	counter = 0;
	enable = 0;
	data = {LEN_CODED_BLOCK{1'b0}};
	#6 reset  = 0;
	#4 enable = 1;
	   data   = 66'b00_11111111_10000000_10000000_10000000_10000000_10000000_10000000_10000000;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_01000000_01000000_01000000_01000000_01000000_01000000_01000000;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00100000_00100000_00100000_00100000_00100000_00100000_00100000;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00010000_00010000_00010000_00010000_00010000_00010000_00010000;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00001000_00001000_00001000_00001000_00001000_00001000_00001000;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00000100_00000100_00000100_00000100_00000100_00000100_00000100;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00000010_00000010_00000010_00000010_00000010_00000010_00000010;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00000001_00000001_00000001_00000001_00000001_00000001_00000001;


end

always #2 clock = ~clock;


bip_calculator
#(
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK)
 )
	u_bip_calculator
	(
		.i_clock(clock)   ,
		.i_reset(reset)   ,
		.i_enable(enable) ,
		.i_data(data)     ,
		.o_bip3(bip3)     ,
		.o_bip7(bip7)
	);

endmodule