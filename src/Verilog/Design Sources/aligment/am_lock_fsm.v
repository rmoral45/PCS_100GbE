module am_lock_fsm
#(
	parameter N_ALIGNERS 	 = 20 ,
	parameter N_BLOCKS   	 = 16383 , //check
	parameter MAX_INVALID_AM = 8 ,
	parameter MAX_VALID_AM   = 20,
	parameter NB_INVALID_CNT = $clog2(MAX_INVALID_AM),
	parameter NB_VALID_CNT   = $clog2(MAX_VALID_AM)
 )
 (
 	input  wire 						i_clock ,
 	input  wire 						i_reset ,
 	input  wire 						i_enable ,
 	input  wire 						i_valid ,
 	input  wire 						i_block_lock ,
	input  wire 						i_timer_done , 
 	input  wire 						i_am_valid  ,
 	input  wire							i_start_of_lane,
 	input  wire [N_ALIGNERS-1 : 0] 		i_match_vector ,
 	input wire  [NB_VALID_CNT-1 : 0]    i_lock_thr,       //contador para am validos
 	input wire  [NB_INVALID_CNT-1 : 0]  i_unlock_thr,     //contador para am invalidos

 	output wire [N_ALIGNERS-1 : 0] 		o_match_mask ,
 	output wire 				   		o_ignore_sh ,
 	output wire							o_enable_mask ,
 	output wire 						o_am_lock ,
 	output wire 						o_resync_by_am_start ,
 	output wire 						o_start_of_lane ,
 	output wire 						o_restore_am
 );

//LOCALPARAMS

localparam N_STATE      = 4;
localparam INIT         = 4'b1000;
localparam WAIT_1ST     = 4'b0100;
localparam WAIT_2ND     = 4'b0010;
localparam LOCKED 	    = 4'b0001;
localparam NB_COUNTER   = $clog2(N_BLOCKS);


//INTERNAL SIGNALS

reg							reset_timer_next, reset_sol_lock;
reg [NB_COUNTER -1 : 0]     timer_search, timer_lock;
reg [N_STATE-1 : 0] 		state 			, next_state;
reg [NB_INVALID_CNT-1 : 0] 	am_invalid_count;


reg [N_ALIGNERS-1 : 0] 	match_mask 	 , match_mask_next ;
reg 					ignore_sh 	 , ignore_sh_next ;
reg 					am_lock   	 , am_lock_next ;
reg 					resync 		 , resync_next ;
reg 					start_of_lane, sol_next	;
reg 					restore_am 	 , rest_am_next;
reg                     reset_match_counter, reset_timer_lock, confirmation_flag;

wire                    match_counter_full;
wire                    invalid_count_full;
wire                    timer_search_done;


//PORTS
assign o_match_mask  		= match_mask;
assign o_ignore_sh   		= ignore_sh;
assign o_enable_mask 		= (state == WAIT_1ST); // verificar si hace falta
assign o_am_lock     		= am_lock;
assign o_restore_am			= restore_am;

//Update state and signaling
always @ (posedge i_clock)
begin
	if(i_reset || !i_block_lock)
	begin
		state 			 <= INIT;
		am_lock 		 <= 0;
	end
	else if (i_enable && i_valid)
	begin
		state 			 <= next_state;
		resync			 <= resync_next;
		am_lock 		 <= am_lock_next;
	end
end

