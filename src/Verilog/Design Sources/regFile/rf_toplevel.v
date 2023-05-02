module rf_toplevel
(
    input   wire                i_fpga_clock,
    input   wire                i_reset,
    input   wire                RsRx,
    output  wire                RsTx
    // output wire [15:0]  o_leds
);

    localparam NB_ENABLE_RF      = 1;
    localparam NB_ADDR           = 9; //slice of GPIOmused for addr
    localparam NB_I_DATA         = 22; //slice of GPIO used for data
    localparam NB_GPIO           = 32;
    localparam N_LANES           = 20;

    //Channel parameters
    localparam NB_CODED_BLOCK    = 66;
    localparam NB_ERR_MASK       = NB_CODED_BLOCK-2;    //mascara; se romperan los bits cuya posicon en la mascara sea 1
    localparam MAX_ERR_BURST     = 1024;                //cantidad de bloques consecutivos que se romperan
    localparam MAX_ERR_PERIOD    = 1024;                //cantidad de bloqus por periodo de error ver NOTAS.
    localparam MAX_ERR_REPEAT    = 10;                  //cantidad de veces que se repite el mismo patron de error
    localparam NB_BURST_CNT      = $clog2(MAX_ERR_BURST);
    localparam NB_PERIOD_CNT     = $clog2(MAX_ERR_PERIOD);
    localparam NB_REPEAT_CNT     = $clog2(MAX_ERR_REPEAT);
    localparam N_MODES           = 4;
    localparam MAX_SKEW_INDEX    = NB_CODED_BLOCK-2;
    localparam NB_SKEW_INDEX     = $clog2(MAX_SKEW_INDEX);
    //Block sync parameters
    localparam MAX_WINDOW        = 4096;
    localparam MAX_INVALID_SH    = (MAX_WINDOW/2); 
    localparam NB_WINDOW_CNT     = $clog2(MAX_WINDOW);
    localparam NB_INVALID_CNT    = $clog2(MAX_INVALID_SH);
    localparam NB_INDEX          = $clog2(NB_CODED_BLOCK);
    //Am checker parameters
    localparam NB_AM             = 48;
    localparam MAX_INV_AM        = 8;
    localparam NB_INV_AM         = $clog2(MAX_INV_AM);
    localparam MAX_VAL_AM        = 20;
    localparam NB_VAL_AM         = $clog2(MAX_VAL_AM);
    localparam NB_BIP_ERR        = 8;
    localparam NB_BIP_ERR_BUS    = N_LANES * NB_BIP_ERR;
    localparam NB_RESYNC_CNT     = 8;
    localparam NB_RESYNC_CNT_BUS = N_LANES * NB_RESYNC_CNT;  
    localparam NB_AM_PERIOD      = 14;  
    //Default parameters
    localparam NB_LANE_ID        = $clog2(N_LANES);    
    localparam AM_PERIOD_BLOCKS  = 16383;
    localparam NB_DECODER_ERROR_COUNTER  = 16;
    localparam NB_ID_BUS         = N_LANES * NB_LANE_ID;
    localparam NB_MISMATCH_COUNTER = 16;
    localparam NB_DATA_CHECKER_ERROR_COUNTER = 16;

wire                                    rf_input_enable;
wire            [NB_ADDR-1      : 0]    rf_input_addr;
wire            [NB_I_DATA-1    : 0]    rf_input_data;

//========================================IP core clocks
wire                                    micro_clock_out_pcs;
wire            [NB_GPIO - 1 : 0]       micro_gpio_rf; // gpio_rtl_tri_o
wire            [NB_GPIO - 1 : 0]       rf_gpio_micro; //gpio_rtl_tri_i
wire                                    locked_clock;


//Delay regs
reg reset_d;
reg reset_2d;
reg locked_clock_d; 
reg locked_clock_2d;

/* RF to PCS TOP */
wire rf_reset_pcs;
wire rf_loopback_pcs;
wire rf_iddle_pattern_mode_pcs;
wire rf_clock_comp_enb_pcs;

/* RF to PCS TX */
wire rf_frame_generator_enb_tx;
wire rf_encoder_enb_tx;
wire rf_scrambler_enb_tx;
wire rf_scrambler_bypass_tx;
wire rf_pc_enb_tx;
wire rf_am_insertion_enb_tx;

