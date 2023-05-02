`timescale 1ns/100ps
module frameChecker
	#(
		parameter									NB_DATA_RAW 		= 64,
		parameter									NB_CTRL_RAW 		= 8,
		parameter									NB_ERROR_COUNTER	= 16,
		parameter                               	MAX_COUNT       	= 255,
		parameter                               	NB_MAX_COUNT    	= $clog2(MAX_COUNT),
		parameter									NB_BYTE				= 8
	)
	(
		input	wire 								i_clock,
		input	wire 								i_reset,
		input	wire 								i_enable,
		input	wire	[NB_DATA_RAW-1 		: 0]	i_rx_raw_data,
		input	wire	[NB_CTRL_RAW-1 		: 0]	i_rx_raw_ctrl,
		output 	wire	[NB_ERROR_COUNTER-1 : 0]	o_error_counter,
		output	wire								o_lock
	);

	localparam										N_STATES 	= 2;
	localparam										NB_STATE	= $clog2(N_STATES);
	localparam										STATE_LOSS	= 0;
	localparam										STATE_LOCK	= 1;

	reg					[NB_STATE-1 		: 0]	state;
	reg					[NB_STATE-1 		: 0]	next_state;

	reg												update_err_counter;
	reg					[NB_ERROR_COUNTER-1 : 0]	error_counter;
	
	wire											match_counter;

	reg					[NB_BYTE-1			: 0]	tx_data_single	[0 : (NB_DATA_RAW/NB_BYTE) - 1];
	reg												tx_data_eq;

	reg					[NB_MAX_COUNT-1 	: 0]	prev_counter;
	reg				    [NB_MAX_COUNT-1 	: 0]	prev_counter_next;

	wire											ctrl_block; 
	assign 											ctrl_block	= |i_rx_raw_ctrl;

	integer data_idx_0;
	always @ (*) begin
		for(data_idx_0 = 0; data_idx_0 < NB_DATA_RAW/NB_BYTE; data_idx_0 = data_idx_0 + 1) begin
			tx_data_single[data_idx_0] = i_rx_raw_data[NB_DATA_RAW - 1 - (data_idx_0*NB_BYTE) -: NB_BYTE];
		end
	end

	integer data_idx_1;
	always @ (*) begin
		tx_data_eq = 1;
		for(data_idx_1 = 0; data_idx_1 < (NB_DATA_RAW/NB_BYTE) - 1; data_idx_1 = data_idx_1 + 1) begin
			tx_data_eq = tx_data_eq & (tx_data_single[data_idx_1] == tx_data_single[data_idx_1+1]);
		end
	end

	always@(posedge i_clock) begin
		if(i_reset) begin
			prev_counter <= 'd0;
		end
		else if(i_enable & ~ctrl_block) begin
			prev_counter <= prev_counter_next;
		end
	end

	always@(posedge i_clock) begin
		if(i_reset) begin
			state <= STATE_LOSS;
		end
		else if(i_enable & ~ctrl_block) begin
			state <= next_state;
		end
	end

	always@(posedge i_clock) begin
		if(i_reset) begin
			error_counter <= {NB_ERROR_COUNTER{1'b0}};
		end
		else if(i_enable & ~ctrl_block & update_err_counter) begin
			error_counter <= error_counter + 1;
		end
	end	
	
	wire overflow_count;
	assign overflow_count = (prev_counter == 8'hff);
	assign	match_counter = tx_data_eq & (tx_data_single[0] ==  prev_counter_next);

	always @ (*) begin

		update_err_counter 	= 1'b0;
		next_state			= state;
		prev_counter_next	= prev_counter+1;

		case(state)
			
			STATE_LOSS: begin
				prev_counter_next	= tx_data_single[0];
				if(match_counter) begin
					next_state 			= STATE_LOCK;
				end
			end

			STATE_LOCK: begin
				if(!match_counter) begin
					next_state			= STATE_LOSS;
					update_err_counter 	= 1'b1;
				end
			end

			default: begin
				next_state 			= STATE_LOSS;
			end
		
		endcase 
	end

	assign 	o_lock 			= (state == STATE_LOCK);
	assign 	o_error_counter	= error_counter;

endmodule

