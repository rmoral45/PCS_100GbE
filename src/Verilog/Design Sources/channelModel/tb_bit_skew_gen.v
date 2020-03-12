`timescale 1ns/100ps

module tb_bit_skew_gen;

/* -------------------- localparams ------------------ */

localparam NB_DATA   = 66;
localparam MAX_INDEX = NB_DATA;
localparam NB_INDEX  = $clog2(MAX_INDEX);
localparam MAX_WINDOW        = 4096;
localparam MAX_INVALID_SH    = (MAX_WINDOW/2); //FIX especificar correctamente
localparam NB_WINDOW_CNT     = $clog2(MAX_WINDOW);
localparam NB_INVALID_CNT    = $clog2(MAX_INVALID_SH);

/* -------------------- inputs  --------------------- */

reg                             tb_clock;
reg                             tb_reset;
reg                             tb_valid;
reg                             tb_i_signal_ok;
reg [NB_DATA-1 : 0]             tb_input_data;
reg [NB_INDEX-1 : 0]            tb_rf_skew_index;
reg                             tb_rf_update;
reg [NB_WINDOW_CNT-1 : 0]       tb_unlocked_timer_limit;
reg [NB_WINDOW_CNT-1 : 0]       tb_locked_timer_limit;
reg [NB_INVALID_CNT-1 : 0]      tb_sh_invalid_limit;

/* ------------------- outputs  --------------------- */

wire [NB_DATA-1 : 0]    tb_output_data;
wire [NB_DATA-1 : 0]    tb_sync_data;
wire                    tb_o_block_lock;
wire [NB_INDEX-1 : 0]   tb_search_index;
wire [NB_INDEX-1 : 0]   tb_block_index;


/* ------------------ signal gen -------------------- */

initial
begin
        tb_clock         = 0;
        tb_reset         = 1;
        tb_valid         = 0;
        //tb_input_data    = 66'h2_ff_fe_fd_fc_fb_fa_f9_f8;
        tb_input_data    = 66'h2_00_00_00_00_00_00_00_00;
        tb_rf_skew_index = 0;
        tb_rf_update     = 0;

        tb_i_signal_ok = 0;
        tb_unlocked_timer_limit = 1024;
        tb_locked_timer_limit = 2048;
        tb_sh_invalid_limit = 100;

        #20
                tb_reset = 0;
                tb_valid = 1;

        #20
                tb_rf_update = 1;

        #20
                tb_rf_update   = 0;
                tb_i_signal_ok = 1;

        #4000
                tb_input_data    = 66'h2_ff_fe_fd_fc_fb_fa_f9_f8;
        #10000
                tb_rf_update     = 1;
                tb_rf_skew_index = 8;
                tb_input_data    = 66'h2_00_00_00_00_00_00_00_00;

        #20
                tb_rf_update     = 0;
        #4000
        
                tb_input_data    = 66'h2_ff_fe_fd_fc_fb_fa_f9_f8;
        #10000
                tb_rf_update     = 1;
                tb_rf_skew_index = 64;
                tb_input_data    = 66'h2_00_00_00_00_00_00_00_00;

        #20
                tb_rf_update     = 0;
        #4000
        
                tb_input_data    = 66'h2_ff_fe_fd_fc_fb_fa_f9_f8;
end

always #1 tb_clock = ~tb_clock;




/* --------------- instances ------------------------ */


bit_skew_gen
#(
        .NB_DATA   (NB_DATA),
        .MAX_INDEX (MAX_INDEX)
 )
        u_bit_skew_gen
        (
                .i_clock                (tb_clock),
                .i_reset                (tb_reset),
                .i_valid                (tb_valid),
                .i_data                 (tb_input_data),
                .i_rf_skew_index        (tb_rf_skew_index),
                .i_rf_update            (tb_rf_update),

                .o_data(tb_output_data)
        );

 block_sync_module#()
 u_block_sync_module(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_valid(tb_valid),
    .i_data(tb_output_data),
    .i_signal_ok(tb_i_signal_ok),
    .i_unlocked_timer_limit(tb_unlocked_timer_limit),
    .i_locked_timer_limit(tb_locked_timer_limit),
    .i_sh_invalid_limit(tb_sh_invalid_limit),
    .o_data(tb_sync_data),
    .o_block_lock(tb_o_block_lock),
    .o_dbg_search_index(tb_search_index),
    .o_dbg_block_index(tb_block_index)
    );

endmodule
