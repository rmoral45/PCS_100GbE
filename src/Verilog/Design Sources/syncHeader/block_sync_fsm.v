

module block_sync_fsm
#(
	parameter                           NB_DATA_CODED	= 66,
	parameter                           MAX_INDEX_VALUE = (NB_DATA_CODED - 2),
	parameter                           MAX_INVALID_SH  = 6,
	parameter                           MAX_WINDOW	    = 2048,
	parameter                           NB_WINDOW_CNT	= $clog2(MAX_WINDOW),
	parameter                           NB_INVALID_CNT 	= $clog2(MAX_INVALID_SH),
	parameter                           NB_INDEX 		= $clog2(NB_DATA_CODED)

 )
 (
 	input  wire 				        i_clock,
 	input  wire 				        i_reset,
 	input  wire 				        i_enable,
 	input  wire 				        i_valid,
 	input  wire 				        i_signal_ok,
 	input  wire 				        i_sh_valid,
 	input  wire [NB_WINDOW_CNT -1 : 0] 	i_rf_unlckd_thr, //usado por timer interno
 	input  wire [NB_WINDOW_CNT -1 : 0] 	i_rf_lckd_thr, //usado por timer interno
 	input  wire [NB_INVALID_CNT-1 : 0] 	i_rf_sh_invalid_thr,

 	output wire [NB_INDEX-1 : 0]		o_block_index,
 	output wire [NB_INDEX-1 : 0]		o_search_index,
 	output wire 				        o_block_lock	     
 );


//LOCALPARAMS

localparam N_STATES  = 2;

localparam UNLOCKED  = 2'b10;
localparam LOCKED  	 = 2'b01;

//INTERNAL SIGNALS

reg 			   					    block_lock;
reg 								    reset_count;
reg             [NB_INVALID_CNT-1 : 0]  sh_invalid_count;
reg             [N_STATES-1 : 0]		state, next_state;
reg             [NB_INDEX-1 : 0]		search_index, next_search_index;
reg             [NB_INDEX-1 : 0]		block_index, next_block_index;
reg             [NB_WINDOW_CNT-1 : 0] 	timer_search;
reg 								    update_search_index;
reg 								    update_block_index;
reg 								    reset_search_index;
reg                                     reset_timer;

wire 								    locked_timer_done;
wire 								    unlocked_timer_done;
wire								    invalid_counter_full;

/*
	Realizar todas las asignaciones de puertos correspondientes
*/

//OUTPUT PORTS
assign                                  o_search_index  = search_index;
assign                                  o_block_index   = block_index;
assign                                  o_block_lock    = block_lock;

//Update state
always @ (posedge i_clock)
begin

	if( i_reset || ~i_signal_ok)
		state <= UNLOCKED;

	else if(i_enable && i_valid)
		state <= next_state;

end

//Update index used to search valid sync-headers in input stream
always @ (posedge i_clock)
begin

	if (i_reset || ~i_signal_ok || reset_search_index)
	begin
		search_index <= {NB_INDEX{1'b0}};
	end

	else if (i_enable && i_valid && update_search_index)
	begin
		if (search_index == MAX_INDEX_VALUE)
			search_index <= {NB_INDEX{1'b0}};
		else
			search_index <= search_index + 1'b1;
	end

end

//Update index used to select data from input stream
always @ (posedge i_clock)
begin
	
	if (i_reset || ~i_signal_ok)
		block_index <= {NB_INDEX{1'b0}};

	else if (i_enable && i_valid && update_block_index)
		block_index <= (search_index == 0) ? search_index : 
		                                     search_index + 1;
end


always @ *
begin
	next_state		= state;
	reset_count 		= 1'b0;
	reset_timer		= 1'b0;
	update_search_index	= 1'b0;
	update_block_index	= 1'b0;
	reset_search_index 	= 1'b0;

	case(state)
		UNLOCKED:
		begin

			block_lock 	= 1'b0;
			if(!i_sh_valid)
			begin
			        reset_timer 		= 1'b1;
				reset_count 		= 1'b1;
				update_search_index 	= 1'b1;
			end
			else if(unlocked_timer_done)
			begin
				reset_count 		= 1'b1;
				reset_timer 		= 1'b1;
				update_block_index 	= 1'b1;
				next_state  		= LOCKED;
			end

		end//end UNLOCKED state

		LOCKED:begin

			block_lock 	= 1'b1;
			if(locked_timer_done)
			begin
				reset_count = 1'b1;
				reset_timer = 1'b1;		
			end

			else if(invalid_counter_full)
			begin
				//block_lock_next		= 1'b0;
				reset_count 		= 1'b1;
				reset_timer 		= 1'b1;
				/*
					Aca tenemos dos opciones,o reseteamos search_index 
					y comenzamos del inicio, o hacemos un update
				*/
				reset_search_index 	= 1'b1;
				next_state			= UNLOCKED;
			end
			
		end // end LOCKED state
	endcase
	
end


//cuenta de sh invalidos

always @ (posedge i_clock)
begin

	if (i_reset || reset_count )
		sh_invalid_count <= {NB_INVALID_CNT{1'b0}};

	else if (i_valid && !i_sh_valid)
		sh_invalid_count <= sh_invalid_count + 1'b1;
	
end

assign invalid_counter_full = (sh_invalid_count >= i_rf_sh_invalid_thr) ? 1'b1 : 1'b0;


//cuenta de timer
always @ (posedge i_clock)
begin
	
	if (i_reset || reset_timer)
		timer_search <= {NB_WINDOW_CNT{1'b0}};

	else if (i_valid)
		timer_search <= timer_search + 1'b1;

end 

assign unlocked_timer_done  = (timer_search == i_rf_unlckd_thr);//time window to search for sh in unlocked state
assign locked_timer_done    = (timer_search == i_rf_lckd_thr); 


endmodule


