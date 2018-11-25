module verification_top_level
	#(	
	parameter                       GPIO_LEN            = 32,
    parameter                       OPCODE_LEN          = 9,
    parameter                       DATA_LEN            = 20,
    parameter                       LEN_CODED_BLOCK     = 66,
    parameter                       LEN_TX_DATA         = 64,
    parameter                       LEN_TX_CTRL         = 8,
    parameter                       RAM_WIDTH_ENCODER   = 66,
    parameter                       RAM_WIDTH_TYPE      = 4,
    parameter                       RAM_ADDR_NBIT       = 5,
    parameter						N_MODULES			= 3					//cantidad de modulos instanciados
	)
	(
	input wire						i_clock,
	input wire						i_reset,
	input wire [GPIO_LEN-1 : 0]		i_gpio_in
	);


wire 								enable_bram;
wire 								enable_encoder;
wire [RAM_WIDTH_TYPE-1 : 0]    		tx_type;
wire [RAM_WIDTH_ENCODER-1 : 0]		tx_coded;
wire 								run_bram;
wire 								read_enb;
wire								mem_full;

assign run_bram  = 1'b1;


register_file
	#(
	.GPIO_LEN(GPIO_LEN),
	.OPCODE_LEN(OPCODE_LEN),
	.DATA_LEN(DATA_LEN),
	.N_MODULES(N_MODULES)
	)
	u_register_file(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_gpio_in(i_gpio_in),
	//.o_gpio_out(),
	//.o_read_enb(),
	//.o_read_address(),
	.o_enable_bram(enable_bram),
	.o_enable_encoder(enable_encoder)
	);

tx_modules
	#(
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK),
	.LEN_TX_DATA(LEN_TX_DATA),
	.LEN_TX_CTRL(LEN_TX_CTRL)
	)
	u_tx_modules(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable_encoder(enable_encoder),
	.o_tx_type(tx_type),
	.o_tx_coded(tx_coded)
	);

bram_control
	#(
	.RAM_WIDTH_ENCODER(RAM_WIDTH_ENCODER),
	.RAM_WIDTH_TYPE(RAM_WIDTH_TYPE),
	.RAM_ADDR_NBIT(RAM_ADDR_NBIT)
	)
	u_bram_control(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_run(run_bram),
	//.i_read_enb(read_enb),
	//.i_read_addr(read_addr),
	.i_data_type(tx_type),
	.i_data_coded(tx_coded),
	//.o_data_type(),
	//.o_data_encoder(),
	.o_mem_full(mem_full)
	);
endmodule