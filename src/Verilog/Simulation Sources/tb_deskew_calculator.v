`timescale 1ns/100ps

module tb_deskew_calculator;

localparam N_LANES      =    20;
localparam MAX_SKEW     =    16;
localparam NB_COUNT     =     6;
localparam PATH_SOL     =    "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/skew_tb_files/start-of-lane-input.txt";
localparam PATH_RESYNC  =    "/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/skew_tb_files/resync-input.txt";    

reg tb_clock, tb_reset, tb_enable, tb_valid, tb_enable_files;
reg     [N_LANES-1 : 0]             temp_sol;
reg     [N_LANES-1 : 0]             tb_i_start_of_lane;
reg     [N_LANES-1 : 0]             temp_resync;
reg     [N_LANES-1 : 0]             tb_i_resync;

wire                                tb_o_set_fifo_delay;
//wire                                tb_o_valid_skew;
//wire                                tb_o_align_status;
wire    [(N_LANES*NB_COUNT)-1 : 0]	tb_o_lane_delay;

integer fid_input_sol_vector; 
integer fid_input_resync_vector;
integer ptr_sol;
integer ptr_resync;
integer code_error_sol;
integer code_error_resync;


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
                $stop;
            end
        end
        
        for(ptr_resync = 0; ptr_resync < N_LANES; ptr_resync = ptr_resync + 1)
        begin
            code_error_resync <= $fscanf(fid_input_resync_vector, "%b\n", temp_resync[ptr_resync]);
            if(code_error_resync != 1)
            begin
                $display("Resync: El caracter leido no es valido..");
                $stop;
            end
        end

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
    .o_set_fifo_delay(tb_o_set_fifo_delay),
    .o_lane_delay(tb_o_lane_delay)
    //.o_valid_skew(tb_o_valid_skew),
    //.o_align_status(tb_o_align_status)
    );

endmodule