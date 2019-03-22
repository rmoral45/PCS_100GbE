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

	localparam								DEPTH			= 16;
	localparam								NB_ADDR_RAM		= $clog2(DEPTH);

	reg 									read_enable;
	reg										run_memory;
	reg				[NB_ADDR_RAM-1 : 0]		read_addr;

	wire									mem_full;
	wire			[LEN_CTRL_BLOCK-1 : 0]	ctrl_compare;
	wire			[LEN_DATA_BLOCK-1 : 0]	data_compare;


	assign o_match_data = (data_compare == i_rx_raw_data) ? 1 : 0;
	assign o_match_ctrl = (ctrl_compare == i_rx_raw_ctrl) ? 1 : 0;


	always @ (posedge i_clock)
	begin
	
		if(i_reset)
		begin
			run_memory 	<= 0;
			read_enable	<= 0;
			read_addr 	<= {NB_ADDR_RAM{1'b0}};
		end
		else if(i_enable && !mem_full)
		begin
			run_memory	<= 1;
			//read_enable <= 1;
			read_enable <= read_enable;
			read_addr 	<= read_addr;
		end
		else if(i_enable && mem_full)
		begin
			run_memory 	<= 0;
			read_enable	<= 1;
			read_addr 	<= read_addr + 1;
		end

	end


log_memory
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
	.o_full(mem_full),
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

