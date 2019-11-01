`timescale 1ns/100ps

module tb_toplvel_tx;

localparam      NB_DATA_RAW         = 64;
localparam      NB_CTRL_RAW         = 8;
localparam      NB_DATA_CODED       = 66;
localparam      NB_DATA_TAGGED      = 67;
localparam      N_LANES             = 20;
localparam      COUNT_SCALE         = 2;
localparam      VALID_COUNT_LIMIT   = 10;
localparam      AM_BLOCK_PERIOD     = 16383;
localparam      SEED                = 58'd0;
localparam      NB_SCRAMBLER        = 58;
localparam      NB_SH               = 2;
localparam      NB_DATA_BUS         = NB_DATA_TAGGED*N_LANES;
localparam      NB_BIP              = 8;

reg tb_clock; 
reg tb_reset;
reg tb_enb_valid_gen;
reg tb_enb_frame_gen;
reg tb_enb_encoder;
reg tb_enb_clock_comp;
reg tb_enb_scrambler;
reg tb_bypass_scrambler;
reg tb_idle_pattern_mode;
reg tb_enb_pc_1_20;
reg tb_enb_am_insertion;
reg tb_enb_pc_20_1;

initial
begin
    tb_clock 				 = 0;
	tb_reset 				 = 0;
    tb_enb_valid_gen         = 0;
    tb_enb_frame_gen         = 0;
    tb_enb_encoder           = 0;
    tb_enb_clock_comp        = 0;
    tb_enb_scrambler         = 0;
    tb_bypass_scrambler      = 0;
    tb_idle_pattern_mode     = 0;
    tb_enb_pc_1_20           = 0;
    tb_enb_am_insertion      = 0;
    tb_enb_pc_20_1           = 0;
#2  tb_reset                 = 1;
#4  tb_reset                 = 0;
#2  tb_enb_valid_gen         = 1;
    tb_enb_frame_gen         = 1;
    tb_enb_encoder           = 1;
    tb_enb_clock_comp        = 1;
    tb_enb_scrambler         = 1;
    tb_enb_pc_1_20           = 1;
    tb_enb_am_insertion      = 1;
    tb_enb_pc_20_1           = 1;
end

always #1 tb_clock = ~tb_clock;

toplevel_tx#(
    .NB_DATA_RAW(NB_DATA_RAW),
    .NB_CTRL_RAW(NB_CTRL_RAW),
    .NB_DATA_CODED(NB_DATA_CODED),
    .NB_DATA_TAGGED(NB_DATA_TAGGED),
    .N_LANES(N_LANES)
)
(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_rf_enb_valid_gen(tb_enb_valid_gen),
    .i_rf_enb_frame_gen(tb_enb_frame_gen),
    .i_rf_enb_encoder(tb_enb_encoder),
    .i_rf_enb_clock_comp(tb_enb_clock_comp),
    .i_rf_enb_scrambler(tb_enb_scrambler),
    .i_rf_bypass_scrambler(tb_bypass_scrambler),
    .i_rf_idle_pattern_mode(tb_idle_pattern_mode),
    .i_rf_enb_pc_1_20(tb_enb_pc_1_20),
    .i_rf_enb_am_insertion(tb_enb_am_insertion),
    .i_rf_enb_pc_20_1(tb_enb_pc_20_1)
);

endmodule
