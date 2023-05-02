`timescale 1ns/100ps
module tb_frame_checker;
    localparam                  NB_DATA_RAW		= 64;
    localparam                  NB_CTRL_RAW		= 8;

    reg                         tb_clock;
    reg                         tb_reset;

    wire                        tb_valid;
    wire    [NB_DATA_RAW-1 : 0] tb_data;
    wire    [NB_CTRL_RAW-1 : 0] tb_ctrl;   

    initial
    begin
        tb_clock = 1'b0;
        tb_reset = 1'b0;
        #100;
        tb_reset = 1'b1;
        #100
        tb_reset = 1'b0;
        #300000000 $finish;
    end
    
    always #1 tb_clock = ~tb_clock;

    top_level_frameGenerator
    u_frame_gen
	(
	    .i_clock        (tb_clock),
	    .i_reset        (tb_reset),
	    .i_enable       (1'b1),
	    .o_tx_data      (tb_data),
	    .o_tx_ctrl      (tb_ctrl),
	    .o_valid        (tb_valid)
	);


    frameChecker
    u_frame_check
	(
		.i_clock        (tb_clock),
		.i_reset        (tb_reset),
		.i_enable       (1'b1),
		.i_rx_raw_data  (tb_data),
		.i_rx_raw_ctrl  (tb_ctrl),
		.o_error_counter(),
		.o_lock         ()
	);


endmodule