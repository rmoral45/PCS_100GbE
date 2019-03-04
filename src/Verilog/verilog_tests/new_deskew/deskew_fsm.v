

module deskew_fsm
#(
	parameter  MAX_SKEW = 16,
	parameter  NB_COUNT = $clog2(MAX_SKEW),//AGREGAR MAS BITS !!!!!
	parameter  N_LANES  = 20
 )
 (
 	input wire 					i_clock,
 	input wire 					i_reset,
 	input wire 					i_enable,
 	input wire 					i_am_lock,
 	input wire 					i_resync,
 	input wire [N_LANES-1 : 0]	i_start_of_lane,
 	input wire [NB_COUNT-1 : 0] i_common_counter,


 	output reg 					o_enable_counters,
 	output reg					o_stop_common_counter,
 	output reg 					o_set_fifo_delay, //hace que las fifo recalculen el delay
 	output wire [N_LANES-1 : 0] o_stop_lane_counters 
 );

 //LOCALPARAMS
 localparam N_STATES 	= 3
 localparam INIT 	 	= 3'b001;
 localparam COUNT 	 	= 3'b010;
 localparam DESKEW_DONE = 3'b100;

 //INTERNAL SIGNALS

 reg 					align_status  , align_status_next;   //indica que termino el proceso de deskew
 reg 					valid_skew    , valid_skew_next; 	 //indica si el skew es aceptable
 reg [N_STATES-1 : 0] 	state 		  , state_next;
 reg [N_LANES-1 : 0]  	start_of_lane , start_of_lane_next;

 wire invalid_skew;
 assign invalid_skew = (i_common_counter >= MAX_SKEW) ? 1'b1 : 1'b0;

 //PORT ASSIGMENT
 assign o_stop_lane_counters = start_of_lane;


 always @ (posedge  i_clock)
 begin
 	
 	if(i_reset || i_resync)
 	begin
 		state 				<= INIT;
 		valid_skew 			<= 0;
 		align_status 		<= 0;
 		start_of_lane 		<= {N_LANES{1'b0}};
 	end
 	else if (i_enable) //[REVISAR]no usa valid por que debe funcionar con el clock de sistema?
 	begin	
 		state 				<= state_next;
 		valid_skew 			<= valid_skew_next;
 		align_status 		<= align_status_next;
 		start_of_lane 		<= start_of_lane_next;
 	end

 end


 always @ *
 begin
 	state_next		      = state;
 	valid_skew_next       = 0;
 	align_status_next  	  = 0;
 	start_of_lane_next 	  = start_of_lane;
 	o_set_fifo_delay 	  = 0;
 	o_enable_counters  	  = 0;
 	o_stop_common_counter = 0;

 	case (state)
 		INIT :
 		begin
 			if( (|i_start_of_lane) )
 			begin
 				state_next 		   = COUNT;
 				start_of_lane_next = i_start_of_lane;
 				o_enable_counters  = 1;
 			end
 		end
 		COUNT :
 		begin
 			o_enable_counters  = 1;
 			start_of_lane_next = (start_of_lane | i_start_of_lane);

 			if (invalid_skew)
 			begin
 				state_next 		   = INIT;
 				valid_skew  	   = 0;
 				align_status_next  = 0;
 				start_of_lane_next = 0;
 			end
 			else if ( (& start_of_lane) )
 			begin
 				state_next 		   = DESKEW_DONE;
 				valid_skew_next    = 1;
 			   	align_status_next  = 1;
 				o_set_fifo_delay   = 1; 
 				o_stop_common_counter = 1;

 			end
 		end
 		DESKEW_DONE :
 		begin
 			valid_skew_next   = 1;
 			align_status_next = 1;
 		end

 	endcase
 end


 endmodule