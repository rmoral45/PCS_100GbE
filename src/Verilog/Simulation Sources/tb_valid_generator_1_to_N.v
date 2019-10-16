`timescale 1ns/100ps 

module tb_valid_generator_1_to_N;

localparam N_LANES                      =   20;
localparam NB_DATA                      =   66;
localparam NB_DATA_BUS                  =   N_LANES*NB_DATA;
localparam NB_COUNT                     =   $clog2(N_LANES);
localparam COUNT_SCALE                  =   2;              //el clock de sistema se escala de igual manera en ambos generadores de valid
localparam VALID_COUNT_LIMIT_FOR_FILE   =   1;              
localparam VALID_COUNT_LIMIT_FOR_PC     =   20;             //esto indica que la señal de valid del PC es 20 veces mas lenta que la del archivo
localparam PATH_DATA_INPUT              =   "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/valid_generator_tb_files/valid-gen-data-input-1-to-20.txt";

reg tb_clock, tb_reset, tb_enable, tb_enable_files;
reg [0 : NB_DATA-1]             temp_i_data;
reg [NB_DATA-1 : 0]             tb_i_data;

wire [NB_DATA_BUS-1 : 0]        tb_o_data;
wire [NB_DATA-1 : 0]            tujavie;
reg  [NB_DATA_BUS-1 : 0]        tb_reg_o_data; 
wire                            tb_valid_generated_for_file;
wire                            tb_valid_generated_for_pc;
wire                            tb_o_valid;


/* Wires signals for debug */
wire [NB_DATA-1 : 0]            out_data_0;
wire [NB_DATA-1 : 0]            out_data_1;
wire [NB_DATA-1 : 0]            out_data_2;
wire [NB_DATA-1 : 0]            out_data_3;
wire [NB_DATA-1 : 0]            out_data_4;
wire [NB_DATA-1 : 0]            out_data_5;
wire [NB_DATA-1 : 0]            out_data_6;
wire [NB_DATA-1 : 0]            out_data_7;
wire [NB_DATA-1 : 0]            out_data_8;
wire [NB_DATA-1 : 0]            out_data_9;
wire [NB_DATA-1 : 0]            out_data_10;
wire [NB_DATA-1 : 0]            out_data_11;
wire [NB_DATA-1 : 0]            out_data_12;
wire [NB_DATA-1 : 0]            out_data_13;
wire [NB_DATA-1 : 0]            out_data_14;
wire [NB_DATA-1 : 0]            out_data_15;
wire [NB_DATA-1 : 0]            out_data_16;
wire [NB_DATA-1 : 0]            out_data_17;
wire [NB_DATA-1 : 0]            out_data_18;
wire [NB_DATA-1 : 0]            out_data_19;
assign out_data_0 = tb_reg_o_data [NB_DATA_BUS-1-(0*NB_DATA) -: NB_DATA];
assign out_data_1 = tb_reg_o_data [NB_DATA_BUS-1-(1*NB_DATA) -: NB_DATA]; 
assign out_data_2 = tb_reg_o_data [NB_DATA_BUS-1-(2*NB_DATA) -: NB_DATA];
assign out_data_3 = tb_reg_o_data [NB_DATA_BUS-1-(3*NB_DATA) -: NB_DATA];
assign out_data_4 = tb_reg_o_data [NB_DATA_BUS-1-(4*NB_DATA) -: NB_DATA];
assign out_data_5 = tb_reg_o_data [NB_DATA_BUS-1-(5*NB_DATA) -: NB_DATA];
assign out_data_6 = tb_reg_o_data [NB_DATA_BUS-1-(6*NB_DATA) -: NB_DATA];
assign out_data_7 = tb_reg_o_data [NB_DATA_BUS-1-(7*NB_DATA) -: NB_DATA];
assign out_data_8 = tb_reg_o_data [NB_DATA_BUS-1-(8*NB_DATA) -: NB_DATA];
assign out_data_9 = tb_reg_o_data [NB_DATA_BUS-1-(9*NB_DATA) -: NB_DATA];
assign out_data_10 = tb_reg_o_data [NB_DATA_BUS-1-(10*NB_DATA) -: NB_DATA];
assign out_data_11 = tb_reg_o_data [NB_DATA_BUS-1-(11*NB_DATA) -: NB_DATA];
assign out_data_12 = tb_reg_o_data [NB_DATA_BUS-1-(12*NB_DATA) -: NB_DATA];
assign out_data_13 = tb_reg_o_data [NB_DATA_BUS-1-(13*NB_DATA) -: NB_DATA];
assign out_data_14 = tb_reg_o_data [NB_DATA_BUS-1-(14*NB_DATA) -: NB_DATA];
assign out_data_15 = tb_reg_o_data [NB_DATA_BUS-1-(15*NB_DATA) -: NB_DATA];
assign out_data_16 = tb_reg_o_data [NB_DATA_BUS-1-(16*NB_DATA) -: NB_DATA];
assign out_data_17 = tb_reg_o_data [NB_DATA_BUS-1-(17*NB_DATA) -: NB_DATA];
assign out_data_18 = tb_reg_o_data [NB_DATA_BUS-1-(18*NB_DATA) -: NB_DATA];
assign out_data_19 = tb_reg_o_data [NB_DATA_BUS-1-(19*NB_DATA) -: NB_DATA];
/* End of wires signals for debug */

integer                         fid_input_data;
integer                         ptr_input_data;
integer                         code_error_idata;

initial
begin
    
    fid_input_data = $fopen(PATH_DATA_INPUT, "r");
    if(fid_input_data == 0)
    begin
        $display("NO SE PUDO ABRIR EL ARCHIVO PARA DATA-INPUT");
        $stop;
    end

    tb_clock        = 0;
    tb_reset        = 1;
    tb_enable       = 0;
    tb_enable_files = 0;
    tb_i_data       = 0;
#12  tb_reset        = 0;
  tb_enable       = 1;
    tb_enable_files = 1;

end

always #1 tb_clock = ~tb_clock;

always @(posedge tb_clock)
begin

    if(tb_enable_files && tb_valid_generated_for_file)
    begin

        for(ptr_input_data = 0; ptr_input_data < NB_DATA; ptr_input_data = ptr_input_data + 1)
        begin
            code_error_idata <= $fscanf(fid_input_data, "%b\n", temp_i_data[ptr_input_data]);
            if(code_error_idata != 1)
            begin
                $display("Input data: El caracter leido no es valido");
                $stop;
            end
        end

        tb_i_data   <= temp_i_data;

    end

end

always @(posedge tb_clock)
begin
    
    if(tb_valid_generated_for_pc)
    begin
        tb_reg_o_data <= tb_o_data; 
    end
    
end


parallel_converter_1_to_N
#(
    .LEN_CODED_BLOCK(NB_DATA),
    .N_LANES(N_LANES),
    .NB_DATA_BUS(NB_DATA_BUS)
)
u_parallel_converter_1_to_20
(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_enable(tb_enable),
    .i_valid(tb_valid_generated_for_file),
    .i_data(tb_i_data),
    .o_valid(tb_o_valid),
    .o_data(tb_o_data)
);

parallel_converter_N_to_1
#(
    .LEN_CODED_BLOCK(NB_DATA),
    .N_LANES(N_LANES),
    .NB_INPUT(NB_DATA_BUS)
)
u_parallel_converter_20_to_1
(
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_enable(tb_enable),
    .i_valid(tb_valid_generated_for_file),
    .i_data(tb_reg_o_data),
    .o_data(tujavie)
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

endmodule
