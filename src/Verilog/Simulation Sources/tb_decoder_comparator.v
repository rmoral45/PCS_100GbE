`timescale 1ns/100ps

module tb_decoder_comparator				;

parameter LEN_RX_DATA		= 64			;
parameter LEN_RX_CTRL		= 8				;
parameter LEN_CODED_BLOCK	= 66			;

reg tb_clock								;
reg tb_reset								;					
reg tb_enable								;
reg counter	[9 : 0]							;
reg [LEN_CODED_BLOCK-1 : 0]  tb_rx_coded	;
reg [LEN_RX_DATA-1 : 0]		 tb_rx_data		;
reg [LEN_RX_CTRL-1 : 0]		 tb_rx_ctrl		;
reg [3 : 0]					 tb_rx_type		;

//wire [3 : 0]				 tb_wire_rx_type;

assign 

//---------------------------------------LOCALPARAMETERS
//---------------------------------------SyncHeaders
localparam DATA_SH = 2'b01					;
localparam CTRL_SH = 2'b01					;
//---------------------------------------BlockTypes
localparam CTRL_BTYPE	= 8'h1E				;
localparam START_BTYPE	= 8'h78				;
localparam ORD_BTYPE	= 8'h4B				;
localparam T0_BTYPE		= 8'h87				;
localparam T1_BTYPE		= 8'h99				;
localparam T2_BTYPE		= 8'hAA				;
localparam T3_BTYPE		= 8'HB4				;
localparam T4_BTYPE		= 8'hCC				;
localparam T5_BTYPE		= 8'hD2				;
localparam T6_BTYPE		= 8'hE1				;
localparam T7_BTYPE		= 8'hFF				;
//---------------------------------------Chars
localparam CHAR_IDLE	= 7'h00				;
localparam CHAR_ERROR	= 7'h1E				;
localparam CHAR_DATA0	= 8'h00				;
localparam CHAR_DATA1	= 8'h01				;
localparam CHAR_DATA2	= 8'h02				;
localparam CHAR_DATA3	= 8'h03				;
localparam CHAR_DATA4	= 8'h04				;
localparam CHAR_DATA5	= 8'h05				;	
localparam CHAR_DATA6	= 8'h06				;
localparam CHAR_DATA7	= 8'h07				;	
localparam CHAR_QORD	= 1'h0 				;
localparam CHAR_Fsig	= 1'hF 				;
localparam CHAR_ZERO	= 1'h0 				;
//---------------------------------------Blocks
localparam DATA_BLOCK	= {DATA_SH, CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_DATA4, CHAR_DATA5, CHAR_DATA6, CHAR_DATA7}		;
localparam ERROR_BLOCK	= {CTRL_SH, CTRL_BTYPE, {8{CHAR_ERROR}}}																		;
localparam IDLE_BLOCK	= {CTRL_SH, CTRL_BTYPE, {8{CHAR_IDLE}}}																			;
localparam START_BLOCK	= {CTRL_SH, START_BTYPE, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_DATA4, CHAR_DATA5, CHAR_DATA6, CHAR_DATA7}	;
localparam QORD_BLOCK	= {CTRL_SH, ORD_BTYPE, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_QORD, {7{CHAR_ZERO}}}							;
localparam Fsig_BLOCK	= {CTRL_SH, ORD_BTYPE, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_Fsig, {7{CHAR_ZERO}}}							;	
localparam T0_BLOCK		= {CTRL_SH, T0_BTYPE, 7'h00, {3{CHAR_IDLE}}, {4{CHAR_ERROR}}}													;
localparam T1_BLOCK		= {CTRL_SH, T1_BTYPE, CHAR_DATA0, 6'h00, {2{CHAR_IDLE}}, {4{CHAR_ERROR}}}										;
localparam T2_BLOCK		= {CTRL_SH, T2_BTYPE, CHAR_DATA0, CHAR_DATA1, 5'h00, CHAR_IDLE, {4{CHAR_ERROR}}}								;
localparam T3_BLOCK		= {CTRL_SH, T3_BTYPE, CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, 4'h0, {4{CHAR_ERROR}}}								;
localparam T4_BLOCK		= {CTRL_SH, T4_BTYPE, CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, 3'h0, {3{CHAR_IDLE}}}						;
localparam T5_BLOCK		= {CTRL_SH, T5_BTYPE, CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_DATA4, 2'h0, {2{CHAR_IDLE}}}			;
localparam T6_BLOCK		= {CTRL_SH, T6_BTYPE, CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_DATA4, CHAR_DATA5, 1'h0, CHAR_IDLE}	;
localparam T7_BLOCK		= {CTRL_SH, T7_BTYPE, CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_DATA4, CHAR_DATA5, CHAR_DATA6}		;
//---------------------------------------
initial
begin
	tb_clock	= 1'b0;
	tb_reset	= 1'b0;
	tb_enable	= 1'b0;	
	counter		= 0;
end

//Simulo el envio de IDLE, START, ERROR, DATA, T0, START, T1, START, DATA, T2, START, ERROR, ERROR, T3

always @(posedge tb_clock or posedge tb_reset) begin
	
	counter = counter + 1						;
	
	case(counter)
		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = IDLE_BLOCK			;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = START_BLOCK			;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = ERROR_BLOCK			;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = DATA_BLOCK			;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = T0_BLOCK				;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = START_BLOCK			;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = T1_BLOCK				;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = START_BLOCK			;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = DATA_BLOCK			;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = T2_BLOCK				;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = START_BLOCK			;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = ERROR_BLOCK			;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = ERROR_BLOCK			;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

		10'D2: tb_reset = 1'b1                  ;
		10'D3: tb_reset = 1'b0                  ;
		10'D5: begin
			tb_rx_coded = T3_BLOCK				;
			tb_enable   = 1'b1                  ;
		end
		10'D6: begin
			tb_enable = 1'b0                    ;
		end

end

decoder_comparator
	#(	
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK)	,
	.LEN_RX_DATA(LEN_RX_DATA)			,
	.LEN_RX_CTRL(LEN_RX_CTRL)
	)

	test_1
	(
	.i_clock   	(tb_clock)    			,
	.i_reset   	(tb_reset)    			,
	.i_enable  	(tb_enable)   			,
	.i_rx_coded (tb_rx_coded)			,
	.o_rx_data	(tb_rx_data)			,
	.o_rx_ctrl	(tb_rx_ctrl)			,
	.o_r_type	(tb_rx_type)			
	);

always #2.5 tb_clock = ~tb_clock;
endmodule





