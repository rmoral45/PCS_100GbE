`timescale 1ns/100ps


module block_sync_toplevel
#(
        parameter                               NB_DATA           = 66,
        parameter                               N_LANES           = 20,
        parameter                               MAX_INDEX_VALUE   = (NB_DATA - 2),
        parameter                               MAX_WINDOW        = 4096,
        parameter                               MAX_INVALID_SH    = (MAX_WINDOW/2), //FIX especificar correctamen    te
        parameter                               NB_WINDOW_CNT     = $clog2(MAX_WINDOW),
        parameter                               NB_INVALID_CNT    = $clog2(MAX_INVALID_SH),
        parameter                               NB_INDEX          = $clog2(NB_DATA),
        parameter                               NB_DATA_BUS       = N_LANES * NB_DATA,
        parameter                               NB_SH_VALID_BUS   = N_LANES
 )
 (
        input  wire                             i_clock,

        input  wire                             i_reset,

        input  wire                             i_enable,

        input  wire                             i_valid,

        input  wire                             i_signal_ok,

        input  wire [NB_WINDOW_CNT-1    : 0]    i_rf_unlocked_timer_limit,

        input  wire [NB_WINDOW_CNT-1    : 0]    i_rf_locked_timer_limit,

        input  wire [NB_INVALID_CNT-1   : 0]    i_rf_sh_invalid_limit,

        input  wire [NB_DATA_BUS-1      : 0]    i_data,

        output wire [NB_DATA_BUS-1      : 0]    o_data,

        output wire                             o_valid,

        output wire [NB_SH_VALID_BUS-1  : 0]    o_sh_bus,

        output wire [N_LANES-1          : 0]    o_block_lock
 );
        
        reg                                     valid;

        wire     [NB_DATA_BUS-1      : 0] block_lock_single_lane[N_LANES - 1 : 0];


        assign      o_valid     =   i_valid;


        genvar i;

        generate
        for (i = 0; i < N_LANES; i = i + 1)
        begin
                block_sync_module
                #(
                    .NB_CODED_BLOCK         (NB_DATA),
                    .MAX_WINDOW             (MAX_WINDOW)
                 )
                u_blk_sync
                (
                    .i_clock                (i_clock),
                    .i_reset                (i_reset),
                    .i_valid                (i_valid),
                    .i_enable               (i_enable),
                    .i_signal_ok            (i_signal_ok),
                    .i_data                 (i_data[NB_DATA_BUS-1-i*NB_DATA -: NB_DATA]),
                    .i_unlocked_timer_limit (i_rf_unlocked_timer_limit),
                    .i_locked_timer_limit   (i_rf_locked_timer_limit),
                    .i_sh_invalid_limit     (i_rf_sh_invalid_limit),

                    .o_data                 (o_data[NB_DATA_BUS-1-i*NB_DATA -: NB_DATA]),
                    .o_valid_sh             (o_sh_bus[i]),
                    .o_block_lock           (o_block_lock[i])
                );
                
                assign block_lock_single_lane[i] = o_data[NB_DATA_BUS-1-i*NB_DATA -: NB_DATA];
        end
        endgenerate

endmodule
