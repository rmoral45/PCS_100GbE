

module deskew_fsm
#(
	parameter  MAX_SKEW 		= 16,
	parameter  NB_DELAY_COUNT 	= $clog2(MAX_SKEW),
	parameter  N_LANES  		= 20
 )
 (
 	input wire                          i_clock,
 	input wire                          i_reset,
 	input wire 	                        i_enable,
	input wire                          i_valid,
 	input wire                          i_resync,
 	input wire [N_LANES-1 : 0]	        i_start_of_lane,
 	input wire [NB_DELAY_COUNT-1 : 0]   i_common_counter,
 	input wire                          i_am_lock,

 	output reg                          o_enable_counters,
 	output reg                          o_stop_common_counter,
 	output wire                         o_set_fifo_delay, 			//hace que las fifo recalculen el delay
    output reg                          o_write_prog_fifo_enb,
	output reg                          o_read_prog_fifo_enb,
 	output wire [N_LANES-1 : 0]         o_stop_lane_counters,
 	output wire                         o_deskew_done,
 	output wire                         o_invalid_skew
 );

 	//LOCALPARAMS
 	localparam N_STATES    	= 3;
 	localparam INIT        	= 3'b001;
 	localparam COUNT 		= 3'b010;
 	localparam DESKEW_DONE 	= 3'b100;

 	//INTERNAL SIGNALS
 	reg                    	deskew_done, deskew_done_next;
 	reg [N_STATES-1 : 0] 	state, state_next;
 	reg [N_LANES-1 : 0]  	start_of_lane, start_of_lane_next;
 	reg 					set_fifo_delay_d,set_fifo_delay_next;

 	//PORTS
 	assign 					o_invalid_skew = (i_common_counter >= MAX_SKEW) ? 1'b1 : 1'b0;		
 	assign 					o_stop_lane_counters = start_of_lane;
 	assign 					o_deskew_done = deskew_done & (!o_invalid_skew);

 	always @ (posedge  i_clock)
 	begin 	
 		if(i_reset || i_resync || ~i_am_lock)
 		  set_fifo_delay_d <= 0;

 		else if (i_enable && i_valid) 			
 	       set_fifo_delay_d <= set_fifo_delay_next;
 	end
 	assign o_set_fifo_delay = set_fifo_delay_d;

 	always @ (posedge  i_clock)
 	begin 	
 		if(i_reset || i_resync || ~i_am_lock)
 		begin
 			state 				<= INIT;
 			deskew_done         <= 0;
 			start_of_lane 		<= {N_LANES{1'b0}};
 		end
 		else if (i_enable && i_valid) 		
 		begin	
 			state 				<= state_next;
 			deskew_done         <= deskew_done_next;
 			start_of_lane 		<= start_of_lane_next;
 		end
 	end


 	always @ *
 	begin
 		state_next            = state;
 	   deskew_done_next      = 0;
 		start_of_lane_next    = start_of_lane;
 		set_fifo_delay_next   = 0;
 		o_enable_counters     = 0;
 		o_stop_common_counter = 0;
		o_write_prog_fifo_enb = 0;
		o_read_prog_fifo_enb  = 0;

 		case (state)
 			INIT :
 			begin
 				if( (|i_start_of_lane) )
 				begin
 					state_next 		   = COUNT;
 					start_of_lane_next = i_start_of_lane;
					 o_write_prog_fifo_enb = 1;
 				end
 			end
 			COUNT :
 			begin
 				o_enable_counters  = 1;
				o_write_prog_fifo_enb = 1;
 				start_of_lane_next = (start_of_lane | i_start_of_lane);

 				if (o_invalid_skew)
 				begin
 					state_next 		   = INIT;
 	               deskew_done_next      = 0;
 					start_of_lane_next = 0;
 				end
 				else if ( (& start_of_lane) )
 				begin
 					state_next 		   = DESKEW_DONE;
 					set_fifo_delay_next   = 1; 
 					o_stop_common_counter = 1;

 				end
 			end
 			DESKEW_DONE :
 			begin
				o_write_prog_fifo_enb = 1;
				o_read_prog_fifo_enb  = 1;
 			    deskew_done_next      = 1;
 			end
 		endcase
 	end


 	endmodule
