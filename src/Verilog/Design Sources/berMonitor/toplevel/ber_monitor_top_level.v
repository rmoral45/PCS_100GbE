`timescale 1ns/100ps

module ber_monitor_top_level
#(
    parameter                           N_LANES             = 20,
    parameter                           NB_SH_VALID_BUS     = N_LANES,
    parameter                           HI_BER_VALUE        = 97,
    parameter                           XUS_TIMER_WINDOW    = 1024
)
(
    input  wire                         i_clock,
    input  wire                         i_reset,
    input  wire                         i_test_mode,
    input  wire [N_LANES     - 1    : 0]i_valid,
    input  wire [NB_SH_VALID_BUS-1  : 0]i_sh_bus,
    input  wire                         i_align_status,

    output  wire [N_LANES-1         : 0]o_hi_ber_bus    
);

genvar i;

generate
        for (i = 0; i < N_LANES; i = i + 1)
        begin: BER_MONITORS
        ber_monitor
            u_ber_monitor
            (
                .i_clock(i_clock),
                .i_reset(i_reset),
                .i_valid_sh(i_sh_bus[N_LANES - i - 1]),
                .i_test_mode(i_test_mode),
                .i_deskew_done(i_align_status),
                .i_valid(i_valid[i]),

                .o_hi_ber(o_hi_ber_bus[N_LANES - i - 1])
            );
        end
endgenerate

endmodule
