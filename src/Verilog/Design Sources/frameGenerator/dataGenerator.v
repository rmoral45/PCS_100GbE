`timescale 1ns/100ps
module dataGenerator
	#(
		parameter								NB_BYTE 		= 8,
		parameter								NB_DATA_RAW 	= 64
	)
	(
		input 	wire							i_clock,
		input 	wire							i_reset,
		input 	wire							i_enable,
		input 	wire							i_valid,

		output 	wire	[NB_DATA_RAW - 1 :0]	o_data_block
	);

	localparam							N_DATA_GENERATORS = 8;

	genvar i;
	generate
		for(i = 0; i < N_DATA_GENERATORS; i = i+1) begin: common_counter_gen
			common_counter
			u_common_counter
			(
				.i_clk 		(i_clock),
				.i_rst 		(i_reset),
				.i_rf_enable(i_enable),
				.i_valid 	(i_valid),
			
				.o_counter 	(o_data_block[NB_DATA_RAW-1-(i*NB_BYTE) -: NB_BYTE])
			);
		end
	endgenerate

endmodule


