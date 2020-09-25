//`timescale 1ns/100ps
`timescale 1ns/1ns

module toplevel_tx
#(
    parameter           NB_DATA_RAW         = 64,
    parameter           NB_CTRL_RAW         = 8,
    parameter           NB_DATA_CODED       = 66,
    parameter           NB_DATA_TAGGED      = 67,
    parameter           N_LANES             = 20
)
(
    input wire                                      i_clock,
    input wire                                      i_reset,
    input wire                                      i_rf_enb_valid_gen,
    input wire                                      i_rf_enb_frame_gen,
    input wire                                      i_rf_enb_encoder,
    input wire                                      i_rf_enb_clock_comp,
    input wire                                      i_rf_enb_scrambler,
    input wire                                      i_rf_bypass_scrambler,
    input wire                                      i_rf_idle_pattern_mode,
    input wire                                      i_rf_enb_pc_1_20,
    input wire                                      i_rf_enb_am_insertion,
        
    output wire                                     o_fast_valid,
    output wire                                     o_slow_valid,
    output wire    [NB_DATA_CODED-1 : 0]            o_encoder_data,
    output wire    [NB_DATA_CODED-1 : 0]            o_clock_comp_data,

    output wire [(NB_DATA_CODED*N_LANES)-1 : 0]     o_data,
    output wire                                     o_valid
);

//parameters for modules
/* valid_generator */
localparam              COUNT_SCALE             = 2;
localparam              VALID_COUNT_LIMIT_FAST  = 2;
localparam              VALID_COUNT_LIMIT_SLOW  = 40;
/* clock_comp_tx - am_insertion */
localparam              AM_BLOCK_PERIOD         = 16383;
//localparam              AM_BLOCK_PERIOD         = 100;

/* scrambler */
localparam              SEED                    = 58'd0;
localparam              NB_SCRAMBLER            = 58;
localparam              NB_SH                   = 2;
/* parallel converters */
localparam              NB_DATA_BUS             = NB_DATA_TAGGED*N_LANES;
/* am_insertion */
localparam              NB_BIP                  = 8;

wire dbg_valid;
assign dbg_valid = 1;

//------------------------------------modules connect signals------------------------------------

//----------------------(Valid Generator)---------------------- 
//--outputs
wire                    fast_valid;         //senial de valid de mayor tasa     
wire                    slow_valid;         //senial de valid de menor tasa

//----------------------(Frame Generator - Encoder)----------------------
//--outputs
wire    [NB_DATA_RAW-1 : 0] frameGenerator_data_encoder;
wire    [NB_CTRL_RAW-1 : 0] frameGenerator_ctrl_encoder;
wire                        frameGenerator_valid_encoder;

//----------------------(Encoder - Clock Compensator)----------------------
//--outputs
wire    [NB_DATA_CODED-1 : 0]   encoder_data_clockComp;
wire                            encoder_valid_clockComp;

//----------------------(Clock Compensator - Scrambler)----------------------
//--outputs
wire    [NB_DATA_CODED-1 : 0]  clockComp_data_scrambler;
wire                           clockComp_tag_scrambler; 
wire                            clockComp_valid_scrambler;

//----------------------(Scrambler - PC_1_to_20)----------------------
//--outputs
wire    [NB_DATA_TAGGED-1 : 0] scrambler_data_pc_1_20;
wire                            scrambler_valid_pc_1_20;

//----------------------(PC_1_to_20 - Am_insertion)----------------------
//--outputs
wire    [NB_DATA_BUS-1 : 0]   pc_1_20_data_am_insert;
wire                          pc_1_20_valid_am_insert;


//Seniales para sacar salidas al tb
assign  o_fast_valid        = fast_valid;
assign  o_slow_valid        = slow_valid;
assign  o_encoder_data      = encoder_data_clockComp;
assign  o_clock_comp_data   = clockComp_data_scrambler;
assign  o_data              = am_insert_data_channel; 
assign  o_valid             = pc_1_20_valid_am_insert;

//tx_modules
valid_generator
#(
    .COUNT_SCALE(COUNT_SCALE),
    .VALID_COUNT_LIMIT(VALID_COUNT_LIMIT_FAST)
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
    .VALID_COUNT_LIMIT(VALID_COUNT_LIMIT_SLOW)
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
    .o_tx_ctrl(frameGenerator_ctrl_encoder),
    .o_valid(frameGenerator_valid_encoder)
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
    .i_valid(frameGenerator_valid_encoder),
    .i_data(frameGenerator_data_encoder),
    .i_ctrl(frameGenerator_ctrl_encoder),
    .o_tx_coded(encoder_data_clockComp),
    .o_valid(encoder_valid_clockComp)
);


reg [128 : 0] cnt;
always @(posedge i_clock)
begin
        if(i_reset)
                cnt <= {129{1'b0}};
        else if (fast_valid)
                cnt <= cnt + 1;
end

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
    .i_enable(i_rf_enb_scrambler),
    .i_valid(clockComp_valid_scrambler),
    .i_bypass(i_rf_bypass_scrambler || clockComp_tag_scrambler),
    .i_alligner_tag(clockComp_tag_scrambler),
    .i_idle_pattern_mode(i_rf_idle_pattern_mode),
    .i_data(clockComp_data_scrambler),
    .o_data(scrambler_data_pc_1_20),
    .o_valid(scrambler_valid_pc_1_20)
);


/*


        AUX PARA DEBUG BORRAR DESP


*/

wire [NB_DATA_TAGGED-1 : 0]dbg;
assign dbg = (scrambler_data_pc_1_20[NB_DATA_TAGGED-1] == 1'b1) ? 67'hffffffffffffffffff : cnt;
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
    .i_valid(scrambler_valid_pc_1_20),
    .i_set_shadow(slow_valid),
    .i_data(scrambler_data_pc_1_20),
    //.i_data(dbg),
    .o_valid(pc_1_20_valid_am_insert),
    .o_data(pc_1_20_data_am_insert)    
);
reg [NB_DATA_BUS-1 : 0] dbg_pc_o;

always @ (i_clock)
begin
    if (i_reset)
        dbg_pc_o <= {NB_DATA_BUS{1'b0}};
    else if (slow_valid)
        dbg_pc_o <= pc_1_20_data_am_insert;
end
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
    .i_valid(pc_1_20_valid_am_insert),
    //.i_valid(slow_valid),
    .i_data(pc_1_20_data_am_insert),
    //.i_data(dbg_pc_o),
    .o_data(am_insert_data_channel),
    .o_valid(o_valid_am_insert)
);

wire [NB_DATA_TAGGED-1 : 0]         dbg_o_pc_per_lane [N_LANES-1:0];
wire [NB_DATA_CODED-1 : 0]          dbg_o_am_per_lane [N_LANES-1:0];

genvar i;
for(i=0; i<N_LANES; i=i+1)
begin: ger_block2
    assign dbg_o_pc_per_lane[i] = dbg_pc_o[(NB_DATA_TAGGED*N_LANES-2) - i*NB_DATA_TAGGED -: NB_DATA_CODED];
    assign dbg_o_am_per_lane[i] = am_insert_data_channel[(NB_DATA_CODED*N_LANES-1) - i*NB_DATA_CODED -: NB_DATA_CODED];
end

endmodule
