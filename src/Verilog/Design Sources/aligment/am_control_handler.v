

module am_control_handler
#(
	parameter MAX_INV_AM = 12 ,
	parameter NB_INV_AM  = $clog2(MAX_INV_AM),
	parameter MAX_VAL_AM = 12 ,
	parameter NB_VAL_AM  = $clog2(MAX_VAL_AM),
	parameter NB_AM_MASK = 48 ,
	parameter N_LANES    = 20
 )
 (

	input wire 				i_clock,
	input wire 				i_reset,
	input wire 				i_enable,
	input wire  				i_valid,
	input wire  				i_set_mask_cfg,
	input wire  				i_set_valid_thr_cfg,
	input wire  				i_set_invalid_thr_cfg,
	input wire  [NB_INV_AM-1 : 0] 		i_invalid_am_thr,
	input wire  [NB_VAL_AM-1 : 0] 		i_valid_am_thr,
	input wire  [NB_AM_MASK-1 : 0 ]		i_am_mask,

	output wire [NB_AM_MASK*N_LANES-1 : 0] 	o_am_mask,
	output wire [NB_INV_AM*N_LANES-1 : 0] 	o_invalid_am_thr,
	output wire [NB_VAL_AM*N_LANES-1 : 0] 	o_valid_am_thr
 );


 //INTERNAL SIGNALS
 reg [NB_AM_MASK*N_LANES-1 : 0] mask ;
 reg [NB_INV_AM*N_LANES-1  : 0] valid_thr;
 reg [NB_VAL_AM*N_LANES-1  : 0] invalid_thr;


always @ (posedge i_clock)
begin
	if (i_reset)
		mask <= {NB_AM_MASK*N_LANES{1'b0}};
	else if (i_enable && i_valid && i_set_mask_cfg)
		mask <= {N_LANES{i_am_mask}};
end


always @ (posedge i_clock)
begin
	if (i_reset)
		valid_thr <= {NB_VAL_AM*N_LANES{1'b0}};
	else if (i_enable && i_valid && i_set_valid_thr_cfg)
		valid_thr <= {N_LANES{i_valid_am_thr}};
end


always @ (posedge i_clock)
begin
	if (i_reset)
		invalid_thr <= {NB_INV_AM*N_LANES{1'b0}};
	else if (i_enable && i_valid && i_set)
		invalid_thr <= {N_LANES{i_invalid_am_thr}};
end



endmodule
