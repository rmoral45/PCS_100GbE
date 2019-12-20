`timescale 1ns/100ps

module tb_toplvel_tx;
localparam      DATA_ENCODER_PATH   = "/home/dabratte/PPS/src/Python/modules/top_level_tx/dump/encoder_output.txt";
localparam      DATA_CLOCKCOMP_PATH = "/home/dabratte/PPS/src/Python/modules/top_level_tx/dump/clockComp_output.txt";
localparam      DATA_AM_INSERT_PATH = "/home/dabratte/PPS/src/Python/modules/top_level_tx/dump/amInsert_output.txt";
localparam      NB_DATA_RAW         = 64;
localparam      NB_CTRL_RAW         = 8;
localparam      NB_DATA_CODED       = 66;
localparam      NB_DATA_TAGGED      = 67;
localparam      N_LANES             = 20;
localparam      COUNT_SCALE         = 2;
localparam      VALID_COUNT_LIMIT   = 10;
//localparam      AM_BLOCK_PERIOD     = 16383;
localparam      AM_BLOCK_PERIOD     = 100;
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

wire                                fast_valid;
wire                                slow_valid;
wire [NB_DATA_CODED-1 : 0]          tb_o_encoder_data;
wire [NB_DATA_CODED-1 : 0]          tb_o_clock_comp_data;
wire [NB_DATA_CODED*N_LANES-1 : 0]  tb_o_am_insert_data;
wire [NB_DATA_TAGGED*N_LANES-1 : 0]  tb_o_pc_data;
wire [NB_DATA_CODED-1 : 0]          tb_o_am_insert_per_lane [N_LANES-1:0];
wire [NB_DATA_TAGGED-1 : 0]         tb_o_pc_per_lane [N_LANES-1:0];
wire                                tb_o_valid_pc;

integer                             fid_tx_data_encoder;
integer                             fid_tx_data_clockComp;
integer                             fid_tx_am_insert;
integer                             j;


initial
begin
    
    fid_tx_data_encoder = $fopen(DATA_ENCODER_PATH, "w");
    if(fid_tx_data_encoder == 0)
    begin
        $display("No se pudo abrir archivo para encoder output");
        $stop;
    end
    
    fid_tx_data_clockComp = $fopen(DATA_CLOCKCOMP_PATH, "w");
    if(fid_tx_data_clockComp == 0)
    begin
        $display("No se pudo abrir archivo para clockComp output");
        $stop;
    end
    
    fid_tx_am_insert = $fopen(DATA_AM_INSERT_PATH, "w");
    if(fid_tx_am_insert == 0)
    begin
        $display("No se pudo abrir archivo para amInsert output");
        $stop;
    end


    tb_clock 		     = 0;
    tb_reset 		     = 0;
    tb_enb_valid_gen         = 0;
    tb_enb_frame_gen         = 0;
    tb_enb_encoder           = 0;
    tb_enb_clock_comp        = 0;
    tb_enb_scrambler         = 0;
    tb_bypass_scrambler      = 0;
    tb_idle_pattern_mode     = 1;
    tb_enb_pc_1_20           = 0;
    tb_enb_am_insertion      = 0;
    tb_enb_pc_20_1           = 0;
    tb_reset                 = 1;
#100  
    tb_reset                 = 0;
    tb_enb_valid_gen         = 1;
    tb_enb_frame_gen         = 1;
    tb_enb_encoder           = 1;
    tb_enb_clock_comp        = 1;
    tb_enb_am_insertion      = 1;
    tb_enb_pc_20_1           = 1;
  tb_enb_scrambler         = 1;
    tb_enb_pc_1_20           = 1;
#200
    tb_bypass_scrambler      = 1;
    tb_idle_pattern_mode     = 0;
    
end

always #1 tb_clock = ~tb_clock;

always @(posedge fast_valid)
begin
        $fwrite(fid_tx_data_encoder, "%b\n", tb_o_encoder_data);
        $fwrite(fid_tx_data_clockComp, "%b\n", tb_o_clock_comp_data);        
end

always @(posedge tb_o_valid_pc)
begin   
        for(j=0; j<N_LANES; j=j+1)
            $fwrite(fid_tx_am_insert, "%b\n", tb_o_am_insert_per_lane[j]);

end

toplevel_tx#(
    .NB_DATA_RAW(NB_DATA_RAW),
    .NB_CTRL_RAW(NB_CTRL_RAW),
    .NB_DATA_CODED(NB_DATA_CODED),
    .NB_DATA_TAGGED(NB_DATA_TAGGED),
    .N_LANES(N_LANES)
)
u_toplevel_tx
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
    .i_rf_enb_pc_20_1(tb_enb_pc_20_1),
    .o_fast_valid(fast_valid),
    .o_slow_valid(slow_valid),
    .o_encoder_data(tb_o_encoder_data),
    .o_clock_comp_data(tb_o_clock_comp_data),
    .o_am_insert_data(tb_o_am_insert_data),
    .o_valid_pc(tb_o_valid_pc),
    .o_pc_data(tb_o_pc_data)
);

genvar i;

//generate - serializar salida del am_insert

for(i=0; i<N_LANES; i=i+1)
begin: ger_block1
    assign tb_o_am_insert_per_lane[i] = tb_o_am_insert_data[(NB_DATA_CODED*N_LANES-1) - i*NB_DATA_CODED -: NB_DATA_CODED];
end

for(i=0; i<N_LANES; i=i+1)
begin: ger_block2
    assign tb_o_pc_per_lane[i] = tb_o_pc_data[(NB_DATA_TAGGED*N_LANES-2) - i*NB_DATA_TAGGED -: NB_DATA_CODED];
end
//endgenerate
endmodule
