//`timescale 1ns/100ps
`timescale 1ns/1ns

/*
 *@TODO agregar un enable diferente por modulo --> LISTO! Definir si hacer un bus de enable o seniales separadas
 *@TODO revisar los i_valid de cada modulo --> Alignment, en principio no haria falta registrar el valid, pero hay que revisar para que salga en fase con sol y resync del modulo
 *@TODO en el RF agregar las seniales de read de los registros COR
 */

module rx_toplevel
#(
    // common
    parameter NB_DATA                   = 66,
    parameter N_LANES                   = 20,
    parameter NB_DATA_BUS               = N_LANES * NB_DATA,

    // decoder
    parameter NB_DECODER_ERROR_COUNTER  = 16,
    // block sync
    parameter NB_SH                     = 2,
    parameter NB_SH_VALID_BUS           = N_LANES,
    parameter MAX_WINDOW                = 4096,
    parameter NB_WINDOW_CNT             = $clog2(MAX_WINDOW),
    parameter MAX_INV_SH                = (MAX_WINDOW/2),
    parameter NB_INV_SH                 = $clog2(MAX_WINDOW/2),
    // ber monitor
    parameter HI_BER_VALUE              = 97,
    parameter XUS_TIMER_WINDOW          = 1024,
    // aligment
    parameter NB_ERROR_COUNTER          = 8,
    parameter N_ALIGNER                 = 20,
    parameter NB_LANE_ID                = $clog2(N_ALIGNER),
    parameter MAX_INV_AM                = 8,
    parameter NB_INV_AM                 = $clog2(MAX_INV_AM),
    parameter MAX_VAL_AM                = 20,
    parameter NB_VAL_AM                 = $clog2(MAX_VAL_AM),
    parameter NB_AM                     = 48,
    parameter NB_AM_PERIOD              = 14,
    parameter AM_PERIOD_BLOCKS          = 16383,
    parameter NB_ID_BUS                 = N_LANES * NB_LANE_ID,
    parameter NB_ERR_BUS                = N_LANES * NB_ERROR_COUNTER,
    parameter NB_RESYNC_COUNTER         = 8,
    parameter NB_RESYNC_COUNTER_BUS     = NB_RESYNC_COUNTER * N_LANES,
    // deskew
    parameter NB_FIFO_DATA              = 67, //incluye tag de SOL
    parameter FIFO_DEPTH                = 20,
    parameter MAX_SKEW                  = 16,
    parameter NB_FIFO_DATA_BUS          = N_LANES * NB_FIFO_DATA,

    //decoder
    parameter NB_FSM_CONTROL    = 4,
    parameter NB_DATA_RAW       = 64,
    parameter NB_CTRL_RAW       = 8,
    
    //test pattern checker
    parameter NB_MISMATCH_COUNTER = 16

)
(
    input  wire                                     i_clock,
    input  wire                                     i_reset,
    input  wire                                     i_valid, //esta senial viene del channel? 
    input  wire [NB_DATA_BUS - 1 : 0]               i_phy_data,
    
    //Block sync inputs
    input  wire                                     i_rf_enable_block_sync,         //done
    input  wire [NB_WINDOW_CNT-1    : 0]            i_rf_unlocked_timer_limit,      //done
    input  wire [NB_WINDOW_CNT-1    : 0]            i_rf_locked_timer_limit,        //done
    input  wire [NB_INV_SH-1        : 0]            i_rf_sh_invalid_limit,          //done
    input  wire                                     i_signal_ok,                   

    //Aligner inputs
    input  wire                                     i_rf_enable_aligner,            //done
    input  wire [NB_INV_AM-1        : 0]            i_rf_invalid_am_thr,            //done
    input  wire [NB_VAL_AM-1        : 0]            i_rf_valid_am_thr,              //done
    input  wire [NB_AM-1            : 0]            i_rf_compare_mask,              //done
    input  wire [NB_AM_PERIOD-1     : 0]            i_rf_am_period,                 //done

    //Deskew inputs
    input  wire                                     i_rf_enable_deskewer,           //done
    
    //Lane reorder inputs                       
    input  wire                                     i_rf_enable_lane_reorder,       //done
    input  wire                                     i_rf_reset_order,               //done
        
    //Descrambler inputs
    input  wire                                     i_rf_enable_descrambler,        //done
    input  wire                                     i_rf_descrambler_bypass,        //done
    input  wire                                     i_rf_enable_clock_comp,         //done

    //Test pattern checker & ber_monitor signal 
    input  wire                                     i_rf_enable_test_pattern_checker, //done
    input  wire                                     i_rf_idle_pattern_mode_rx,        //done  
    
    //Decoder signals
    input  wire                                     i_rf_enable_decoder,              //done

    output wire [N_LANES-1                  : 0]    o_rf_hi_ber,
    output wire [NB_ERR_BUS  - 1            : 0]    o_rf_am_error_counter,
    output wire [NB_RESYNC_COUNTER_BUS- 1   : 0]    o_rf_resync_counter_bus,
    output wire [N_LANES     - 1            : 0]    o_rf_am_lock,
    output wire                                     o_rf_deskew_done,
    output wire [NB_MISMATCH_COUNTER-1      : 0]    o_rf_missmatch_counter,
    output wire [N_LANES-1                  : 0]    o_rf_lanes_block_lock,
    output wire [NB_ID_BUS-1                : 0]    o_rf_lanes_id,
    output wire [NB_DECODER_ERROR_COUNTER-1 : 0]    o_rf_decoder_error_counter
);

//-----------------  localparameters  ------------------//
// valid_generators

//-----------------  module connect wires  ------------------//

//block sync --> aligment
wire    [NB_DATA_BUS - 1        : 0]    blksync_data_aligment;
wire                                    blksync_valid_aligment;
wire    [N_LANES     - 1        : 0]    blksync_lock_aligment;
wire    [NB_SH_VALID_BUS-1      : 0]    blksync_sh_bermonitor;

//aligment   --> deskew
wire    [NB_DATA_BUS - 1        : 0]    aligment_data_deskew;
wire                                    aligment_valid_deskew;
wire    [N_LANES     - 1        : 0]    aligment_resync_deskew;
wire    [N_LANES     - 1        : 0]    aligment_sol_deskew;

//aligment    --> lane reorder
wire    [NB_ID_BUS   - 1        : 0]    aligment_id_reorder;

//alignment   --> rf
wire    [NB_ERR_BUS-1           : 0]    alignment_error_bus_rf; 

wire    [N_LANES-1              : 0]    am_lanes_lock;  
wire    [NB_RESYNC_COUNTER_BUS-1: 0]    am_resync_counter_rf_bus;

//ber monitor --> rf
wire    [N_LANES-1              : 0]    ber_monitor_hi_ber_bus_rf;

//deskew      --> reorder
//@CAREFUL estos datos son de 67 bits xq contiene el tag
wire [NB_FIFO_DATA_BUS  - 1     : 0]    deskew_data_reorder;
wire                                    deskew_deskewdone_reorder;
wire                                    deskew_valid_reorder;

//deskew      --> regfile
wire                                    deskew_invalidskew_rf;

//deskew      --> ber monitor
wire                                    deskew_validskew_bermonitor;

// reorder    --> descrambler
wire    [NB_DATA     - 1 : 0]           reorder_data_descrambler;
wire                                    reorder_tag_descrambler;
wire                                    reorder_valid_descrambler;

//descrambler --> clock comp rx
wire    [NB_DATA     - 1 : 0]           descrambler_data_clockcomp;
wire                                    descrambler_tag;
wire                                    descrambler_valid_clockcomp;

//clock comp rx --> decoder
wire    [NB_DATA     - 1 : 0]           clockcomp_data_decoder;
wire                                    clockcomp_valid_decoder;

//test pattern checker --> rf
wire    [NB_MISMATCH_COUNTER-1      : 0]    missmatch_counter_rf;


//decoder --> clock comp rx
wire    [NB_DATA_RAW-1              :   0]  decoder_data_raw;
wire    [NB_CTRL_RAW-1              :   0]  decoder_ctrl_raw;

//decoder --> rf
wire     [NB_DECODER_ERROR_COUNTER-1: 0]    decoder_errorcounter_rf;

//---------------------  Output RF signals registers --------------------------//
reg [N_LANES-1 : 0] lanes_block_lock_d;
reg [N_LANES-1 : 0] hi_ber_d;
reg [N_LANES-1 : 0] am_lanes_lock_d;
reg                 deskew_done_d;

//---------------------  Output RF signals registers --------------------------//
(* keep = "true" *) reg     [N_LANES-1                  : 0]    hi_ber;
(* keep = "true" *) reg     [NB_ERR_BUS-1               : 0]    am_error_counter;
(* keep = "true" *) reg     [NB_RESYNC_COUNTER_BUS-1    : 0]    am_resyncs;
(* keep = "true" *) reg     [N_LANES-1                  : 0]    am_locks;
(* keep = "true" *) reg     [NB_MISMATCH_COUNTER-1      : 0]    patternchecker_missmatch_counter;
(* keep = "true" *) reg     [N_LANES-1                  : 0]    lanes_block_lock;
(* keep = "true" *) reg     [NB_ID_BUS-1                : 0]    lanes_id_bus;
(* keep = "true" *) reg                                         deskew_done;
(* keep = "true" *) reg     [NB_DECODER_ERROR_COUNTER-1 : 0]    decoder_error_counter;                           

(* keep = "true" *) reg     [4                  : 0] deskew_done_replicated;

always @(posedge i_clock)
begin
    deskew_done_replicated <= {deskew_deskewdone_reorder, 
                               deskew_deskewdone_reorder,
                               deskew_deskewdone_reorder,
                               deskew_deskewdone_reorder,
                               deskew_deskewdone_reorder};
end

always @(posedge i_clock)
begin
    if(i_reset)
        hi_ber                  <=  {N_LANES{1'b0}};
    else
        hi_ber                  <=  ber_monitor_hi_ber_bus_rf;
end

always @(posedge i_clock)
begin
    if(i_reset)
        am_error_counter        <=  {NB_ERR_BUS{1'b0}};
    else
        am_error_counter        <=  alignment_error_bus_rf;
end

always @(posedge i_clock)
begin
    if(i_reset)
        am_resyncs              <=  {NB_ERR_BUS{1'b0}};
    else
        am_resyncs              <=  am_resync_counter_rf_bus;
end

always @(posedge i_clock)
begin
    if(i_reset)
        am_locks              <=  {N_LANES{1'b0}};
    else
        am_locks              <=  am_lanes_lock;
end

always @(posedge i_clock)
begin
    if(i_reset)
        deskew_done            <=  1'b0;
    else
        deskew_done            <= deskew_done_replicated[4];
end

always @(posedge i_clock)
begin
    if(i_reset)
        patternchecker_missmatch_counter  <=  {NB_MISMATCH_COUNTER{1'b0}};
    else
        patternchecker_missmatch_counter  <=  missmatch_counter_rf;
end

always @(posedge i_clock)
begin
    if(i_reset)
        lanes_block_lock  <=  {N_LANES{1'b0}};
    else
        lanes_block_lock  <=  blksync_lock_aligment;
end

always @(posedge i_clock)
begin
    if(i_reset)
        lanes_id_bus  <=  {NB_ID_BUS{1'b0}};
    else
        lanes_id_bus  <=  aligment_id_reorder;
end

always @(posedge i_clock)
begin
    if(i_reset)
        decoder_error_counter  <=  {NB_DECODER_ERROR_COUNTER{1'b0}};
    else
       decoder_error_counter  <=  decoder_errorcounter_rf; 
end

//---------------------  Outputs --------------------------//
    assign                                  o_rf_hi_ber                 = hi_ber;
    assign                                  o_rf_am_error_counter       = am_error_counter;
    assign                                  o_rf_resync_counter_bus     = am_resyncs;
    assign                                  o_rf_am_lock                = am_lanes_lock;
    assign                                  o_rf_missmatch_counter      = patternchecker_missmatch_counter;
    assign                                  o_rf_lanes_block_lock       = lanes_block_lock;
    assign                                  o_rf_lanes_id               = lanes_id_bus;
    assign                                  o_rf_deskew_done            = deskew_done;
    assign                                  o_rf_decoder_error_counter  = decoder_error_counter;

    (* keep = "true" *) reg     [9:0] reset_replied;

    always @(posedge i_clock)
    begin
        reset_replied <= {  i_reset, i_reset, i_reset, i_reset, i_reset,
                            i_reset, i_reset, i_reset, i_reset, i_reset};
    end

//---------------------  Instances --------------------------//

decoder
u_decoder
(
    .i_clock                    (i_clock),
    .i_reset                    (reset_replied[0] & (~i_rf_enable_decoder)),
    .i_enable                   (i_rf_enable_decoder),
    .i_data                     (clockcomp_data_decoder),
    .i_valid                    (clockcomp_valid_decoder),

    .o_data                     (decoder_data_raw),
    .o_ctrl                     (decoder_ctrl_raw),
    .o_fsm_control              (decoder_fsmcontrol_clockcomp),
    .o_rf_error_counter         (decoder_errorcounter_rf)
);

test_pattern_checker
u_test_pattern_checker
(
    .i_clock                    (i_clock),
    .i_reset                    (reset_replied[1] & (~i_rf_enable_test_pattern_checker)),
    .i_enable                   (i_rf_enable_test_pattern_checker),
    .i_valid                    (clockcomp_valid_decoder),
    .i_idle_pattern_mode        (i_rf_idle_pattern_mode_rx),
    .i_data                     (descrambler_data_clockcomp),
    
    .o_mismatch_counter         (missmatch_counter_rf)
);

//revisar FIFO para que no propague X para arriba
clock_comp_rx
u_clock_comp_rx
(
    .i_clock                    (i_clock),
    .i_reset                    (reset_replied[2] & (~i_rf_enable_clock_comp)),
    .i_rf_enable                (i_rf_enable_clock_comp & deskew_done_replicated[0]),
    .i_valid                    (descrambler_valid_clockcomp),
    .i_sol_tag                  (descrambler_tag),  
    .i_data                     (descrambler_data_clockcomp),
    
    .o_data                     (clockcomp_data_decoder),
    .o_valid                    (clockcomp_valid_decoder)
);

descrambler
#(
    .LEN_CODED_BLOCK            (NB_DATA)
 )
    u_descrambler
    (
        .i_clock                (i_clock),
        .i_reset                (reset_replied[3] & (~i_rf_enable_descrambler)),
        .i_enable               (i_rf_enable_descrambler), 
        .i_valid                (reorder_valid_descrambler),
        .i_bypass               (i_rf_descrambler_bypass | reorder_tag_descrambler),
        .i_data                 (reorder_data_descrambler),
        .i_tag                  (reorder_tag_descrambler),
        .i_deskew_done          (deskew_done_replicated[1]),

        .o_data                 (descrambler_data_clockcomp),
        .o_valid                (descrambler_valid_clockcomp),
        .o_tag                  (descrambler_tag)
    );


reorder_toplevel
#(
    .NB_DATA        (NB_DATA),
    .NB_FIFO_DATA   (NB_FIFO_DATA),
    .N_LANES        (N_LANES)
 )
    u_reorder_top
    (
    .i_clock                    (i_clock),
    .i_reset                    (reset_replied[4] & (~i_rf_enable_lane_reorder)),
    .i_rf_reset_order           (i_rf_reset_order),
    .i_enable                   (i_rf_enable_lane_reorder),
    .i_valid                    (deskew_valid_reorder),
    .i_deskew_done              (deskew_done_replicated[2]),
    .i_logical_rx_ID            (aligment_id_reorder),
    .i_data                     (deskew_data_reorder),

    .o_data                     (reorder_data_descrambler),
    .o_valid                    (reorder_valid_descrambler),
    .o_tag                      (reorder_tag_descrambler)
    );

deskew_top
#(
    .N_LANES                    (N_LANES),
    .NB_DATA                    (NB_DATA),
    .NB_FIFO_DATA               (NB_FIFO_DATA),
    .FIFO_DEPTH                 (FIFO_DEPTH),
    .MAX_SKEW                   (MAX_SKEW)
)
    u_deskew_top
    (
    .i_clock                    (i_clock),
    .i_reset                    (reset_replied[5] & (~i_rf_enable_deskewer)),
    .i_enable                   (i_rf_enable_deskewer),
    .i_valid                    (aligment_valid_deskew),
    .i_resync                   (aligment_resync_deskew),
    .i_start_of_lane            (aligment_sol_deskew),
    .i_data                     (aligment_data_deskew),
    .i_am_lock                  (&am_lanes_lock),
    
    .o_data                     (deskew_data_reorder),
    .o_valid                    (deskew_valid_reorder),
    .o_deskew_done              (deskew_deskewdone_reorder),
    .o_invalid_skew             (deskew_invalidskew_rf)
    );


am_top_level
#(
    .N_LANES                    (N_LANES),
    .NB_DATA                    (NB_DATA),
    .NB_ERROR_COUNTER           (NB_ERROR_COUNTER),
    .N_ALIGNER                  (N_ALIGNER),
    .MAX_INV_AM                 (MAX_INV_AM),
    .MAX_VAL_AM                 (MAX_VAL_AM),
    .NB_AM                      (NB_AM)
    
)
u_aligner_top
(
    .i_clock                    (i_clock),
    .i_reset                    (reset_replied[6] & (~i_rf_enable_aligner)),
    .i_rf_enable                (i_rf_enable_aligner),
    .i_valid                    (blksync_valid_aligment),
    .i_block_lock               (blksync_lock_aligment),
    .i_data                     (blksync_data_aligment),
    .i_rf_invalid_am_thr        ('d6),
    .i_rf_valid_am_thr          ('d3),
    .i_rf_compare_mask          (48'hffffffffffff),
    .i_rf_am_period             ('d16383),

    .o_data                     (aligment_data_deskew),
    .o_valid                    (aligment_valid_deskew),
    .o_lane_id                  (aligment_id_reorder),
    .o_error_counter            (alignment_error_bus_rf),
    .o_am_lock                  (am_lanes_lock),
    .o_resync                   (aligment_resync_deskew),
    .o_resync_counter_bus       (am_resync_counter_rf_bus),
    .o_start_of_lane            (aligment_sol_deskew)
);

ber_monitor_top_level
u_ber_monitor_top_level
(
    .i_clock                    (i_clock),
    .i_reset                    (reset_replied[7]),
    .i_valid                    (blksync_valid_aligment),
    .i_sh_bus                   (blksync_sh_bermonitor),
    .i_test_mode                (i_rf_idle_pattern_mode_rx),
    .i_align_status             (deskew_done_replicated[3]),

    .o_hi_ber_bus               (ber_monitor_hi_ber_bus_rf)
);

block_sync_toplevel
#(
    .NB_DATA                    (NB_DATA),
    .N_LANES                    (N_LANES),
    .MAX_WINDOW                 (MAX_WINDOW)
)
u_block_sync_top
(
    .i_clock                    (i_clock),
    .i_reset                    (reset_replied[8] & (~i_rf_enable_block_sync)),
    .i_enable                   (i_rf_enable_block_sync),
    .i_valid                    (i_valid),
    .i_data                     (i_phy_data),
    .i_signal_ok                (i_signal_ok),
    .i_rf_unlocked_timer_limit  ('d512),
    .i_rf_locked_timer_limit    ('d128),
    .i_rf_sh_invalid_limit      ('d128),

    .o_data                     (blksync_data_aligment),
    .o_sh_bus                   (blksync_sh_bermonitor),
    .o_valid                    (blksync_valid_aligment),
    .o_block_lock               (blksync_lock_aligment)
);

endmodule
