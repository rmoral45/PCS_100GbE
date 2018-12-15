`timescale 1ns/100ps;


module tb_log_memory;

localparam NB_DATA = 16;
localparam DEPTH   = 32;
localparam NB_ADDR = $clog2(DEPTH);

reg clock,reset,run;

reg  [NB_DATA-1 : 0] input_data;
wire [NB_DATA-1 : 0] output_data;

reg  [NB_ADDR-1 : 0] read_addr;

wire 				 tb_mem_full;


initial
begin
	clock = 0;
	reset = 1;
	run   = 0;
	read_addr  = 0;
	# 6
		reset = 0;
	# 6
		run = 1;
		input_data = 0;
end

always #1 clock = ~clock;

always @ (posedge clock)
begin
	input_data <= input_data+1;	
end
always @ (posedge clock)
begin
	if(tb_mem_full)
		read_addr <= read_addr + 1;	
end
log_memory
#(
	.NB_DATA(NB_DATA),
	.DEPTH(DEPTH),
	.NB_ADDR(NB_ADDR)
 )
	u_log_memory
	(
		.i_clock 		(clock),
		.i_reset 		(reset),
		.i_run 			(run),
		.i_read_addr	(read_addr),
		.i_data 		(input_data),

		.o_full 		(tb_mem_full),
		.o_data 		(output_data)
	);

endmodule