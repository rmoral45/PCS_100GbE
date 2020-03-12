`timescale 1ns/100ps


module one_hot_20_to_1_mux
#(
        parameter N_LANES = 20
 )
 (
        input wire [N_LANES-1 : 0]      i_lane_id,
        input wire [N_LANES-1 : 0]      i_data,

        output reg                     o_data
 );


integer i;

always @ *
begin
       o_data = | (i_lane_id & i_data);
end


endmodule
