

    reg                             rf_reset;
    reg                             rf_loopback;
    reg                             rf_test_pattern_mode_tx;
    reg                             rf_test_pattern_mode_rx;

    /* block sync control */
    reg                             rf_enable_block_sync;
    reg [`NB_WINDOW_CNT - 1 : 0]    rf_locked_timer_limit;
    reg [`NB_WINDOW_CNT - 1 : 0]    rf_unlocked_timer_limit;
    reg [`NB_INV_SH     - 1 : 0]    rf_sh_invalid_limit;

    /* aligners control */
    reg                             rf_enable_aligners;
    reg [`NB_INV_AM     - 1 : 0]    rf_invalid_am_thr;
    reg [`NB_VAL_AM     - 1 : 0]    rf_valid_am_thr;
    reg [16             - 1 : 0]    rf_compare_mask_0;
    reg [16             - 1 : 0]    rf_compare_mask_1;
    reg [16             - 1 : 0]    rf_compare_mask_0;
    reg [`NB_AM_PERIOD  - 1 : 0]    rf_am_period;

    /* deskew control */
    reg                             rf_enable_deskewer;

    /* lane reorder control */
    reg                             rf_enable_lane_reorder;
    reg                             rf_reset_order;

    /* descrambler control*/
    reg                             rf_enable_descrambler;
    reg                             rf_descrambler_bypass;

    /* clock comp control */
    reg                             rf_enable_clock_comp;
    /* decoder control */
    reg                             rf_enable_decoder;

    /* Clear On Read signals */
    reg                             rf_read_hi_ber;
    reg                             rf_read_am_error_counters;
    reg                             rf_read_am_resyncs;
    reg                             rf_read_mismatch_counter;
    reg                             rf_read_block_lock;
    reg                             rf_read_lanes_id;





