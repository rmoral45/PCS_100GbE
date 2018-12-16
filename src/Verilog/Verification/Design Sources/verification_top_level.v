
`include "/home/diego/fundacion/PPS/src/Verilog/Verification/Micro_files/verification_files.v"

module verification_top_level
  #(
  	parameter						NB_GPIOS				= `NB_GPIOS,
  	parameter 						NB_LEDS					= `NB_LEDS,
  	parameter						RAM_DEPTH				= `RAM_DEPTH,
  	parameter 						NB_ADDR_RAM				= $clog2(RAM_DEPTH),
  	parameter 						NB_OPCODE				= `NB_OPCODE,
  	parameter 						NB_DATA 				= `NB_DATA,
  	parameter	 					N_MODULES 				= `N_MODULES,
  	parameter 						LEN_DATA_BLOCK 			= `LEN_DATA_BLOCK,
  	parameter						LEN_CTRL_BLOCK			= `LEN_CTRL_BLOCK,
  	parameter						LEN_CODED_BLOCK			= `LEN_CODED_BLOCK, 						
  	parameter 						LEN_TYPE 				= `LEN_TYPE
	)
	(
	input                           i_clock,
    input wire                      i_reset,
    input wire                      i_rx_uart,
    output wire  [NB_LEDS-1 : 0]    o_leds,
    output wire                     o_tx_uart
	);

wire 								enable_bram;
wire 								enable_encoder;
wire 								enable_scrambler;
wire 								enable_descrambler;
wire 								enable_decoder;
wire [LEN_DATA_BLOCK-1 : 0]			tx_data;
wire [LEN_CTRL_BLOCK-1 : 0]			tx_ctrl;
wire [LEN_DATA_BLOCK-1 : 0]			rx_raw_data;
wire [LEN_CTRL_BLOCK-1 : 0]			rx_raw_ctrl;
wire 								read_enable;
wire [NB_ADDR_RAM-1 : 0]    	    read_addr;
wire								mem_full;
wire [LEN_CTRL_BLOCK-1 : 0]     	log_ctrl_decoded;
wire [LEN_DATA_BLOCK-1 : 0]        	log_data_decoded;


wire          [NB_GPIOS-1 : 0]   gpo0;
wire          [NB_GPIOS-1 : 0]   gpi0;
wire                             locked;
wire                             soft_reset;
wire                             clock_u;
wire                             bypass;


//DEBUG
wire invalid_opcode;
wire [8 : 0] opcode;


	assign bypass = 1'b0;

   ///////////////////////////////////////////
   // Leds
   ///////////////////////////////////////////
   	assign o_leds[0] = locked;
   	assign o_leds[1] = ~i_reset;
   	assign o_leds[2] = invalid_opcode;
   	assign o_leds[3] = gpo0[13];

   	assign o_leds[4] = opcode[0];
   	assign o_leds[5] = opcode[1];
   	assign o_leds[6] = opcode[2];

   	assign o_leds[7] = opcode[3];
   	assign o_leds[8] = opcode[4];
   	assign o_leds[9] = opcode[5];

   	assign o_leds[10] = opcode[6];
   	assign o_leds[11] = opcode[7];
   	assign o_leds[12] = opcode[8];

   	assign o_leds[13] = gpo0[9];
   	
   	assign o_leds[14] = gpo0[10];
   	assign o_leds[15] = gpo0[11];
   
   
   
   
MicroGPIO
	#(
	)
u_micro
   	(
   	.clock100        (clock_u)   ,  // Clock aplicacion
   	.gpio_rtl_tri_i  (gpo0)       ,  // GPIO
   	.gpio_rtl_tri_o  (gpi0)       ,  // GPIO
   	.reset           (~i_reset)    ,  // Hard Reset
   	.sys_clock       (i_clock)    ,  // Clock de FPGA
   	.o_lock_clock    (locked)     ,  // Senal Lock Clock
   	.usb_uart_rxd    (i_rx_uart ) ,  // UART
   	.usb_uart_txd    (o_tx_uart)   	 // UART
   	);

register_file
	#(
	.NB_GPIOS(NB_GPIOS),
	.NB_OPCODE(NB_OPCODE),
	.NB_DATA(NB_DATA),
	.N_MODULES(N_MODULES),
	.NB_ADDR_RAM(NB_ADDR_RAM)
	)
u_register_file
	(
	.i_clock				(clock_u),
	.i_reset				(i_reset),
	.i_gpio_in				(gpi0),
	.i_decoder_data			(log_data_decoded),
	.i_decoder_ctrl			(log_ctrl_decoded),
	.o_gpio_out				(gpo0),
	.o_enable_read			(read_enable),
	.o_read_address			(read_addr),
	.o_enable_bram			(enable_bram),
	.o_enable_encoder		(enable_encoder),
	.o_enable_decoder		(enable_decoder),
	.o_enable_scrambler 	(enable_scrambler),
	.o_enable_descrambler	(enable_descrambler),
	.o_invalid_opcode 		(invalid_opcode),
	.o_opcode 				(opcode),
	.o_reset 				(soft_reset)
	);

PCS_modules
	#(
	)
u_PCS_modules
	(
	.i_clock				(i_clock)			,
	.i_reset				(soft_reset)		,
	.i_enable_encoder		(enable_encoder)	,
	.i_bypass 				(bypass)			,
	.i_enable_scrambler 	(enable_scrambler)	,
	.i_enable_descrambler	(enable_descrambler),
	.i_enable_decoder		(enable_decoder)	,
	.o_rx_raw_data 			(rx_raw_data)		,
	.o_rx_raw_ctrl			(rx_raw_ctrl)
	);


log_memory
	#(
	.NB_DATA(LEN_DATA_BLOCK),
	.DEPTH(RAM_DEPTH)
 	)
	u_log_data_mem
		(
			.i_clock(i_clock),
			.i_reset(soft_reset),
			.i_run(enable_bram),
			.i_read_addr(read_addr),
			.i_data(rx_raw_data),

			.o_full(mem_full),
			.o_data(log_data_decoded)
		);

log_memory
	#(
	.NB_DATA(LEN_CTRL_BLOCK),
	.DEPTH(RAM_DEPTH)
 	)
	u_log_ctrl_mem
		(
			.i_clock(i_clock),
			.i_reset(soft_reset),
			.i_run(enable_bram),
			.i_read_addr(read_addr),
			.i_data(rx_raw_ctrl),

			.o_full(mem_full),
			.o_data(log_ctrl_decoded)
		);
/*
bram_driver
	#(
	.NB_WORD_RAM(LEN_CTRL_BLOCK)
	)
u_bram_control
	(
	.i_clock		(clock_u)	  	  ,
	.i_reset		(i_reset)	  	  ,
	.i_run			(enable_bram) 	  ,
	.i_read_enb		(read_enable)	  ,
	.i_read_addr	(read_addr)	  	  ,
	.i_data			(rx_raw_ctrl) 	  ,
	.o_data 		(log_ctrl_decoded),
	.o_mem_full		(mem_full)
	);

bram_driver
	#(
	.NB_WORD_RAM(LEN_DATA_BLOCK)
	)
u_bram_data
	(
	.i_clock		(clock_u)	  	  ,
	.i_reset		(i_reset)	  	  ,
	.i_run			(enable_bram) 	  ,
	.i_read_enb		(read_enable)	  ,
	.i_read_addr	(read_addr)	  	  ,
	.i_data			(rx_raw_data) 	  ,
	.o_data			(log_data_decoded),
	.o_mem_full		(mem_full)
	);
*/
endmodule