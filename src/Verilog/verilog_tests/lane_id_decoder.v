

module lane_id_decoder
#(
	parameter N_ALIGNER = 20,
	parameter ID_LEN	= $clog2(N_ALIGNER)
 )
 (
 	input wire  [N_ALIGNER-1 : 0] 	i_match_mask,

 	output wire [ID_LEN-1 : 0]		o_lane_id
 );




 reg [ID_LEN-1 : 0] lane_id;


 always @ *
 begin
 	lane_id = 0;
 	for(integer i=0; i<N_ALIGNER; i= i+1)
 	begin
 		if(i_match_mask[i])
 			lane_id |= i;
 	end
 end


endmodule