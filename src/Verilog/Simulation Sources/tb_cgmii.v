`timescale 1ns/100ps

module tb_cgmii;

//Registro
reg 			tb_clock;
reg 			tb_reset;
reg 	[3:0]	tb_debug_pulse;
wire 	[7:0]	tb_tx_ctrl;
wire 	[63:0]	tb_tx_data;

initial begin
		tb_clock 			= 1'b0;
		tb_reset 			= 1'b0;
		tb_debug_pulse      = 4'b0000;
#1 tb_reset = 1'b1;
#1 tb_reset = 1'b0;
#10 tb_debug_pulse = 4'b0000;
#10000000 $finish ;
end

//always @ (posedge tb_clock)
//begin
//	counter = counter + 1                       ;
//	case(counter)
//		10'D2: tb_reset = 1'b1                  ;
//		10'D3: tb_reset = 1'b0                  ;
//		10'D10: tb_debug_pulse = 4'b0000			;
//		10'D200: tb_debug_pulse = 4'b0001		;	
//		10'D400: tb_debug_pulse = 4'b0010		;
//		10'D500: tb_debug_pulse = 4'b1000		;
//		10'D600: tb_debug_pulse = 4'b1111		;
//	endcase

//end

always #1 tb_clock = ~tb_clock;

cgmii#()
test_cgmii(
			.i_clock(tb_clock),
			.i_reset(tb_reset),
			.i_debug_pulse(tb_debug_pulse),
			.o_tx_ctrl(tb_tx_ctrl),
			.o_tx_data(tb_tx_data)
	);
	
endmodule