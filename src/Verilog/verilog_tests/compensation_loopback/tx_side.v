`timescale 1ns/100ps

module tx_side
#(
	parameter							NB_DATA_RAW		= 64,
    parameter							NB_CTRL_RAW		= 8,
    parameter                           NB_DATA_CODED   = 66,
    parameter                           NB_DATA         = 66,
    parameter                           NB_DATA_TAGGED  = 67,
    parameter                           N_LANES         = 20,
    parameter                           AM_BLOCK_PERIOD = 16383,
    
    	parameter NB_SCRAMBLER   = 58,
	parameter NB_SH 	  = 2,
	parameter SEED		  = 0,
	parameter NB_MISMATCH_COUNTER = 32
)
(
    input wire i_clock,
    input wire i_reset,
    input wire i_enable,
    input wire i_valid,
    input wire i_rf_bypass_scrambler,
    input wire i_rf_idle_pattern_mode,
    input wire i_enable_clock_comp,
    
    output wire [NB_DATA_RAW-1 : 0] o_data,
    output wire [NB_CTRL_RAW-1 : 0] o_ctrl
);

wire [NB_DATA_RAW-1 : 0] framegen_data_encoder;
wire [NB_CTRL_RAW-1 : 0] framegen_ctrl_encoder;
wire                    framegen_valid_encoder;

wire    [NB_DATA_CODED-1 : 0]   encoder_data_clockComp;
wire                            encoder_valid_clockComp;

wire    [NB_DATA_CODED-1 : 0]  clockComp_data_scrambler;
wire                           clockComp_tag_scrambler; 
wire                            clockComp_valid_scrambler;

wire    [NB_DATA_TAGGED-1 : 0] scrambler_data_pc_1_20;
wire                            scrambler_valid_pc_1_20;

wire    [NB_DATA     - 1 : 0]       descrambler_data_clockcomp;
wire                                descrambler_tag;
wire                                descrambler_valid_clockcomp;

//clock comp rx --> decoder
wire    [NB_DATA     - 1 : 0]       clockcomp_data_decoder;
wire                                clockcomp_valid_decoder;

wire                                decoder_fsmcontrol_clockcomp;
wire    [NB_MISMATCH_COUNTER-1 : 0] missmatch_counter_rf;


top_level_frameGenerator
u_top_level_frameGenerator
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_enable),
    .i_valid(),
    
    .o_tx_data(framegen_data_encoder),
    .o_tx_ctrl(framegen_ctrl_encoder),
    .o_valid(framegen_valid_encoder)
);

encoder
u_encoder
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_enable),
    .i_valid(framegen_valid_encoder),
    .i_data(framegen_data_encoder),
    .i_ctrl(framegen_ctrl_encoder),
    .o_tx_coded(encoder_data_clockComp),
    .o_valid(encoder_valid_clockComp)    
);


clock_comp_tx
#(
    .NB_DATA_CODED(NB_DATA_CODED),
    .AM_BLOCK_PERIOD(AM_BLOCK_PERIOD),
    .N_LANES(N_LANES)
)
u_clock_comp
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_enable),
    .i_valid(encoder_valid_clockComp),
    .i_data(encoder_data_clockComp),
    //.i_data(cnt),
    .o_data(clockComp_data_scrambler),
    .o_aligner_tag(clockComp_tag_scrambler),
    .o_valid(clockComp_valid_scrambler)
);

scrambler
#(  
    .NB_SCRAMBLER(NB_SCRAMBLER),
    .NB_DATA_CODED(NB_DATA_CODED),
    .NB_DATA_TAGGED(NB_DATA_TAGGED),
    .NB_SH(NB_SH),
    .SEED(SEED)
)
u_scrambler
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_enable),
    .i_valid(clockComp_valid_scrambler),
    .i_bypass(i_rf_bypass_scrambler || clockComp_tag_scrambler),
    .i_alligner_tag(clockComp_tag_scrambler),
    .i_idle_pattern_mode(i_rf_idle_pattern_mode),
    .i_data(clockComp_data_scrambler),
    .o_data(scrambler_data_pc_1_20),
    .o_valid(scrambler_valid_pc_1_20)
);


decoder
u_decoder
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_enable_clock_comp),
    .i_data(clockcomp_data_decoder),
    .i_valid(clockcomp_valid_decoder),

    .o_data(o_data),
    .o_ctrl(o_ctrl),
    .o_fsm_control(decoder_fsmcontrol_clockcomp)
);

test_pattern_checker
u_test_pattern_checker
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_enable_clock_comp),
    .i_valid(clockcomp_valid_decoder),
    .i_idle_pattern_mode(i_rf_idle_pattern_mode),
    .i_data(descrambler_data_clockcomp),
    
    .o_mismatch_counter(missmatch_counter_rf)
);

//revisar FIFO para que no propague X para arriba
clock_comp_rx
u_clock_comp_rx
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_rf_enable(i_enable_clock_comp),
    .i_valid(descrambler_valid_clockcomp),
    .i_fsm_control(decoder_fsmcontrol_clockcomp),
    .i_sol_tag(descrambler_tag),  
    .i_data(descrambler_data_clockcomp),
    
    .o_data(clockcomp_data_decoder),
    .o_valid(clockcomp_valid_decoder)
);

descrambler
#(
    .LEN_CODED_BLOCK    (NB_DATA)
 )
    u_descrambler
    (
        .i_clock    (i_clock),
        .i_reset    (i_reset),
        .i_enable   (i_enable), 
        .i_valid    (scrambler_valid_pc_1_20),
        
        .i_bypass   (i_rf_bypass_scrambler | scrambler_data_pc_1_20[NB_DATA_TAGGED-1]),
        .i_data     (scrambler_data_pc_1_20[NB_DATA_TAGGED -2 : 0]),
        
        .i_tag      (scrambler_data_pc_1_20[NB_DATA_TAGGED-1]),

        .o_data     (descrambler_data_clockcomp),
        .o_valid    (descrambler_valid_clockcomp),
        .o_tag      (descrambler_tag)
    );

endmodule




