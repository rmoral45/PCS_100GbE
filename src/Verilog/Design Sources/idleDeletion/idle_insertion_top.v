


module idle_insertion_top
#(
	parameter LEN_TX_DATA = 64,
	parameter LEN_TX_CTRL = 8 ,
	parameter N_IDLE 	  = 20,
	parameter N_BLOCKS    = 16383,
	parameter N_LANES     = 20 // deberia ser siempre igual a N_IDLE 
 )
 (
 	input  wire 					i_clock  ,
 	input  wire 					i_reset  ,
 	input  wire 					i_enable ,
 	input  wire 					i_valid  ,
 	input  wire [LEN_TX_DATA-1 : 0] i_tx_data,
 	input  wire [LEN_TX_CTRL-1 : 0] i_tx_ctrl,

 	output wire [LEN_TX_DATA-1 : 0] o_tx_data,
 	output wire [LEN_TX_CTRL-1 : 0] o_tx_ctrl,
 	output wire 					o_am_flag,
 	output wire						o_valid

 );

//LOCALPARAMS
localparam NB_DATA    = (LEN_TX_DATA + LEN_TX_CTRL);
localparam NB_ADDR    = $clog2(N_IDLE); 
localparam CGMII_IDLE = 8'h07;

//Internal signals
wire 				 idle_detected   ;
wire 				 idle_enable     ;
wire 				 idle_payload    ; 
wire 				 block_count_done; 
wire 				 idle_count_done ;
wire 				 insert_am_idle  ;
wire 				 fifo_write_enb  ;
wire [NB_DATA-1 : 0] fifo_input_data ;
wire 				 fifo_read_enb   ;
wire [NB_DATA-1 : 0] fifo_output_data;
wire 				 fifo_empty      ;

//Instancies
idle_counter
	#(
		.N_IDLE(N_IDLE)
	 )
	u_idle_counter
	 (
	 	.i_clock           (i_clock),
	 	.i_reset           (i_reset),
	 	.i_enable          (i_enable),
	 	.i_block_count_done(block_count_done),
	 	.i_idle_detected   (idle_detected),

	 	.o_idle_count_done (idle_count_done)
	 );

am_mod_counter
	#(
		.N_BLOCKS(N_BLOCKS),
		.N_LANES (N_LANES)
	 )
	u_am_mod_counter
	 (
	 	.i_clock           (i_clock),
	 	.i_reset           (i_reset),
	 	.i_enable          (i_enable),
	 	.i_valid		   (i_valid),
	 	
	 	.o_block_count_done(block_count_done),
	 	.o_insert_am_idle  (insert_am_idle),
	 	.o_enable_fifo_read(fifo_read_enb)
	 );

sync_fifo
	#(
		.NB_DATA(NB_DATA),
		.NB_ADDR(NB_ADDR)
	 )
	u_sync_fifo
	 (
	 	.i_clock           (i_clock ),
	 	.i_reset           (i_reset ),
	 	.i_enable          (i_enable),
	 	.i_write_enb	   (fifo_write_enb ),
	 	.i_read_enb		   (fifo_read_enb  ),
	 	.i_data            (fifo_input_data),

	 	.o_empty		   (fifo_empty),
	 	.o_data            (fifo_output_data)
	 );




//Idle detection
assign idle_enable   = (i_tx_ctrl == 8'hFF)           ? 1'b1 : 1'b0;
assign idle_payload  = (i_tx_data == {8{CGMII_IDLE}}) ? 1'b1 : 1'b0;
assign idle_detected = (idle_enable & idle_payload);

//Fifo write logic 
assign fifo_write_enb  = 
	(idle_detected == 1'b1 && idle_count_done == 1'b0 ) ? 1'b0 : 1'b1;
assign fifo_input_data = {i_tx_data,i_tx_ctrl};

//PORTS
assign o_tx_data =  fifo_output_data[NB_DATA-1             -: LEN_TX_DATA];
assign o_tx_ctrl =  fifo_output_data[NB_DATA-1-LEN_TX_CTRL -: LEN_TX_CTRL];
assign o_valid   =  (~fifo_empty & fifo_read_enb); 
assign o_am_flag =  insert_am_idle;//redundante


endmodule