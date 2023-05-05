`timescale 1ns/100ps

module tb_PCS_loopback;
//Common parameters
    localparam           NB_DATA_RAW             = 64;
    localparam           NB_CTRL_RAW             = 8;
    localparam           NB_DATA_CODED           = 66;
    localparam           NB_DATA_TAGGED          = 67;
    localparam           N_LANES                 = 20;
    localparam           NB_DATA_BUS             = N_LANES * NB_DATA_CODED;

    //Channel Model
    localparam           NB_ERR_MASK             = NB_DATA_CODED-2;         //mascara, se romperan los bits cuya posicon en la mascara sea ;
    localparam           MAX_ERR_BURST           = 1024;                    //cantidad de bloques consecutivos que se rompera;
    localparam           MAX_ERR_PERIOD          = 1024;                    //cantidad de bloqus por periodo de error ver NOTAS;
    localparam           MAX_ERR_REPEAT          = 10;                      //cantidad de veces que se repite el mismo patron de erro;
    localparam           NB_BURST_CNT            = $clog2(MAX_ERR_BURST);
    localparam           NB_PERIOD_CNT           = $clog2(MAX_ERR_PERIOD);
    localparam           NB_REPEAT_CNT           = $clog2(MAX_ERR_REPEAT);
    localparam           N_MODES                 = 4;
    localparam           MAX_SKEW_INDEX          = (NB_DATA_RAW - 2);
    localparam           NB_SKEW_INDEX           = $clog2(MAX_SKEW_INDEX);
    
    //RX localparam;
    // block sync
    localparam           NB_SH                   = 2;
    localparam           NB_SH_VALID_BUS         = N_LANES;
    localparam           MAX_WINDOW              = 4096;
    localparam           NB_WINDOW_CNT           = $clog2(MAX_WINDOW);
    localparam           MAX_INV_SH              = (MAX_WINDOW/2);
    localparam           NB_INV_SH               = $clog2(MAX_WINDOW/2);
    // ber monitor
    localparam           HI_BER_VALUE            = 97;
    localparam           XUS_TIMER_WINDOW        = 1024;
    // aligment
    localparam           NB_ERROR_COUNTER        = 16;
    localparam           N_ALIGNER               = 20;
    localparam           NB_LANE_ID              = $clog2(N_ALIGNER);
    localparam           MAX_INV_AM              = 8;
    localparam           NB_INV_AM               = $clog2(MAX_INV_AM);
    localparam           MAX_VAL_AM              = 20;
    localparam           NB_VAL_AM               = $clog2(MAX_VAL_AM);
    localparam           NB_AM                   = 48;
    localparam           NB_AM_PERIOD            = 14;
    localparam           AM_PERIOD_BLOCKS        = 16383;
    localparam           NB_ID_BUS               = N_LANES * NB_LANE_ID;
    localparam           NB_ERR_BUS              = N_LANES * NB_ERROR_COUNTER;
    localparam           NB_RESYNC_COUNTER       = 8;
    localparam           NB_RESYNC_COUNTER_BUS   = NB_RESYNC_COUNTER * N_LANES;
    // deskew
    localparam           NB_FIFO_DATA            = 67; //incluye tag de SOL
    localparam           FIFO_DEPTH              = 20;
    localparam           MAX_SKEW                = 16;
    localparam           NB_FIFO_DATA_BUS        = N_LANES * NB_FIFO_DATA;

    //decoder
    localparam           NB_FSM_CONTROL          = 4;
    
    //test pattern checker
    localparam           NB_MISMATCH_COUNTER     = 32 ;

reg i_fpga_clock;
reg rf_reset_pcs;

initial begin
    i_fpga_clock = 0;
    rf_reset_pcs = 1;
    #10;
    rf_reset_pcs = 0;

end


always #1 i_fpga_clock = ~i_fpga_clock;

PCS_loopback
u_PCS_loopback
(
//Common inputs
    .i_clock                     (i_fpga_clock),

    .i_reset                     (rf_reset_pcs),
    .i_rf_idle_pattern_mode      (1'b0),

    //-----------------------Tx-----------------------
    //Enables
    .i_rf_enb_tx_frame_gen       (1'b1),
    .i_rf_enb_tx_encoder         (1'b1),
    .i_rf_enb_tx_clock_comp      (1'b1),
    .i_rf_enb_tx_scrambler       (1'b1),
    .i_rf_tx_bypass_scrambler    (1'b0),
    .i_rf_enb_tx_pc_1_20         (1'b1),
    .i_rf_enb_tx_am_insertion    (1'b1),
    .i_rf_broke_data_sh          (1'b0),

    //-----------------------Rx-----------------------
    //Enables
    .i_rf_enb_rx_block_sync(1'b1),
    .i_rf_enb_rx_aligner(1'b1),
    .i_rf_enb_rx_deskewer(1'b1),
    .i_rf_enb_rx_lane_reorder(1'b1),
    .i_rf_enb_rx_descrambler(1'b1),
    .i_rf_enb_rx_clock_comp(1'b1),
    .i_rf_enb_rx_test_pattern_checker(1'b0),
    .i_rf_enb_rx_decoder(1'b1),
    //Rx modes and config
    .i_rf_rx_descrambler_bypass(1'b0),
    .i_rf_rx_unlocked_timer_limit(512),
    .i_rf_rx_locked_timer_limit(1024),
    .i_rf_rx_sh_invalid_limit(3),
    .i_rx_signal_ok(1'b1),
    .i_rf_rx_invalid_am_thr(10),
    .i_rf_rx_valid_am_thr(2),
    .i_rf_rx_compare_mask(48'hffff_ffff_ffff_ffff_ffff_ffff),
    .i_rf_rx_am_period(16383),
    .i_rf_rx_reset_order(1'b0),
    
    //Rx rf outputs
    .o_rf_hi_ber(rx_hi_ber_rf),
    .o_rf_am_error_counter(rx_am_error_counter_rf),
    .o_rf_resync_counter_bus(rx_resync_counter_bus_rf),
    .o_rf_am_lock(rx_am_lock_rf),
    .o_rf_deskew_done(rx_deskew_done_rf),
    .o_rf_missmatch_counter(rx_missmatch_counter_rf),
    .o_rf_lanes_block_lock(rx_lanes_block_lock_rf),
    .o_rf_lanes_id(rx_lanes_id_rf),
    .o_rf_decoder_error_counter(rx_decoder_error_counter_rf),
    .o_rf_frame_data_checker_error_counter(frame_data_checker_error_counter_rf),
    .o_rf_frame_data_checker_lock(frame_data_checker_lock_rf)
    
);

endmodule