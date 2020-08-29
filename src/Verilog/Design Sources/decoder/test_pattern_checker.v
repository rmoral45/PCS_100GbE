


module test_pattern_checker
#(
	parameter NB_CODED_BLOCK 	= 66,
	parameter NB_SH 	 	= 2,
	parameter NB_MISMATCH_COUNTER	= 32
 )
 (
	 input  wire 					i_clock,
	 input  wire 					i_reset,
	 input  wire 					i_enable,
	 input  wire 					i_valid,
	 input  wire 					i_idle_pattern_mode,
	 input  wire [NB_CODED_BLOCK-1 : 0] 		i_data, 

	 output wire [NB_MISMATCH_COUNTER-1 : 0] 	o_mismatch_counter
 );

//LOCALPARAM
localparam [NB_CODED_BLOCK-1 : 0] static_idle_block = 66'h21E00000000000000;

//INTERNAL SIGNALS
reg  [NB_MISMATCH_COUNTER-1 : 0] counter;
wire max_limit;
wire mismatch;


always @ (posedge i_clock)
begin
	if (i_reset)
		counter <= {NB_MISMATCH_COUNTER{1'b0}};

	else if (i_enable && i_valid && i_idle_pattern_mode)
	begin
		if (max_limit)
			counter <= counter;
		else if (mismatch)
			counter <= counter + 1'b1;
	end
end

assign max_limit = &counter; //el contador alcanzo el valor maximo
assign mismatch  = (i_data != static_idle_block) ? 1'b1 : 1'b0;

endmodule
