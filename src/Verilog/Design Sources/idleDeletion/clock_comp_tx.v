


module clock_comp_tx
#(
	parameter NB_DATA       = 66,
	parameter N_IDLE        = 20,
	parameter N_BLOCKS      = 16383,
	parameter N_LANES       = 20 // deberia ser siempre igual a N_IDLE 
 )
 (
 	input  wire                     i_clock  ,
 	input  wire                     i_reset  ,
 	input  wire                     i_enable ,
 	input  wire                     i_valid  ,
 	input  wire [NB_DATA-1 : 0]     i_data,

 	output wire [NB_DATA-1 : 0]     o_data,
 	output wire                     o_am_flag

 );

//LOCALPARAMS
localparam NB_ADDR                      = $clog2(N_IDLE); //[CHECK] 
localparam [NB_DATA-1 : 0] PCS_IDLE     = 'h1e_00_00_00_00_00_00_00_0; 

//Internal signals
wire 				idle_detected   ;
wire 				block_count_done; 
wire 				idle_count_done ;
wire 				insert_am_idle  ;
wire 				fifo_write_enb  ;
wire [NB_DATA-1 : 0]            fifo_input_data ;
wire 				fifo_read_enb   ;
wire [NB_DATA-1 : 0]            fifo_output_data;
wire 				fifo_empty      ;

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
	 	.i_clock                (i_clock ),
	 	.i_reset                (i_reset ),
	 	.i_enable               (i_enable),
	 	.i_write_enb	        (fifo_write_enb ),
	 	.i_read_enb             (fifo_read_enb  ),
	 	.i_data                 (i_data),

	 	.o_empty                (fifo_empty),
	 	.o_data                 (fifo_output_data)
	 );




//Idle detection
assign idle_detected = (i_data == PCS_IDLE) ? 1'b1 : 1'b0;

//Fifo write logic 
assign fifo_write_enb  = 
	(idle_detected == 1'b1 && idle_count_done == 1'b0 ) ? 1'b0 : 1'b1;


//PORTS
assign o_valid      =  (~fifo_empty & fifo_read_enb); 
assign o_data       =  (fifo_read_enable) ? fifo_output_data : PCS_IDLE;
assign o_aliger_tag =  (fifo_read_enable) ? 1'b0             : 1'b1;

endmodule
