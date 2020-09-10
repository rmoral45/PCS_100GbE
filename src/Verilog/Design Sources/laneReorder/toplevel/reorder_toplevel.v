`timescale 1ns/100ps

module reorder_toplevel
#(
    parameter NB_DATA           = 66,
    parameter NB_FIFO_DATA      = 67,
    parameter N_LANES           = 20,
    parameter NB_ID             = $clog2(N_LANES),
    parameter NB_DATA_BUS       = N_LANES * NB_DATA,
    parameter NB_ID_BUS         = N_LANES * NB_ID,
    parameter NB_FIFO_DATA_BUS  = N_LANES * NB_FIFO_DATA
 )
 (
    input  wire                              i_clock,
    input  wire                              i_reset,
    input  wire                              i_rf_reset_order,
    input  wire                              i_enable,
    input  wire                              i_valid, //@TODO revisar si el valid se genera interno
    input  wire                              i_deskew_done,
    input  wire [NB_ID_BUS - 1 : 0]          i_logical_rx_ID,
    input  wire [NB_FIFO_DATA_BUS - 1 : 0]   i_data,

    output wire [NB_DATA - 1 : 0]            o_data,
    output wire                              o_tag
 ); 

//----output data logic
wire [NB_FIFO_DATA - 1 : 0]     swapped_data;
assign o_tag  = swapped_data[NB_FIFO_DATA - 1];
assign o_data = swapped_data[NB_FIFO_DATA - 2 : 0];

//----internal module connections
wire [NB_ID_BUS - 1 : 0]    ordered_ids;

//reoder ready flank detection signals
wire                        update_selector;
wire                        update_selector_posedge;
reg                         update_selector_prev;
//deskew done flank detection
wire                        deskew_done_posedge;
reg                         deskew_done_prev;

reg [NB_FIFO_DATA_BUS - 1 : 0] data_d;

always @(posedge i_clock)
begin
    if(i_reset)
        data_d <= {NB_FIFO_DATA_BUS{1'b0}};
    else if(i_enable && i_valid)
        data_d <= i_data;
end

always @(posedge i_clock)
begin
    if (i_reset)
        update_selector_prev <= 0;
    else if (i_enable && i_valid)
        update_selector_prev <= update_selector;
end
assign update_selector_posedge = update_selector && (~update_selector_prev);

always @(posedge i_clock)
begin
    if (i_reset)
        deskew_done_prev <= 0;
    else if (i_enable && i_valid)
        deskew_done_prev <= i_deskew_done;
end
assign deskew_done_posedge = i_deskew_done && (~deskew_done_prev);

lane_swap_v2
#(
    .NB_DATA    (NB_FIFO_DATA),
    .N_LANES    (N_LANES)
 )
    u_lane_swap
    (
        .i_clock            (i_clock),
        .i_reset            (i_reset),
        .i_enable           (i_enable),
        .i_valid            (i_valid),
        .i_reorder_done     (update_selector_posedge),
        .i_data             (data_d),
        .i_lane_ids         (ordered_ids),

        .o_data             (swapped_data)
    );

lane_reorder
#(
    .N_LANES(N_LANES)
 )
    u_lane_reorder
    (
        .i_clock                (i_clock),
        .i_reset                (i_reset),
        .i_reset_order          (deskew_done_posedge || i_rf_reset_order),
        .i_enable               (i_enable),
        .i_valid                (i_valid),
        .i_deskew_done          (i_deskew_done),
        .i_logical_rx_ID        (i_logical_rx_ID),

        .o_reorder_mux_selector (ordered_ids),
        .o_update_selectors     (update_selector)
    );


endmodule
