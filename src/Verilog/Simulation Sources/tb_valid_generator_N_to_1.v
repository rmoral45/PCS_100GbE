`timescale 1ns/100ps

module tb_valid_generator_N_to_1;

localparam N_LANES              =   20;
localparam NB_DATA              =   66;
localparam NB_DATA_BUS          =   N_LANES*NB_DATA;
localparam VALID_COUNT_LIMIT_FOR_FILE    =   20;
localparam COUNT_SCALE          =   1;
localparam VALID_COUNT_LIMIT_FOR_PC = 1;
localparam PATH_DATA_INPUT      =   "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/valid_generator_tb_files/valid-gen-data-input-20-to-1.txt";


reg tb_clock, tb_reset, tb_enable, tb_enable_files;
reg [0 : (NB_DATA*N_LANES)-1]   temp_i_data;
reg [(NB_DATA*N_LANES)-1 : 0]   tb_i_data;

wire [NB_DATA-1 : 0]             tb_o_data; 
wire tb_valid_generated_for_file;
wire tb_valid_generated_for_pc;

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
#2  tb_enable_files = 1;
    tb_reset        = 0;
    tb_enable       = 1;
end

always #1 tb_clock = ~tb_clock;

always @(posedge tb_clock)
begin

    if(tb_enable_files && tb_valid_generated_for_file)
    begin

        for(ptr_input_data = 0; ptr_input_data < N_LANES*NB_DATA; ptr_input_data = ptr_input_data + 1)
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
    .i_valid(tb_valid_generated_for_pc),
    .i_data(tb_i_data),
    .o_data(tb_o_data)
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
