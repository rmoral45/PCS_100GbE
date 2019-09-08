`timescale 1ns/100ps

module tb_payload_breaker;


localparam NB_CODED_BLOCK  = 66;
localparam NB_ERR_MASK     = NB_CODED_BLOCK-2;
localparam MAX_ERR_BURST   = 100;
localparam MAX_ERR_PERIOD  = 200;
localparam MAX_ERR_REPEAT  = 5;
localparam N_MODES         = 4;
localparam NB_BURST_CNT    = $clog2(MAX_ERR_BURST);
localparam NB_PERIOD_CNT   = $clog2(MAX_ERR_PERIOD);
localparam NB_REPEAT_CNT   = $clog2(MAX_ERR_REPEAT);
localparam NB_SH           = 2;
localparam NB_ERR_CNT      = 32;

//-------------Input Signals-------------//

reg                             tb_clock; 
reg                             tb_reset; 
reg                             tb_valid; 
reg                             tb_align_tag;
reg [N_MODES-1 : 0]             tb_rf_mode;
reg                             tb_rf_update;
reg [NB_ERR_MASK-1 : 0]         tb_rf_err_mask;
reg [NB_BURST_CNT-1 : 0]        tb_rf_error_burst;
reg [NB_PERIOD_CNT-1 : 0]       tb_rf_error_period;
reg [NB_REPEAT_CNT-1 : 0]       tb_rf_error_repeat;
reg [NB_CODED_BLOCK-1 : 0]      tb_input_data;
reg [NB_SH-1 : 0]               tb_rand_sh;

// Assert aux signals
reg [NB_ERR_CNT-1 : 0]          tb_err_counter;
reg [NB_ERR_CNT-1 : 0]          tb_expected_err;
reg                             tb_bad_error;
reg [NB_ERR_CNT-1 : 0]          ctrl_sh_cnt;
reg [NB_ERR_CNT-1 : 0]          data_sh_cnt;
reg [NB_ERR_CNT-1 : 0]          aligner_cnt;
wire eq;

//------------Output Signals--------------//

wire                            tb_output_tag;
wire [NB_CODED_BLOCK-1 : 0]     tb_output_data;


initial
begin
        tb_clock           = 0;
        tb_reset           = 1;
        tb_valid           = 0;
        tb_align_tag       = 0;
        tb_rf_mode         = 0; // MODE_ALL (rompe todos ;os bloques)
        tb_rf_update       = 0;
        //tb_rf_err_mask     = 64'hCA_05_B7_00_12_58_DE_A0; // random
        tb_rf_err_mask     = 64'hff_00_00_00_00_00_00_ff; 
        tb_rf_error_burst  = 2;
        tb_rf_error_period = 10;
        tb_rf_error_repeat = 3;
        tb_expected_err    = 0;
        aligner_cnt        = 0;
        data_sh_cnt        = 0;
        ctrl_sh_cnt        = 0;
        tb_expected_err    = tb_rf_error_burst * tb_rf_error_repeat;
        #10
                tb_reset   = 0;
                tb_valid   = 1;
        //Comienzo a romper solo bloques alineadores
        #10
                tb_rf_update = 1;
        #7
                tb_rf_update = 0;

        //Cominezo a romper solo bloques de control
        #100
               // assert_block_error(tb_err_counter, tb_expected_err, aligner_cnt, tb_rf_mode, tb_bad_error);
                tb_rf_mode   = 1;
                tb_rf_update = 1;
        #4
                tb_rf_update = 0;

        //Comienzo  a romper solo bloques de datos
        #100
                //assert_block_error(tb_err_counter, tb_expected_err, ctrl_sh_cnt, tb_rf_mode, tb_bad_error);
                tb_rf_mode   = 2;
                tb_rf_update = 1;
        #4
                tb_rf_update = 0;

        //Comienzo a romper todo
        #100
                //assert_block_error(tb_err_counter, tb_expected_err, data_sh_cnt,tb_rf_mode, tb_bad_error);
                tb_rf_mode   = 3;
                tb_rf_update = 1;
        #4
                tb_rf_update = 0;

        #100
                //assert_block_error(tb_err_counter,tb_expected_err, (aligner_cnt + ctrl_sh_cnt + data_sh_cnt),tb_rf_mode, tb_bad_error);
                $finish;
end

always #1 tb_clock = ~tb_clock;
// Data generation

always @ (posedge tb_clock) 
begin
        if ($random % 2)
                tb_rand_sh = 2'b10;
        else
                tb_rand_sh = 2'b01;
end
always @ (posedge tb_clock)
begin
        if (tb_rf_mode == 0)
        begin
                tb_input_data = {2'b10, $random, $random};
                tb_align_tag  = $random;
        end
        else if (tb_rf_mode == 1)
        begin
                
                tb_input_data = {2'b10, $random, $random};
                tb_align_tag  = 0;
        end
        else if (tb_rf_mode == 2)
        begin
                tb_input_data = {2'b01, $random, $random};
                tb_align_tag  = 0;
        end
        else if (tb_rf_mode == 3)
        begin
                tb_input_data = {tb_rand_sh, $random, $random};
                tb_align_tag  = $random ;
        end
end


always  @ (posedge tb_clock)
begin
        if ( tb_rf_update == 1)
        begin
                ctrl_sh_cnt = 0;
                data_sh_cnt = 0;
                aligner_cnt = 0;
        end
        else
        begin
                if (tb_align_tag == 1)
                        aligner_cnt = aligner_cnt + 1;
                if (tb_rand_sh == 2'b10)
                        ctrl_sh_cnt = ctrl_sh_cnt + 1;
                else if (tb_rand_sh == 2'b01)
                        data_sh_cnt = data_sh_cnt + 1;
        end
end

// Data checker
//always #2 
  //      if(tb_bad_error)
    //            $stop;
assign eq = (tb_input_data == tb_output_data);
always  @ (posedge tb_clock)
begin
        if (tb_reset || tb_rf_update)
                tb_err_counter = 0;
        else if (!eq)
                tb_err_counter = tb_err_counter + 1;
                
end
/*
always #2 
        count_block_error(tb_input_data, tb_output_data, tb_rf_err_mask, tb_err_counter);
*/
//---------------Instances-----------------//
payload_breaker
#(
        .NB_CODED_BLOCK(NB_CODED_BLOCK),
        .MAX_ERR_BURST(MAX_ERR_BURST),
        .MAX_ERR_PERIOD(MAX_ERR_PERIOD),
        .MAX_ERR_REPEAT(MAX_ERR_REPEAT),
        .N_MODES(N_MODES)
 )
        u_payload_breaker
        (
                .i_clock(tb_clock),
                .i_reset(tb_reset),
                .i_valid(tb_valid),
                .i_aligner_tag(tb_align_tag),
                .i_data(tb_input_data),
                .i_rf_mode(tb_rf_mode),
                .i_rf_update(tb_rf_update),
                .i_rf_error_mask(tb_rf_err_mask),
                .i_rf_error_burst(tb_rf_error_burst),
                .i_rf_error_period(tb_rf_error_period),
                .i_rf_error_repeat(tb_rf_error_repeat),

                .o_data(tb_output_data),
                .o_aligner_tag(tb_output_tag)
        );


/*
        Esta task checkea que solo se rompan los bits que deben 
        romperse
*/

task automatic assert_block_error;
        input [NB_ERR_CNT-1 : 0] err_counter;
        input [NB_ERR_CNT-1 : 0] expected_error;
        input [NB_ERR_CNT-1 : 0] type_gen_block;
        input [N_MODES-1 : 0]    tb_mode;
        output bad_error;
        begin
                bad_error = 0;

                if (err_counter != expected_error && type_gen_block >= expected_error)
                begin
                        $display("La cantidad de bloques rotos en Modo %d es incorrecta", tb_mode);
                        bad_error = 1;
                       // $stop;
                end
                /*
                else if (err_counter != type_gen_block && type_gen_block < expected_error )
                begin
                        $display("La cantidad de bloques rotos en Modo %d es incorrecta", tb_mode);
                        bad_error = 1;
                        $stop;
                end
                else
                        bad_error = 0;
                */
        end
endtask
/*
task count_block_error;
        input  [NB_CODED_BLOCK-1 : 0]   raw_data;
        input  [NB_CODED_BLOCK-1 : 0]   broke_data;
        input  [NB_ERR_MASK-1 : 0]      in_mask;
        output reg [NB_ERR_CNT-1 : 0]   err_counter;

        begin
                
                integer i;
                always @ *
                begin
                        for (i=0; i< NB_ERR_MASK; i=i+1)
                        begin
                                if (in_mask[i] && (raw_data[i] == broke_data[i]))
                                        bad_error |= 1;
                                else if (!in_mask[i] && (raw_data[i] != broke_data[i]))
                                        bad_error |= 1;
                        end
                end
                
                        if (raw_data != broke_data)
                        begin
                                err_counter = err_counter + 1;
                        end
        end
endtask
*/
endmodule
