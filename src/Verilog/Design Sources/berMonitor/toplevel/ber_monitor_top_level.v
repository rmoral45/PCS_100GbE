`timescale 1ns/100ps

module ber_monitor_top_level
#(
    parameter                           N_LANES             = 1,
    parameter                           NB_SH_VALID_BUS     = N_LANES,
    parameter                           HI_BER_VALUE        = 97,
    parameter                           XUS_TIMER_WINDOW    = 1024
)
(
    input  wire                         i_clock,
    input  wire                         i_reset,
    input  wire                         i_test_mode,
    input  wire                         i_valid,
    input  wire [NB_SH_VALID_BUS-1  : 0]i_sh_bus,
    input  wire                         i_align_status,

    output  wire [N_LANES-1         : 0]o_hi_ber_bus    
);

(* keep = "true" *) reg valid_d;
(* keep = "true" *) reg  [NB_SH_VALID_BUS-1 : 0] sh_bus_d ;

always @(posedge i_clock) begin
    if(i_reset) begin
        valid_d <= 1'b0;
        sh_bus_d <= {NB_SH_VALID_BUS{1'b0}};
    end else begin
        valid_d <= i_valid;
        sh_bus_d <= i_sh_bus;
    end
end

genvar i;

generate
        for (i = 0; i < N_LANES; i = i + 1)
        begin: BER_MONITORS
        ber_monitor
            u_ber_monitor
            (
                .i_clock(i_clock),
                .i_reset(i_reset),
                .i_valid_sh(sh_bus_d[N_LANES - i - 1]),
                .i_test_mode(i_test_mode),
                .i_deskew_done(i_align_status),
                .i_valid(valid_d),

                .o_hi_ber(o_hi_ber_bus[N_LANES - i - 1])
            );
        end
endgenerate

endmodule
