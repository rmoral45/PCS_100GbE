
/*
	MSB i_lane_id es el id de la lane fisica 19.

	Si en los MSB(lane id) recibo el id 1, entonces el multiplexor 19 debe seleccionar como salida la linea 1
*/


module lane_reorder
#(
	parameter LEN_CODED_BLOCK 	= 66,
	parameter N_LANES 			= 20,
	parameter NB_ID  			= $clog2(N_LANES),
	parameter NB_BUS_ID			= N_LANES*NB_ID  
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

 reg [NB_ID-1 : 0] 		reordered_lanes 		[0 : N_LANES-1];
 reg [NB_ID-1 : 0] 		reordered_lanes_next	[0 : N_LANES-1];

 reg [NB_BUS_ID-1 : 0] 	lane_select;
// reg [NB_ID-1 : 0] 		lane_n_id;


integer i;


assign o_lane_select = lane_select;
always @ (posedge i_clock)
begin
	if(i_reset)
	begin
		for(i=0; i<N_LANES; i=i+1)
			reordered_lanes[i] <= {NB_ID{1'b0}};
	end
	else if (i_lanes_deskewed && i_enable)
	begin
		for(i=0; i<N_LANES; i=i+1)
			reordered_lanes[i] <= reordered_lanes_next[i];
	end
end


always @ (posedge i_clock)
begin
	if(i_reset)
	begin
		lane_select <= {NB_BUS_ID{1'b0}};
	end
	else if (i_lanes_deskewed && i_enable && i_valid)
		for(i=0; i<N_LANES; i=i+1)
			lane_select[(i*NB_ID) +: NB_ID] <= reordered_lanes[i];
end





always @ *
begin
	for(i=0; i<N_LANES; i=i+1)
		reordered_lanes_next[i] = reordered_lanes[i];

	for(i=0; i<N_LANES; i=i+1)
	begin
		reordered_lanes_next [i_lane_id [(i*NB_ID) +: NB_ID]] = i ;
	end

end


endmodule