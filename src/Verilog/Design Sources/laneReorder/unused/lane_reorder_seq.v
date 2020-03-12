


module lane_reorder_seq
#(
	LEN_CODED_BLOCK = 66,
	N_LANES 		= 20,
	NB_ID  			= $clog2(N_LANES),
	NB_BUS_ID		= N_LANES*NB_ID  
 )
 (
 	input wire i_clock,
 	input wire i_reset,
 	input wire i_enable,
 	input wire i_valid,
 	input wire i_lanes_deskewed,
 	input wire  [NB_BUS_ID-1 : 0] i_lane_id,

 	output wire [NB_BUS_ID-1 : 0] o_lane_select
 );


assign o_lane_select = reordered_lanes;
 reg [NB_BUS_ID-1 : 0] reordered_lanes;
 reg [NB_BUS_ID-1 : 0] lane_select;
 reg [NB_ID-1 : 0] lane_n_id;
 reg [NB_ID-1 : 0] counter;
 reg reorder_done;


 always @ (posedge  i_clock)
 begin
 	if(i_reset)
 	begin
 		counter <= 0;
 	end
 	else if (i_enable && i_valid && i_lanes_deskewed)
 	begin
 		if(counter < N_LANES)
 		begin
 			counter 	 <= counter + 1;
 			reorder_done <= 1'b0;
 		end
 		else
 		begin 
 			counter <= counter;
 			reorder_done <= 1'b1;
 		end
 	end
 end


 always @ (posedge i_clock)
 begin
 	if (i_reset)
 		reordered_lanes <= {NB_BUS_ID{1'b0}};
 	else if (i_enable && i_valid && i_lanes_deskewed && !reorder_done)
 		reordered_lanes[(i_lane_id[((counter*NB_ID)) +: NB_ID]) +: NB_ID] <= counter;
 end


 endmodule