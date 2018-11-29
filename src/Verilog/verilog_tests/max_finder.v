module max_finder
	#(
		parameter	MAX_SKEW 				= 15,
		parameter	N_LANES					= 20,
		parameter	NB_SKEW					= $clog2(MAX_SKEW),
		parameter	NB_DELAY_VECTOR			= N_LANES * NB_SKEW
	)
	(
		input wire	[NB_DELAY_VECTOR-1 : 0]	i_delay_vector,
		output wire	[NB_SKEW-1 : 0]			o_max_delay
	);

	integer 		i;

	reg 			[NB_SKEW-1 : 0]			max_delay;

	assign  		o_max_delay 			= max_delay;


	always @ *
	begin
		
		max_delay = i_delay_vector [NB_DELAY_VECTOR-1 -: NB_SKEW];

		for(i=N_LANES; i>0; i=i-1)
		begin
			
			if(max_delay < i_delay_vector [((i*NB_SKEW)-1) -: NB_SKEW])
			begin
				max_delay = i_delay_vector [((i*NB_SKEW)-1) -: NB_SKEW];
			end

		end

	end 

endmodule