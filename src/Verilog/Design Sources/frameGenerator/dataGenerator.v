module dataGenerator
	#(
	parameter							DATA_BYTE_LEN 	= 8,
	parameter							DATA_BLOCK_LEN 	= 64
	)
	(
	input								i_clock,
	input								i_reset,
	input								i_enable,
	input								i_valid,
	output wire	[DATA_BLOCK_LEN - 1 :0]	o_data_block
	);

wire						valid = 1'b1;
wire [DATA_BYTE_LEN-1 : 0]	data0;
wire [DATA_BYTE_LEN-1 : 0]	data1;
wire [DATA_BYTE_LEN-1 : 0]	data2;
wire [DATA_BYTE_LEN-1 : 0]	data3;
wire [DATA_BYTE_LEN-1 : 0]	data4;
wire [DATA_BYTE_LEN-1 : 0]	data5;
wire [DATA_BYTE_LEN-1 : 0]	data6;
wire [DATA_BYTE_LEN-1 : 0]	data7;


prbs11#(
	)
u_data0_prbs
	(
		.i_clock(i_clock),
		.i_reset(i_reset),
		.i_enable(i_enable),
		.i_valid(valid),
		.o_sequence(data0)
	);


prbs11#(
	)
u_data1_prbs
	(
		.i_clock(i_clock),
		.i_reset(i_reset),
		.i_enable(i_enable),
		.i_valid(valid),
		.o_sequence(data1)
	);

prbs11#(
	)
u_data2_prbs
	(
		.i_clock(i_clock),
		.i_reset(i_reset),
		.i_enable(i_enable),
		.i_valid(valid),
		.o_sequence(data2)
	);

prbs11#(
	)
u_data3_prbs
	(
		.i_clock(i_clock),
		.i_reset(i_reset),
		.i_enable(i_enable),
		.i_valid(valid),
		.o_sequence(data3)
	);

prbs11#(
	)
u_data4_prbs
	(
		.i_clock(i_clock),
		.i_reset(i_reset),
		.i_enable(i_enable),
		.i_valid(valid),
		.o_sequence(data4)
	);

prbs11#(
	)
u_data5_prbs
	(
		.i_clock(i_clock),
		.i_reset(i_reset),
		.i_enable(i_enable),
		.i_valid(valid),
		.o_sequence(data5)
	);

prbs11#(
	)
u_data6_prbs
	(
		.i_clock(i_clock),
		.i_reset(i_reset),
		.i_enable(i_enable),
		.i_valid(valid),
		.o_sequence(data6)
	);

prbs11#(
	)
u_data7_prbs
	(
		.i_clock(i_clock),
		.i_reset(i_reset),
		.i_enable(i_enable),
		.i_valid(valid),
		.o_sequence(data7)
	);


assign o_data_block	= {data0, data1, data2, data3, data4, data5, data6, data7};

endmodule


