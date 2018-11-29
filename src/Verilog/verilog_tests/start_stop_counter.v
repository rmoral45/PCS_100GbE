module start_stop_counter
	#(
		parameter	MAX_SKEW 	= 15,
		parameter	NB_SKEW		= $clog2(MAX_SKEW)
	 )
	(

		input wire					i_clock,
		input wire					i_reset,
		input wire					i_start_count,
		input wire					i_stop_count,
		input wire					i_reset_count,

		output wire					o_invalid_skew,
		output wire	[NB_SKEW-1 : 0]	o_counter
	);

	assign 	o_invalid_skew		= 	(counter == MAX_SKEW);
	assign 	o_counter			=	counter;

	reg [NB_SKEW-1 : 0]				counter;
	reg 							count_enb;


	always @(posedge i_clock)
	begin
		
		if(i_reset)
			count_enb <= 1'b0;
	
		else if(i_stop_count)
			count_enb <= 1'b0;

		else if(i_start_count)
			count_enb <= 1'b1;
		
	end


	always @(posedge i_clock)
	begin
		
		if(i_reset || i_reset_count)
			counter <= {NB_SKEW{1'b0}};
	
		else if(!count_enb)
			counter <= counter;

		else if(count_enb)
		begin
			if(counter >= MAX_SKEW)
				counter <= MAX_SKEW;
			else
				counter <= counter + 1;
		end
			
	end

endmodule




