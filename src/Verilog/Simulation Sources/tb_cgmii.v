`timescale 1ns/100ps

module tb_cgmii();

//Registro
reg 		clock;
reg 		reset;
reg [3:0]	debug_pulse;

wire [7:0]	tx_ctrl;
wire [63:0]	tx_data;

initial begin
clock = 1'b0;
reset = 1'b0;
#4 reset = 1'b1;
#8 reset = 1'b0;
#12 debug_pulse = 4'b0000;		//Funcionamiento normal
#1024 debug_pulse = 4'b0001;	//Estado de error
#1024 debug_pulse = 4'b0010;	//Estado de control
#1024 debug_pulse = 4'b0100;	//Estado de inicio de trama
#1024 debug_pulse = 4'b1000;	//Estado de datos
#1024 debug_pulse = 4'b1111;	//Estado de finalizacion de trama
#100000000 $finish;
end

always #1 clock = ~clock;

cgmii#()
test_cgmii(
			.i_clock(clock),
			.i_reset(reset),
			.i_debug_pulse(debug_pulse),
			.o_tx_ctrl(tx_ctrl),
			.o_tx_data(tx_data)
	);
	
endmodule