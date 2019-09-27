`timescale 1ns/100ps

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
 	input  wire 				i_clock ,
 	input  wire 				i_reset ,
 	input  wire 				i_enable ,
 	input  wire 				i_valid ,
 	input  wire 				i_block_lock ,
 	input  wire 				i_am_valid  ,
 	input  wire [N_ALIGNERS-1 : 0] 		i_match_vector ,
 	input wire  [NB_VALID_CNT-1 : 0]    	i_lock_thr,       //contador para am validos
 	input wire  [NB_INVALID_CNT-1 : 0]  	i_unlock_thr,     //contador para am invalidos

 	output wire [N_ALIGNERS-1 : 0] 		o_match_mask ,
 	output wire				o_enable_mask ,
 	output wire 				o_am_lock ,	    //quizas no haga falta ya que manejamos todo con resync
 	output wire 				o_resync_by_am_start ,
 	output wire 				o_start_of_lane ,
	output wire 				o_search_timer_done //entrada al comparator
 );

//LOCALPARAMS

localparam N_STATE      = 4;
localparam INIT         = 4'b1000;
localparam WAIT_1ST     = 4'b0100;
localparam WAIT_2ND     = 4'b0010;
localparam LOCKED 	= 4'b0001;
localparam NB_COUNTER   = $clog2(N_BLOCKS);


//INTERNAL SIGNALS

reg				reset_timer_next, reset_sol_lock;
reg [NB_COUNTER -1 : 0]     	timer_search	, timer_lock;
reg [N_STATE-1 : 0] 		state 		, next_state;
reg [NB_INVALID_CNT-1 : 0] 	am_invalid_count;
reg [NB_VALID_CNT-1 : 0] 	am_valid_count;


reg [N_ALIGNERS-1 : 0] 	match_mask 	 , match_mask_next ;
reg 			am_lock   	 , am_lock_next ;
reg 			restore_am 	 , rest_am_next; 
reg                     reset_match_counter, reset_timer_lock, confirmation_flag;
reg 			rst_good_am_cnt;

wire                    match_counter_full;
wire                    invalid_count_full;
wire                    timer_search_done;


//PORTS
assign o_match_mask  		= match_mask;
assign o_enable_mask 		= (state == WAIT_1ST); // verificar si hace falta
assign o_am_lock     		= am_lock;

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
		am_lock 		 <= am_lock_next;
	end
end

//Update control registers
always @ (posedge i_clock)
begin
	if(i_reset || !i_block_lock)
	begin
		match_mask  	 <= {N_ALIGNERS{1'b1}};
	end
	else if (i_enable && i_valid)
	begin
		match_mask  	 <= match_mask_next;
	end
end


always @ *
begin
	next_state 		  = state;
	am_lock_next 		  = am_lock;
	match_mask_next		  = match_mask;
	rest_am_next		  = 1'b0;
	reset_match_counter   = 1'b0;
	reset_timer_lock      = 1'b0;
	reset_timer_next 	  = 1'b0;
	confirmation_flag	  = 1'b0;
	rst_good_am_cnt 	  = 1'b0;

	case(state)
		INIT://Merge con wait 1st ?
		begin

			am_lock_next 	= 1'b0;
			match_mask_next	= {N_ALIGNERS{1'b1}};
			next_state   	= WAIT_1ST;

		end

		WAIT_1ST:
		begin

			if (i_am_valid)
			begin
				reset_timer_next  = 1'b1;
				rest_am_next	  = 1'b1;
				match_mask_next   = i_match_vector;
				next_state 	      = WAIT_2ND;
			end

		end

		WAIT_2ND:
		begin

			if(timer_search_done && i_am_valid && match_counter_full)
			begin

				am_lock_next 	 	= 1'b1;
				rest_am_next	 	= 1'b1;
				reset_timer_lock 	= 1'b1;
				reset_timer_next 	= 1'b1;
				reset_match_counter = 1'b1;
				next_state 	 	 	= LOCKED;

			end
			else if(timer_search_done && !i_am_valid)
			begin

				match_mask_next  = {N_ALIGNERS{1'b1}};
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
				reset_match_counter   = 1'b1;

			end
			else if (timer_search_done && !i_am_valid && invalid_count_full)
			begin

				next_state 		= WAIT_1ST;
				match_mask_next = {N_ALIGNERS{1'b1}};
				am_lock_next 	= 1'b0;
				rst_good_am_cnt = 1'b1;
				reset_match_counter = 1'b1;
							
			end
		end

	endcase
end

//cuenta para am invalid

    always @( posedge i_clock )
    begin

        if ( i_reset || (i_valid && reset_match_counter))
        begin
           am_invalid_count <= 0;
        end

        else if (i_valid && timer_search_done)
        begin
            if ( confirmation_flag && i_am_valid )
					am_invalid_count <= am_invalid_count; //en realidad si estoy LOCKED y recibo am valido deberia resetear esta cuenta
            else if ( !i_am_valid )
                	am_invalid_count <= am_invalid_count + 1'b1;
        end

    end

    assign  invalid_count_full = ( am_invalid_count == i_unlock_thr ) ; //coincide numero de am_invalid con entrada --> WAIT_1ST


 //cuenta de am validos, se realiza para poder obtener el estado de lock

    always @ ( posedge i_clock)
    begin

    	if (i_reset || rst_good_am_cnt)
    	begin
    		am_valid_count <= {NB_VALID_CNT{1'b0}};
    	end
    	else if (i_valid && timer_search_done)
    	begin
    		am_valid_count <= (i_am_valid) ? (am_valid_count + 1'b1) : 0;
    	end

    end

    assign match_counter_full = (am_valid_count == i_lock_thr) ? 1'b1 : 1'b0;
   
 //cuenta de timer para busqueda de am   
    
    always @( posedge i_clock )
    begin
        if (i_reset || (i_valid && reset_timer_next))
            timer_search
                <= 1 ; 
        else if ( i_valid )
            timer_search
                <= ( timer_search_done )? 1 : timer_search+1'b1 ;
    end

    assign timer_search_done = ( timer_search == N_BLOCKS) ;
    assign o_search_timer_done = timer_search_done;


//cuenta de timer para start of lane
    always @( posedge i_clock )
    begin
        if ( i_reset || i_valid && reset_timer_lock )//setear reset timer lock en algun lado !!!
            timer_lock
                <= 1 ;  // FIXME: Use proper value to ensure both counters are equal after resync.
        else if ( i_valid )
            timer_lock 
                <= ( o_start_of_lane )? 1 : timer_lock+1'b1 ;
    end

    // PORTS
    assign o_start_of_lane = ( timer_lock == N_BLOCKS ) ;
    assign o_resync_by_am_start = reset_timer_lock && ( timer_lock!=timer_search ) ;

endmodule
