

module deskew_quick_test;

localparam N_LANES = 6;
localparam NB_COUNT = 6;
localparam MAX_SKEW = 32;
reg tb_clock;
reg tb_reset;
reg tb_enable;
reg tb_valid;
reg tb_am_lock;
reg [N_LANES-1 : 0] tb_resync;
reg [N_LANES-1 : 0] tb_SOL;
wire tb_set_fifo_delay;
wire [(N_LANES*NB_COUNT)-1 : 0]tb_lane_delay;
wire [NB_COUNT-1 : 0] lane_0_delay;
wire [NB_COUNT-1 : 0] lane_1_delay;
wire [NB_COUNT-1 : 0] lane_2_delay;
wire [NB_COUNT-1 : 0] lane_3_delay;
wire [NB_COUNT-1 : 0] lane_4_delay;
wire [NB_COUNT-1 : 0] lane_5_delay;

assign lane_0_delay = tb_lane_delay[0*NB_COUNT +: NB_COUNT];
assign lane_1_delay = tb_lane_delay[1*NB_COUNT +: NB_COUNT];
assign lane_2_delay = tb_lane_delay[2*NB_COUNT +: NB_COUNT];
assign lane_3_delay = tb_lane_delay[3*NB_COUNT +: NB_COUNT];
assign lane_4_delay = tb_lane_delay[4*NB_COUNT +: NB_COUNT];
assign lane_5_delay = tb_lane_delay[5*NB_COUNT +: NB_COUNT];

initial
begin
	tb_clock 	= 0;
	tb_reset 	= 1;
	tb_enable 	= 0;
	tb_valid 	= 0;
	tb_am_lock 	= 0;
	tb_resync 	= 0;
	tb_SOL 		= 0;
	#10 
		tb_reset  = 0;
		tb_enable = 1;
	#10
		tb_am_lock = 1;
	#10
		tb_SOL     = 1;
		tb_resync  = 1;
	#2
		tb_resync  = 0;
	#2
		tb_valid   = 1;

end


always #2 tb_clock = ~tb_clock;

always @ (posedge tb_clock)
begin
	if(tb_valid)
		tb_SOL <= (tb_SOL << 1);
end

deskew_top
#(
	.N_LANES(N_LANES),
	.MAX_SKEW(MAX_SKEW),
	.NB_COUNT(NB_COUNT)
 )
u_deskew_top
 (
 	.i_clock		(tb_clock),
 	.i_reset		(tb_reset),
 	.i_enable		(tb_enable),
 	.i_valid		(tb_valid),
 	.i_am_lock		(tb_am_lock),
 	.i_resync		(tb_resync),
 	.i_start_of_lane(tb_SOL),

 	.o_set_fifo_delay(tb_set_fifo_delay),
 	.o_lane_delay	 (tb_lane_delay)
 );

 
endmodule