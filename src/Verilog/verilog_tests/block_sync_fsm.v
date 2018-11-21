


module block_sync_fsm
#(
 )
 (
 	input  wire i_clock		,
 	input  wire i_reset		,
 	input  wire i_signal_ok ,
 	input  wire i_test_sh   , //vale 1 cuando se acumularon 66 bits desde PMA
 	input  wire i_sh_valid  ,
 )


//LOCALPARAMS

localparam N_STATES   = 9;

localparam LOCK_INIT  = 9'b100000000;
localparam RESET_CNT  = 9'b010000000;
localparam TEST_SH    = 9'b001000000;
localparam VALID_SH   = 9'b000100000;
localparam _64_GOOD   = 9'b000010000;
localparam TEST_SH2   = 9'b000001000;
localparam INVALID_SH = 9'b000000100;
localparam VALID_SH2  = 9'b000000010;
localparam SLIP       = 9'b000000001;

localparam NB_CNT = 11;
localparam NB_INV = 8;

//INTERNAL SIGNALS

reg 			   		block_lock  , block_lock_next	;
reg				   		test_sh     , test_sh_next		;
reg [NB_CNT-1 : 0] 		sh_cnt      , sh_cnt_next 		;
reg [NB_INV-1 : 0] 		sh_invld_cnt, sh_invld_cnt_next ;
reg [N_STATES-1 : 0]	state 		, state_next		;



//Update state signals
always @ (posedge i_clock)
begin
	if( i_reset || ~i_signal_ok)
	begin
		state 	   	 <= LOCK_INIT;
		block_lock 	 <= 0;
		test_sh    	 <= 0;
		sh_cnt 	     <= 0;
		sh_invld_cnt <= 0;
	end
	else 
	begin
		test_sh    	 <= test_sh_next; // no lo necesito creo
		block_lock 	 <= block_lock_next;
		sh_cnt 		 <= sh_cnt_next;
		sh_invld_cnt <= sh_invld_cnt_next;
		state 	   	 <= state_next;
	end
end



always @ *
begin
	block_lock_next   = block_lock  ;
	sh_cnt_next 	  = sh_cnt      ;
	sh_invld_cnt_next = sh_invld_cnt;
	state_next = state;

	case(state)
		LOCK_INIT: 
		begin
			block_lock_next = 0;
			test_sh_next 	= 0;
			state_next 		= RESET_CNT;
		end
		RESET_CNT:
		begin
			sh_cnt_next 	  = 0;
			sh_invld_cnt_next = 0;
			//slip_done = 0; checkear si es necesari
			if (i_test_sh && block_lock == 0 )
				state_next = TEST_SH;
			else if (i_test_sh && block_lock == 1)
				state_next = TEST_SH2;
		end
		TEST_SH:
		begin
			test_sh_next = 0; //check
			if(i_sh_valid)begin
				sh_cnt_next = sh_cnt + 1;
				state_next  = VALID_SH;
			end
			else begin
				sh_cnt_next       = sh_cnt + 1;
				sh_invld_cnt_next = sh_invld_cnt +1;
				state_next		  = INVALID_SH;
			end
		end
		VALID_SH:
		begin
			if (sh_cnt == 64)
				state_next = _64_GOOD;
			else if (i_test_sh && (sh_cnt < 64))
				state_next = TEST_SH;
		end
		_64_GOOD:
		begin
			block_lock_next = 1;
			state_next = RESET_CNT;
		end
		TEST_SH2:
		begin
			
		end
		INVALID_SH:
		begin
			
		end
		VALID_SH2:
		begin
			
		end
		SLIP:
		begin
			
		end

	endcase
	
end


