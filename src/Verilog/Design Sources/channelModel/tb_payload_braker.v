`timescale 1ns/100ps

module tb_payload_breaker;


/* ----------------- localparams --------------------- */

localparam NB_CODED_BLOCK = 66;
localparam NB_ERR_MASK    = NB_CODED_BLOCK-2;
localparam MAX_ERR_BURST  = 200;
localparam MAX_ERR_PERIOD = 400;
localparam MAX_ERR_REPEAT = 100;
localparam NB_BURST_CNT   = $clog2(MAX_ERR_BURST) ;
localparam NB_PERIOD_CNT  = $clog2(MAX_ERR_PERIOD) ;
localparam NB_REPEAT_CNT  = $clog2(MAX_ERR_REPEAT) ;
localparam N_MODES        = 4;
localparam MODE_ALIN      = 4'b0001;
localparam MODE_CTRL      = 4'b0010;
localparam MODE_DATA      = 4'b0100;
localparam MODE_ALL       = 4'b1000;

/* ---------------- inputs --------------------------- */

reg                             tb_clock;
reg                             tb_reset;
reg                             tb_valid;
reg                             tb_aligner_tag;
reg [NB_CODED_BLOCK-1 : 0]      tb_input_data;
reg [N_MODES-1        : 0]      tb_rf_mode;
reg                             tb_rf_update;
reg [NB_ERR_MASK-1    : 0]      tb_rf_error_mask;
reg [NB_BURST_CNT-1   : 0]      tb_rf_error_burst;
reg [NB_PERIOD_CNT-1  : 0]      tb_rf_error_period;
reg [NB_REPEAT_CNT-1  : 0]      tb_rf_error_repeat;

/* ---------------- outputs --------------------------- */

wire [NB_CODED_BLOCK-1 : 0]     tb_output_data;
wire                            tb_output_aligner_tag;


initial
begin
        tb_clock         = 0;
        tb_reset         = 1;
        tb_valid         = 0;
        tb_aligner_tag   = 0;
        tb_input_data    = 66'h2_00_00_00_00_00_00_00_00;
        tb_rf_mode       = MODE_ALL;
        tb_rf_update     = 0;
        tb_rf_error_mask = 64'hff00ff00ff00ff00;
        tb_rf_error_burst   = 10;
        tb_rf_error_period  = 15;
        tb_rf_error_repeat  = 4;

        #7
                tb_reset = 0;
                tb_valid = 1;

        #12
                tb_rf_update = 1;

        #12
                tb_rf_update = 0;

        #200
                tb_rf_error_burst = 1;
                tb_rf_update = 1;
        #12
                tb_rf_update = 0;

        #200
                tb_rf_error_burst = 5;
                tb_rf_mode = MODE_CTRL;
                tb_rf_update = 1;
        #12
                tb_rf_update = 0;
        #200
                tb_rf_error_burst = 14;
                tb_rf_mode = MODE_DATA;
                tb_rf_update = 1;
        #10
                tb_rf_update = 0;
                
end

always #1 tb_clock = ~tb_clock;


/*----------------- instances  ------------------------------*/

payload_breaker
#(
        .NB_CODED_BLOCK  (NB_CODED_BLOCK),
        .MAX_ERR_BURST (MAX_ERR_BURST),
        .MAX_ERR_PERIOD  (MAX_ERR_PERIOD),
        .MAX_ERR_REPEAT  (MAX_ERR_REPEAT),
        .N_MODES         (N_MODES)
 )
        u_payload_breaker
        (
                .i_clock                (tb_clock),
                .i_reset                (tb_reset),
                .i_valid                (tb_valid),
                .i_aligner_tag          (tb_aligner_tag),
                .i_data                 (tb_input_data),
                .i_rf_mode              (tb_rf_mode),
                .i_rf_update            (tb_rf_update),
                .i_rf_error_mask        (tb_rf_error_mask),
                .i_rf_error_burst       (tb_rf_error_burst),
                .i_rf_error_period      (tb_rf_error_period),
                .i_rf_error_repeat      (tb_rf_error_repeat),

                .o_data                 (tb_output_data),
                .o_aligner_tag          (tb_output_aligner_tag)
        );

endmodule
