`timescale 1ns/100ps


module tb_sh_shifter;


localparam NB_CODED_BLOCK = 66;
localparam  NB_SHIFT_INDEX = $clog2(NB_CODED_BLOCK);

//-------- Input Signals -------//

reg                             tb_clock;
reg                             tb_reset;
reg                             tb_valid;
reg                             tb_rf_update;
reg [NB_SHIFT_INDEX-1 : 0]      tb_rf_sh_pos;
reg [NB_CODED_BLOCK-1 : 0]      tb_input_data;

//------ Output Signals -------//
wire [NB_CODED_BLOCK-1 : 0]     tb_output_data;



initial
begin
        tb_clock        = 0;
        tb_reset        = 1;
        tb_valid        = 0;
        tb_rf_sh_pos    = 0;
        tb_rf_update    = 0;
        tb_input_data   = 66'h2_00_00_00_00_00_00_00_00;


        #10
                tb_reset     = 0;
                tb_rf_update = 1;
                tb_valid     = 1;
                tb_rf_sh_pos = 0;
        #4
                tb_rf_update = 0;
        #10
                tb_rf_update = 1;
                tb_rf_sh_pos = 1;
        #4
                tb_rf_update = 0;
        #10
                tb_rf_update = 1;
                tb_rf_sh_pos = 2;
        #4
                tb_rf_update = 0;
        #10
                tb_rf_update = 1;
                tb_rf_sh_pos = 3;
        #4
                tb_rf_update = 0;
        #10
                tb_rf_update = 1;
                tb_rf_sh_pos = 10;
        #4
                tb_rf_update = 0;
        #10
                tb_rf_update = 1;
                tb_rf_sh_pos = 11;
        #4
                tb_rf_update = 0;
        #10
                tb_rf_update = 1;
                tb_rf_sh_pos = 12;
        #4
                tb_rf_update = 0;
        #10
                tb_rf_update = 1;
                tb_rf_sh_pos = 20;
        #4
                tb_rf_update = 0;
        #10
                tb_rf_update = 1;
                tb_rf_sh_pos = 34;
        #4
                tb_rf_update = 0;
        #10
                tb_rf_update = 1;
                tb_rf_sh_pos = 64;
        #4
                tb_rf_update = 0;
        #10
                tb_rf_update = 1;
                tb_rf_sh_pos = 65;
        #4
                tb_rf_update = 0;
        #10
                tb_rf_update = 1;
                tb_rf_sh_pos = 66;
        #4
                tb_rf_update = 0;
        #10
                $finish;
end


always #1 tb_clock = ~tb_clock;

//------- Instances -------//

sh_shifter
#(
        .NB_CODED_BLOCK(NB_CODED_BLOCK)
 )
        u_sh_shifter
        (
                .i_clock(tb_clock),
                .i_reset(tb_reset),
                .i_valid(tb_valid),
                .i_rf_update(tb_rf_update),
                .i_data(tb_input_data),
                .i_rf_sh_pos(tb_rf_sh_pos),
                
                .o_data(tb_output_data)
        );


endmodule