//Update control registers
always @ (posedge i_clock)
begin
	if(i_reset || !i_block_lock)
	begin
		ignore_sh   	 <= 0;
		restore_am 		 <= 0;
		match_mask  	 <= {N_ALIGNERS{1'b1}};
		am_invalid_count <= {NB_INVALID_CNT{1'b0}};
	end
	else if (i_enable && i_valid)
	begin
		ignore_sh   	 <= ignore_sh_next;
		match_mask  	 <= match_mask_next;
		restore_am 		 <= rest_am_next;
	end
end


always @ *
begin
	next_state 		 	  = state;
	am_lock_next 		  = am_lock;
	match_mask_next		  = match_mask;
	ignore_sh_next		  = ignore_sh;
	resync_next			  = 1'b0;
	rest_am_next		  = 1'b0;
	reset_match_counter   = 1'b0;
	reset_timer_lock      = 1'b0;

	case(state)
		INIT://Merge con wait 1st ?
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
				ignore_sh_next    = 1'b1;
				reset_timer_next  = 1'b1;
				rest_am_next	  = 1'b1;
				match_mask_next   = i_match_vector;
				next_state 	      = WAIT_2ND;
			end 
		end
		WAIT_2ND:
		begin
		    confirmation_flag    = 1'b0 ;
		    reset_match_counter = timer_search_done ;
			if(timer_search_done && i_am_valid && match_counter_full)
			begin
				am_lock_next 	 = 1'b1;
				rest_am_next	 = 1'b1;
				next_state 	 = LOCKED;
				/*
				* resetear tanto el  timer search como el
				* timer lock
				* 
				*/
			end
			else if(timer_search_done && !i_am_valid)
			begin
				match_mask_next  = {N_ALIGNERS{1'b1}};
				ignore_sh_next   = 1'b0;
				next_state 		 = WAIT_1ST;
			end
		end
		LOCKED: //verificar que sucede con los contadore cuando se cumple 
			//que el alineador  recibido es invalido pero no se alcanzo la cuenta max
		begin
		    confirmation_flag     = 1'b1;
			if (timer_search_done && i_am_valid)
			begin
				reset_timer_next 	  = 1'b1;
				rest_am_next     	  = 1'b1;
				reset_match_counter   = 1'b1 ;
			end
			else if (i_timer_done && !i_am_valid && invalid_count_full)
			begin
					next_state 		= WAIT_1ST;
					match_mask_next = {N_ALIGNERS{1'b1}};
					ignore_sh_next  = 1'b0;
					am_lock_next 	= 1'b0;
					//reset  timer next				
			end
		end

	endcase
end

//cuenta para am invalid

    always @( posedge i_clock )
    begin
        if ( i_reset || i_valid && reset_match_counter )//verificar correcta precedencia de los operadores
           am_invalid_count <= 0 ;
        else if ( i_timer_done && i_valid )
        begin
            if ( confirmation_flag && i_am_valid )
                am_invalid_count <= am_invalid_count; //quizas no se cupla nuncaa,pero lo dejamos para revisar
            else if ( !i_am_valid )
                am_invalid_count <= am_invalid_count + 1'b1 ;          
        end
    end
    /*
    FIX, match counter full debe depender de alguna cuenta de am validos,la cual no esta siendo realizada

    assign  match_counter_full = ( am_invalid_count == i_lock_thr ) ;       //coincide numero de am_valid con entrada --> LOCK

    */
    assign  invalid_count_full = ( am_invalid_count == i_unlock_thr ) ;     //coincide numero de am_invalid con entrada --> WAIT_1ST
    
   
 //cuenta de timer para busqueda de am   
    
    always @( posedge i_clock )
    begin
        if (i_reset || (i_valid && reset_timer_next))
            timer_search
                <= 0 ;
        else if ( i_valid )
            timer_search
                <= ( timer_search_done )? 0 : timer_search+1'b1 ;
    end
    assign timer_search_done = ( timer_search == N_BLOCKS ) ;


//cuenta de timer para start of lane
    always @( posedge i_clock )
    begin
        if ( i_reset || i_valid && reset_timer_lock )//setear reset timer lock en algun lado !!!
            timer_lock
                <= 1 ;  // FIXME: Use proper value to ensure both counters are equal after resync.
        else if ( i_valid )
            timer_lock 
                <= ( o_start_of_lane )? 0 : timer_lock+1'b1 ;
    end
    //assign o_start_of_lane = ( timer_search == N_BLOCKS ) ;//FIX, la cond de reset deberia ser timer_lock,no timer search
    assign o_start_of_lane = ( timer_lock == N_BLOCKS ) ;
    assign o_resync_by_am_start = reset_timer_lock && ( timer_lock!=timer_search ) ;

endmodule
