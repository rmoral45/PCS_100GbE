module lane_deskew
	#(
		parameter	N_LANES		= 20,
		parameter	MAX_SKEW 	= 15,
		parameter	NB_SKEW		= $clog2(MAX_SKEW)
	)

	(
		input wire						i_clock,
		input wire						i_reset,
		input wire						i_enable,
		input wire						i_allignment_lock,
		input wire	[N_LANES-1 : 0]		i_resync,
		input wire	[N_LANES-1 : 0]		i_start_of_lane,

		output reg	[MAX_SKEW-1 : 0]	o_delay
	);


	wire reduct_sol;
	wire reduct_resync;

	assign	start_count		=|	i_start_of_lane;
	assign	reset_count		=|	i_resync;

	always @(posedge i_clock)
	begin
		if(~rst_n) begin
			 <= 0;
		end else begin
			 <= ;
		end
	end





