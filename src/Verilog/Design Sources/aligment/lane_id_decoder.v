
/*
   conversion de one hot  a binario
*/

module lane_id_decoder
#(
	parameter N_ALIGNER = 20,
	parameter ID_LEN    = $clog2(N_ALIGNER)
 )
 (
 	input wire  [N_ALIGNER-1 : 0]		i_match_mask,

 	output wire [ID_LEN-1 	 : 0]		o_lane_id
 );



 reg  [ID_LEN-1    : 0] lane_id;
 wire [N_ALIGNER-1 : 0] match_mask;

 assign match_mask = i_match_mask;

 integer i;
 always @ *
 begin
 	lane_id = 0;

 	for(i=0; i<N_ALIGNER; i= i+1)
 	begin
 		if(match_mask[i])
 			lane_id = i;
 	end
 end

 assign o_lane_id = lane_id;

endmodule
