`timescale 1ns/100ps

module PCS_loopback
#(
    //Common parameters
    parameter           NB_DATA_RAW             = 64,
    parameter           NB_CTRL_RAW             = 8,
    parameter           NB_DATA_CODED           = 66,
    parameter           NB_DATA_TAGGED          = 67,
    parameter           N_LANES                 = 20,
    parameter           NB_DATA_BUS             = N_LANES * NB_DATA_CODED,

    //Channel Model
    parameter           NB_ERR_MASK             = NB_DATA_CODED-2,    //mascara, se romperan los bits cuya posicon en la mascara sea 1
    parameter           MAX_ERR_BURST           = 1024,                //cantidad de bloques consecutivos que se romperan
    parameter           MAX_ERR_PERIOD          = 1024,                //cantidad de bloqus por periodo de error ver NOTAS.
    parameter           MAX_ERR_REPEAT          = 10,                  //cantidad de veces que se repite el mismo patron de error
    parameter           NB_BURST_CNT            = $clog2(MAX_ERR_BURST),
    parameter           NB_PERIOD_CNT           = $clog2(MAX_ERR_PERIOD),
    parameter           NB_REPEAT_CNT           = $clog2(MAX_ERR_REPEAT),
    parameter           N_MODES                 = 4,
    parameter           MAX_SKEW_INDEX          = (NB_DATA_RAW - 2),
    parameter           NB_SKEW_INDEX           = $clog2(MAX_SKEW_INDEX),
    
    //RX Parameters
    // block sync
    parameter           NB_SH                   = 2,
    parameter           NB_SH_VALID_BUS         = N_LANES,
    parameter           MAX_WINDOW              = 4096,
    parameter           NB_WINDOW_CNT           = $clog2(MAX_WINDOW),
    parameter           MAX_INV_SH              = (MAX_WINDOW/2),
    parameter           NB_INV_SH               = $clog2(MAX_WINDOW/2),
    // ber monitor
    parameter           HI_BER_VALUE            = 97,
    parameter           XUS_TIMER_WINDOW        = 1024,
    // aligment
    parameter           NB_ERROR_COUNTER        = 8,
    parameter           N_ALIGNER               = 20,
    parameter           NB_LANE_ID              = $clog2(N_ALIGNER),
    parameter           MAX_INV_AM              = 8,
    parameter           NB_INV_AM               = $clog2(MAX_INV_AM),
    parameter           MAX_VAL_AM              = 20,
    parameter           NB_VAL_AM               = $clog2(MAX_VAL_AM),
    parameter           NB_AM                   = 48,
    parameter           NB_AM_PERIOD            = 14,
    parameter           AM_PERIOD_BLOCKS        = 16383,
    parameter           NB_ID_BUS               = N_LANES * NB_LANE_ID,
    parameter           NB_ERR_BUS              = N_LANES * NB_ERROR_COUNTER,
    parameter           NB_RESYNC_COUNTER       = 8,
    parameter           NB_RESYNC_COUNTER_BUS   = NB_RESYNC_COUNTER * N_LANES,
    // deskew
    parameter           NB_FIFO_DATA            = 67, //incluye tag de SOL
    parameter           FIFO_DEPTH              = 20,
    parameter           MAX_SKEW                = 16,
    parameter           NB_FIFO_DATA_BUS        = N_LANES * NB_FIFO_DATA,

    //decoder
    parameter           NB_FSM_CONTROL          = 4,
    parameter           NB_DECODER_ERROR_COUNTER= 16,

    //frame_data_checker
    parameter           NB_DATA_CHECKER_ERROR_COUNTER = 16,
    
    //test pattern checker
    parameter           NB_MISMATCH_COUNTER     = 16    
)
(
    //Common inputs
    input wire                                                  i_clock                     ,
    input wire                                                  i_reset                     ,
    input wire                                                  i_rf_idle_pattern_mode      ,


    //-----------------------Tx-----------------------
    //Enables
    input wire                                                  i_rf_enb_tx_frame_gen       ,
    input wire                                                  i_rf_enb_tx_encoder         ,
    input wire                                                  i_rf_enb_tx_clock_comp      ,
    input wire                                                  i_rf_enb_tx_scrambler       ,
    input wire                                                  i_rf_tx_bypass_scrambler    ,
    input wire                                                  i_rf_enb_tx_pc_1_20         ,
    input wire                                                  i_rf_enb_tx_am_insertion    ,
    input wire                                                  i_rf_broke_data_sh          ,

    //-----------------------Rx-----------------------
    //Enables
    input wire                                                  i_rf_enb_rx_block_sync,
    input wire                                                  i_rf_enb_rx_aligner,
    input wire                                                  i_rf_enb_rx_deskewer,
    input wire                                                  i_rf_enb_rx_lane_reorder,
    input wire                                                  i_rf_enb_rx_descrambler,
    input wire                                                  i_rf_enb_rx_clock_comp,
    input wire                                                  i_rf_enb_rx_test_pattern_checker,
    input wire                                                  i_rf_enb_rx_decoder,
    //Rx modes and config
    input wire                                                  i_rf_rx_descrambler_bypass,
    input  wire     [NB_WINDOW_CNT-1                    : 0]    i_rf_rx_unlocked_timer_limit,
    input  wire     [NB_WINDOW_CNT-1                    : 0]    i_rf_rx_locked_timer_limit,
    input  wire     [NB_INV_SH-1                        : 0]    i_rf_rx_sh_invalid_limit,
    input  wire                                                 i_rx_signal_ok,
    input  wire     [NB_INV_AM-1                        : 0]    i_rf_rx_invalid_am_thr,
    input  wire     [NB_VAL_AM-1                        : 0]    i_rf_rx_valid_am_thr,
    input  wire     [NB_AM-1                            : 0]    i_rf_rx_compare_mask,
    input  wire     [NB_AM_PERIOD-1                     : 0]    i_rf_rx_am_period,    
    input  wire                                                 i_rf_rx_reset_order,
    
    //Rx rf outputs
    output wire     [N_LANES-1                          : 0]    o_rf_hi_ber,
    output wire     [NB_ERR_BUS-1                       : 0]    o_rf_am_error_counter,
    output wire     [NB_RESYNC_COUNTER_BUS-1            : 0]    o_rf_resync_counter_bus,
    output wire     [N_LANES-1                          : 0]    o_rf_am_lock,
    output wire                                                 o_rf_deskew_done,
    output wire     [NB_MISMATCH_COUNTER-1              : 0]    o_rf_missmatch_counter,
    output wire     [N_LANES-1                          : 0]    o_rf_lanes_block_lock,
    output wire     [NB_ID_BUS-1                        : 0]    o_rf_lanes_id,
    output wire     [NB_DECODER_ERROR_COUNTER-1         : 0]    o_rf_decoder_error_counter,
    output wire     [NB_DATA_CHECKER_ERROR_COUNTER-1    : 0]    o_rf_frame_data_checker_error_counter,
    output wire                                                 o_rf_frame_data_checker_lock
);
/* Tx to Channel signals */
    wire            [NB_DATA_CODED-1                    : 0]    tx_encoder_data_rx;
    wire            [NB_DATA_CODED-1                    : 0]    tx_clockcomp_data_rx; 
    wire            [(NB_DATA_CODED*N_LANES)-1          : 0]    tx_databus_channel;
    wire            [N_LANES-1                          : 0]    tx_tagbus_channel;
    wire                                                        tx_valid_channel;

//============================================================================//

    // Rx RF signals registers    
    wire                        [N_LANES-1                      : 0]    lanes_block_lock_rf;
    wire                        [N_LANES-1                      : 0]    ber_monitor_hi_ber_rf;
    wire                        [N_LANES-1                      : 0]    am_lanes_lock_rf;  
    wire                        [NB_RESYNC_COUNTER_BUS-1        : 0]    am_resync_counter_rf;
    wire                        [NB_ERR_BUS-1                   : 0]    am_error_counter_rf; 
    wire                        [NB_ID_BUS-1                    : 0]    lanes_id_rf;
    wire                                                                deskew_done_rf;
    wire                        [NB_MISMATCH_COUNTER-1          : 0]    pattern_checker_missmatch_counter_rf;
    wire                        [NB_DECODER_ERROR_COUNTER-1     : 0]    decoder_error_counter_rf;
    wire                        [NB_DATA_CHECKER_ERROR_COUNTER-1: 0]    frame_data_checker_error_counter_rf;
    wire                                                                frame_data_checker_lock_rf;
    

    (* keep = "true" *) reg     [N_LANES-1                      : 0]    lanes_block_lock_rf_d;
    (* keep = "true" *) reg     [N_LANES-1                      : 0]    ber_monitor_hi_ber_rf_d;
    (* keep = "true" *) reg     [N_LANES-1                      : 0]    am_lanes_lock_rf_d;
    (* keep = "true" *) reg     [NB_RESYNC_COUNTER_BUS-1        : 0]    am_resync_counter_rf_d;
    (* keep = "true" *) reg     [NB_ERR_BUS-1                   : 0]    am_error_counter_rf_d;
    (* keep = "true" *) reg     [NB_ID_BUS-1                    : 0]    lanes_id_rf_d;
    (* keep = "true" *) reg                                             deskew_done_rf_d;
    (* keep = "true" *) reg     [NB_MISMATCH_COUNTER-1          : 0]    pattern_checker_missmatch_counter_rf_d;
    (* keep = "true" *) reg     [NB_DECODER_ERROR_COUNTER-1     : 0]    decoder_error_counter_rf_d;   
    (* keep = "true" *) reg     [NB_DATA_CHECKER_ERROR_COUNTER-1: 0]    frame_data_checker_error_counter_rf_d;
    (* keep = "true" *) reg                                             frame_data_checker_lock_rf_d;   

    assign o_rf_lanes_block_lock                    =   lanes_block_lock_rf_d;
    assign o_rf_hi_ber                              =   ber_monitor_hi_ber_rf_d;
    assign o_rf_am_lock                             =   am_lanes_lock_rf_d;
    assign o_rf_resync_counter_bus                  =   am_resync_counter_rf_d;
    assign o_rf_am_error_counter                    =   am_error_counter_rf_d;
    assign o_rf_lanes_id                            =   lanes_id_rf_d;
    assign o_rf_deskew_done                         =   deskew_done_rf_d;
    assign o_rf_missmatch_counter                   =   pattern_checker_missmatch_counter_rf_d;
    assign o_rf_decoder_error_counter               =   decoder_error_counter_rf_d; 
    assign o_rf_frame_data_checker_error_counter    =   frame_data_checker_error_counter_rf_d;
    assign o_rf_frame_data_checker_lock             =   frame_data_checker_lock_rf_d;

    always @(posedge i_clock)
    begin
        if(i_reset)
            lanes_block_lock_rf_d  <=  {N_LANES{1'b0}};
        else
            lanes_block_lock_rf_d  <=  lanes_block_lock_rf;
    end
    
    always @(posedge i_clock)
    begin
        if(i_reset)
            ber_monitor_hi_ber_rf_d <=  {N_LANES{1'b0}};
        else
            ber_monitor_hi_ber_rf_d <=  ber_monitor_hi_ber_rf;
    end
    
    always @(posedge i_clock)
    begin
        if(i_reset)
            am_lanes_lock_rf_d  <=  {N_LANES{1'b0}};
        else
            am_lanes_lock_rf_d  <=  am_lanes_lock_rf;
    end

    always @(posedge i_clock)
    begin
        if(i_reset)
            am_resync_counter_rf_d  <=  {NB_ERR_BUS{1'b0}};
        else
            am_resync_counter_rf_d  <=  am_resync_counter_rf;
    end    

    always @(posedge i_clock)
    begin
        if(i_reset)
            am_error_counter_rf_d   <=  {NB_ERR_BUS{1'b0}};
        else
            am_error_counter_rf_d   <=  am_error_counter_rf;
    end

    always @(posedge i_clock)
    begin
        if(i_reset)
            lanes_id_rf_d   <=  {NB_ID_BUS{1'b0}};
        else
            lanes_id_rf_d   <=  lanes_id_rf;
    end
    
    always @(posedge i_clock)
    begin
        if(i_reset)
            deskew_done_rf_d    <=  1'b0;
        else
            deskew_done_rf_d    <= deskew_done_rf;
    end
    
    always @(posedge i_clock)
    begin
        if(i_reset)
            pattern_checker_missmatch_counter_rf_d  <=  {NB_MISMATCH_COUNTER{1'b0}};
        else
            pattern_checker_missmatch_counter_rf_d  <=  pattern_checker_missmatch_counter_rf;
    end
    
    always @(posedge i_clock)
    begin
        if(i_reset)
            decoder_error_counter_rf_d  <=  {NB_DECODER_ERROR_COUNTER{1'b0}};
        else
            decoder_error_counter_rf_d  <=  decoder_error_counter_rf; 
    end
    
    always @(posedge i_clock)
    begin
        if(i_reset)
            frame_data_checker_error_counter_rf_d  <=  {NB_DATA_CHECKER_ERROR_COUNTER{1'b0}};
        else
            frame_data_checker_error_counter_rf_d  <=  frame_data_checker_error_counter_rf; 
    end

    always @(posedge i_clock)
    begin
        if(i_reset)
            frame_data_checker_lock_rf_d  <=  1'b0;
        else
            frame_data_checker_lock_rf_d  <=  frame_data_checker_lock_rf; 
    end
//============================================================================// 

//Instances
toplevel_tx
u_tx_toplevel
(
    .o_encoder_data                         (tx_encoder_data_rx),
    .o_clock_comp_data                      (tx_clockcomp_data_rx),
    .o_data                                 (tx_databus_channel),
    .o_tag_bus                              (tx_tagbus_channel),
    .o_valid                                (tx_valid_channel),

    .i_clock                                (i_clock),
    .i_reset                                (i_reset),
    .i_rf_enb_frame_gen                     (i_rf_enb_tx_frame_gen),
    .i_rf_enb_encoder                       (i_rf_enb_tx_encoder),
    .i_rf_enb_clock_comp                    (i_rf_enb_tx_clock_comp),
    .i_rf_enb_scrambler                     (i_rf_enb_tx_scrambler),
    .i_rf_bypass_scrambler                  (i_rf_tx_bypass_scrambler),
    .i_rf_idle_pattern_mode                 (i_rf_idle_pattern_mode),
    .i_rf_enb_pc_1_20                       (i_rf_enb_tx_pc_1_20),
    .i_rf_enb_am_insertion                  (i_rf_enb_tx_am_insertion),
    .i_rf_broke_data_sh                     (i_rf_broke_data_sh)
);

rx_toplevel
#(
    .NB_SH(NB_SH),                   
    .NB_SH_VALID_BUS(NB_SH_VALID_BUS),         
    .MAX_WINDOW(MAX_WINDOW),              
    .NB_WINDOW_CNT(NB_WINDOW_CNT),           
    .MAX_INV_SH(MAX_INV_SH),              
    .NB_INV_SH(NB_INV_SH),               
    // ber monitor
    .HI_BER_VALUE(HI_BER_VALUE),            
    .XUS_TIMER_WINDOW(XUS_TIMER_WINDOW),        
    // aligment
    .NB_ERROR_COUNTER(NB_ERROR_COUNTER),        
    .N_ALIGNER(N_ALIGNER),               
    .NB_LANE_ID(NB_LANE_ID),              
    .MAX_INV_AM(MAX_INV_AM),              
    .NB_INV_AM(NB_INV_AM),               
    .MAX_VAL_AM(MAX_VAL_AM),              
    .NB_VAL_AM(NB_VAL_AM),               
    .NB_AM(NB_AM),                   
    .NB_AM_PERIOD(NB_AM_PERIOD),            
    .AM_PERIOD_BLOCKS(AM_PERIOD_BLOCKS),        
    .NB_ID_BUS(NB_ID_BUS),               
    .NB_ERR_BUS(NB_ERR_BUS),              
    .NB_RESYNC_COUNTER(NB_RESYNC_COUNTER),       
    .NB_RESYNC_COUNTER_BUS(NB_RESYNC_COUNTER_BUS),   
    // deskew
    .NB_FIFO_DATA(NB_FIFO_DATA),            
    .FIFO_DEPTH(FIFO_DEPTH),              
    .MAX_SKEW(MAX_SKEW),                
    .NB_FIFO_DATA_BUS(NB_FIFO_DATA_BUS),        

    //decoder
    .NB_FSM_CONTROL(NB_FSM_CONTROL),          
    
    //test pattern checker
    .NB_MISMATCH_COUNTER(NB_MISMATCH_COUNTER)  
)
u_rx_toplevel
(
        .o_rf_hi_ber                            (ber_monitor_hi_ber_rf),
        .o_rf_am_error_counter                  (am_error_counter_rf),
        .o_rf_resync_counter_bus                (am_resync_counter_rf),
        .o_rf_am_lock                           (am_lanes_lock_rf),
        .o_rf_deskew_done                       (deskew_done_rf),
        .o_rf_missmatch_counter                 (pattern_checker_missmatch_counter_rf),
        .o_rf_lanes_block_lock                  (lanes_block_lock_rf),
        .o_rf_lanes_id                          (lanes_id_rf),
        .o_rf_decoder_error_counter             (decoder_error_counter_rf),
        .o_rf_frame_data_checker_error_counter  (frame_data_checker_error_counter_rf),
        .o_rf_frame_data_checker_lock           (frame_data_checker_lock_rf),
        .i_clock                                (i_clock),
        .i_reset                                (i_reset),
        .i_valid                                (tx_valid_channel),
        .i_phy_data                             (tx_databus_channel),
        .i_rf_enable_block_sync                 (i_rf_enb_rx_block_sync),
        .i_rf_unlocked_timer_limit              (i_rf_rx_unlocked_timer_limit),
        .i_rf_locked_timer_limit                (i_rf_rx_locked_timer_limit),
        .i_rf_sh_invalid_limit                  (i_rf_rx_sh_invalid_limit),
        .i_signal_ok                            (i_rf_enb_rx_block_sync),
        .i_rf_enable_aligner                    (i_rf_enb_rx_aligner),
        .i_rf_invalid_am_thr                    (i_rf_rx_invalid_am_thr),
        .i_rf_valid_am_thr                      (i_rf_rx_valid_am_thr),
        .i_rf_compare_mask                      (i_rf_rx_compare_mask),
        .i_rf_am_period                         (i_rf_rx_am_period  ),        
        .i_rf_enable_deskewer                   (i_rf_enb_rx_deskewer),
        .i_rf_enable_lane_reorder               (i_rf_enb_rx_lane_reorder),
        .i_rf_reset_order                       (i_rf_rx_reset_order),
        .i_rf_enable_descrambler                (i_rf_enb_rx_descrambler),
        .i_rf_enable_clock_comp                 (i_rf_enb_rx_clock_comp),
        .i_rf_enable_test_pattern_checker       (i_rf_enb_rx_test_pattern_checker),
        .i_rf_enable_decoder                    (i_rf_enb_rx_decoder),
        .i_rf_descrambler_bypass                (i_rf_rx_descrambler_bypass),
        .i_rf_idle_pattern_mode_rx              (i_rf_idle_pattern_mode)
);

endmodule

