


module am_mask_handler
#(
	parameter NB_AM = 48,
	parameter N_MASK_MODES = 4,
	parameter NB_MASK_CONFIG = $clog2(N_MASK_MODES)
 )
 (
	input wire 				i_clock,
	input wire 				i_reset,
	input wire 				i_enable,
	input wire 		 		i_valid,
	input wire 		 		i_config,
	input wire  [NB_MASK_CONFIG-1 : 0] 	i_mask_config,

	output wire [NB_AM-1 : 0] 		o_compare_mask
 );

//localparam
localparam FULL_MASK_OPT  	      = 2'b00;
localparam HALF_MASK_OPT 	      = 2'b01;
localparam UPPER_LOWER_MASK_OPT       = 2'b10;
localparam INTERLEAVED_BYTE_MASK_OPT  = 2'b11;

localparam FULL_MASK 			= 48'hffffffffffff;
localparam HALF_MASK 			= 48'hffffff000000;
localparam UPPER_LOWER_MASK 		= 48'hffff0000ffff;
localparam INTERLEAVED_BYTE_MASK 	= 48'hff00ff00ff00;

//INTERNAL SIGNALS
reg [(NB_AM*N_MASK_MODES)-1 : 0] mask_pool;

reg [NB_AM-1 : 0] 		 selected_mask;

always @ (posedge i_clock)
begin
end
