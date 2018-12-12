module verification_top_level
  #(	
	parameter                       GPIO_LEN            	= 32,
    parameter                       OPCODE_LEN          	= 9,
    parameter                       DATA_LEN            	= 20,
    parameter                       RAM_ADDR_NBIT       	= 5,
    parameter						LEN_TX_DATA 			= 64,
    parameter 						LEN_RX_CTRL 			= 8,
    parameter						LEN_RX_DATA 			= 64,
    parameter 						LEN_TX_CTRL 			= 8,    
    parameter						LEN_CODED_BLOCK			= 66,
    parameter						LEN_TYPE				= 4,
    parameter						N_MODULES				= 5					//cantidad de modulos instanciados	
	)
	(
	input wire						i_clock,
	input wire						i_reset,
	input wire [GPIO_LEN-1 : 0]		i_gpio_in
	);


wire 								enable_bram;
wire 								enable_encoder;
wire 								enable_scrambler;
wire 								enable_descrambler;
wire 								enable_decoder;
wire [LEN_TX_DATA-1 : 0]			tx_data;
wire [LEN_TX_CTRL-1 : 0]			tx_ctrl;
wire [LEN_RX_DATA-1 : 0]			rx_raw_data;
wire [LEN_RX_CTRL-1 : 0]			rx_raw_ctrl;
wire 								read_enable;
wire [RAM_ADDR_NBIT-1 : 0]          read_addr;
wire								mem_full;
wire [LEN_RX_CTRL-1 : 0]           	log_ctrl_decoded;
wire [LEN_RX_DATA-1 : 0]        	log_data_decoded;

register_file
	#(
	.GPIO_LEN(GPIO_LEN),
	.OPCODE_LEN(OPCODE_LEN),
	.DATA_LEN(DATA_LEN),
	.N_MODULES(N_MODULES),
	.RAM_ADDR_NBIT(RAM_ADDR_NBIT)
	)
	u_register_file
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_gpio_in(i_gpio_in),
	//.o_gpio_out(),
	.o_enable_read(read_enable),
	.o_read_address(read_addr),
	.o_enable_bram(enable_bram),
	.o_enable_encoder(enable_encoder),
	.o_enable_cgmii(enable_cgmii)
	);

tx_modules
	#(
	)
u_tx_modules
	(
	.i_clock				(i_clock)			,
	.i_reset				(i_reset)			,
	.i_enable_encoder		(enable_encoder)	,
	.i_tx_data 				(tx_data)			,
	.i_tx_ctrl 				(tx_ctrl)			,
	.i_bypass 				(bypass)			,
	.i_enable_scrambler 	(enable_scrambler)	,
	.i_enable_descrambler	(enable_descrambler),
	.o_rx_raw_data 			(rx_raw_data)		,
	.o_rx_raw_ctrl			(rx_raw_ctrl)
	);

bram_control
	#(
	)
	u_bram_control
	(
	.i_clock		(i_clock)	  	  ,
	.i_reset		(i_reset)	  	  ,
	.i_run			(enable_bram) 	  ,
	.i_read_enb		(read_enb)	  	  ,
	.i_read_addr	(read_addr)	  	  ,
	.i_ctrl_decoded	(rx_raw_ctrl) 	  ,
	.i_data_decoded	(rx_raw_data) 	  ,
	.o_data_decoded	(log_ctrl_decoded),
	.o_ctrl_decoded	(log_data_decoded),
	.o_mem_full		(mem_full)
	);
endmodule