/* RF to PCS RX */
wire                                            rf_enb_rx_block_sync;
wire                                            rf_enb_rx_aligner;
wire                                            rf_enb_rx_deskewer;
wire                                            rf_enb_rx_lane_reorder;
wire                                            rf_enb_rx_descrambler;
wire                                            rf_enb_rx_test_pattern_checker;
wire                                            rf_enb_rx_decoder;
//Rx modes and config
wire                                            rf_rx_descrambler_bypass;
wire     [NB_WINDOW_CNT-1    : 0]               rf_rx_unlocked_timer_limit;
wire     [NB_WINDOW_CNT-1    : 0]               rf_rx_locked_timer_limit;
wire     [NB_INVALID_CNT-1   : 0]               rf_rx_sh_invalid_limit;
wire     [NB_INV_AM-1        : 0]               rf_rx_invalid_am_thr;
wire     [NB_VAL_AM-1        : 0]               rf_rx_valid_am_thr;
wire     [NB_AM-1            : 0]               rf_rx_compare_mask;
wire     [NB_AM_PERIOD-1     : 0]               rf_rx_am_period;    
wire                                            rf_rx_reset_order;
//Read pulses
wire     [N_LANES-1          : 0]               rf_rx_read_hi_ber;
wire     [N_LANES-1          : 0]               rf_rx_read_am_error_counter;
wire     [N_LANES-1          : 0]               rf_rx_read_am_resyncs;
wire     [N_LANES-1          : 0]               rf_rx_read_am_lock;
wire                                            rf_rx_read_invalid_skew;
wire                                            rf_rx_read_missmatch_counter;
wire     [N_LANES-1          : 0]               rf_rx_read_lanes_block_lock;
wire     [N_LANES-1          : 0]               rf_rx_read_lanes_id;
wire                                            rf_rx_read_decoder_error_counter;

/* PCS RX to RF */
wire     [N_LANES-1                  : 0]       rx_hi_ber_rf;
wire     [NB_BIP_ERR_BUS-1           : 0]       rx_am_error_counter_rf;
wire     [NB_RESYNC_CNT_BUS-1        : 0]       rx_resync_counter_bus_rf;
wire     [N_LANES-1                  : 0]       rx_am_lock_rf;
wire                                            rx_deskew_done_rf;
wire     [NB_MISMATCH_COUNTER-1      : 0]       rx_missmatch_counter_rf;
wire     [N_LANES-1                  : 0]       rx_lanes_block_lock_rf;
wire     [NB_ID_BUS-1                : 0]       rx_lanes_id_rf;
wire     [NB_DECODER_ERROR_COUNTER-1 : 0]       rx_decoder_error_counter_rf;

wire    [NB_DATA_CHECKER_ERROR_COUNTER-1: 0]    frame_data_checker_error_counter_rf;
wire                                            frame_data_checker_lock_rf;




(* keep = "true" *) reg  [1 : 0] single_clk_comp_enb;

/* Signal registring [FIXME]: how to initialize those regs? */  
always @(posedge i_fpga_clock) begin
    reset_d             <= i_reset;
    reset_2d            <= reset_d;
    locked_clock_d      <= locked_clock;
    locked_clock_2d     <= locked_clock_d;
    single_clk_comp_enb <= {rf_clock_comp_enb_pcs, rf_clock_comp_enb_pcs};//[FIXME]: si cambiamos el clock de la pcs cambiar el clock de este reg
end

rf_write
u_rf_write
(
    .i_clock(i_fpga_clock),
    .i_reset(reset_2d),
    .i_gpio_data(micro_gpio_rf),

    //-----------------------Global-----------------------
    .o_pcs__i_rf_reset(rf_reset_pcs),
    .o_pcs__i_rf_loopback(rf_loopback_pcs),
    .o_pcs__i_rf_idle_pattern_mode(rf_iddle_pattern_mode_pcs),
    .o_clock_comp__i_rf_enable(rf_clock_comp_enb_pcs),

    //-----------------------Tx-----------------------
    .o_frame_gen__i_rf_enable(rf_frame_generator_enb_tx),
    .o_encoder__i_rf_enable(rf_encoder_enb_tx),
    .o_scrambler__i_rf_enable(rf_scrambler_enb_tx),
    .o_scrambler__i_rf_bypass(rf_scrambler_bypass_tx),
    .o_tx_pc__i_rf_enable(rf_pc_enb_tx),
    .o_pcs__i_rf_enable_tx_am_insertion(rf_am_insertion_enb_tx),

    //-----------------------Rx-----------------------
    .o_blksync__i_rf_enable(rf_enb_rx_block_sync),
    .o_aligner__i_rf_enable(rf_enb_rx_aligner),
    .o_deskew__i_rf_enable(rf_enb_rx_deskewer),
    .o_reorder__i_rf_enable(rf_enb_rx_lane_reorder),
    .o_descrambler__i_rf_enable(rf_enb_rx_descrambler),
    .o_descrambler__i_rf_bypass(rf_rx_descrambler_bypass),
    .o_ptrncheck__i_rf_enable(rf_enb_rx_test_pattern_checker),
    .o_decoder__i_rf_enable(rf_enb_rx_decoder),
    .o_blksync__i_rf_locked_timer_limit(rf_rx_locked_timer_limit),
    .o_blksync__i_rf_unlocked_timer_limit(rf_rx_unlocked_timer_limit),
    .o_blksync__i_rf_sh_invalid_limit(rf_rx_sh_invalid_limit),
    .o_aligner__i_rf_invalid_am_thr(rf_rx_invalid_am_thr),
    .o_aligner__i_rf_valid_am_thr(rf_rx_valid_am_thr),
    .o_aligner__i_rf_am_period(rf_rx_am_period),
    .o_aligner__i_rf_compare_mask(rf_rx_compare_mask),
    .o_reorder__i_rf_reset_order(rf_rx_reset_order)
);

    assign rf_input_addr = micro_gpio_rf[30:22];

