`timescale 1ns/100ps
module prbs
	#(
	parameter 								SEED 		= 12'hABC,
	parameter                               EXP1        = 10,
	parameter                               EXP2        = 9,
	parameter								N_BITS		= 12,
	parameter 								HIGH_LIM	= 12,
	parameter								LOW_LIM		= 0
	)
	(
	input									i_clock,
	input									i_reset,
	input									i_enable,
	input									i_valid,
	output wire	[HIGH_LIM-LOW_LIM :0]    	o_sequence
	);


	reg			[N_BITS-1:0]				new_sequence;
	wire									result;

	assign 	o_sequence = new_sequence[HIGH_LIM-1:LOW_LIM];
	assign  result = new_sequence[EXP1] ^ new_sequence[EXP2] & 1;

always @ (posedge i_clock)begin
	
	if(i_reset)begin
		new_sequence <= SEED;	
	end
	else if(i_enable && i_valid)begin
		new_sequence <= {new_sequence[N_BITS-2:0], result};
	end

end

endmodule