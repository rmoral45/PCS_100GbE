`timescale 1ns/100ps

module tb_parallel_converter;

reg [9:0]			 counter;
reg 				 clock;
reg 				 reset;
reg 				 enable;
reg [65 : 0] 		 data;
wire 				 valid;
wire [(66*10)-1 : 0] out;
reg [(66*10)-1 : 0] out_aux;
reg  [65:0] lanes [0 : 9];
integer i;
initial begin
	clock  = 0;
	reset  = 1;
	enable = 0;
	data   = {66{1'b0}};
	counter = 0;
	#5 reset  = 0;
end


always @ (posedge clock)
begin
	counter <= counter + 1;
	if(counter == 10)
		enable <= 1;
	else if(counter > 10)
		data <= data +1;
end

always @ (posedge clock)
begin
	if(valid)
		out_aux <= out;
end
always #2.5 clock = ~clock;


parallel_converter
#(
	.LEN_CODED_BLOCK(66),
	.N_LANES(10)
 )
	u_parallel_converter
	(
		.i_clock(clock),
		.i_reset(reset),
		.i_enable(enable),
		.i_data(data),
		.o_valid(valid),
		.o_data(out)
	);

always @ *
begin//para ver cada dato por separado
	for(i=0; i < 10 ; i=i+1 )
		lanes[i] = out_aux[ (((66*10)-1)-(i*66)) -: 66 ];
end


endmodule