rf_read_mux
u_rf_read_mux
(
    .o_gpio_data(rf_gpio_micro),
    .i_clock    (i_fpga_clock),
    .i_reset    (reset_2d),
    .input_addr(rf_input_addr),
    .bermonitor__o_rf_hi_ber(rx_hi_ber_rf),
    .aligner__o_rf_bip_error_count(rx_am_error_counter_rf),
    .aligner__o_rf_am_lock(rx_am_lock_rf),
    .aligner__o_rf_am_resync_counters(rx_resync_counter_bus_rf),
    .deskewer__o_rf_deskew_done(rx_deskew_done_rf),
    .ptrncheck__o_rf_mismatch_count(rx_missmatch_counter_rf),
    .blksync__o_rf_block_lock(rx_lanes_block_lock_rf),
    .aligner__o_rf_id(rx_lanes_id_rf),
    .decoder__o_rf_error_counter(rx_decoder_error_counter_rf),
    .frame_data_checker__o_rf_error_counter(frame_data_checker_error_counter_rf),
    .frame_data_checker__o_rf_lock(frame_data_checker_lock_rf)    
);

PCS_loopback
u_PCS_loopback
(
//Common inputs
    .i_clock                     (i_fpga_clock),

    .i_reset                     (rf_reset_pcs),
    .i_rf_idle_pattern_mode      (rf_iddle_pattern_mode_pcs),

    //-----------------------Tx-----------------------
    //Enables
    .i_rf_enb_tx_frame_gen       (rf_frame_generator_enb_tx),
    .i_rf_enb_tx_encoder         (rf_encoder_enb_tx),
    .i_rf_enb_tx_clock_comp      (single_clk_comp_enb[0]),
    .i_rf_enb_tx_scrambler       (rf_scrambler_enb_tx),
    .i_rf_tx_bypass_scrambler    (rf_scrambler_bypass_tx),
    .i_rf_enb_tx_pc_1_20         (rf_pc_enb_tx),
    .i_rf_enb_tx_am_insertion    (rf_am_insertion_enb_tx),

    //-----------------------Rx-----------------------
    //Enables
    .i_rf_enb_rx_block_sync(rf_enb_rx_block_sync),
    .i_rf_enb_rx_aligner(rf_enb_rx_aligner),
    .i_rf_enb_rx_deskewer(rf_enb_rx_deskewer),
    .i_rf_enb_rx_lane_reorder(rf_enb_rx_lane_reorder),
    .i_rf_enb_rx_descrambler(rf_enb_rx_descrambler),
    .i_rf_enb_rx_clock_comp(single_clk_comp_enb[1]),
    .i_rf_enb_rx_test_pattern_checker(rf_enb_rx_test_pattern_checker),
    .i_rf_enb_rx_decoder(rf_enb_rx_decoder),
    //Rx modes and config
    .i_rf_rx_descrambler_bypass(rf_rx_descrambler_bypass),
    .i_rf_rx_unlocked_timer_limit(rf_rx_unlocked_timer_limit),
    .i_rf_rx_locked_timer_limit(rf_rx_locked_timer_limit),
    .i_rf_rx_sh_invalid_limit(rf_rx_sh_invalid_limit),
    .i_rx_signal_ok(1'b1),
    .i_rf_rx_invalid_am_thr(rf_rx_invalid_am_thr),
    .i_rf_rx_valid_am_thr(rf_rx_valid_am_thr),
    .i_rf_rx_compare_mask(rf_rx_compare_mask),
    .i_rf_rx_am_period(rf_rx_am_period),
    .i_rf_rx_reset_order(rf_rx_reset_order),
    
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

Micro_rf_PCS
u_micro
(
    .pcs_clock          (micro_clock_out_pcs),
    .gpio_rtl_tri_o     (micro_gpio_rf),
    .gpio_rtl_tri_i     (rf_gpio_micro),
    .reset              (i_reset), //hard reset
    .sys_clock          (i_fpga_clock), //fpga clock
    .o_lock_clock       (locked_clock),
    .usb_uart_rxd       (RsRx),
    .usb_uart_txd       (RsTx)
);

endmodule