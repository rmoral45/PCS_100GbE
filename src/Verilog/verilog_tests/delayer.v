`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2020 08:22:12 PM
// Design Name: 
// Module Name: delayer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module delayer
#(
    parameter NB_DATA = 66,
    parameter N_DELAY = 10
)
(
    output wire [NB_DATA - 1 : 0] o_data,
    
    input wire i_clock,
    input wire i_reset,
    input wire i_valid,
    input wire [NB_DATA - 1 : 0] i_data
);

reg [NB_DATA-1 : 0] delayed_data [N_DELAY - 1 : 0];
integer i;

always @(posedge i_clock)
begin
    if(i_reset)
        for(i = 0; i < N_DELAY; i = i + 1)
            delayed_data[i] <= {NB_DATA{1'b0}};
    else if(i_valid)
    begin
        delayed_data[0] <= i_data;
        for(i = 1; i < N_DELAY; i = i + 1)
            delayed_data[i] <= delayed_data[i - 1]; 
    end
end

assign o_data = delayed_data[N_DELAY - 1];

endmodule
