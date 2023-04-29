`timescale 1ns/100ps

module am_top_level
#(
        parameter N_LANES               = 20,
        parameter NB_DATA               = 66,
        parameter NB_ERROR_COUNTER      = 16,
        parameter NB_RESYNC_COUNTER     = 8,
        parameter N_ALIGNER             = 20,
        parameter NB_LANE_ID            = $clog2(N_ALIGNER),
        parameter MAX_INV_AM            = 8,
        parameter NB_INV_AM             = $clog2(MAX_INV_AM),
        parameter MAX_VAL_AM            = 20,
        parameter NB_VAL_AM             = $clog2(MAX_VAL_AM),
        parameter NB_AM                 = 48,
        parameter NB_AM_PERIOD          = 14,
        parameter NB_DATA_BUS           = N_LANES * NB_DATA,
        parameter NB_ID_BUS             = N_LANES * NB_LANE_ID,
        parameter NB_ERR_BUS            = N_LANES * NB_ERROR_COUNTER,
        parameter NB_RESYNC_COUNTER_BUS = NB_RESYNC_COUNTER * N_LANES
 )
 (
        input  wire                                     i_clock,

        input  wire                                     i_reset,

        input  wire                                     i_rf_enable,

        input  wire                                     i_valid,

        input  wire [N_LANES-1                  : 0]    i_block_lock,

        input  wire [NB_DATA_BUS-1              : 0]    i_data,

        input  wire [NB_INV_AM-1                : 0]    i_rf_invalid_am_thr,

        input  wire [NB_VAL_AM-1                : 0]    i_rf_valid_am_thr,

        input  wire [NB_AM-1                    : 0]    i_rf_compare_mask,

        input  wire [NB_AM_PERIOD-1             : 0]    i_rf_am_period,

        
        output wire [NB_DATA_BUS-1              : 0]    o_data,
        
        output wire                                     o_valid,

        output wire [NB_ID_BUS-1                : 0]    o_lane_id,

        output wire [NB_ERR_BUS-1               : 0]    o_error_counter,

        output wire [N_LANES-1                  : 0]    o_am_lock,

        output wire [N_LANES-1                  : 0]    o_resync,

        output wire [NB_RESYNC_COUNTER_BUS-1    : 0]    o_resync_counter_bus,

        output wire [N_LANES-1                  : 0]    o_start_of_lane
 );
 
        wire        [NB_DATA_BUS-1 : 0]                 alignment_out;
          
        assign                                          o_valid = i_valid;
        assign                                          o_data  = alignment_out;

        genvar i;
        generate
            for (i = 0; i < N_LANES; i = i + 1)
            begin : LANE_ALIGNERS
                am_lock_module
                #(  
                    .NB_CODED_BLOCK         (NB_DATA),
                    .NB_ERROR_COUNTER       (NB_ERROR_COUNTER),
                    .N_ALIGNER              (N_ALIGNER),
                    .MAX_INV_AM             (MAX_INV_AM),
                    .MAX_VAL_AM             (MAX_VAL_AM)
                )
                u_am_lock
                (
                    .i_clock                (i_clock),
                    .i_reset                (i_reset),
                    .i_rf_enable            (i_rf_enable),
                    .i_valid                (i_valid),
                    .i_block_lock           (i_block_lock[N_LANES-1-i]),
                    .i_data                 (i_data[(NB_DATA_BUS-1 - i*NB_DATA) -: NB_DATA]),
                    .i_rf_invalid_am_thr    (i_rf_invalid_am_thr),
                    .i_rf_valid_am_thr      (i_rf_valid_am_thr),
                    .i_rf_compare_mask      (48'hffffffffffff),
                    .i_rf_am_period         (i_rf_am_period),
    
                    .o_data                 (alignment_out[NB_DATA_BUS-1-i*NB_DATA -: NB_DATA]),
                    .o_lane_id              (o_lane_id[(NB_ID_BUS-1-i*NB_LANE_ID) -: NB_LANE_ID]),
                    .o_error_counter        (o_error_counter[NB_ERR_BUS-1-i*NB_ERROR_COUNTER -: NB_ERROR_COUNTER]),
                    .o_am_lock              (o_am_lock[N_LANES - i - 1]),
                    .o_resync               (o_resync[N_LANES - i - 1]),
                    .o_resync_counter       (o_resync_counter_bus[NB_RESYNC_COUNTER_BUS-1-i*NB_RESYNC_COUNTER -: NB_RESYNC_COUNTER]),
                    .o_start_of_lane        (o_start_of_lane[N_LANES - i - 1])
                );
            end
        endgenerate


endmodule
