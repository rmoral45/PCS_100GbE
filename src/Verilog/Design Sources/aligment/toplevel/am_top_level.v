`timescale 1ns/100ps

module am_top_level
#(
        parameter N_LANES               = 20,
        parameter NB_DATA               = 66,
        parameter NB_ERROR_COUNTER      = 16,
        parameter NB_RESYNC_COUNTER     = 8,
        parameter N_ALIGNER             = 20,
        parameter NB_LANE_ID            = $clog2(N_ALIGNER),
        parameter MAX_INV_AM            = 8,
        parameter NB_INV_AM             = $clog2(MAX_INV_AM),
        parameter MAX_VAL_AM            = 20,
        parameter NB_VAL_AM             = $clog2(MAX_VAL_AM),
        parameter NB_AM                 = 48,
        parameter NB_AM_PERIOD          = 14,
        parameter NB_DATA_BUS           = N_LANES * NB_DATA,
        parameter NB_ID_BUS             = N_LANES * NB_LANE_ID,
        parameter NB_ERR_BUS            = N_LANES * NB_ERROR_COUNTER,
        parameter NB_RESYNC_COUNTER_BUS = NB_RESYNC_COUNTER * N_LANES
 )
 (
        input  wire                                     i_clock,

        input  wire                                     i_reset,

        input  wire                                     i_rf_enable,

        input  wire                                     i_valid,

        input  wire [N_LANES-1                  : 0]    i_block_lock,

        input  wire [NB_DATA_BUS-1              : 0]    i_data,

        input  wire [NB_INV_AM-1                : 0]    i_rf_invalid_am_thr,

        input  wire [NB_VAL_AM-1                : 0]    i_rf_valid_am_thr,

        input  wire [NB_AM-1                    : 0]    i_rf_compare_mask,

        input  wire [NB_AM_PERIOD-1             : 0]    i_rf_am_period,

        
        output wire [NB_DATA_BUS-1              : 0]    o_data,
        
        output wire                                     o_valid,

        output wire [NB_ID_BUS-1                : 0]    o_lane_id,

        output wire [NB_ERR_BUS-1               : 0]    o_error_counter,

        output wire [N_LANES-1                  : 0]    o_am_lock,

        output wire [N_LANES-1                  : 0]    o_resync,

        output wire [NB_RESYNC_COUNTER_BUS-1    : 0]    o_resync_counter_bus,

        output wire [N_LANES-1                  : 0]    o_start_of_lane
 );

        (* keep = "true" *) reg enable_replicated [0 : N_LANES];
        (* keep = "true" *) reg reset_replicated [0 : N_LANES];
        (* keep = "true" *) reg valid_replicated [0 : N_LANES];
        (* keep = "true" *) reg [NB_DATA_BUS-1              : 0] input_data_d;


        integer enb_idx;

        always @(posedge i_clock)
        begin
            for(enb_idx = 0; enb_idx < 21; enb_idx=enb_idx+1) begin
                enable_replicated[enb_idx]  <= i_rf_enable;
                reset_replicated[enb_idx]   <= i_reset;                
                valid_replicated[enb_idx]   <= i_valid;
                input_data_d   <= i_data;
            end
        end
 
        wire        [NB_DATA_BUS-1 : 0]                 alignment_out;

        //output signals registers
        wire [NB_DATA_BUS-1              : 0]                       output_data_wire;
        wire [NB_ID_BUS-1                : 0]                       output_lane_id_wire;
        wire [NB_ERR_BUS-1               : 0]                       output_error_counter_wire;
        wire [N_LANES-1                  : 0]                       output_am_lock_wire;
        wire [N_LANES-1                  : 0]                       output_resync_wire;
        wire [NB_RESYNC_COUNTER_BUS-1    : 0]                       output_resync_counter_bus_wire;
        wire [N_LANES-1                  : 0]                       output_start_of_lane_wire;

        (* keep = "true" *) reg [NB_DATA_BUS-1              : 0]    output_data_d;
        (* keep = "true" *) reg [NB_ID_BUS-1                : 0]    output_lane_id_d;
        (* keep = "true" *) reg [NB_ERR_BUS-1               : 0]    output_error_counter_d;
        (* keep = "true" *) reg [N_LANES-1                  : 0]    output_am_lock_d;
        (* keep = "true" *) reg [N_LANES-1                  : 0]    output_resync_d;
        (* keep = "true" *) reg [NB_RESYNC_COUNTER_BUS-1    : 0]    output_resync_counter_bus_d;
        (* keep = "true" *) reg [N_LANES-1                  : 0]    output_start_of_lane_d;
        (* keep = "true" *) reg                                     output_valid_d;

        always @(posedge i_clock)
        begin
            if(reset_replicated[N_LANES]) begin
                output_data_d   <= {NB_DATA_BUS{1'b0}};
                output_lane_id_d    <= {NB_ID_BUS{1'b0}};
                output_error_counter_d  <= {NB_ERR_BUS{1'b0}};
                output_am_lock_d    <= {N_LANES{1'b0}};
                output_resync_d <= {N_LANES{1'b0}};
                output_resync_counter_bus_d <= {NB_RESYNC_COUNTER_BUS{1'b0}};
                output_start_of_lane_d  <= {N_LANES{1'b0}};
                output_valid_d  <= 1'b0;
            end
            else begin
                output_data_d   <= output_data_wire;
                output_lane_id_d    <= output_lane_id_wire;
                output_error_counter_d  <= output_error_counter_wire;
                output_am_lock_d    <= output_am_lock_wire;
                output_resync_d <= output_resync_wire;
                output_resync_counter_bus_d <= output_resync_counter_bus_wire;
                output_start_of_lane_d  <= output_start_of_lane_wire; 
                output_valid_d <= valid_replicated[N_LANES];
            end
        end

        assign o_data       = output_data_d; 
        assign o_lane_id        = output_lane_id_d; 
        assign o_error_counter      = output_error_counter_d; 
        assign o_am_lock        = output_am_lock_d; 
        assign o_resync     = output_resync_d; 
        assign o_resync_counter_bus     = output_resync_counter_bus_d; 
        assign o_start_of_lane      = output_start_of_lane_d; 
        assign o_valid              = output_valid_d;

        genvar i;
        generate
            for (i = 0; i < N_LANES; i = i + 1)
            begin : LANE_ALIGNERS
                am_lock_module
                #(  
                    .NB_CODED_BLOCK         (NB_DATA),
                    .NB_ERROR_COUNTER       (NB_ERROR_COUNTER),
                    .N_ALIGNER              (N_ALIGNER),
                    .MAX_INV_AM             (MAX_INV_AM),
                    .MAX_VAL_AM             (MAX_VAL_AM)
                )
                u_am_lock
                (
                    .i_clock                (i_clock),
                    .i_reset                (reset_replicated[i]),
                    .i_rf_enable            (enable_replicated[i]),
                    .i_valid                (valid_replicated[i]),
                    .i_block_lock           (i_block_lock[N_LANES-1-i]),
                    .i_data                 (input_data_d[(NB_DATA_BUS-1 - i*NB_DATA) -: NB_DATA]),
                    .i_rf_invalid_am_thr    (i_rf_invalid_am_thr),
                    .i_rf_valid_am_thr      (i_rf_valid_am_thr),
                    .i_rf_compare_mask      (48'hffffffffffff),
                    .i_rf_am_period         (i_rf_am_period),
    
                    .o_data                 (output_data_wire[NB_DATA_BUS-1-i*NB_DATA -: NB_DATA]),
                    .o_lane_id              (output_lane_id_wire[(NB_ID_BUS-1-i*NB_LANE_ID) -: NB_LANE_ID]),
                    .o_error_counter        (output_error_counter_wire[NB_ERR_BUS-1-i*NB_ERROR_COUNTER -: NB_ERROR_COUNTER]),
                    .o_am_lock              (output_am_lock_wire[N_LANES - i - 1]),
                    .o_resync               (output_resync_wire[N_LANES - i - 1]),
                    .o_resync_counter       (output_resync_counter_bus_wire[NB_RESYNC_COUNTER_BUS-1-i*NB_RESYNC_COUNTER -: NB_RESYNC_COUNTER]),
                    .o_start_of_lane        (output_start_of_lane_wire[N_LANES - i - 1])
                );
            end
        endgenerate

endmodule
