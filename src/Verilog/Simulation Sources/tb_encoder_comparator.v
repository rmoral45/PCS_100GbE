
`timescale 1ns/100ps

module tb_encoder_comparator;

parameter LEN_TX_CTRL = 8;
parameter LEN_TX_DATA = 64;
parameter LEN_CODED_BLOCK = 66;


reg tb_clock;
reg tb_reset;
reg tb_enable;

reg [9:0] counter;

reg  [LEN_TX_CTRL-1:0]      tb_tx_ctrl;
reg  [LEN_TX_DATA-1:0]      tb_tx_data;
wire [3:0] 				    tb_o_type;
wire [LEN_CODED_BLOCK-1:0]  tb_tx_coded;


initial
begin
	tb_reset  = 1'b0;
	tb_clock  = 1'b0;
	tb_enable = 1'b0;
	counter   = 0;
end

always @ (posedge tb_clock)
begin
	counter = counter + 1;
	case(counter)
		10'D2: tb_reset = 1'b1;
		10'D3: tb_reset = 1'b0;
		10'D5: begin
			tb_tx_ctrl  = 8'h00;
			tb_tx_data  = 64'h0001020304050607;
			tb_enable   = 1'b1;
		end
		10'D6: begin
			tb_enable = 1'b0;
		end
		10'D10: begin
			tb_tx_ctrl  = 8'hff;
			tb_tx_data  = 64'h0707070707070707;
			tb_enable   = 1'b1;
		end
		10'D11: begin
			tb_enable = 1'b0;
		end
		10'D15: begin
			tb_tx_ctrl  = 8'h80;
			tb_tx_data  = 64'hFB01020304050607;
			tb_enable   = 1'b1;
		end
		10'D16: begin
			tb_enable = 1'b0;
		end
		10'D20: begin
			tb_tx_ctrl  = 8'hff;
			tb_tx_data  = 64'hFDFE07FE07FE07FE;
			tb_enable   = 1'b1;
		end
		10'D21: begin
			tb_enable = 1'b0;
		end

	endcase

end




comparator_test
#(
	.LEN_TX_CTRL(LEN_TX_CTRL),
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK),
	.LEN_TX_DATA(LEN_TX_DATA)
 )



	u_comparator
	(
		.i_clock(tb_clock),
		.i_reset(tb_reset),
		.i_enable(tb_enable),
		.i_tx_ctrl(tb_tx_ctrl),
		.i_tx_data(tb_tx_data),
		.o_t_type(tb_o_type),
		.o_tx_coded(tb_tx_coded)
	);


 always #2.5 tb_clock = ~tb_clock;
endmodule
