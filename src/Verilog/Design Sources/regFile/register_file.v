/*
*/

module register_file
#(
    parameter NB_GPIO           = 32,
    parameter N_LANES           = 20,
    /* counters */
    parameter NB_ERR_COUNTER    = 32,
    parameter NB_RESYNC_COUNTER = 8,
    parameter NB_LANE_ID        = 5,

    /* buses */
    parameter NB_RESYNC_BUS     = NB_RESYNC_COUNTER * N_LANES,
    parameter NB_ERR_BUS        = NB_ERR_COUNTER    * N_LANES,
    parameter NB_ID_BUS         = NB_LANE_ID        * N_LANES
 )
 (
    // to and from toplevel
    input  wire                             i_clock,
    input  wire                             i_reset,
    input  wire [NB_GPIO - 1 : 0]           i_gpio,
    output wire [NB_GPIO - 1 : 0]           o_gpio,


    //from PCS
    input  wire [N_LANES        - 1 : 0]    i_rf_hi_ber,
    input  wire [N_LANES        - 1 : 0]    i_rf_am_lock,
    input  wire [N_LANES        - 1 : 0]    i_rf_block_lock,
    input  wire [NB_ERR_BUS     - 1 : 0]    i_rf_am_error_counter,
    input  wire [NB_RESYNC_BUS  - 1 : 0]    i_rf_resync_counter_bus,
    input  wire [NB_ID_BUS      - 1 : 0]    i_rf_lanes_id,
    input  wire [NB_ERR_COUNTER - 1 : 0]    i_rf_decoder_error,
    input  wire [NB_ERR_COUNTER - 1 : 0]    i_rf_pattern_error,

    //to pcs
    output wire                             o_rf_reset,
    output wire                             o_rf_loopback,
    output wire                             o_rf_test_pattern_mode_tx,
    output wire                             o_rf_test_pattern_mode_rx,
/*
    output wire                             o_rf_enable_,
    output wire                             o_rf_enable_,
    output wire                             o_rf_enable_,
    output wire                             o_rf_enable_,
    output wire                             o_rf_enable_,
    output wire                             o_rf_enable_,
    output wire                             o_rf_enable_,
    output wire                             o_rf_enable_,
*/
    /* block sync control */
    output wire [] o_rf_locked_timer_limit,
    output wire [] o_rf_unlocked_timer_limit,
    output wire [] o_rf_sh_invalid_limit,

    /* aligners control */
    output wire [] o_rf_invalid_am_thr,
    output wire [] o_rf_valid_am_thr,
    output wire [] o_rf_compare_mask,
    output wire [] o_rf_am_period,

    /* deskew control */
    output wire o_rf_enable_deskewer,

    /* lane reorder control */
    output wire o_rf_enable_lane_reorder,
    output wire o_rf_reset_order

    /* descrambler control*/
    output wire o_rf_enable_descrambler,

    /* clock comp control */
    output wire o_rf_enable_clock_comp,

    output wire o_rf_enable_decoder

    /* Clear On Read signals */
    output wire o_,
    output wire o_,
    output wire o_,
    output wire o_,

 );

/* i_gpio split */
wire          enable;
wire [14 : 0] addr;
wire [15 : 0] data;

assign enable = i_gpio[NB_GPIO - 1];
assign addr   = i_gpio[NB_GPIO - 2 -: 15];
assign data   = i_gpio[0 +: 16];

/* output register */
reg [NB_GPIO - 1 : 0] output_gpio;
reg [NB_GPIO - 1 : 0] next_output_gpio;
//----------------------------------------- config registers  --------------------------------------

`include "register_file_regs.v"

//------------------------------------------ REGISTER READ -----------------------------------------------

always @ (posedge i_clock)
begin
    if (i_reset)
        output_gpio <= {NB_GPIO{1'b0}};
    else
        output_gpio <= next_output_gpio;
end

always @ (*)
begin
    case (addr)
        15'd0   : next_output_gpio = i_rf_[NB_] ;
        15'd0   : next_output_gpio = i_rf_[NB_] ;
        15'd0   : next_output_gpio = i_rf_[NB_] ;
        default : next_output_gpio = output_gpio;
    endcase
end

// OUTPUT ASSIGMENT
assign o_gpio = output_gpio;




endmodule
