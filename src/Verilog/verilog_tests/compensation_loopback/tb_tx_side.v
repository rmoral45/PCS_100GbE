`timescale 1ns/100ps

module tb_tx_side;

reg tb_clock, tb_reset, tb_enable, tb_bypass, tb_pattern_mode;
reg tb_enable_clock_comp;

wire [63 : 0] tb_o_data;
wire [7 : 0]  tb_o_ctrl;


initial
begin

    tb_clock = 1'b0;
    tb_reset = 1'b0;
    tb_enable=1'b0;
    tb_bypass=1'b0;
    tb_pattern_mode=1'b0;
    tb_enable_clock_comp = 1'b0;

#10 tb_reset = 1'b1;
#2  tb_reset = 1'b0;
    //tb_bypass = 1'b0;

#2  tb_enable = 1'b1;
#573 tb_enable_clock_comp = 1'b1;

#100000000 $finish;
end

always #1 tb_clock = ~tb_clock;

tx_side
u_tx_side
(
.i_clock(tb_clock),
.i_reset(tb_reset),
.i_enable(tb_enable),
.i_valid(1'b1),
.i_rf_bypass_scrambler(tb_bypass),
.i_rf_idle_pattern_mode(tb_pattern_mode),
.i_enable_clock_comp(tb_enable_clock_comp),
.o_data(tb_o_data),
.o_ctrl(tb_o_ctrl)
);


endmodule
