



module am_lock_fsm
#(
	parameter N_ALIGNERS 	 = 20   ,
	parameter N_BLOCKS   	 = 16383, //check
	parameter MAX_INVALID_AM = 8 	,
	parameter NB_INVALID_CNT = $clog2(MAX_INVALID_AM)
 )
 (
 	input  wire 						i_clock,
 	input  wire 						i_reset,
 	input  wire 						i_enable,
 	input  wire 						i_valid,
 	input  wire 						i_block_lock,
 	input  wire 						i_am_valid,
 	input  wire [NB_INVALID_CNT-1 : 0] 	i_am_invalid_limit,
 	input  wire [N_ALIGNERS-1 : 0] 		i_match_vector,

 	output wire [N_ALIGNERS-1 : 0] 		o_match_mask  ,
 	output wire 				   		o_ignore_sh   ,
 	output wire 						o_am_lock   

 );

//LOCALPARAMS

localparam N_STATE  = 4;
localparam INIT     = 4'b1000;
localparam WAIT_1ST = 4'b0100;
localparam WAIT_2ND = 4'b0010;
localparam LOCKED 	= 4'b0001;


//INTERNAL SIGNALS

wire timer_done;
reg							reset_timer 	, reset_timer_next;
reg [N_STATE-1 : 0] 		state 			, next_state;
reg [NB_INVALID_CNT-1 : 0] 	am_invalid_count, am_invalid_count_next;


reg match_mask, match_mask_next;
reg ignore_sh , ignore_sh_next ;
reg am_lock   , am_lock_next   ;

//PORTS



///////////

always @ (posedge i_clock)
begin//***********actualizar los registros que faltan
	if(i_reset)
	begin
		state 			 <= INIT;
		reset_timer 	 <= 0;
		am_invalid_count <= 0;
	end
	else if (i_enable && i_valid)
	begin
		state 			 <= next_state;
		reset_timer 	 <= reset_timer_next;
		am_invalid_count <= am_invalid_count_next
	end
end


always @ *
begin
	next_state 		 	  = state;
	reset_timer_next 	  = 1'b0;
	am_invalid_count_next = am_invalid_count;
	am_lock_next 		  = am_lock;
	match_mask_next		  = match_mask;
	ignore_sh_next		  = ignore_sh;

	case(state)
		INIT:
		begin
			am_lock_next	 = 1'b0;
			o_ignore_sh	 = 1'b0;
			o_match_mask = {N_ALIGNERS{1'b1}};
			next_state   = WAIT_1ST;
		end
		WAIT_1ST:
		begin
			if(i_am_valid)
			begin
				o_ignore_sh  	  = 1'b1;
				reset_timer_next  = 1'b1;
				match_mask_next = i_match_vector;
				next_state 	      = WAIT_2ND;
			end 
		end
		WAIT_2ND:
		begin
			if(timer_done && i_am_valid)
			begin
				o_am_lock = 1'b1;
				reset_timer_next = 1'b1;
				next_state = LOCKED;
			end
			else if(timer_done && !i_am_valid)
			begin
				next_state 		= WAIT_1ST;
				match_mask_next = {N_ALIGNERS{1'b1}};
				sh_ignore_next  = 1'b0;
			end
		end
		LOCKED:
		begin
			if(am_invalid_count >= i_am_invalid_limit)
			begin
				next_state 		= WAIT_1ST;
				match_mask_next = {N_ALIGNERS{1'b1}};
				sh_ignore_next  = 1'b0;
				am_lock_next 	= 1'b0;				
			end
			else if (timer_done && i_am_valid)
			begin
				am_invalid_count_next = 0;
				reset_timer_next = 1'b1;
			end
			else if (timer_done && !i_am_valid)
			begin
				am_invalid_count_next = am_invalid_count + 1;
				reset_timer_next = 1'b1;
			end
		end
	endcase
end






endmodule






endmodule