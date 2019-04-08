module frameChecker
	#(
	parameter								LEN_DATA_BLOCK 	= 64,
	parameter								LEN_CTRL_BLOCK 	= 8,
	parameter								LEN_GNG			= 16,
	parameter								N_BLOCKS		= 2048
	)
	(
	input									i_clock,
	input									i_reset,
	input									i_enable,
	input 	wire	[LEN_DATA_BLOCK-1 : 0]	i_tx_data,
	input 	wire	[LEN_CTRL_BLOCK-1 : 0]	i_tx_ctrl,
	input	wire	[LEN_DATA_BLOCK-1 : 0]	i_rx_raw_data,
	input	wire	[LEN_CTRL_BLOCK-1 : 0]	i_rx_raw_ctrl,
	output 	wire							o_match_data,
	output	wire							o_match_ctrl
	);

	localparam								DEPTH			= 2048;
	localparam								NB_ADDR_RAM		= $clog2(DEPTH);
	localparam 								NB_PERIOD_CNTR	= $clog2(N_BLOCKS); 

	reg 									read_enable;
	reg										run_memory;
	reg				[NB_PERIOD_CNTR-1 : 0]	period_counter;
	reg                                     match_ctrl;
	reg                                     match_data;

	reg				[NB_PERIOD_CNTR-1 : 0]	current_error;			
	reg				[NB_PERIOD_CNTR-1 : 0]	min_error;				//Worst scenario is min_error = N_BLOCKS
	reg                                     reset_current_error;
	reg				[NB_ADDR_RAM-1 : 0]		read_ptr;
	reg				[NB_ADDR_RAM-1 : 0]		min_read_ptr;
	

	wire			[LEN_CTRL_BLOCK-1 : 0]	ctrl_compare;
	wire			[LEN_DATA_BLOCK-1 : 0]	data_compare;
	wire 									depth_flag;
	
	assign  	depth_flag            = (read_ptr == 2**(NB_ADDR_RAM-1)) ? 1 : 0;
    

	/*	Run de memoria	*/
	always @ (posedge i_clock)
	begin

        read_enable <= 1;	
		
		if(i_reset) 
		
			run_memory 		<= 0;
	
		else if(i_enable) 

		    run_memory  	<= 1;

	end


	/*	Incremento el read pointer automaticamente	*/
	always @ (posedge i_clock) 
	begin
		
		if(i_reset)
		begin
			period_counter	    <= {NB_PERIOD_CNTR{1'b0}};
			read_ptr 	        <= {NB_ADDR_RAM{1'b0}};
			reset_current_error <= 1'b0;
		end
		else if(i_enable && !depth_flag)
		begin
			period_counter 	    <= period_counter + 1;
			read_ptr 		    <= read_ptr;

			if(period_counter == N_BLOCKS-1)
			begin
				period_counter 	<= {NB_PERIOD_CNTR{1'b0}};
				read_ptr 		<= read_ptr + 1;
                reset_current_error <= 1'b1;
                		
				if(current_error < min_error)
                begin
                    min_error           <= current_error;
                    min_read_ptr        <= read_ptr;
                end
			end
		end

	end

	/*	Comparacion entre la salida del deco y la entrada al encoder */
    always @ *
    begin
        match_ctrl = 0;
        if(read_enable)
        begin
            match_ctrl = (ctrl_compare == i_rx_raw_ctrl) ? 1 : 0;
        end
    end 

    assign o_match_ctrl = match_ctrl;


	/*	error counter	*/	
	always @ (posedge i_clock)
	begin

		if(i_reset)
		begin
			min_error		<= {NB_PERIOD_CNTR{1'b1}}; 	//After reset, has max value possible
			current_error	<= {NB_PERIOD_CNTR{1'b0}};
			min_read_ptr	<= {NB_ADDR_RAM{1'b0}};
		end
		else if(i_enable)
		begin
			
			if(reset_current_error)
			begin
			    current_error	<= {NB_PERIOD_CNTR{1'b0}};
			    reset_current_error <= 1'b0;
			end    
			else if(match_ctrl)
				current_error <= current_error;
			
			else if(!match_ctrl)
			    current_error <= current_error +1; 

		end
	end


shift_memory
    #(
    .NB_DATA(LEN_CTRL_BLOCK),
    .NB_ADDR(NB_ADDR_RAM)
    )
    u_shift_memory
    (
    .i_clock(i_clock),
    .i_write_enb(run_memory),
    .i_data(i_tx_ctrl),
    .i_read_addr(read_ptr),
    .i_read_enb(read_enable),
    .o_data(ctrl_compare)
    );

endmodule

