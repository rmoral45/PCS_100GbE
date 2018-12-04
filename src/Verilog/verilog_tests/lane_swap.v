


module lane_swap
#(
	parameter NB_CODED_BLOCK = 66,
	parameter N_LANES		 = 20,
	parameter NB_ID			 = $clog2(N_LANES)
 )
 (
 	input wire [NB_CODED_BLOCK*N_LANES-1 : 0] i_data,
 	input wire [NB_ID*N_LANES-1 : 0] i_ID,
 	output reg [NB_CODED_BLOCK*N_LANES-1 : 0] o_data
 );



 integer i;





 always @ *
 begin
 	
 	for(i=0; i < N_LANES; i=i+1)
 	begin
 		o_data[(i*NB_CODED_BLOCK) +: NB_CODED_BLOCK] = i_data[ (i_ID[i*NB_ID +: NB_ID]* NB_CODED_BLOCK ) +: NB_CODED_BLOCK];
 	end
 end