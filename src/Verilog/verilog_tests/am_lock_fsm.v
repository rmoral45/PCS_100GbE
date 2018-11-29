



module am_lock_fsm
#(
	parameter N_ALIGNERS 	 = 20 ,
	parameter N_BLOCKS   	 = 16383 , //check
	parameter MAX_INVALID_AM = 8 ,
	parameter NB_INVALID_CNT = $clog2(MAX_INVALID_AM)
 )
 (
 	input  wire 						i_clock ,
 	input  wire 						i_reset ,
 	input  wire 						i_enable ,
 	input  wire 						i_valid ,
 	input  wire 						i_block_lock ,
 	input  wire 						i_timer_done , 
 	input  wire 						i_am_valid  ,
 	input  wire [NB_INVALID_CNT-1 : 0] 	i_am_invalid_limit ,
 	input  wire [N_ALIGNERS-1 : 0] 		i_match_vector ,

 	output wire [N_ALIGNERS-1 : 0] 		o_match_mask ,
 	output wire 				   		o_ignore_sh ,
 	output wire							o_enable_mask ,
 	output wire							o_reset_count ,
 	output wire 						o_am_lock ,
 	output wire 						o_resync ,
 	output wire 						o_start_of_lane ,
 	output wire 						o_restore_am    

 );

//LOCALPARAMS

localparam N_STATE  = 4;
localparam INIT     = 4'b1000;
localparam WAIT_1ST = 4'b0100;
localparam WAIT_2ND = 4'b0010;
localparam LOCKED 	= 4'b0001;


//INTERNAL SIGNALS

reg							reset_timer 	, reset_timer_next;
reg [N_STATE-1 : 0] 		state 			, next_state;
reg [NB_INVALID_CNT-1 : 0] 	am_invalid_count, am_invalid_count_next;


reg match_mask 	 , match_mask_next ;
reg ignore_sh 	 , ignore_sh_next ;
reg am_lock   	 , am_lock_next ;
reg resync 		 , resync_next ;
reg start_of_lane, sol_next	;
reg restore_am 	 , rest_am_next;


//PORTS
assign o_match_mask  	= match_mask;
assign o_ignore_sh   	= ignore_sh;
assign o_enable_mask 	= (state == WAIT_1ST); // verificar si hace falta
assign o_reset_count 	= reset_timer;
assign o_am_lock     	= am_lock;
assign o_resync		 	= resync;
assign o_start_of_lane 	= start_of_lane;
assign o_restore_am		= restore_am;



//Update state and signaling
always @ (posedge i_clock)
begin/
	if(i_reset)
	begin
		state 			 <= INIT;
		start_of_lane    <= 0;
		resync			 <= 0;
		am_lock 		 <= 0;
	end
	else if (i_enable && i_valid)
	begin
		state 			 <= next_state;
		start_of_lane	 <= sol_next;
		resync			 <= resync_next;
		am_lock 		 <= am_lock_next;
	end
end

//Update control registers
always @ (posedge i_clock)
begin
	if(i_reset)
	begin
		ignore_sh   	 <= 0;
		reset_timer 	 <= 0;
		restore_am 		 <= 0;
		match_mask  	 <= {N_ALIGNERS{1'b1}};
		am_invalid_count <= {NB_INVALID_CNT{1'b0}};
	end
	else if (i_enable && i_valid)
	begin
		ignore_sh   	 <= ignore_sh_next;
		reset_timer 	 <= reset_timer_next; 
		match_mask  	 <= match_mask_next;
		restore_am 		 <= rest_am_next;
		am_invalid_count <= am_invalid_count_next;
	end
end


always @ *
begin
	next_state 		 	  = state;
	am_invalid_count_next = am_invalid_count;
	am_lock_next 		  = am_lock;
	match_mask_next		  = match_mask;
	ignore_sh_next		  = ignore_sh;
	resync_next			  = 1'b0;
	sol_next			  = 1'b0;
	reset_timer_next 	  = 1'b0;
	rest_am_next		  = 1'b0;

	case(state)
		INIT:
		begin
			am_lock_next 	= 1'b0;
			ignore_sh_next	= 1'b0;
			match_mask_next	= {N_ALIGNERS{1'b1}};
			next_state   	= WAIT_1ST;
		end
		WAIT_1ST:
		begin
			if(i_am_valid)
			begin
				o_ignore_sh  	  = 1'b1;
				reset_timer_next  = 1'b1;
				rest_am_next	  = 1'b1;
				match_mask_next   = i_match_vector;
				next_state 	      = WAIT_2ND;
			end 
		end
		WAIT_2ND:
		begin
			if(i_timer_done && i_am_valid)
			begin
				am_lock_next 	 = 1'b1;
				reset_timer_next = 1'b1;
				rest_am_next	 = 1'b1;
				sol_next		 = 1'b1;
				resync_next		 = 1'b1; // check
				next_state 		 = LOCKED;
			end
			else if(i_timer_done && !i_am_valid)
			begin
				match_mask_next  = {N_ALIGNERS{1'b1}};
				sh_ignore_next   = 1'b0;
				rest_am_next     = 1'b1; // check
				next_state 		 = WAIT_1ST;
			end
		end
		LOCKED:
		begin
			if (i_timer_done && i_am_valid)
			begin
				am_invalid_count_next = 0;
				reset_timer_next 	  = 1'b1;
				sol_next		 	  = 1'b1;
				rest_am_next     	  = 1'b1;
			end
			else if (i_timer_done && !i_am_valid)
			begin
				if(am_invalid_count >= i_am_invalid_limit)
				begin
					next_state 		= WAIT_1ST;
					match_mask_next = {N_ALIGNERS{1'b1}};
					sh_ignore_next  = 1'b0;
					am_lock_next 	= 1'b0;				
				end
				else
				begin
					am_invalid_count_next = am_invalid_count + 1;
					reset_timer_next 	  = 1'b1;
					rest_am_next     	  = 1'b1;
					sol_next		 	  = 1'b1;
				end
			end
		end

	endcase
end



endmodule
