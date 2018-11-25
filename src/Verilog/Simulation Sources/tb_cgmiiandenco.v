`timescale 1ns/100ps

module tb_cgmiiandenco;

parameter LEN_TX_CTRL = 8      ;
parameter LEN_TX_DATA = 64     ;
parameter LEN_CODED_BLOCK = 66 ;


reg tb_clock  ;
reg tb_reset  ;
reg tb_enable ;

reg 	[9:0] 	counter ;
reg 	[3:0]	tb_debug_pulse;

wire [LEN_TX_CTRL-1:0]      tb_tx_ctrl  ;
wire [LEN_TX_DATA-1:0]      tb_tx_data  ;
wire [3:0] 				    tb_o_type   ;
wire [LEN_CODED_BLOCK-1:0]  tb_tx_coded ;


initial
begin
	tb_reset  = 1'b0 ;
	tb_clock  = 1'b0 ;
	tb_enable = 1'b0 ;
	counter   = 0    ;
end


always @ (posedge tb_clock)
begin
	counter = counter + 1                       ;
	case(counter)
		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D4: tb_debug_pulse = 4'b000			;
		10'D5: tb_enable = 1'b1;
	endcase

end

cgmii
	#(
	)
test_cgmii
	(
	.i_clock(tb_clock),
	.i_reset(tb_reset),
	.i_debug_pulse(tb_debug_pulse),
	.o_tx_ctrl(tb_tx_ctrl),
	.o_tx_data(tb_tx_data)
	);

encoder_comparator
	#(
	.LEN_TX_CTRL    (LEN_TX_CTRL)     ,
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK) ,
	.LEN_TX_DATA    (LEN_TX_DATA)
 	)
u_comparator
	(
	.i_clock   (tb_clock)    ,
	.i_reset   (tb_reset)    ,
	.i_enable  (tb_enable)   ,
	.i_tx_ctrl (tb_tx_ctrl)  ,
	.i_tx_data (tb_tx_data)  ,
	.o_t_type  (tb_o_type)   ,
	.o_tx_coded(tb_tx_coded)
	);


 always #2.5 tb_clock = ~tb_clock;
endmodule