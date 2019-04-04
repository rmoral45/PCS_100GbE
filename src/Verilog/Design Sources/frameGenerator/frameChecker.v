module frameChecker
	#(
	parameter								LEN_DATA_BLOCK 	= 64,
	parameter								LEN_CTRL_BLOCK 	= 8,
	parameter								LEN_GNG			= 16,
	parameter								NB_TERM			= 3,
	parameter								NB_DATA			= 8,
	parameter								NB_IDLE			= 5
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

	localparam								DEPTH			= 32;
	localparam								NB_ADDR_RAM		= $clog2(DEPTH);

	reg 									read_enable;
	reg										run_memory;
	reg				[NB_ADDR_RAM-1 : 0]		read_addr;
	reg                                     match_ctrl;
	reg                                     match_data;

	wire									mem_full;
	wire			[LEN_CTRL_BLOCK-1 : 0]	ctrl_compare;
	wire			[LEN_DATA_BLOCK-1 : 0]	data_compare;
    



	always @ (posedge i_clock)
	begin

        read_enable <= 1;	
		
		if(i_reset)
		
			run_memory 	<= 0;

		
		else if(i_enable)
		    run_memory  <= 1;
	end


    always @ *
    begin
        match_ctrl = 0;
        if(read_enable)
        begin
            match_ctrl = (ctrl_compare == i_rx_raw_ctrl) ? 1 : 0;
            //match_data = (data_compare == i_rx_raw_data) ? 1 : 0;
        end
    end 
    //assign o_match_data = (data_compare == i_rx_raw_data) ? 1 : 0;
    assign o_match_ctrl = match_ctrl;

/*log_memory
	#(
	.NB_DATA(LEN_CTRL_BLOCK),
	.DEPTH(DEPTH)
	)
ctrl_block_memory
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_run(run_memory),
	.i_read_addr(read_addr),
	.i_data(i_tx_ctrl),
	//.i_data(i_rx_raw_ctrl),
	.o_full(mem_full),
	.o_data(ctrl_compare)
	);*/
	
	
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
    .i_read_addr(5'd4),
    .i_read_enb(read_enable),
    .o_data(ctrl_compare)
    );
    
    

/*log_memory
	#(
	.NB_DATA(LEN_DATA_BLOCK),
	.DEPTH(DEPTH)
	)	
data_block_memory
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_run(run_memory),
	.i_read_addr(read_addr),
	.i_data(i_tx_data),
	.o_full(mem_full),
	.o_data(ctrl_compare)
	)*/

endmodule

