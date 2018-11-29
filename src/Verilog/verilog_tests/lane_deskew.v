module lane_deskew
	#(
		parameter	N_LANES		= 20,
		parameter	MAX_SKEW 	= 15,
		parameter	NB_SKEW		= $clog2(NB_SKEW)
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
