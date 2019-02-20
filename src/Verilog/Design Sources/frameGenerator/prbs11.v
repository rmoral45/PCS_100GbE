module prbs11
	#(
	parameter 								SEED 		= 12'hABCD,
	parameter								N_BITS		= 12,
	parameter 								HIGH_LIM	= 12,
	parameter								LOW_LIM		= 0
	)
	(
	input									i_clock,
	input									i_reset,
	input									i_enable,
	input									i_valid,
	output wire	[HIGH_LIM-LOW_LIM - 1:0]	o_sequence
	);


	reg			[N_BITS-1:0]				new_sequence;
	reg										result;

	assign 	o_sequence = new_sequence[HIGH_LIM:LOW_LIM];
	assign  result = new_sequence[10] ^ new_sequence[9] & 1;

always @ (posedge i_clock)begin
	
	if(i_reset)begin
		new_sequence <= SEED;	
	end
	else if(i_enable && i_valid)begin
		new_sequence <= {new_sequence[N_BITS-1:1], result};
	end

end

endmodule