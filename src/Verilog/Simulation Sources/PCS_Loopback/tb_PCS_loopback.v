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



reg tb_clock;
reg tb_reset;
reg tb_idle_pattern_mode;

/* TX */
reg tb_enb_tx_valid_gen   ;
reg tb_enb_tx_frame_gen   ;
reg tb_enb_tx_encoder     ;
reg tb_enb_tx_clock_comp  ;
reg tb_enb_tx_scrambler   ;
reg tb_tx_bypass_scrambler;
reg tb_enb_tx_pc_1_20     ;
reg tb_enb_tx_am_insertion;

/* CHANNEL MODEL */
//Payload breaker
reg [N_LANES-1                  : 0]tb_payload_breaker_update;
reg [N_MODES-1                  : 0]tb_payload_breaker_mode;
reg [NB_ERR_MASK-1              : 0]tb_payload_breaker_err_mask;
reg [NB_BURST_CNT-1             : 0]tb_payload_breaker_err_burst;
reg [NB_PERIOD_CNT-1            : 0]tb_payload_breaker_err_period;
reg [NB_REPEAT_CNT-1            : 0]tb_payload_breaker_err_repeat;
//Sh breaker
reg [N_LANES-1                  : 0]tb_sh_breaker_update;
reg [N_MODES-1                  : 0]tb_sh_breaker_mode;
reg [NB_BURST_CNT-1             : 0]tb_sh_breaker_err_burst;
reg [NB_PERIOD_CNT-1            : 0]tb_sh_breaker_err_period;
reg [NB_REPEAT_CNT-1            : 0]tb_sh_breaker_err_repeat;
//Bit sk
reg [N_LANES-1                  : 0]tb_bit_skew_update;
reg [NB_SKEW_INDEX-1            : 0]tb_bit_skew_index;
//Skew generator
reg [NB_SKEW_INDEX-1            : 0]tb_block_skew;

//-----------------------Rx-----------------------
//Enables
reg tb_rf_enb_rx_block_sync;
reg tb_rf_enb_rx_aligner;
reg tb_rf_enb_rx_deskewer;
reg tb_rf_enb_rx_lane_reorder;
reg tb_rf_enb_rx_descrambler;
reg tb_rf_enb_rx_clock_comp;
reg tb_rf_enb_rx_test_pattern_checker;
reg tb_rf_enb_rx_decoder;
//Rx modes
reg tb_rf_rx_descrambler_bypass;
reg tb_rf_rx_reset_order;
//Read pulses
reg tb_rf_rx_read_hi_ber;
reg tb_rf_rx_read_am_error_counter;
reg tb_rf_rx_read_am_resyncs;
reg tb_rf_rx_read_invalid_skew;
reg tb_rf_rx_read_missmatch_counter;
reg tb_rf_rx_read_lanes_block_lock;
reg tb_rf_rx_read_lanes_id;

reg [NB_WINDOW_CNT-1    : 0]    tb_rx_rf_unlocked_timer_limit;
reg [NB_WINDOW_CNT-1    : 0]    tb_rx_rf_locked_timer_limit;
reg [NB_INV_SH-1        : 0]    tb_rx_rf_sh_invalid_limit;
reg                             tb_rx_signal_ok;
reg [NB_INV_AM-1        : 0]    tb_rx_rf_invalid_am_thr;
reg [NB_VAL_AM-1        : 0]    tb_rx_rf_valid_am_thr;
reg [NB_AM-1            : 0]    tb_rx_rf_compare_mask;
reg [NB_AM_PERIOD-1     : 0]    tb_rx_rf_am_period;

