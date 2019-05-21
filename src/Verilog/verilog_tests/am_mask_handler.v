


module am_mask_handler
#(
	parameter NB_AM = 48,
 )
 (
	input wire 			i_clock,
	input wire 			i_reset,
	input wire 			i_enable,
	input wire 		 	i_valid,
	input wire 		 	i_config,
	input wire  [NB_AM-1 : 0] 	i_mask_config,

	output wire [NB_AM-1 : 0] 	o_compare_mask
 );



//INTERNAL SIGNALS

reg [NB_AM-1 : 0]        selected_mask;

always @ (posedge i_clock)
begin
        if (i_reset)
                selected_mask <= {NB_AM{1'b1}};
        else if (i_config && i_enable)
                selected_mask <= i_mask_config;
end

assign o_compare_mask = selected_mask;

endmodule
