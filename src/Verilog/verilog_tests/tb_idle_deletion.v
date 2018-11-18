`timescale 1ns/100ps


module tb_idle_deletion;

localparam CGMII_IDLE = 8'h07;

reg 		clock;
reg 		reset;
reg [63:0] 	data;
reg [63:0] 	data_aux;
reg [7:0] 	ctrl;
reg			valid;
reg 		enable;
reg [9:0]   counter;

wire [63:0] 	output_data;



initial begin
clock    = 1'b0;
reset    = 1'b1;
data     = {64{1'b0}};
data_aux = {64{1'b0}};
ctrl     = 0;
valid    = 0;
enable   = 0;
counter  = 0;
#5 reset = 0;

end

always #2.5 clock = ~clock;

always @ (posedge clock)
begin
	counter <= counter + 1;
	valid 	<= 1;
	enable  <= 1;

	if (counter < 30)
	begin
		data <= data + 1;
		ctrl <= 0;
	end
	else if (counter >= 30 && counter < 80)
	begin
		if((counter % 2) == 0)
		begin
			data <= {8{CGMII_IDLE}};
			ctrl <= 8'hff;
		end
		else
		begin
			data <= data_aux + 1;
			ctrl <= 0;
		end
	end
	else
	begin
		data <= data +1;
		ctrl <= 0;
	end

end

idle_insertion_top
#(
	.LEN_TX_DATA(64),
	.LEN_TX_CTRL(8),
	.N_IDLE		(20),
	.N_BLOCKS	(100),
	.N_LANES	(20)
 )
 	u_idle_insertion
 					(
 						.i_clock(clock),
 						.i_reset(reset),
 						.i_enable(enable),
 						.i_valid(valid),
 						.i_tx_data(data),
 						.i_tx_ctrl(ctrl),
 						.o_tx_data(output_data)
 					);


endmodule