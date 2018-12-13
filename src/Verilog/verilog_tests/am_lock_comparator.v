


module am_lock_comparator
#(
	parameter LEN_AM 	= 48,
	parameter N_ALIGNER = 20
 )
 (	input  wire 					i_enable_mask,// input from fsm
 	input  wire 					i_timer_done ,
 	input  wire [LEN_AM-1 : 0] 	 	i_am_value	 ,
 	input  wire [N_ALIGNER-1 : 0] 	i_match_mask ,
 	input  wire 					i_sh_valid   ,
 	output wire 					o_am_match	 ,
 	output wire [N_ALIGNER-1 : 0] 	o_match_vector
 );




localparam AM_LANE_0  = 48'hC168213E97DE;
localparam AM_LANE_1  = 48'h9D718E628E71;
localparam AM_LANE_2  = 48'h594BE8A6B417;
localparam AM_LANE_3  = 48'h4D957BB26A84;
localparam AM_LANE_4  = 48'hF507090AF8F6;
localparam AM_LANE_5  = 48'hDD14C222EB3D;
localparam AM_LANE_6  = 48'h9A4A2665B5D9;
localparam AM_LANE_7  = 48'h7B456684BA99;
localparam AM_LANE_8  = 48'hA024765FDB89;
localparam AM_LANE_9  = 48'h68C9FB973604;
localparam AM_LANE_10 = 48'hFD6C99029366; //check
localparam AM_LANE_11 = 48'hB99155466EAA;
localparam AM_LANE_12 = 48'h5CB9B2A3464D;
localparam AM_LANE_13 = 48'h1AF8BDE50742;
localparam AM_LANE_14 = 48'h83C7CA7C3835;
localparam AM_LANE_15 = 48'h3536CDCAC932;
localparam AM_LANE_16 = 48'hC4314C3BCEB3;
localparam AM_LANE_17 = 48'hADD6B7522948;
localparam AM_LANE_18 = 48'h5F662AA099D5;
localparam AM_LANE_19 = 48'hC0F0E53F0F1A;


integer i;

reg [LEN_AM*N_ALIGNER-1 : 0] 	  aligners; 
reg [N_ALIGNER-1 : 0] 			  match_mask; //salida de fsm
reg [N_ALIGNER-1 : 0] 			  match_vector;//salida de comparadores
reg [N_ALIGNER-1 : 0] 			  match_expected_am;
reg [LEN_AM-1 : 0] 				  am_value;// bits
reg match_payload;
reg enable;
reg match;

always @ *
begin
	aligners 	  = { AM_LANE_19, AM_LANE_18, AM_LANE_17, AM_LANE_16, AM_LANE_15, AM_LANE_14, AM_LANE_13
					, AM_LANE_12, AM_LANE_11, AM_LANE_10, AM_LANE_9 , AM_LANE_8 , AM_LANE_7 , AM_LANE_6
					, AM_LANE_5 , AM_LANE_4 , AM_LANE_3 , AM_LANE_2 , AM_LANE_1 , AM_LANE_0 };
	match_vector  = 0;
	match_expected_am = 0;
	match_payload = 0;
	enable = 0;
	match = 0;

	for(i=0;i<N_ALIGNER;i=i+1)
	begin
		if((aligners[i*LEN_AM  +: LEN_AM] == i_am_value) && i_match_mask[i])
		begin
			match_expected_am[i] = 1;
			match_vector[i]      = 1;
		end 
	end

	match_payload = | match_expected_am; // se encontro un match
	enable 		  = (i_timer_done | i_enable_mask);
	match 		  = match_payload & enable & i_sh_valid;//input to fsm

end 

assign o_am_match = match;
assign o_match_vector = match_vector;

endmodule