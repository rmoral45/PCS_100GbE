`timescale 1ns/100ps

module am_lock_comparator_v2
#(
	parameter 						NB_AM    = 48,
	parameter 						N_ALIGNER = 20
 )
 (	input  wire 					i_enable_mask,	
 	input  wire 					i_timer_done ,
 	input  wire [NB_AM-1 	 : 0] 	i_am_value ,
 	input  wire [NB_AM-1 	 : 0] 	i_compare_mask ,
 	input  wire [N_ALIGNER-1 : 0]	i_match_mask ,	
 	output wire 					o_am_match ,  	
 	output wire [N_ALIGNER-1 : 0] 	o_match_vector
 );

localparam NB_AM_ENCODING = 24;
localparam N_LANES = 20;

localparam [(NB_AM_ENCODING*N_LANES)-1 : 0] AM_ENCODING_LOW    = { 24'h83_16_84, 
                                                                   24'hB9_8E_71, 
                                                                   24'h9A_D2_17, 
                                                                   24'hB2_A9_DE, 
                                                                   24'hAF_E0_90,
                                                                   24'hBB_28_43, 
                                                                   24'h59_52_64, 
                                                                   24'hDE_A2_66, 
                                                                   24'h05_24_6E, 
                                                                   24'h16_93_DF,
                                                                   24'hBF_36_99, 
                                                                   24'h9D_89_AA, 
                                                                   24'h3A_9D_4D, 
                                                                   24'h58_1F_BD, 
                                                                   24'hC1_E3_53,
                                                                   24'hAC_6C_B3, 
                                                                   24'h23_8C_32, 
                                                                   24'hB5_6B_ED, 
                                                                   24'hFA_66_54, 
                                                                   24'h03_0F_A7}; 
localparam [(NB_AM_ENCODING*N_LANES)-1 : 0] AM_ENCODING_HIGH    = {~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-1 -: NB_AM_ENCODING],
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(1*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(2*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(3*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(4*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(5*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(6*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(7*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(8*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(9*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(10*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(11*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(12*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(13*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(14*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(15*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(16*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(17*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(18*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], 
                                                                   ~AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(19*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]}; 

localparam AM_LANE_0  = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_1  = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(1*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(1*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_2  = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(2*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(2*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_3  = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(3*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(3*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_4  = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(4*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(4*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_5  = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(5*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(5*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_6  = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(6*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(6*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_7  = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(7*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(7*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_8  = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(8*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(8*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_9  = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(9*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(9*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_10 = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(10*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(10*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_11 = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(11*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(11*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_12 = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(12*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(12*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_13 = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(13*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(13*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_14 = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(14*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(14*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_15 = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(15*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(15*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_16 = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(16*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(16*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_17 = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(17*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(17*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_18 = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(18*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(18*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};
localparam AM_LANE_19 = {AM_ENCODING_LOW[(NB_AM_ENCODING*N_LANES)-(19*NB_AM_ENCODING)-1 -: NB_AM_ENCODING], AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-(19*NB_AM_ENCODING)-1 -: NB_AM_ENCODING]};

integer i;

reg [NB_AM*N_ALIGNER-1 : 0] 	  aligners; 
reg [N_ALIGNER-1 : 0] 		  match_mask; 
reg [N_ALIGNER-1 : 0] 		  match_vector;
reg [N_ALIGNER-1 : 0] 		  match_expected_am;
reg [NB_AM-1 : 0] 		  am_value_masked;
reg match_payload;
reg enable;
reg match;
reg aux_am_mask;

always @ *
begin
	aligners 	  = { AM_LANE_19, AM_LANE_18, AM_LANE_17, AM_LANE_16, AM_LANE_15, AM_LANE_14, AM_LANE_13,
			      AM_LANE_12, AM_LANE_11, AM_LANE_10, AM_LANE_9 , AM_LANE_8 , AM_LANE_7 , AM_LANE_6 ,
					  AM_LANE_5 , AM_LANE_4 , AM_LANE_3 , AM_LANE_2 , AM_LANE_1 , AM_LANE_0 };
	match_vector  = 0;
	match_expected_am = 0;
	match_payload = 0;
	enable = 0;
	match = 0;
	aux_am_mask = 0;

	for(i=0;i<N_ALIGNER;i=i+1)
	begin
		aux_am_mask = & (((~( i_am_value ^ aligners[i*NB_AM +: NB_AM] )) | ~i_compare_mask ) ) ;
		if (aux_am_mask && i_match_mask[i])
		begin
			match_vector[i]      = 1;
		end 
	end

	match_payload = | match_vector; 
	enable 	      = (i_timer_done | i_enable_mask);
	match 	      = match_payload & enable;

end 

assign o_am_match = match;
assign o_match_vector = match_vector;

endmodule
