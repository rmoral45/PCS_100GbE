`timescale 1ns/100ps

module toplevel_tx
#(
    parameter           NB_DATA_RAW         = 64,
    parameter           NB_CTRL_RAW         = 8,
    parameter           NB_DATA_CODED       = 66,
    parameter           NB_DATA_TAGGED      = 67,
    parameter           N_LANES             = 20
)
(
    input wire          i_clock,
    input wire          i_reset,
    input wire          i_rf_enb_valid_gen,
    input wire          i_rf_enb_frame_gen,
    input wire          i_rf_enb_encoder,
    input wire          i_rf_enb_clock_comp,
    input wire          i_rf_enb_scrambler,
    input wire          i_rf_bypass_scrambler,
    input wire          i_rf_idle_pattern_mode,
    input wire          i_rf_enb_pc_1_20,
    input wire          i_rf_enb_am_insertion
    //input wire          i_rf_enb_serial_transmitter,
    
    //output wire [(NB_DATA_CODED*N_LANES)-1 : 0]     o_data
);

//parameters for modules
/* valid_generator */
localparam              COUNT_SCALE         = 2;
localparam              VALID_COUNT_LIMIT   = 10;
/* clock_comp_tx - am_insertion */
localparam              AM_BLOCK_PERIOD     = 16383;
/* scrambler */
localparam              SEED                = 58'd0;
localparam              NB_SCRAMBLER        = 58;
localparam              NB_SH               = 2;
/* parallel converters */
localparam              NB_DATA_BUS         = NB_DATA_TAGGED*N_LANES;
/* am_insertion */
localparam              NB_BIP              = 8;


//------------------------------------modules connect signals------------------------------------

//----------------------(Valid Generator)---------------------- 
//--outputs
wire                    fast_valid;         //senial de valid de mayor tasa     
wire                    slow_valid;         //senial de valid de menor tasa

//----------------------(Frame Generator - Encoder)----------------------
//--outputs
wire    [NB_DATA_RAW-1 : 0] frameGenerator_data_encoder;
wire    [NB_CTRL_RAW-1 : 0] frameGenerator_ctrl_encoder;

//----------------------(Encoder - Clock Compensator)----------------------
//--outputs
wire    [NB_DATA_CODED-1 : 0] encoder_data_clockComp;

//----------------------(Clock Compensator - Scrambler)----------------------
//--outputs
wire    [NB_DATA_CODED-1 : 0]  clockComp_data_scrambler;
wire                           clockComp_tag_scrambler; 

//----------------------(Scrambler - PC_1_to_20)----------------------
//--outputs
wire    [NB_DATA_TAGGED-1 : 0] scrambler_data_pc_1_20;

//----------------------(PC_1_to_20 - Am_insertion)----------------------
//--outputs
wire    [NB_DATA_BUS-1 : 0]   pc_1_20_data_am_insert;
wire                          pc_1_20_valid_am_insert;

//----------------------(Am_insertion - PC_20_to_1)----------------------
//--outputs
wire    [(NB_DATA_CODED*N_LANES)-1 : 0] am_insert_data_pc_20_1;

//----------------------(PC_20_to_1 - Serial Transmitter)----------------------
//--outputs
wire    [NB_DATA_CODED-1 : 0] pc_20_1_data_serial_tx;


//tx_modules
valid_generator
#(
    .COUNT_SCALE(COUNT_SCALE),
    .VALID_COUNT_LIMIT(VALID_COUNT_LIMIT)
)
u_fast_valid
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_rf_enb_valid_gen),
    .o_valid(fast_valid)
);

valid_generator
#(
    .COUNT_SCALE(COUNT_SCALE),
    .VALID_COUNT_LIMIT(VALID_COUNT_LIMIT)
)
u_slow_valid
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_rf_enb_valid_gen),
    .o_valid(slow_valid)
);

top_level_frameGenerator
#(
    .NB_DATA_RAW(NB_DATA_RAW),
    .NB_CTRL_RAW(NB_CTRL_RAW)
)
u_frameGenerator
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_rf_enb_frame_gen),
    .o_tx_data(frameGenerator_data_encoder),
    .o_tx_ctrl(frameGenerator_ctrl_encoder)
);

encoder
#(
    .NB_DATA_CODED(NB_DATA_CODED),
    .NB_DATA_RAW(NB_DATA_RAW),
    .NB_CTRL_RAW(NB_CTRL_RAW)
)
u_encoder
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_rf_enb_encoder),
    .i_valid(fast_valid),
    .i_data(frameGenerator_data_encoder),
    .i_ctrl(frameGenerator_ctrl_encoder),
    .o_tx_coded(encoder_data_clockComp)
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
    .i_enable(i_rf_enb_clock_comp),
    .i_valid(fast_valid),
    .i_data(encoder_data_clockComp),
    .o_data(clockComp_data_scrambler),
    .o_aligner_tag(clockComp_tag_scrambler)
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
    .i_enable(i_rf_enb_scrambler),
    .i_valid(fast_valid),
    .i_bypass(i_rf_bypass_scrambler || clockComp_tag_scrambler),
    .i_alligner_tag(clockComp_tag_scrambler),
    .i_idle_pattern_mode(i_rf_idle_pattern_mode),
    .i_data(clockComp_data_scrambler),
    .o_data(scrambler_data_pc_1_20)
);

parallel_converter_1_to_N
#(
    .NB_DATA_TAGGED(NB_DATA_TAGGED),
    .NB_DATA_CODED(NB_DATA_CODED),
    .N_LANES(N_LANES),
    .NB_DATA_BUS(NB_DATA_BUS)
)
u_pc_1_to_20
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_rf_enb_pc_1_20),
    .i_valid(fast_valid),
    .i_set_shadow(slow_valid),
    .i_data(scrambler_data_pc_1_20),
    .o_valid(pc_1_20_valid_am_insert),
    .o_data(pc_1_20_data_am_insert)    
);

am_insertion_toplevel
#(
    .NB_DATA_CODED(NB_DATA_CODED),
    .NB_DATA_TAGGED(NB_DATA_TAGGED),
    .N_LANES(N_LANES),
    .NB_BIP(NB_BIP)
)
u_am_insertion
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_rf_enb_am_insertion),
    .i_valid(slow_valid),
    .i_data(pc_1_20_data_am_insert),
    .o_data(am_insert_data_pc_20_1)
);

parallel_converter_N_to_1
#(
    .NB_DATA_CODED(NB_DATA_CODED),
    .N_LANES(N_LANES)
)
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(),
    .i_valid(slow_valid),
    .i_data(am_insert_data_pc_20_1),
    .o_data(pc_20_1_data_serial_tx)
);

endmodule