//Rx rf outputs
// reg [N_LANES-1                  : 0]tb_rx_rf_hi_ber;
// reg [NB_ERR_BUS-1               : 0]tb_rx_rf_am_error_counter;
// reg [NB_RESYNC_COUNTER_BUS-1    : 0]tb_rx_rf_resync_counter_bus;
// reg [N_LANES-1                  : 0]tb_rx_rf_am_lock;
// reg                                 tb_rx_rf_invalid_skew;
// reg [NB_MISMATCH_COUNTER-1      : 0]tb_rx_rf_missmatch_counter;
// reg [N_LANES-1                  : 0]tb_rx_rf_lanes_block_lock;
// reg [NB_ID_BUS-1                : 0]tb_rx_rf_lanes_i;

//Test description:
//                  - Time 0: reg initializations 
//                  - Time 100: reset during 10 periods
//                  - Time 100: reset during 10 periods

initial
begin
    tb_clock                = 1'b0;
    tb_reset                = 1'b0;
    tb_idle_pattern_mode    = 1'b0;
    
    //-------------------- TX
    tb_enb_tx_valid_gen     = 0;
    tb_enb_tx_frame_gen     = 0;
    tb_enb_tx_encoder       = 0;
    tb_enb_tx_clock_comp    = 0;
    tb_enb_tx_scrambler     = 0;
    tb_tx_bypass_scrambler  = 0;
    tb_enb_tx_pc_1_20       = 0;
    tb_enb_tx_am_insertion  = 0;

    tb_payload_breaker_update = 0;
    tb_payload_breaker_mode = 0;
    tb_payload_breaker_err_mask = 0;
    tb_payload_breaker_err_burst = 0;
    tb_payload_breaker_err_period = 0;
    tb_payload_breaker_err_repeat = 0;
    //Sh breaker
    tb_sh_breaker_update = 0;
    tb_sh_breaker_mode = 0;
    tb_sh_breaker_err_burst = 0;
    tb_sh_breaker_err_period = 0;
    tb_sh_breaker_err_repeat = 0;
    //Bit sk
    tb_bit_skew_update = 0;
    tb_bit_skew_index = 0;
    //Skew generator
    tb_block_skew = 0;

    /*rx*/
    tb_rf_enb_rx_block_sync = 0;
    tb_rf_enb_rx_aligner = 0;
    tb_rf_enb_rx_deskewer = 0;
    tb_rf_enb_rx_lane_reorder = 0;
    tb_rf_enb_rx_descrambler = 0;
    tb_rf_enb_rx_clock_comp = 0;
    tb_rf_enb_rx_test_pattern_checker = 0;
    tb_rf_enb_rx_decoder = 0;
    tb_rf_rx_descrambler_bypass = 0;
    tb_rf_rx_reset_order = 0;
    tb_rf_rx_read_hi_ber = 0;
    tb_rf_rx_read_am_error_counter = 0;
    tb_rf_rx_read_am_resyncs = 0;
    tb_rf_rx_read_invalid_skew = 0;
    tb_rf_rx_read_missmatch_counter = 0;
    tb_rf_rx_read_lanes_block_lock = 0;
    tb_rf_rx_read_lanes_id = 0;

    tb_rx_rf_unlocked_timer_limit = 0;
    tb_rx_rf_locked_timer_limit = 0;
    tb_rx_rf_sh_invalid_limit = 0;
    tb_rx_signal_ok = 0;
    tb_rx_rf_invalid_am_thr = 0;
    tb_rx_rf_valid_am_thr = 0;
    tb_rx_rf_compare_mask = 0;
    tb_rx_rf_am_period = 0;    

    #100    tb_reset                = 1'b1;
    #10     tb_reset                = 1'b0;

    //TX
    tb_enb_tx_valid_gen     = 1;
    tb_enb_tx_frame_gen     = 1;
    tb_enb_tx_encoder       = 1;
    tb_enb_tx_clock_comp    = 1;
    tb_enb_tx_scrambler     = 1;
    tb_tx_bypass_scrambler  = 0;
    tb_enb_tx_pc_1_20       = 1;
    tb_enb_tx_am_insertion  = 1;  
    
    /*rx*/
    tb_rf_enb_rx_block_sync = 1;
    tb_rf_enb_rx_aligner = 1;
    tb_rf_enb_rx_deskewer = 1;
    tb_rf_enb_rx_lane_reorder = 1;
    tb_rf_enb_rx_descrambler = 1;
    tb_rf_enb_rx_clock_comp = 1;
    tb_rf_enb_rx_test_pattern_checker = 1;
    tb_rf_enb_rx_decoder = 1;
    tb_rf_rx_descrambler_bypass = 0;
    tb_rf_rx_read_hi_ber = 0;
    tb_rf_rx_read_am_error_counter = 0;
    tb_rf_rx_read_am_resyncs = 0;
    tb_rf_rx_read_invalid_skew = 0;
    tb_rf_rx_read_missmatch_counter = 0;
    tb_rf_rx_read_lanes_block_lock = 0;
    tb_rf_rx_read_lanes_id = 0; 
    
    tb_rx_rf_unlocked_timer_limit = 64;
    tb_rx_rf_locked_timer_limit = 1024;
    tb_rx_rf_sh_invalid_limit = 65;
    tb_rx_signal_ok = 1;
    tb_rx_rf_invalid_am_thr = 4;
    tb_rx_rf_valid_am_thr = 1;
    tb_rx_rf_compare_mask = {NB_AM{1'b1}};
    tb_rx_rf_am_period = 16383;  
        

#20000
    tb_bit_skew_index = 10;
    tb_bit_skew_update = 20'h80000;
#10 tb_bit_skew_update = 20'h00000;
#500 tb_bit_skew_index = 30;
     tb_bit_skew_update = 20'h20000;
#10  tb_bit_skew_update = 20'h00000;
#500 tb_bit_skew_index = 60;
     tb_bit_skew_update = 20'h40000;
#10  tb_bit_skew_update = 20'h00000;
#500 tb_bit_skew_index = 17;
     tb_bit_skew_update = 20'h00001;
#10  tb_bit_skew_update = 20'h00000;
#500 tb_bit_skew_index = 33;
     tb_bit_skew_update = 20'h00200;
#10  tb_bit_skew_update = 20'h00000;
#60000
    tb_sh_breaker_mode = 4'b0100;
    tb_sh_breaker_err_burst = 500;
    tb_sh_breaker_err_period = 1024;
    tb_sh_breaker_err_repeat = 10000;
    tb_sh_breaker_update = 20'h80000;
#10 tb_sh_breaker_update = 20'h00000;   
#3500000
    tb_payload_breaker_mode = 4'b0100;
    tb_payload_breaker_err_mask = 64'hAA00BC00AAFFFFFA;
    tb_payload_breaker_err_burst = 20;
    tb_payload_breaker_err_period = 30000;
    tb_payload_breaker_err_repeat = 1000;
    tb_payload_breaker_update = 20'h80000;
#10 tb_payload_breaker_update = 20'h00000;    
    
    #300000000 $finish;
end

always #1 tb_clock = ~tb_clock;

PCS_loopback
u_PCS_loopback
(
//Common inputs
    .i_clock                     (tb_clock),
    .i_reset                     (tb_reset),
    .i_rf_idle_pattern_mode      (tb_idle_pattern_mode),
    //-----------------------Tx-----------------------
    //Enables
    .i_rf_enb_tx_valid_gen       (tb_enb_tx_valid_gen),
    .i_rf_enb_tx_frame_gen       (tb_enb_tx_frame_gen),
    .i_rf_enb_tx_encoder         (tb_enb_tx_encoder),
    .i_rf_enb_tx_clock_comp      (tb_enb_tx_clock_comp),
    .i_rf_enb_tx_scrambler       (tb_enb_tx_scrambler),
    .i_rf_tx_bypass_scrambler    (tb_tx_bypass_scrambler),
    .i_rf_enb_tx_pc_1_20         (tb_enb_tx_pc_1_20),
    .i_rf_enb_tx_am_insertion    (tb_enb_tx_am_insertion),

    //-----------------------Channel Module-----------------------
    //Payload breaker
    .i_rf_payload_breaker_update(tb_payload_breaker_update),
    .i_rf_payload_breaker_mode(tb_payload_breaker_mode),
    .i_rf_payload_breaker_err_mask(tb_payload_breaker_err_mask),
    .i_rf_payload_breaker_err_burst(tb_payload_breaker_err_burst),
    .i_rf_payload_breaker_err_period(tb_payload_breaker_err_period),
    .i_rf_payload_breaker_err_repeat(tb_payload_breaker_err_repeat),
    //Sh breaker
    .i_rf_sh_breaker_update(tb_sh_breaker_update),
    .i_rf_sh_breaker_mode(tb_sh_breaker_mode),
    .i_rf_sh_breaker_err_burst(tb_sh_breaker_err_burst),
    .i_rf_sh_breaker_err_period(tb_sh_breaker_err_period),
    .i_rf_sh_breaker_err_repeat(tb_sh_breaker_err_repeat),
    //Bit sk
    .i_rf_bit_skew_update(tb_bit_skew_update),
    .i_rf_bit_skew_index(tb_bit_skew_index),
    //Skew generator
    .i_rf_block_skew(tb_block_skew),

    //-----------------------Rx-----------------------
    //Enables
    .i_rf_enb_rx_block_sync(tb_rf_enb_rx_block_sync),
    .i_rf_enb_rx_aligner(tb_rf_enb_rx_aligner),
    .i_rf_enb_rx_deskewer(tb_rf_enb_rx_deskewer),
    .i_rf_enb_rx_lane_reorder(tb_rf_enb_rx_lane_reorder),
    .i_rf_enb_rx_descrambler(tb_rf_enb_rx_descrambler),
    .i_rf_enb_rx_clock_comp(tb_rf_enb_rx_clock_comp),
    .i_rf_enb_rx_test_pattern_checker(tb_rf_enb_rx_test_pattern_checker),
    .i_rf_enb_rx_decoder(tb_rf_enb_rx_decoder),
    //Rx modes and config
    .i_rf_rx_unlocked_timer_limit(tb_rx_rf_unlocked_timer_limit),
    .i_rf_rx_locked_timer_limit(tb_rx_rf_locked_timer_limit),
    .i_rf_rx_sh_invalid_limit(tb_rx_rf_sh_invalid_limit),
    .i_rx_signal_ok(tb_rx_signal_ok),
    .i_rf_rx_invalid_am_thr(tb_rx_rf_invalid_am_thr),
    .i_rf_rx_valid_am_thr(tb_rx_rf_valid_am_thr),
    .i_rf_rx_compare_mask(tb_rx_rf_compare_mask),
    .i_rf_rx_am_period(tb_rx_rf_am_period),
    .i_rf_rx_descrambler_bypass(tb_rf_rx_descrambler_bypass),
    .i_rf_rx_reset_order(tb_rf_rx_reset_order),
    //Read pulses
    .i_rf_rx_read_hi_ber(tb_rf_rx_read_hi_ber),
    .i_rf_rx_read_am_error_counter(tb_rf_rx_read_am_error_counter),
    .i_rf_rx_read_am_resyncs(tb_rf_rx_read_am_resyncs),
    .i_rf_rx_read_invalid_skew(tb_rf_rx_read_invalid_skew),
    .i_rf_rx_read_missmatch_counter(tb_rf_rx_read_missmatch_counter),
    .i_rf_rx_read_lanes_block_lock(tb_rf_rx_read_lanes_block_lock),
    .i_rf_rx_read_lanes_id(tb_rf_rx_read_lanes_id),
    //Tx rf outputs
    
    //Rx rf outputs
    .o_rf_hi_ber(),
    .o_rf_am_error_counter(),
    .o_rf_resync_counter_bus(),
    .o_rf_am_lock(),
    .o_rf_invalid_skew(),
    .o_rf_missmatch_counter(),
    .o_rf_lanes_block_lock(),
    .o_rf_lanes_id()    
);

endmodule