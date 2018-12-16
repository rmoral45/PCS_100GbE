`timescale 1ns/100ps



module tb_top_pcs;

reg clock,reset,enable;
wire [63 : 0] output_data;
wire [7  : 0] output_ctrl;



initial
begin
	clock = 0;
	reset = 1;
	enable = 0;

	#5
		reset  = 0;
		enable = 1;
end


always #1 clock = ~clock;

PCS_modules
	u_top
	(
		.i_clock(clock),
		.i_reset(reset),
		.i_enable_encoder(enable),
		.i_enable_scrambler(enable),
		.i_bypass(0),
		.i_enable_descrambler(enable),
		.i_enable_decoder(enable)

	);


endmodule