


module block_sync_fsm   //*** realizar con menos estados y que reaccione sin necesidad de tener clocks extra.
#(
	parameter LEN_CODED_BLOCK    = 66,
	parameter MAX_INVALID_SH     = 6,
	parameter MAX_WINDOW	     = 2048,
	parameter NB_WINDOW_CNT      = $clog2(MAX_WINDOW),
	parameter NB_INVALID_CNT 	 = $clog2(MAX_INVALID_AM)

 )
 (
 	input  wire i_clock			   		,
 	input  wire i_reset			   		,
 	input  wire i_enable		   		,
 	input  wire i_valid			   		,
 	input  wire i_signal_ok 	   		,
 	input  wire i_sh_valid  	   			,
 	input  wire [NB_WINDOW_CNT -1 : 0] i_unlocked_count_limit  	, //usado por timer interno
 	input  wire [NB_WINDOW_CNT -1 : 0] i_locked_count_limit   	, //usado por timer interno
 	input  wire [NB_INVALID_CNT-1 : 0] i_sh_invalid_limit 		,

 	output wire o_index			     
 );


//LOCALPARAMS

localparam N_STATES  = 2;

localparam UNLOCKED  = 2'b10;
localparam LOCKED  	 = 2'b01;
localparam NB_INDEX = $clog2(LEN_CODED_BLOCK) ; //***

//INTERNAL SIGNALS

reg 			   					block_lock  , block_lock_next	;
reg				   					test_sh     , test_sh_next		;
reg 								reset_count , reset_count_next  ;
reg [NB_CNT-1 : 0] 					sh_cnt      , sh_cnt_next 		;
reg [NB_INVALID_CNT-1 : 0] 			sh_invld_cnt, sh_invld_cnt_next ;
reg [N_STATES-1 : 0]				state 		, state_next		;
reg [NB_INDEX-1 : 0]				index 		, index_next		;							

wire locked_count_done;
wire unlocked_count_done;

//Update state signals
always @ (posedge i_clock)
begin
	if( i_reset || ~i_signal_ok)
	begin
		state 	   	 <= UNLOCKED;
		block_lock 	 <= 0;
		sh_invld_cnt <= 0;
		index 		 <= 0;
		reset_count  <= 0;
	end
	else if(i_enable && i_valid)
	begin
		block_lock 	 <= block_lock_next;
		sh_invld_cnt <= sh_invld_cnt_next;
		reset_count  <= reset_count_next;
		state 	   	 <= state_next;
		index 		 <= index_next;
	end
end



always @ *
begin
	block_lock_next   = block_lock  ;
	sh_invld_cnt_next = sh_invld_cnt;
	state_next 		  = state;
	index_next 		  = index;
	reset_count_next  = 1'b0;

	case(state)
		UNLOCKED:
		begin
			if(!i_sh_valid)
				reset_count_next = 1'b1;
			else if(unlocked_count_done)
			begin
				state_next = LOCKED;
				block_lock_next  = 1;
				reset_count_next = 1'b1; 
			end
		end//end UNLOCKED state

		LOCKED:begin
			if(locked_count_done)
			begin
				sh_invld_cnt_next = 0;
				reset_count_next  = 1'b1;		
			end
			else if( sh_invld_cnt >= i_sh_invalid_limit )
			begin
				block_lock_next   = 0;
				index_next 		  = index + 1;
				reset_count_next  = 1'b1;
				sh_invld_cnt_next = 0;
				state_next 		  = UNLOCKED;
			end
			else if(!i_sh_valid)
			begin
				sh_invld_cnt_next = sh_invld_cnt + 1;
			end
		end // end LOCKED state
	endcase
	
end



//block window timer

/*
	La cuenta se resetea solo comandada por la FSM,sino cuenta hasta hacer overflow
	al alcanzar el valor de ventana maximo,definbida por el parameter MAX_WINDOW
*/

block_sync_timer
#(
	.MAX_WINDOW(MAX_WINDOW)
 )
	u_timer
	(
		.i_clock(i_clock),
		.i_reset(reset),
		.i_reset_count(reset_count),
		.i_enable(i_enable),
		.i_valid(i_valid),
		.i_unlocked_count_limit(i_unlocked_count_limit),
		.i_locked_count_limit(i_locked_count_limit),
		.o_unlocked_count_done(unlocked_count_done),
		.o_locked_count_done(locked_count_done)
	);


endmodule


