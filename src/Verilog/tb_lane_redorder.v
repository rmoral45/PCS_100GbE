

module tb_lane_reorder;

parameter LEN_CODED_BLOCK = 66;
parameter N_LANES 		= 20;
parameter NB_ID  		= $clog2(N_LANES);
parameter NB_BUS_ID		= N_LANES*NB_ID;

localparam ID_0 = 5'd0 ;
localparam ID_1 = 5'd1 ;
localparam ID_2 = 5'd2 ;
localparam ID_3 = 5'd3 ;
localparam ID_4 = 5'd4 ;
localparam ID_5 = 5'd5 ;
localparam ID_6 = 5'd6 ;
localparam ID_7 = 5'd7 ;
localparam ID_8 = 5'd8 ;
localparam ID_9 = 5'd9 ;
localparam ID_10 = 5'd10 ;
localparam ID_11 = 5'd11 ;
localparam ID_12 = 5'd12 ;
localparam ID_13 = 5'd13 ;
localparam ID_14 = 5'd14 ;
localparam ID_15 = 5'd15 ;
localparam ID_16 = 5'd16 ;
localparam ID_17 = 5'd17 ;
localparam ID_18 = 5'd18 ;
localparam ID_19 = 5'd19 ;



reg reset;
reg clock;
reg enable;
reg lane_deskew;
reg valid;

reg [NB_BUS_ID-1 : 0] i_id;
wire [NB_BUS_ID-1 : 0] o_id;

initial begin
	
	reset  = 1;
	clock  = 0;
	enable = 0;
	lane_deskew = 0;
	valid = 0;
	i_id = {ID_0,ID_3,ID_17,ID_16,ID_14,ID_15,ID_13,ID_12,ID_11,ID_10,ID_9,ID_8,ID_7,ID_6,ID_5,ID_4,ID_19,ID_2,ID_1,ID_18};
	#6 	reset = 0;
		enable =1;
		lane_deskew = 1;
	#4 valid = 1;
end

always #2 clock = ~clock;

lane_reorder
#(
	.N_LANES(N_LANES)
 )
	u_lane_redorder
	(
		.i_clock			(clock),
 		.i_reset			(reset),
 		.i_enable			(enable),
 		.i_valid			(valid),
 		.i_lanes_deskewed	(lane_deskew),
 		.i_lane_id			(i_id),

 		.o_lane_select		(o_id)
	);


endmodule