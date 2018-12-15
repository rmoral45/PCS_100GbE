
`include "verification_files.v"

module verification_top_level
  #(
  	parameter						NB_GPIOS				= `NB_GPIOS,
  	parameter 						NB_LEDS					= `NB_LEDS,
  	parameter 						NB_ADDR_RAM				= `NB_ADDR_RAM,
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
wire                             clockdsp;
wire                             bypass;

	assign bypass = 1'b1;

   ///////////////////////////////////////////
   // Leds
   ///////////////////////////////////////////
   	assign o_leds[0] = locked;
   	assign o_leds[1] = ~i_reset;
   	assign o_leds[2] = gpo0[12];
   	assign o_leds[3] = gpo0[13];

   	assign o_leds[4] = gpo0[0];
   	assign o_leds[5] = gpo0[1];
   	assign o_leds[6] = gpo0[2];

   	assign o_leds[7] = gpo0[3];
   	assign o_leds[8] = gpo0[4];
   	assign o_leds[9] = gpo0[5];

   	assign o_leds[10] = gpo0[6];
   	assign o_leds[11] = gpo0[7];
   	assign o_leds[12] = gpo0[8];

   	assign o_leds[13] = gpo0[9];
   	assign o_leds[14] = gpo0[10];
   	assign o_leds[15] = gpo0[11];
   
   
   
   
MicroGPIO
	#(
	)
   	u_micro
   	(
   	.clock100        (clockdsp)   ,  // Clock aplicacion
   	.gpio_rtl_tri_i  (gpo0)       ,  // GPIO
   	.gpio_rtl_tri_o  (gpi0)       ,  // GPIO
   	.reset           (i_reset)   ,  // Hard Reset
   	.sys_clock       (i_clock)     ,  // Clock de FPGA
   	.o_lock_clock    (locked)     ,  // Senal Lock Clock
   	.usb_uart_rxd    (i_rx_uart ),  // UART
   	.usb_uart_txd    (o_tx_uart)   // UART
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
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_gpio_in(gpi0),
	//.o_gpio_out(),
	.o_enable_read(read_enable),
	.o_read_address(read_addr),
	.o_enable_bram(enable_bram),
	.o_enable_encoder(enable_encoder),
	.o_enable_decoder(enable_decoder)
	);

PCS_modules
	#(
	)
u_PCS_modules
	(
	.i_clock				(i_clock)			,
	.i_reset				(i_reset)			,
	.i_enable_encoder		(enable_encoder)	,
	.i_tx_data 				(tx_data)			,
	.i_tx_ctrl 				(tx_ctrl)			,
	.i_bypass 				(bypass)			,
	.i_enable_scrambler 	(enable_scrambler)	,
	.i_enable_descrambler	(enable_descrambler),
	.i_enable_decoder		(enable_decoder)	,
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
	.i_read_enb		(read_enable)	  ,
	.i_read_addr	(read_addr)	  	  ,
	.i_ctrl_decoded	(rx_raw_ctrl) 	  ,
	.i_data_decoded	(rx_raw_data) 	  ,
	.o_data_decoded	(log_ctrl_decoded),
	.o_ctrl_decoded	(log_data_decoded),
	.o_mem_full		(mem_full)
	);
endmodule