`timescale 1ns/100ps


module tb_serial_transmit;

localparam LEN_CODED_BLOCK = 66;
reg [9:0] counter;
reg clock;
reg reset;
reg block_clock;
reg tx_clock;
reg [LEN_CODED_BLOCK-1 : 0] data;
wire tx_bit;

initial begin
	clock = 0;
	reset = 1;
	counter = 0;
	data = {LEN_CODED_BLOCK{1'b0}};
	#6 reset = 0;
	#4 block_clock = 1;
	   data = 66'h2_0f_0f_0f_0f_0f_0f_0f_0f;
	#2 block_clock = 0;
	#2 tx_clock    = 1;
	#2 tx_clock = 0;
	#2 tx_clock = 1;
	#2 tx_clock = 0;
	#2 tx_clock = 1;
	#2 tx_clock = 0;
	#2 tx_clock = 1;
	#2 tx_clock = 0;
	#2 tx_clock = 1;
	#2 tx_clock = 0;
	#2 tx_clock = 1;
	#2 tx_clock = 0;
	#2 tx_clock = 1;
	#2 tx_clock = 0;
	#2 tx_clock = 1;
	#2 tx_clock = 0;
	#2 tx_clock = 1;
	#2 tx_clock = 0;
	#2 tx_clock = 1;
	#2 tx_clock = 0;
	#2 tx_clock = 1;
	#2 tx_clock = 0;
	#2 tx_clock = 1;


end

always #2 clock = ~clock;


serial_transmitter
#(
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK)
 )
	u_serial_transmitter
	(
		.i_clock(clock)   ,
		.i_reset(reset)   ,
		.i_data(data)     ,
		.i_block_clock(block_clock), 
		.i_transmit_clock(tx_clock),
		.o_tx_bit(tx_bit)
	);

endmodule