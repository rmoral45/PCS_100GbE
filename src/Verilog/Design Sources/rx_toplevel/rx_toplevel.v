
`timescale 1ns/100ps

module toplevel_rx
#(
    parameter                                           NB_DATA_CODED       = 66,
    parameter                                           N_LANES             = 20,
    parameter                                           NB_DATA_BUS         = NB_DATA_CODED*N_LANES,

    /*                  Block sync parameters                                               */
    parameter                                           MAX_WINDOW          = 4096,
    parameter                                           MAX_INVALID_SH      = (MAX_WINDOW/2), //FIX especificar correctamente
    parameter                                           NB_WINDOW_CNT       = $clog2(MAX_WINDOW),
    parameter                                           NB_INVALID_CNT      = $clog2(MAX_INVALID_SH),

    /*                  Alignment parameters                                                */
    parameter                                           NB_ERROR_COUNTER    = 32,
    parameter                                           NB_LANE_ID          = $clog2(N_LANES),
    parameter                                           N_PERIOD_BLOCKS     = 16383,
    parameter                                           N_MAX_INV_AM        = 8,
    parameter                                           NB_INV_AM           = $clog2(N_MAX_INV_AM),
    parameter                                           N_MAX_VAL_AM        = 20,
    parameter                                           NB_VAL_AM           = $clog2(N_MAX_VAL_AM),
    parameter                                           NB_AM               = 48,

    /*                  Deskew parameters                                                   */
    parameter                                           FIFO_DEPTH          = 20,
    parameter                                           MAX_SKEW            = 16,
    parameter                                           NB_DELAY_COUNT      = $clog2(FIFO_DEPTH),

    /*                  Lane reorder parameters                                             */
    parameter                                           NB_BUS_ID           = N_LANES*NB_LANE_ID;

)
(
    /*                  enble of modules from rf                                            */
    input wire                                          i_rf_enb_blk_sync,
    input wire                                          i_rf_enb_alignment,
    input wire                                          i_rf_enb_deskew_calc,
    input wire                                          i_rf_enb_lane_reorder,
    input wire                                          i_rf_enb_lane_swap,
    input wire                                          i_rf_enb_pc_20_to_1,
    input wire                                          i_rf_enb_rx_clock_comp,
    
    /*                  Block sync signals                                                  */
    input wire                                          i_clock,
    input wire                                          i_reset,
    input wire  [NB_DATA_BUS-1                  :   0]  i_data,
    input wire                                          i_valid,            //named as i_signal_ok in the standard?
    input wire                                          i_enable,
    input wire  [NB_WINDOW_CNT-1                :   0]  i_rf_unlckd_thr,     
    input wire  [NB_WINDOW_CNT-1                :   0]  i_rf_lckd_thr,
    input wire  [NB_INVALID_CNT -1              :   0]  i_rf_sh_invalid_thr,

    /*                  Alignment signals                                                   */
    input wire  [NB_INV_AM-1                    :   0]  i_rf_invalid_am_thr,
    input wire  [NB_VAL_AM-1                    :   0]  i_rf_valid_am_thr,
    input wire  [N_LANES-1                      :   0]  i_rf_am_comp_mask,

)

    /*                  Top level internal signals & variables                              */
    genvar                                              i;

    /*                  Block sync signals                                                  */
    wire        [NB_DATA_BUS-1                  :   0]  blk_sync_lanes_data_out;
    wire        [N_LANES-1                      :   0]  lanes_blk_lock;

    /*                  Alignment signals                                                   */
    wire        [NB_DATA_BUS-1                  :   0]  am_lock_lanes_data_out;         //to deskew_mod
    wire        [NB_BUS_ID-1                    :   0]  am_lock_lanes_id;               //to lane_reord
    wire        [(NB_ERROR_COUNTER*N_LANES)-1   :   0]  am_lock_lanes_rf_err_count;     //to rf
    wire        [N_LANES-1                      :   0]  lanes_am_lock;                  //to deskew_mod   [CHECK: NOT USED IN DESKEW_CALCULATOR]
    wire        [N_LANES-1                      :   0]  lanes_am_resync;                //to deskew_mod
    wire        [N_LANES-1                      :   0]  lanes_am_sol;                   //to deskew_mod

    /*                  Deskew signals                                                      */
    wire        [NB_DATA_BUS-1                  :   0]  deskew_calculator_data_out;
    wire                                                posedge_deskew_done;

    /*                  Lane swap & reorder signals                                         */
    wire        [NB_DATA_CODED-1                :   0]  lanes_swap_data_out;
    wire        [NB_BUS_ID-1                    :   0]  lane_reorder_mux_sel;
    wire                                                lane_reoder_update_mux_sel;
    
    /*                  PC 20:1 signals                                                     */
    wire        [NB_DATA_CODED-1                :   0]  pc_20_to_1_data_out;


    generate
        for(i = 0; i < N_LANES; i = i+1)
        begin: lane_modules_generation

        block_sync_module
        u_block_sync_module
        (
            //Outputs
            .o_data                                     (blk_sync_lanes_data_out[NB_DATA_BUS-1 - i*NB_DATA_CODED -: NB_DATA_CODED]),
            .o_block_lock                               (lanes_blk_lock[N_LANES-1-i]),   

            //Inputs
            .i_data                                     (i_data[NB_DATA_BUS-1 - i*NB_DATA_CODED -: NB_DATA_CODED]),
            .i_rf_enable                                (i_rf_enb_blk_sync),
            .i_valid                                    (i_valid),
            .i_rf_unlckd_thr                            (i_rf_unlckd_thr),
            .i_rf_lckd_thr                              (i_rf_lckd_thr),
            .i_rf_sh_invalid_thr                        (i_rf_sh_invalid_thr),

            //Clocking & reset
            .i_clock                                    (i_clock),
            .i_reset                                    (i_reset)
        );

        am_lock_module
        u_am_lock_module
        (
            //Outputs
            .o_data                                     (am_lock_lanes_data_out[NB_DATA_BUS-1 - i*NB_DATA_CODED -: NB_DATA_CODED]),
            .o_lane_id                                  (am_lock_lanes_id[(NB_BUS_ID-1) - i*NB_LANE_ID -: NB_LANE_ID]),
            .o_rf_error_count                           (am_lock_lanes_rf_err_count[(NB_ERROR_COUNTER*N_LANES)-1 - i*NB_ERROR_COUNTER -: NB_ERROR_COUNTER]),
            .o_am_lock                                  (lanes_am_lock[N_LANES-1-i]),
            .o_resync                                   (lanes_am_resync[N_LANES-1-i]),
            .o_start_of_lane                            (lanes_am_sol[N_LANES-1-i]),

            //Inputs
            .i_rf_enable                                (i_rf_enb_alignment),
            .i_valid                                    (i_valid),
            .i_block_lock                               (lanes_blk_lock[N_LANES-1-i]),
            .i_data                                     (blk_sync_lanes_data_out[NB_DATA_BUS-1 - i*NB_DATA_CODED -: NB_DATA_CODED]),
            .i_rf_invalid_am_thr                        (i_rf_invalid_am_thr),
            .i_rf_valid_am_thr                          (i_rf_valid_am_thr),
            .i_rf_am_comp_mask                          (i_rf_am_comp_mask),

            //Clocking & reset
            .i_clock                                    (i_clock),
            .i_reset                                    (i_reset)
        );

        deskew_top
        u_deskew_calculator
        (
            //Outputs
            .o_data                                     (deskew_calculator_data_out[NB_DATA_BUS-1 - i*NB_DATA_CODED -: NB_DATA_CODED]),
            .o_posedge_deskew_done                      (posedge_deskew_done),

            //Inputs
            .i_rf_enable                                (i_rf_enb_deskew_calc),
            .i_valid                                    (i_valid),
            .i_resync                                   (lanes_am_resync[N_LANES-1-i]),
            .i_start_of_lane                            (lanes_am_sol[N_LANES-1-i]),
            .i_data                                     (am_lock_lanes_data_out[NB_DATA_BUS-1 - i*NB_DATA_CODED -: NB_DATA_CODED]),

            //Clocking & reset
            .i_clock                                    (i_clock),
            .i_reset                                    (i_reset)
        );


    end //endgenerate

    lane_reorder
    u_lane_reorder
    (
            //Outputs
            .o_reorder_mux_selector                     (lane_reorder_mux_sel),
            .o_update_selectors                         (lane_reoder_update_mux_sel),

            //Inputs
            .i_rf_enable                                (i_rf_enb_lane_reorder),
            .i_valid                                    (i_valid),
            .i_reset_order                              (|lanes_am_resync),                                             //[CHECK: que va conectado aca? resyncs?]
            .i_deskew_done                              (posedge_deskew_done),
            .i_logical_rx_ID                            (am_lock_lanes_id[0 : NB_BUS_ID-1]),            

            //Clocking & reset
            .i_clock                                    (i_clock),
            .i_reset                                    (i_reset)
    );

    lane_swap_v2
    u_lane_swap
    (
            //Outputs
            .o_data                                     (lanes_swap_data_out),

            //Inputs
            .i_rf_enable                                (i_rf_enb_lane_swap),
            .i_valid                                    (i_valid),
            .i_reorder_done                             (lane_reoder_update_mux_sel),               //[CHECK: It is correct?]
            .i_data                                     (deskew_calculator_data_out[0 : NB_DATA_BUS-1]), //[CHECK: wire interpolation!!!!!!!!!!]
            .i_lane_ids                                 (lane_reorder_mux_sel),

            //Clocking & reset
            .i_clock                                    (i_clock),
            .i_reset                                    (i_reset)
    );

    clock_comp_rx
    u_clock_comp
    (
            //Outputs
            .o_data(),

            //Inputs
            .i_data                                     (lanes_swap_data_out),
            .i_rf_enable                                (i_rf_enb_rx_clock_comp),
            .i_valid                                    (i_valid),
            .i_fsm_control                              (),                                             //from decoder fsm
            .i_sol_tag                                  (&lanes_am_sol),                                //[CHECK: It is correct?]

            //Clocking & reset
            .i_clock                                    (i_clock),
            .i_reset                                    (i_reset)
    );


endmodule