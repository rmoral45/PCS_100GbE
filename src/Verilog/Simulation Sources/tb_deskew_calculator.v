`timescale 1ns/100ps

module tb_deskew_calculator;

localparam N_LANES          =   20;
localparam MAX_SKEW         =   16;
localparam NB_COUNT         =   $clog2(MAX_SKEW);
localparam NB_DATA          =   66;
localparam PATH_SOL         =   "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/skew_tb_files/start-of-lane-input.txt";
localparam PATH_RESYNC      =   "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/skew_tb_files/resync-input.txt";  
localparam PATH_DATA_INPUT  =   "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/skew_tb_files/fifos-input.txt"; 
localparam PATH_DATA_OUTPUT =   "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/skew_tb_files/fifos-output-verilog.txt";


reg tb_clock, tb_reset, tb_enable, tb_valid, tb_enable_files;
reg     [N_LANES-1 : 0]             temp_sol;
reg     [N_LANES-1 : 0]             tb_i_start_of_lane;
reg     [N_LANES-1 : 0]             temp_resync;
reg     [N_LANES-1 : 0]             tb_i_resync;
reg     [(N_LANES*NB_DATA)-1 : 0]   tb_i_data;
reg     [(N_LANES*NB_DATA)-1 : 0]   temp_i_data;

wire                                tb_o_set_fifo_delay;
//wire                                tb_o_valid_skew;
//wire                                tb_o_align_status;
wire    [(N_LANES*NB_COUNT)-1 : 0]	tb_o_lane_delay;
wire    [(NB_DATA*N_LANES)-1 : 0]   tb_o_data;

integer fid_input_sol_vector; 
integer fid_input_resync_vector;
integer fid_input_data;
integer fid_output_data;
integer ptr_sol;
integer ptr_resync;
integer ptr_input_data;
integer code_error_sol;
integer code_error_resync;
integer code_error_idata;

initial
begin

    fid_input_sol_vector = $fopen(PATH_SOL, "r");   
    if(fid_input_sol_vector == 0)
    begin
        $display("NO SE PUDO ABRIR EL ARCHIVO PARA SOL-INPUT");
        $stop;
    end

    fid_input_resync_vector = $fopen(PATH_RESYNC, "r");
    if(fid_input_resync_vector == 0)
    begin
        $display("NO SE PUDO ABRIR EL ARCHIVO PARA RESYNC-INPUT");
        $stop;    
    end
    
    fid_input_data = $fopen(PATH_DATA_INPUT, "r");
    if(fid_input_data == 0)
    begin
        $display("NO SE PUDO ABRIR EL ARCHIVO PARA INPUT-DATA");
        $stop;
    end

    fid_output_data = $fopen(PATH_DATA_OUTPUT, "w");
    if(fid_output_data == 0)
    begin
        $display("NO SE PUDO ABRIR EL ARCHIVO PARA OUTPUT-DATA");
        $stop;
    end
    
    tb_clock = 0;
    tb_reset = 1;
    tb_enable = 0;
    tb_valid = 0;
    tb_enable_files = 0;
    #2  tb_enable_files = 1;
    #2  tb_reset = 0;
        tb_enable = 1;
        tb_valid = 1;
end

always #1tb_clock = ~tb_clock;

always @ (posedge tb_clock)
begin
    
    if(tb_enable_files)
    begin

        for(ptr_sol = 0; ptr_sol < N_LANES; ptr_sol = ptr_sol + 1)
        begin
            code_error_sol <= $fscanf(fid_input_sol_vector, "%b\n", temp_sol[ptr_sol]);
            if(code_error_sol != 1)
            begin
                $display("Start_of_lane: El caracter leido no es valido..");
                //$stop;
            end
        end
        
        for(ptr_resync = 0; ptr_resync < N_LANES; ptr_resync = ptr_resync + 1)
        begin
            code_error_resync <= $fscanf(fid_input_resync_vector, "%b\n", temp_resync[ptr_resync]);
            if(code_error_resync != 1)
            begin
                $display("Resync: El caracter leido no es valido..");
                //$stop;
            end
        end
        
        for(ptr_input_data = 0; ptr_input_data < N_LANES*NB_DATA; ptr_input_data = ptr_input_data + 1)
        begin
            code_error_idata <= $fscanf(fid_input_data, "%b\n", temp_i_data[ptr_input_data]);
            if(code_error_idata != 1)
            begin
                $display("Resync: El caracter leido no es valido..");
                //$stop;
            end
        end

        $fwrite(fid_output_data, "%b\n", tb_o_data);
        
        tb_i_data           <= temp_i_data;
        tb_i_start_of_lane  <= temp_sol;
        tb_i_resync         <= temp_resync;

    end

end



deskew_top
#()
u_deskew_top
    (
    .i_clock(tb_clock),
    .i_reset(tb_reset),
    .i_enable(tb_enable),
    .i_valid(tb_valid),
    .i_resync(tb_i_resync),
    .i_start_of_lane(tb_i_start_of_lane),
    .i_data(tb_i_data),
    .o_set_fifo_delay(tb_o_set_fifo_delay),
    //.o_deskew_done(tb_o_deskew_done),
    .o_lane_delay(tb_o_lane_delay),
    .o_data(tb_o_data)
    );

endmodule