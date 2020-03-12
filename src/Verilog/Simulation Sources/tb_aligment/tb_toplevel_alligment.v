`timescale 1ns/100ps

module tb_toplevel_alligment;

localparam  LEN_TAGGED_BLOCK            = 67;
localparam  LEN_CODED_BLOCK             = 66;
localparam  N_LANES                     = 20;
localparam  NB_BIP                      = 8;
localparam  LEN_DATA_BUS                = LEN_TAGGED_BLOCK*N_LANES;
localparam  AM_ENCODING_LOW             = 24'd0; //{M0,M1,M2} tabla 82-2
localparam  AM_ENCODING_HIGH            = 24'd0;  //{M4,M5,M6} tabla 82-2
localparam  COUNT_SCALE                 = 2;              //el clock de sistema se escala de igual manera en ambos generadores de valid
localparam  VALID_COUNT_LIMIT_FOR_FILE  = 1;              
localparam  VALID_COUNT_LIMIT_FOR_PC    = 20;             //esto indica que la señal de valid del PC es 20 veces mas lenta que la del archivo
//localparam  PATH_DATA_INPUT             = "/home/dabratte/PPS/src/Python/run/toplevel_am_insert_tb_files/data-input.txt";
localparam  PATH_DATA_INPUT             = "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/toplevel_am_insert_tb_files/data-input.txt";
//common signals
reg tb_clock, tb_reset, tb_valid, tb_enable, tb_enable_files, tb_enable_pc;
integer fid_input_data;
integer ptr_input_data;
integer code_error_idata;
//signals for file reading
reg     [0 : LEN_TAGGED_BLOCK-1]             temp_PC_i_data;
//valid_generator signals
wire                                         tb_valid_generated_for_file;
wire                                         tb_valid_generated_for_pc;
//PC_1_TO_20 signals
//reg     [LEN_TAGGED_BLOCK-1 : 0]             tb_PC_1_to_20_i_data;
reg     [0 : LEN_TAGGED_BLOCK-1]             tb_PC_1_to_20_i_data;
wire                                         tb_PC_1_to_20_o_data_valid;
wire    [LEN_DATA_BUS-1 : 0]                 tb_PC_1_to_20_o_data;  
//am_insertion signals
wire    [(LEN_CODED_BLOCK*N_LANES)-1 : 0]    tb_am_insert_o_data;
//PC_20_to_1 signals
wire    [LEN_CODED_BLOCK-1 : 0]              tb_PC_20_to_1_o_data;


reg         [(LEN_TAGGED_BLOCK*N_LANES)-1 : 0] latch_between_pc_and_am; 

initial 
begin

    fid_input_data = $fopen(PATH_DATA_INPUT, "r");
    if(fid_input_data == 0)
    begin
        $display("NO SE PUDO ABRIR EL ARCHIVO PARA DATA-INPUT1");
        $stop;
    end
    
    tb_clock        = 0;
    tb_reset        = 1;
    tb_enable       = 0;
    tb_enable_pc    = 0;
    tb_valid        = 0;
    tb_enable_files = 0;
/*#2  tb_enable_files = 1;
    tb_reset        = 0;
    tb_enable       = 1;
    tb_valid        = 1;
    */
#2  tb_reset        = 0;
    tb_valid        = 1;
#1  tb_enable_files = 1;    
#7  tb_enable       = 1;
#2  tb_enable_pc    = 1;
end

always #1 tb_clock = ~tb_clock;

always @(posedge tb_clock)
begin
    
    if(tb_enable_files && tb_valid_generated_for_file)
    //if(tb_enable_files)
    begin
        for(ptr_input_data = 0; ptr_input_data < LEN_TAGGED_BLOCK; ptr_input_data = ptr_input_data+1)
        begin
            code_error_idata = $fscanf(fid_input_data, "%b\n", temp_PC_i_data[ptr_input_data]);
            if(code_error_idata != 1)
            begin
                $display("Input data: El caracter leido no es valido");
                $stop;
            end
        end
        tb_PC_1_to_20_i_data = temp_PC_i_data;
        
    end

end

always @ (posedge tb_clock)
begin
    if (tb_reset)
        latch_between_pc_and_am <= 'd0;
    else if (tb_valid_generated_for_pc)
        latch_between_pc_and_am <= tb_PC_1_to_20_o_data;
end

parallel_converter_1_to_N
#(
    .LEN_TAGGED_BLOCK(LEN_TAGGED_BLOCK),
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK),
    .N_LANES(N_LANES)
)
u_pc_1_to_20
(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_enable(tb_enable_pc),
    .i_valid(tb_valid_generated_for_file),
    .i_set_shadow(tb_valid_generated_for_pc),
    .i_data(tb_PC_1_to_20_i_data),
    .o_valid(tb_PC_1_to_20_o_data_valid),
    .o_data(tb_PC_1_to_20_o_data)    
);

am_insertion_toplevel
#(
    .LEN_TAGGED_BLOCK(LEN_TAGGED_BLOCK),
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK),
    .N_LANES(N_LANES),
    .NB_BIP(NB_BIP)
)
u_am_insertion
(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_valid(tb_PC_1_to_20_o_data_valid),
    .i_enable(tb_PC_1_to_20_o_data_valid),
    //.i_data(tb_PC_1_to_20_o_data),
    .i_data(latch_between_pc_and_am),
    .o_data(tb_am_insert_o_data)
);

parallel_converter_N_to_1
#(
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK),
    .N_LANES(N_LANES)
)
u_pc_20_to_1
(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_enable(tb_enable),
    .i_valid(tb_valid_generated_for_file),
    .i_data(tb_am_insert_o_data),
    .o_data(tb_PC_20_to_1_o_data)
);

valid_generator
#(
    .COUNT_SCALE(COUNT_SCALE),
    .VALID_COUNT_LIMIT(VALID_COUNT_LIMIT_FOR_FILE) 
)
u_valid_generator_for_file
(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_enable(tb_enable),
    .o_valid(tb_valid_generated_for_file)
);

valid_generator
#(
    .COUNT_SCALE(COUNT_SCALE),
    .VALID_COUNT_LIMIT(VALID_COUNT_LIMIT_FOR_PC) 
)
u_valid_generator_for_pc
(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_enable(tb_enable),
    .o_valid(tb_valid_generated_for_pc)
);

//generates para ver valores en tb
//salida PC_1_TO_20
wire [LEN_TAGGED_BLOCK-1 : 0] PC_1_to_20_output_per_lane [N_LANES-1 : 0];
wire [LEN_TAGGED_BLOCK-1 : 0] am_insert_out_per_lane [N_LANES-1 : 0];
wire [LEN_TAGGED_BLOCK-1 : 0] am_insert_in_per_lane [N_LANES-1 : 0];   
wire [N_LANES-1 : 0]          am_insert_flag_per_lane;
genvar i;
for(i=0; i<N_LANES; i=i+1)
begin: ger_block1
        assign PC_1_to_20_output_per_lane[i] = tb_PC_1_to_20_o_data[(LEN_TAGGED_BLOCK*N_LANES)-1 - i*LEN_TAGGED_BLOCK -: LEN_TAGGED_BLOCK];
        assign am_insert_out_per_lane[i] = tb_am_insert_o_data[(LEN_CODED_BLOCK*N_LANES)-1 - i*LEN_CODED_BLOCK -: LEN_CODED_BLOCK];
        assign am_insert_in_per_lane[i] = tb_PC_1_to_20_o_data[(LEN_TAGGED_BLOCK*N_LANES)-1 - i*LEN_TAGGED_BLOCK -: LEN_TAGGED_BLOCK];
        //assign am_insert_in_per_lane[i] = latch_between_pc_and_am[(LEN_TAGGED_BLOCK*N_LANES)-1 - i*LEN_TAGGED_BLOCK -: LEN_TAGGED_BLOCK];
        assign am_insert_flag_per_lane  = tb_PC_1_to_20_o_data[(LEN_TAGGED_BLOCK*N_LANES)-1 - i*LEN_TAGGED_BLOCK];
end

//endgenerate
endmodule