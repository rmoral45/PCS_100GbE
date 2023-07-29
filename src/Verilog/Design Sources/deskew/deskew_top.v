

module deskew_top
#(
	parameter 	N_LANES          = 20,
	parameter 	NB_DATA          = 66,
    parameter 	NB_FIFO_DATA     = 67,
	parameter 	FIFO_DEPTH       = 20,
	parameter 	MAX_SKEW         = 16,	
	parameter 	NB_DELAY_COUNT   = $clog2(FIFO_DEPTH),
	parameter 	NB_DELAY_BUS     = NB_DELAY_COUNT*N_LANES,
	parameter 	NB_DATA_BUS      = NB_DATA*N_LANES,
	parameter 	NB_FIFO_DATA_BUS = NB_FIFO_DATA*N_LANES
 )
 (
 	input wire 					            i_clock,
 	input wire 					            i_reset,
 	input wire 					            i_enable,
 	input wire 					            i_valid,
 	input wire 	[N_LANES-1 : 0]		        i_resync,
 	input wire 	[N_LANES-1 : 0]		        i_start_of_lane,
 	input wire  [NB_DATA_BUS-1 : 0]         i_data,
 	input wire                              i_am_lock,

 	output wire [NB_FIFO_DATA_BUS-1 : 0]    o_data, 
 	output wire                             o_valid,
    output wire                             o_deskew_done,
    output wire                             o_invalid_skew
 );

 //INTERNAL SIGNALS
 wire [N_LANES-1 : 0]		    stop_lane_counters;
 wire [NB_DELAY_BUS-1 : 0]      lane_counters_value;
 wire                           enable_counter;
 wire [NB_DELAY_COUNT-1 : 0]    common_counter_value;
 wire 					        stop_common_counter;
 wire 					        set_fifo_delay;
 wire                           write_prog_fifo_enb;
 wire                           read_prog_fifo_enb;
 wire 				            invalid_skew;
 
 wire [NB_FIFO_DATA_BUS-1 : 0] 	data_and_tags; 
 wire [NB_FIFO_DATA_BUS-1 : 0] 	fifo_out_data;
 
 assign o_data = (o_deskew_done) ? fifo_out_data : data_and_tags;
 
 genvar j;
  for (j=0; j<N_LANES; j=j+1)
 begin : prog_fifo_ger_block
    assign data_and_tags[NB_FIFO_DATA_BUS - j*NB_FIFO_DATA -1 -: NB_FIFO_DATA] = {i_start_of_lane[N_LANES - j - 1], i_data[NB_DATA_BUS - j*NB_DATA - 1 -: NB_DATA]};
 end
 
 //PORTS
 assign o_invalid_skew  = invalid_skew;
 assign o_valid         = i_valid;

 //MODULES
 prog_fifo_top
 #(
    .NB_DATA(NB_FIFO_DATA),
    .NB_FIFO_DATA(NB_FIFO_DATA),
    .FIFO_DEPTH(FIFO_DEPTH)
 )
 u_prog_fifo_top
 (
    .i_clock            (i_clock),
    .i_reset            (i_reset),
    .i_valid            (i_valid),
    .i_set_fifo_delay   (set_fifo_delay),
    .i_write_enb        (write_prog_fifo_enb),
    .i_read_enb         (read_prog_fifo_enb),
    .i_delay_vector     (lane_counters_value),
    .i_data             (data_and_tags),
    .o_data             (fifo_out_data)
 );
 
 deskew_fsm
 #(
 	.N_LANES 	    (N_LANES),
 	.NB_DELAY_COUNT (NB_DELAY_COUNT),
 	.MAX_SKEW	    (MAX_SKEW)
  )
 u_deskew_fsm
  (
  	//INPUT
  	.i_clock                (i_clock),
  	.i_reset                (i_reset),
  	.i_enable               (i_enable),
  	.i_valid                (i_valid),
  	.i_am_lock              (i_am_lock),
  	.i_resync               (|i_resync),
  	.i_start_of_lane        (i_start_of_lane),
  	.i_common_counter       (common_counter_value),

  	//OUTPUT
  	.o_enable_counters      (enable_counter),
  	.o_stop_common_counter  (stop_common_counter),
  	.o_set_fifo_delay       (set_fifo_delay),
  	.o_write_prog_fifo_enb  (write_prog_fifo_enb),
  	.o_read_prog_fifo_enb   (read_prog_fifo_enb),
  	.o_stop_lane_counters   (stop_lane_counters),
  	.o_invalid_skew         (invalid_skew),
    .o_deskew_done          (o_deskew_done)
  );

  ss_counter
  #(
  	.NB_DELAY_COUNT(NB_DELAY_COUNT)
  	)
  u_common_counter
   (
   	//INPUT
  	.i_clock            (i_clock),
  	.i_reset            (i_reset),
  	.i_enable           (i_enable),
  	.i_valid            (i_valid),
  	.i_resync           (|i_resync),           
  	.i_enable_counter   (enable_counter),
  	.i_stop_counter     (&stop_lane_counters), 
  	//OUTPUT
  	.o_count            (common_counter_value)
   );

 genvar i;

 for (i=0; i<N_LANES; i=i+1)
 begin :ger_block
	   ss_counter
      #(
        .NB_DELAY_COUNT(NB_DELAY_COUNT)
       )
	  u_ss_counter
	   (
	   	//INPUT
	  	.i_clock            (i_clock),
	  	.i_reset            (i_reset),
	  	.i_enable           (i_enable),
	  	.i_valid            (i_valid),
	  	.i_resync           (|i_resync ), 
	  	.i_enable_counter   (enable_counter),
	  	.i_stop_counter     (stop_lane_counters[N_LANES - 1 -i]),
	  	//OUTPUT
	  	.o_count            (lane_counters_value[NB_DELAY_BUS-(i*NB_DELAY_COUNT)-1 -: NB_DELAY_COUNT])
	  	
	   );
 	
 end

endmodule
