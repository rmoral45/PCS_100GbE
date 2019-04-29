`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2019 10:42:08 AM
// Design Name: 
// Module Name: tb_bip_calc_alone
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

module tb_bip_calc_alone;
localparam LEN_CODED_BLOCK = 66;

reg tb_clock;
reg tb_reset;
reg tb_enable;
reg [LEN_CODED_BLOCK-1 : 0] tb_data;

initial
begin
    tb_clock = 0;
	tb_reset = 1;
	tb_enable = 0;
#6  tb_reset = 0;
    tb_enable = 1;
#1000000 $finish;
end

always #1 tb_clock = ~tb_clock;


bip_calculator
#(
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK)
 )
	u_bip_calculator
 	(
    .i_clock (tb_clock)  ,
    .i_reset (tb_reset)  ,
    .i_data  (tb_data)     , // data from internal reg. [FIX]
    .i_enable(tb_enable) ,
	.i_am_insert(tb_insert),
    .o_bip3(tb_bip3),
    .o_bip7(tb_bip7),
    .i_bip(tb_br)
    );





endmodule
