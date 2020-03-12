`timescale 1ns/100ps
module dataGenerator
	#(
	parameter							NB_BYTE 		= 8,
	parameter							NB_DATA_RAW 	= 64
	)
	(
	input								i_clock,
	input								i_reset,
	input								i_enable,
	output wire	[NB_DATA_RAW - 1 :0]	o_data_block
	);

wire									valid = 1'b1;
wire 			[NB_BYTE-1 : 0]	data0;
wire 			[NB_BYTE-1 : 0]	data1;
wire 			[NB_BYTE-1 : 0]	data2;
wire 			[NB_BYTE-1 : 0]	data3;
wire 			[NB_BYTE-1 : 0]	data4;
wire 			[NB_BYTE-1 : 0]	data5;
wire 			[NB_BYTE-1 : 0]	data6;
wire 			[NB_BYTE-1 : 0]	data7;

assign o_data_block	= {data0, data1, data2, data3, data4, data5, data6, data7};

prbs#(
    .HIGH_LIM(10),
    .LOW_LIM(3)
	)
u_data0_prbs11
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(i_enable),
	.i_valid(valid),
	.o_sequence(data0)
	);

prbs#(
    .SEED(12'hFBE),
    .HIGH_LIM(7),
    .LOW_LIM(0)
	)
u_data1_prbs11
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(i_enable),
	.i_valid(valid),
	.o_sequence(data1)
	);

prbs#(
    .SEED(12'hAAA),
    .HIGH_LIM(9),
    .LOW_LIM(2)
	)
u_data2_prbs11
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(i_enable),
	.i_valid(valid),
	.o_sequence(data2)
    );

prbs#(
    .SEED(12'hCED),
    .HIGH_LIM(11),
    .LOW_LIM(4)
	)
u_data3_prbs11
	(
.i_clock(i_clock),
.i_reset(i_reset),
.i_enable(i_enable),
.i_valid(valid),
.o_sequence(data3)
	);

prbs#(
    .SEED(12'hBAA),
    .HIGH_LIM(10),
    .LOW_LIM(3)
	)
u_data4_prbs11
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(i_enable),
	.i_valid(valid),
	.o_sequence(data4)
	);

prbs#(
    .SEED(12'hFAE),
    .HIGH_LIM(8),
    .LOW_LIM(1)
	)
u_data5_prbs11
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(i_enable),
	.i_valid(valid),
	.o_sequence(data5)
	);

prbs#(
    .SEED(12'hDCA),
    .HIGH_LIM(12),
    .LOW_LIM(5)
	)
u_data6_prbs11
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(i_enable),
	.i_valid(valid),
    .o_sequence(data6)
	);

prbs#(
    .SEED(12'hADC),
    .HIGH_LIM(9),
    .LOW_LIM(2)
	)
u_data7_prbs11
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(i_enable),
	.i_valid(valid),
	.o_sequence(data7)
	);

endmodule


