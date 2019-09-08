`timescale 1ns/100ps

module tb_payload_breaker;


localparam NB_CODED_BLOCK  = 66;
localparam NB_ERR_MASK     = NB_CODED_BLOCK-2;
localparam MAX_ERR_BURST   = 10;
localparam MAX_ERR_PERIOD  = 5;
localparam MAX_ERR_REPEAT  = 5;
localparam N_MODES         = 4;
localparam NB_BURST_CNT    = $clog2(MAX_ERR_BURST);
localparam NB_PERIOD_CNT   = $clog2(MAX_ERR_PERIOD);
localparam NB_REPEAT_CNT   = $clog2(MAX_ERR_REPEAT);
localparam NB_SH           = 2;
localparam NB_ERR_CNT      = 32;

//-------------Input Signals-------------//

reg                             tb_clock, 
reg                             tb_reset, 
reg                             tb_valid, 
reg                             tb_align_tag;
reg                             tb_rf_mode;
reg                             tb_rf_update;
reg [NB_ERR_MASK-1 : 0]         tb_rf_error_mask;
reg [NB_BURST_CNT-1 : 0]        tb_rf_error_burst;
reg [NB_PERIOD_CNT-1 : 0]       tb_rf_error_period;
reg [NB_REPEAT_CNT-1 : 0]       tb_rf_error_repeat;
reg [NB_CODED_BLOCK-1 : 0]      tb_input_data;
reg [NB_SH-1 : 0]               tb_rand_sh;
reg [NB_ERR_MASK-1 : 0]         tb_err_mask;

// Assert aux signals
reg [NB_ERR_CNT-1 : 0]          tb_err_counter;
reg                             bad_error;
reg [NB_ERR_CNT-1 : 0]          ctrl_sh_cnt;
reg [NB_ERR_CNT-1 : 0]          data_sh_cnt;
reg [NB_ERR_CNT-1 : 0]          aligner_cnt;

//------------Output Signals--------------//

wire                            tb_output_tag;
wire [NB_CODED_BLOCK-1 : 0]     tb_output_data;


initial
begin
        tb_clock           = 0;
        tb_reset           = 1;
        tb_valid           = 0;
        tb_align_tag       = 0;
        tb_rf_mode         = 0; // MODE_ALIN (solo rompe alineadores)
        tb_rf_update       = 0;
        tb_rf_err_mask     = 64'hCA_05_B7_00_12_58_DE_A0; // random
        tb_rf_error_burst  = 1;
        tb_rf_error_period = 10;
        tb_rf_error_repeat = 10;
        tb_err_counter     = 0;
        bad_error          = 0;
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
                assert_block_error(tb_err_counter, expected_error, align_cnt);
                tb_rf_mode   = 1;
                tb_rf_update = 1;
        #4
                tb_rf_update = 0;

        //Comienzo  a romper solo bloques de datos
        #100
                assert_block_error(tb_err_counter, expected_error, ctrl_sh_cnt);
                tb_rf_mode   = 2;
                rb_rf_update = 1;
        #4
                tb_rf_update = 0;

        //Comienzo a romper todo
        #100
                assert_block_error(tb_error_counter, expected_error, data_sh_cnt);
                tb_rf_mode   = 3;
                rb_rf_update = 1;
        #4
                tb_rf_update = 0;

        #100
                assert_block_error(tb_error_counter, expected_error, (align_cnt + ctrl_sh_cnt + data_sh_cnt));
                $finish;
end

always #1 tb_clock = ~tb_clock;
// Data generation
always #2
begin

        if (tb_rf_mode == 0)
        begin
                tb_input_data = {2'b10, $random, $random};
                tb_align_tag  = 1;
        end
        else if (tb_rf_mode == 1)
        begin
                
                tb_input_data = {tb_rand_sh, $random, $random};
                tb_align_tag  = 0;
        end
        else if (tb_rf_mode == 2)
        begin
                tb_input_data = {tb_rand_sh, $random, $random};
                tb_align_tag  = 0;
        end
        else if (tb_rf_mode == 3)
        begin
                tb_input_data = {$random, $random, $random};
                tb_align_tag  = $random ;
        end
end


always #2
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
always #2 
        if(bad_error)
                $stop;

always #2 
        count_block_error(tb_input_data, tb_output_data, tb_rf_err_mask,bad_error,tb_err_counter);

//---------------Instances-----------------//



/*
        Esta task checkea que solo se rompan los bits que deben 
        romperse
*/

task assert_block_error
        input [] err_counter;
        input [] expected_error;
        input [] type_gen_block;
        output bad_error;
        begin
                if (err_counter != expected_error && type_gen_block >= expected_error)
                        $display("La cantidad de bloques rotos en Modo %d es incorrecta", mode);
                        bad_error = 1;
                        $stop;
                else if (err_counter != type_gen_block && type_gen_block < expected_error )
                        $display("La cantidad de bloques rotos en Modo %d es incorrecta", mode);
                        bad_error = 1;
                        $stop;
        end
endtask

task count_block_error
        input  [NB_CODED_BLOCK-1 : 0]   raw_data;
        input  [NB_CODED_BLOCK-1 : 0]   broke_data;
        input  [NB_ERR_MASK-1 : 0]      in_mask;
        output reg                      bad_error;
        output reg [NB_ERR_CNT-1 : 0]   err_counter;

        begin
                /*
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
                */
                always @ *
                begin
                        if (raw_data != broke_data)
                        begin
                                err_counter = err_counter + 1;
                                bad_error   = 0;
                        end
                end
        end
endtask

endmodule
