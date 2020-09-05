//`timescale 1ns/100ps
`timescale 1ns/1ns

module tb_pcs_loopback;

localparam           NB_DATA_RAW         = 64;
localparam           NB_CTRL_RAW         = 8;
localparam           NB_DATA_CODED       = 66;
localparam           NB_DATA_TAGGED      = 67;
localparam           N_LANES             = 20;


//rx
// common
localparam NB_DATA                   = 66;
localparam NB_DATA_BUS               = N_LANES * NB_DATA;
// valid generators  
localparam COUNT_SCALE               = 2;
localparam VALID_COUNT_LIMIT_FAST    = 2;
localparam VALID_COUNT_LIMIT_SLOW    = 40;
// block sync
localparam NB_SH                     = 2;
localparam NB_SH_VALID_BUS           = 20;
localparam MAX_WINDOW                = 4096;
localparam NB_WINDOW_CNT             = $clog2(MAX_WINDOW);
localparam MAX_INV_SH                = (MAX_WINDOW/2);
localparam NB_INV_SH                 = $clog2(MAX_WINDOW/2);
// ber monitor
localparam HI_BER_VALUE              = 97;
localparam XUS_TIMER_WINDOW          = 1024;
// aligment
localparam NB_ERROR_COUNTER          = 16;
localparam N_ALIGNER                 = 20;
localparam NB_LANE_ID                = $clog2(N_ALIGNER);
localparam MAX_INV_AM                = 8;
localparam NB_INV_AM                 = $clog2(MAX_INV_AM);
localparam MAX_VAL_AM                = 20;
localparam NB_VAL_AM                 = $clog2(MAX_VAL_AM);
localparam NB_AM                     = 48;
localparam NB_AM_PERIOD              = 16;
localparam AM_PERIOD_BLOCKS          = 16383;
localparam NB_ID_BUS                 = N_LANES * NB_LANE_ID;
localparam NB_ERR_BUS                = N_LANES * NB_ERROR_COUNTER;
localparam NB_RESYNC_COUNTER         = 8;
localparam NB_RESYNC_COUNTER_BUS     = NB_RESYNC_COUNTER * N_LANES;
// deskew
localparam NB_FIFO_DATA              = 67; //incluye tag de SOL
localparam FIFO_DEPTH                = 20;
localparam MAX_SKEW                  = 16;
localparam FIFO_DATA_BUS             = N_LANES * FIFO_DEPTH;

//decoder
localparam NB_FSM_CONTROL    = 4;


//test pattern checker
localparam NB_MISMATCH_COUNTER = 32;




reg tb_clock;
reg tb_reset;

// tx_toplevel
reg tb_rf_enb_valid_gen;
reg tb_rf_enb_frame_gen;
reg tb_rf_enb_encoder;
reg tb_rf_enb_clock_comp;
reg tb_rf_enb_scrambler;
reg tb_rf_bypass_scrambler;
reg tb_rf_idle_pattern_mode;
reg tb_rf_enb_pc_1_20;
reg tb_rf_enb_am_insertion;
reg tb_rf_enb_pc_20_1;

wire                                     tb_tx_o_fast_valid;
wire                                     tb_tx_o_slow_valid;
wire    [NB_DATA_CODED-1 : 0]            tb_tx_o_encoder_data;
wire    [NB_DATA_CODED-1 : 0]            tb_tx_o_clock_comp_data;
wire    [(NB_DATA_CODED*N_LANES)-1 : 0]  tb_tx_o_am_insert_data;
wire                                     tb_tx_o_valid_pc;
wire    [(NB_DATA_CODED*N_LANES)-1 : 0] tb_tx_o_data;
wire tb_tx_slow_valid;
wire tb_tx_fast_valid;



    reg tb_enable_rx;
    reg tb_valid; //esta senial viene del channel? 
    reg tb_phy_data;
    
    
    //Block sync inputs
    reg tb_rf_enable_block_sync;
    reg [NB_WINDOW_CNT-1    : 0]  tb_rf_unlocked_timer_limit;
    reg [NB_WINDOW_CNT-1    : 0] tb_rf_locked_timer_limit;
    reg [NB_INV_SH-1        : 0] tb_rf_sh_invalid_limit;
    reg tb_data;
    reg tb_signal_ok;

    //Aligner inputs
    reg tb_rf_enable_aligner;
    reg [NB_INV_AM-1        : 0]  tb_rf_invalid_am_thr;
    reg [NB_VAL_AM-1        : 0]tb_rf_valid_am_thr;
    reg [NB_AM-1            : 0] tb_rf_compare_mask;
    reg [NB_AM_PERIOD-1     : 0] tb_rf_am_period;
    wire[N_LANES-1          : 0] tb_rf_am_lock;

    //Deskew inputs
    reg tb_rf_enable_deskewer;

    //Lane reorder inputs
    reg tb_rf_enable_lane_reorder;
    reg tb_rf_reset_order;
        
    //Descrambler inputs
    reg tb_rf_enable_descrambler;
    reg tb_rf_descrambler_bypass;
    reg tb_rf_enable_clock_comp;

    //Test pattern checker & ber_monitor signal
    reg tb_rf_test_pattern_checker;
    reg tb_rf_idle_pattern_mode_rx;
    
    //Decoder signals
    reg tb_rf_enable_decoder;
    
    wire [N_LANES-1          : 0]    tb_o_rf_hi_ber;
    wire [NB_ERR_BUS  - 1    : 0]    tb_o_rf_am_error_counter;
    wire [NB_RESYNC_COUNTER_BUS  - 1    : 0]    tb_o_rf_resync_counter_bus;
    wire [N_LANES     - 1    : 0]    tb_o_rf_am_lock;
    wire                             tb_o_rf_invalid_skew;
    wire [NB_MISMATCH_COUNTER-1  : 0] tb_o_rf_missmatch_counter;
    wire [N_LANES-1          : 0]    tb_o_rf_lanes_block_lock;
    wire [NB_ID_BUS-1        : 0]    tb_o_rf_lanes_id;

initial
begin

        tb_clock                = 1'b0;
        tb_reset                = 1'b0;

        //TX
        tb_rf_enb_valid_gen     = 1'b0;
        tb_rf_enb_frame_gen     = 1'b0;
        tb_rf_enb_encoder       = 1'b0;
        tb_rf_enb_clock_comp    = 1'b0;
        tb_rf_enb_scrambler     = 1'b0;
        tb_rf_bypass_scrambler  = 1'b0;
        tb_rf_idle_pattern_mode = 1'b0;
        tb_rf_enb_pc_1_20       = 1'b0;
        tb_rf_enb_am_insertion  = 1'b0;
        tb_rf_enb_pc_20_1       = 1'b0;       

        //RX
        tb_enable_rx= 1'b0;
        tb_phy_data= 1'b0;
        //Valid generator inputs
        tb_rf_enb_valid_gen= 1'b0;
        //Block sync inputs
        tb_rf_enable_block_sync= 1'b0;
        tb_rf_unlocked_timer_limit= {NB_WINDOW_CNT{1'b0}};
        tb_rf_locked_timer_limit= {NB_WINDOW_CNT{1'b0}};
        tb_rf_sh_invalid_limit= {NB_INV_SH{1'b0}};
        tb_signal_ok= 1'b0;
        //Aligner inputs
        tb_rf_enable_aligner= 1'b0;
        tb_rf_invalid_am_thr= {NB_INV_AM{1'b0}};
        tb_rf_valid_am_thr= {NB_VAL_AM{1'b0}};
        tb_rf_compare_mask= {NB_AM{1'b0}};
        tb_rf_am_period= {NB_AM_PERIOD{1'b0}};
        //Deskew inputs
        tb_rf_enable_deskewer= 1'b0;
        //Lane reorder inputs
        tb_rf_enable_lane_reorder= 1'b0;
        tb_rf_reset_order= 1'b0;
        //Descrambler inputs
        tb_rf_enable_descrambler= 1'b0;
        tb_rf_descrambler_bypass= 1'b0;
        tb_rf_enable_clock_comp= 1'b0;
        //Test pattern checker & ber_monitor signal
        tb_rf_test_pattern_checker= 1'b0;
        tb_rf_idle_pattern_mode_rx= 1'b0;
        //Decoder signals
        tb_rf_enable_decoder= 1'b0;
        //Read pulses to COR registers
//        tb_rf_read_lanes_id= 1'b0;
//        tb_rf_hi_ber= 1'b0;
//        tb_rf_am_error_counter= 1'b0;
//        tb_rf_resync_counter_bus= 1'b0;
//        tb_rf_am_lock= 1'b0;
//        tb_rf_invalid_skew= 1'b0;
//        tb_missmatch_counter= 1'b0;
//        tb_rf_lanes_block_lock= 1'b0;
//        tb_rf_lanes_id= 1'b0;        

#100    tb_reset                = 1'b1;
#10     tb_reset                = 1'b0;

        //tx
#100    tb_rf_enb_valid_gen     = 1'b1;
        tb_rf_enb_frame_gen     = 1'b1;
        tb_rf_enb_encoder       = 1'b1;
        tb_rf_enb_clock_comp    = 1'b1;
        tb_rf_enb_scrambler     = 1'b1;
        tb_rf_bypass_scrambler  = 1'b1;
        tb_rf_idle_pattern_mode = 1'b0;
        tb_rf_enb_pc_1_20       = 1'b1;
        tb_rf_enb_am_insertion  = 1'b1;
        tb_rf_enb_pc_20_1       = 1'b1;

        //RX
        tb_enable_rx= 1'b1;
        tb_valid= 1'b1; //esta senial viene del channel? 
        tb_phy_data= 1'b1;
        //Valid generator inputs
        tb_rf_enb_valid_gen= 1'b1;
        //Block sync inputs
        tb_rf_enable_block_sync= 1'b1;
        tb_rf_unlocked_timer_limit = 64;
        tb_rf_locked_timer_limit= 1024;
        tb_rf_sh_invalid_limit= 65;
        tb_signal_ok= 1'b1;
        //Aligner inputs
        tb_rf_enable_aligner= 1'b1;
        tb_rf_invalid_am_thr = 4;
        tb_rf_valid_am_thr = 1;
        tb_rf_compare_mask= {NB_AM{1'b1}};
        tb_rf_am_period= 16383;
        //Deskew inputs
        tb_rf_enable_deskewer= 1'b1;
        //Lane reorder inputs
        tb_rf_enable_lane_reorder= 1'b1;
        tb_rf_reset_order= 1'b0;
        //Descrambler inputs
        tb_rf_enable_descrambler= 1'b1;
        tb_rf_descrambler_bypass= 1'b1;
        tb_rf_enable_clock_comp= 1'b1;
        //Test pattern checker & ber_monitor signal
        tb_rf_test_pattern_checker= 1'b1;
        tb_rf_idle_pattern_mode_rx= 1'b1;
        //Decoder signals
        tb_rf_enable_decoder= 1'b1;
        //Read pulses to COR registers
        // tb_rf_read_lanes_id= 1'b0;
        // tb_rf_hi_ber= 1'b0;
        // tb_rf_am_error_counter= 1'b0;
        // tb_rf_resync_counter_bus= 1'b0;
        // tb_rf_am_lock= 1'b0;
        // tb_rf_invalid_skew= 1'b0;
        // tb_missmatch_counter= 1'b0;
        // tb_rf_lanes_block_lock= 1'b0;
        // tb_rf_lanes_id= 1'b0;

    #300000000 $finish;
end

always #1 tb_clock = ~tb_clock;


toplevel_tx#(
    .NB_DATA_RAW(NB_DATA_RAW),
    .NB_CTRL_RAW(NB_CTRL_RAW),
    .NB_DATA_CODED(NB_DATA_CODED),
    .NB_DATA_TAGGED(NB_DATA_TAGGED),
    .N_LANES(N_LANES)
)
u_toplevel_tx
(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_rf_enb_valid_gen(tb_rf_enb_valid_gen),
    .i_rf_enb_frame_gen(tb_rf_enb_frame_gen),
    .i_rf_enb_encoder(tb_rf_enb_encoder),
    .i_rf_enb_clock_comp(tb_rf_enb_clock_comp),
    .i_rf_enb_scrambler(tb_rf_enb_scrambler),
    .i_rf_bypass_scrambler(tb_rf_bypass_scrambler),
    .i_rf_idle_pattern_mode(tb_rf_idle_pattern_mode),
    .i_rf_enb_pc_1_20(tb_rf_enb_pc_1_20),
    .i_rf_enb_am_insertion(tb_rf_enb_am_insertion),
    .i_rf_enb_pc_20_1(tb_rf_enb_pc_20_1),
    
    .o_fast_valid(tb_tx_fast_valid),
    .o_slow_valid(tb_tx_slow_valid),
    .o_encoder_data(tb_tx_o_encoder_data),
    .o_clock_comp_data(tb_tx_o_clock_comp_data),
    .o_am_insert_data(tb_tx_o_am_insert_data),
    .o_valid_pc(tb_tx_o_valid_pc),
    .o_data(tb_tx_o_data)
);

rx_toplevel
#(
    // common
    .NB_DATA                   (NB_DATA),
    .N_LANES                   (N_LANES),
    .NB_DATA_BUS               (NB_DATA_BUS),
    // valid generators  
    .COUNT_SCALE               (COUNT_SCALE),
    .VALID_COUNT_LIMIT_FAST    (VALID_COUNT_LIMIT_FAST),
    .VALID_COUNT_LIMIT_SLOW    (VALID_COUNT_LIMIT_SLOW),
    // block sync
    .NB_SH                     (NB_SH),
    .NB_SH_VALID_BUS           (NB_SH_VALID_BUS),
    .MAX_WINDOW                (MAX_WINDOW),
    .NB_WINDOW_CNT             (NB_WINDOW_CNT),
    .MAX_INV_SH                (MAX_INV_SH),
    .NB_INV_SH                 (NB_INV_SH),
    // ber monitor
    .HI_BER_VALUE              (HI_BER_VALUE),
    .XUS_TIMER_WINDOW          (XUS_TIMER_WINDOW),
    // aligment
    .NB_ERROR_COUNTER          (NB_ERROR_COUNTER),
    .N_ALIGNER                 (N_ALIGNER),
    .NB_LANE_ID                (NB_LANE_ID),
    .MAX_INV_AM                (MAX_INV_AM),
    .NB_INV_AM                 (NB_INV_AM),
    .MAX_VAL_AM                (MAX_VAL_AM),
    .NB_VAL_AM                 (NB_VAL_AM),
    .NB_AM                     (NB_AM),
    .NB_AM_PERIOD              (NB_AM_PERIOD),
    .AM_PERIOD_BLOCKS          (AM_PERIOD_BLOCKS),
    .NB_ID_BUS                 (NB_ID_BUS),
    .NB_ERR_BUS                (NB_ERR_BUS),
    .NB_RESYNC_COUNTER         (NB_RESYNC_COUNTER),
    .NB_RESYNC_COUNTER_BUS     (NB_RESYNC_COUNTER_BUS),
    // deskew
    .NB_FIFO_DATA              (NB_FIFO_DATA),
    .FIFO_DEPTH                (FIFO_DEPTH),
    .MAX_SKEW                  (MAX_SKEW),
    .FIFO_DATA_BUS             (FIFO_DATA_BUS),

    //decoder
    .NB_FSM_CONTROL    (NB_FSM_CONTROL),
    .NB_DATA_RAW       (NB_DATA_RAW),
    .NB_CTRL_RAW       (NB_CTRL_RAW),
    
    //test pattern checker
    .NB_MISMATCH_COUNTER (NB_MISMATCH_COUNTER)
)
u_rx_toplevel
(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_enable(tb_enable_rx),
    .i_phy_data(tb_tx_o_data),
    
    //Valid generator inputs
    .i_rf_enb_valid_gen(tb_rf_enb_valid_gen),
    
    //Block sync inputs
    .i_rf_enable_block_sync(tb_rf_enable_block_sync),
    .i_rf_unlocked_timer_limit(tb_rf_unlocked_timer_limit),
    .i_rf_locked_timer_limit(tb_rf_locked_timer_limit),
    .i_rf_sh_invalid_limit(tb_rf_sh_invalid_limit),
    .i_signal_ok(tb_signal_ok),

    //Aligner inputs
    .i_rf_enable_aligner(tb_rf_enable_aligner),
    .i_rf_invalid_am_thr(tb_rf_invalid_am_thr),
    .i_rf_valid_am_thr(tb_rf_valid_am_thr),
    .i_rf_compare_mask(tb_rf_compare_mask),
    .i_rf_am_period(tb_rf_am_period),

    //Deskew inputs
    .i_rf_enable_deskewer(tb_rf_enable_deskewer),

    //Lane reorder inputs
    .i_rf_enable_lane_reorder(tb_rf_enable_lane_reorder),
    .i_rf_reset_order(tb_rf_reset_order),
        
    //Descrambler inputs
    .i_rf_enable_descrambler(tb_rf_enable_descrambler),
    .i_rf_descrambler_bypass(tb_rf_descrambler_bypass),
    .i_rf_enable_clock_comp(tb_rf_enable_clock_comp),

    //Test pattern checker & ber_monitor signal
    .i_rf_enable_test_pattern_checker(tb_rf_test_pattern_checker),
    .i_rf_idle_pattern_mode_rx(tb_rf_idle_pattern_mode),
    
    //Decoder signals
    .i_rf_enable_decoder(tb_rf_enable_decoder),
    
    //Read pulses to COR registers
    .i_rf_read_hi_ber(1'b0),
    .i_rf_read_am_error_counter(1'b0),
    .i_rf_read_am_resyncs(1'b0),
    .i_rf_read_invalid_skew(1'b0),
    .i_rf_read_missmatch_counter(1'b0),
    .i_rf_read_lanes_block_lock(1'b0),
    .i_rf_read_lanes_id(1'b0),

    .o_rf_hi_ber(tb_o_rf_hi_ber),
    .o_rf_am_error_counter(tb_o_rf_am_error_counter),
    .o_rf_resync_counter_bus(tb_rf_resync_counter_bus),
    .o_rf_am_lock(tb_rf_am_lock),
    .o_rf_invalid_skew(tb_rf_invalid_skew),
    .o_rf_missmatch_counter(tb_o_rf_missmatch_counter),
    .o_rf_lanes_block_lock(tb_o_rf_lanes_block_lock),
    .o_rf_lanes_id(tb_o_rf_lanes_id)
);


endmodule