`timescale 1ns/100ps

module tb_swap_v2;

localparam NB_DATA     = 66;
localparam N_LANES     = 20;
localparam NB_ID       = $clog2(N_LANES);
localparam NB_DATA_BUS = NB_DATA * N_LANES;
localparam NB_ID_BUS   = NB_ID   * N_LANES;

//inputs
reg                     tb_clock;
reg                     tb_reset;
reg                     tb_enable;
reg                     tb_valid;
reg                     tb_reorder_done;
reg [NB_DATA_BUS-1 : 0] tb_i_data;
reg [NB_ID_BUS-1 : 0]   tb_i_lane_ids;

//outputs
wire [NB_DATA-1 : 0]    tb_o_data;

always #1 tb_clock = ~tb_clock;

initial
begin
        tb_clock        = 0;
        tb_reset        = 1;
        tb_enable       = 0;
        tb_valid        = 0;
        tb_i_data       = $random;
        tb_reorder_done = 0;
        tb_i_lane_ids   = {
                           5'd0,
                           5'd1,
                           5'd2,
                           5'd3,
                           5'd4,
                           5'd5,
                           5'd6,
                           5'd7,
                           5'd8,
                           5'd9,
                           5'd10,
                           5'd11,
                           5'd12,
                           5'd13,
                           5'd14,
                           5'd15,
                           5'd16,
                           5'd17,
                           5'd18,
                           5'd19
                          };

        #10
                tb_reset  = 0;
                tb_enable = 1;
                tb_valid  = 1;
        #10
                tb_reorder_done = 1;
        #3
                tb_reorder_done = 0;
                tb_i_data       = {
                                    66'd1000,
                                    66'd1001,
                                    66'd1002,
                                    66'd1003,
                                    66'd1004,
                                    66'd1005,
                                    66'd1006,
                                    66'd1007,
                                    66'd1008,
                                    66'd1009,
                                    66'd1010,
                                    66'd1011,
                                    66'd1012,
                                    66'd1013,
                                    66'd1014,
                                    66'd1015,
                                    66'd1016,
                                    66'd1017,
                                    66'd1018,
                                    66'd1019
                                  };
end

//INSTANCES

lane_swap_v2
#(
        .NB_DATA        (NB_DATA),
        .N_LANES        (N_LANES),
        .NB_ID          (NB_ID)
 )
 u_lane_swap
 (
        .i_clock        (tb_clock),
        .i_reset        (tb_reset),
        .i_enable       (tb_enable),
        .i_valid        (tb_valid),
        .i_reorder_done (tb_reorder_done),
        .i_data         (tb_i_data),
        .i_lane_ids     (tb_i_lane_ids),

        .o_data         (tb_o_data)
 );


endmodule
