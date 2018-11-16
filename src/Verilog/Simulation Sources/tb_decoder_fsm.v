`timescale 1ns/100ps                                    ;
module tb_decoder_fsm									;	

parameter LEN_RX_DATA		= 64						;
parameter LEN_RX_CTRL		= 8							;
parameter LEN_CODED_BLOCK	= 66						;

reg 							 tb_clock				;
reg 						     tb_reset				;					
reg  		 					 tb_enable				;
reg	 [9 : 0] 					 counter				;
reg  [LEN_RX_DATA-1 : 0]		 tb_i_rx_data			;
reg  [LEN_RX_CTRL-1 : 0]		 tb_i_rx_control 		;
reg  [3 : 0]					 tb_i_rx_type 			;
reg  [3 : 0]					 tb_i_rx_type_next		;

wire [LEN_RX_DATA-1 : 0]		 tb_o_rx_raw_data		;
wire [LEN_RX_CTRL-1 : 0]		 tb_o_rx_raw_control 	;


//---------------------------------------LOCALPARAMETERS

//---------------------------------------Types
localparam [3:0] TYPE_D  = 4'b1000;
localparam [3:0] TYPE_S  = 4'b0100;
localparam [3:0] TYPE_C  = 4'b0010;
localparam [3:0] TYPE_T  = 4'b0001;
localparam [3:0] TYPE_E  = 4'b0000;
//---------------------------------------CGMII Control
localparam [7:0] CGMII_IDLE   = 8'h07;
localparam [7:0] CGMII_ERROR  = 8'hFE;
localparam [7:0] CGMII_START  = 8'hFB;
localparam [7:0] CGMII_TERM   = 8'hFD;
localparam [7:0] CGMII_QORD   = 8'h5C;
localparam [7:0] CGMII_Fsig   = 8'h9C;

//---------------------------------------Chars
localparam CHAR_IDLE	= 8'h07				;
localparam CHAR_ERROR	= 8'hFE				;
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
localparam DATA_BLOCK	= {CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_DATA4, CHAR_DATA5, CHAR_DATA6, CHAR_DATA7}	;
localparam ERROR_BLOCK	= {8{CGMII_ERROR}}																					;
localparam IDLE_BLOCK	= {8{CGMII_IDLE}}																					;
localparam START_BLOCK	= {CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_DATA4, CHAR_DATA5, CHAR_DATA6, CHAR_DATA7}				;
localparam QORD_BLOCK	= {CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_QORD, {7{CHAR_ZERO}}}									;
localparam Fsig_BLOCK	= {CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_Fsig, {7{CHAR_ZERO}}}									;	
localparam T0_BLOCK		= {7'h00, {3{CGMII_IDLE}}, {4{CGMII_ERROR}}}															;
localparam T1_BLOCK		= {CHAR_DATA0, 6'h00, {2{CHAR_IDLE}}, {4{CHAR_ERROR}}}												;
localparam T2_BLOCK		= {CHAR_DATA0, CHAR_DATA1, 5'h00, CHAR_IDLE, {4{CHAR_ERROR}}}										;
localparam T3_BLOCK		= {CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, 4'h0, {4{CHAR_ERROR}}}										;
localparam T4_BLOCK		= {CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, 3'h0, {3{CHAR_IDLE}}}							;
localparam T5_BLOCK		= {CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_DATA4, 2'h0, {2{CHAR_IDLE}}}				;
localparam T6_BLOCK		= {CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_DATA4, CHAR_DATA5, 1'h0, CHAR_IDLE}			;
localparam T7_BLOCK		= {CHAR_DATA0, CHAR_DATA1, CHAR_DATA2, CHAR_DATA3, CHAR_DATA4, CHAR_DATA5, CHAR_DATA6}				;
//---------------------------------------


initial
begin
	tb_clock 	        = 1'b0                  ;
	tb_reset 	        = 1'b0                  ;
	tb_enable 	        = 1'b0                  ;
	tb_i_rx_data		= {LEN_RX_DATA{1'b0}}	;
    tb_i_rx_control     = {LEN_RX_CTRL{1'b0}}	;
    tb_i_rx_type        = {4{1'b0}}             ;     
	counter		= 0;
end

//Simulo el envio de IDLE, START, ERROR, DATA, T0, START, T1, START, DATA, T2, T7, START, ERROR, ERROR, T3, T4
//Por lo tanto, los types que se van a pasar son: C->S->E->D->T->S->T->S->D->T->T->S->E->E->T->T

always @(posedge tb_clock or posedge tb_reset)
begin
	
	counter = counter + 1							;
	
	case(counter)
		10'D2: tb_reset 		= 1'b1              ;
		10'D3: tb_reset 		= 1'b0              ;
		10'D5: begin
			tb_i_rx_type 		= TYPE_C			;
			tb_i_rx_type_next 	= TYPE_S			;			
			tb_i_rx_control 	= CGMII_IDLE		;
			tb_i_rx_data 		= IDLE_BLOCK		;
			tb_enable   		= 1'b1              ;
		end

		10'D6: begin
			tb_enable = 1'b0                    	;
		end

		10'D10: begin
			tb_i_rx_type 	= TYPE_S				;
			tb_i_rx_type_next 	= TYPE_E			;
			tb_i_rx_control = CGMII_START			;
			tb_i_rx_data 	= START_BLOCK			;
			tb_enable   	= 1'b1              	;
		end

		10'D11: begin
			tb_enable = 1'b0                    	;
		end

		10'D15: begin
			tb_i_rx_type 	= TYPE_E				;
			tb_i_rx_type_next 	= TYPE_D			;
			tb_i_rx_control = CGMII_ERROR			;
			tb_i_rx_data 	= ERROR_BLOCK			;
			tb_enable   	= 1'b1              	;
		end

		10'D16: begin
			tb_enable = 1'b0                    	;
		end

		10'D20: begin
			tb_i_rx_type 	= TYPE_D				;
			tb_i_rx_type_next 	= TYPE_T			;
			tb_i_rx_control = 8'h00					;
			tb_i_rx_data 	= DATA_BLOCK			;
			tb_enable   	= 1'b1              	;
		end

		10'D21: begin
			tb_enable = 1'b0                    	;
		end

		10'D25: begin
			tb_i_rx_type 	= TYPE_T				;
			tb_i_rx_type_next 	= TYPE_S			;
			tb_i_rx_control = CGMII_TERM			;
			tb_i_rx_data 	= T0_BLOCK				;
			tb_enable   	= 1'b1              	;
		end

		10'D26: begin
			tb_enable = 1'b0                    	;
		end

		10'D30: begin
			tb_i_rx_type 	= TYPE_S				;
			tb_i_rx_type_next 	= TYPE_T			;
			tb_i_rx_control = CGMII_START			;
			tb_i_rx_data 	= START_BLOCK			;
			tb_enable   	= 1'b1              	;
		end

		10'D31: begin
			tb_enable = 1'b0                    	;
		end

		10'D35: begin
			tb_i_rx_type 	= TYPE_T				;
			tb_i_rx_type_next 	= TYPE_S			;
			tb_i_rx_control = CGMII_TERM			;
			tb_i_rx_data 	= T1_BLOCK				;
			tb_enable   	= 1'b1              	;
		end

		10'D36: begin
			tb_enable = 1'b0                    	;
		end


		10'D40: begin
			tb_i_rx_type 	= TYPE_S				;
			tb_i_rx_type_next 	= TYPE_D			;
			tb_i_rx_control = CGMII_START			;
			tb_i_rx_data 	= START_BLOCK			;
			tb_enable   	= 1'b1              	;
		end

		10'D41: begin
			tb_enable = 1'b0                    	;
		end

		10'D45: begin
			tb_i_rx_type 	= TYPE_D				;
			tb_i_rx_type_next 	= TYPE_T			;
			tb_i_rx_control = 8'h00					;
			tb_i_rx_data 	= DATA_BLOCK			;
			tb_enable   	= 1'b1              	;
		end

		10'D46: begin
			tb_enable = 1'b0                    	;
		end

		10'D50: begin
			tb_i_rx_type 	= TYPE_T				;
			tb_i_rx_type_next 	= TYPE_T			;
			tb_i_rx_control = CGMII_TERM			;
			tb_i_rx_data 	= T2_BLOCK				;
			tb_enable   	= 1'b1              	;
		end

		10'D51: begin
			tb_enable = 1'b0                    	;
		end

		10'D55: begin
			tb_i_rx_type 	= TYPE_T				;
			tb_i_rx_type_next 	= TYPE_S			;
			tb_i_rx_control = CGMII_TERM			;
			tb_i_rx_data 	= T7_BLOCK				;
			tb_enable   	= 1'b1              	;
		end

		10'D56: begin
			tb_enable = 1'b0                    	;
		end

		10'D60: begin
			tb_i_rx_type 	= TYPE_S				;
			tb_i_rx_type_next 	= TYPE_E			;
			tb_i_rx_control = CGMII_START			;
			tb_i_rx_data 	= START_BLOCK			;
			tb_enable   	= 1'b1              	;
		end

		10'D61: begin
			tb_enable = 1'b0                    	;
		end

		10'D65: begin
			tb_i_rx_type 	= TYPE_E				;	
			tb_i_rx_type_next 	= TYPE_E			;
			tb_i_rx_control = CGMII_ERROR			;
			tb_i_rx_data 	= ERROR_BLOCK			;
			tb_enable   	= 1'b1              	;
		end

		10'D66: begin
			tb_enable = 1'b0                    	;
		end

		10'D70: begin
			tb_i_rx_type 	= TYPE_E				;
			tb_i_rx_type_next 	= TYPE_T			;
			tb_i_rx_control = CGMII_ERROR			;
			tb_i_rx_data 	= ERROR_BLOCK			;
			tb_enable   	= 1'b1              	;
		end

		10'D71: begin
			tb_enable = 1'b0                    	;
		end

		10'D75: begin
			tb_i_rx_type 	= TYPE_T				;
			tb_i_rx_type_next 	= TYPE_T			;
			tb_i_rx_control = CGMII_TERM			;
			tb_i_rx_data 	= T3_BLOCK				;
			tb_enable   	= 1'b1              	;
		end

		10'D76: begin
			tb_enable = 1'b0                    	;
		end

		10'D80: begin
			tb_i_rx_type 	= TYPE_T				;
			tb_i_rx_type_next 	= TYPE_S			;
			tb_i_rx_control = CGMII_TERM			;
			tb_i_rx_data 	= T4_BLOCK				;
			tb_enable   	= 1'b1              	;
		end

		10'D81: begin
			tb_enable = 1'b0                    	;
		end
		
	endcase
end

decoder_fsm 
	#(	
	.LEN_RX_DATA(LEN_RX_DATA)			,
	.LEN_RX_CTRL(LEN_RX_CTRL)
	)

	test_1_decoder_fsm
	(
	.i_clock   	       (tb_clock)    		,
	.i_reset   	       (tb_reset)    		,
	.i_enable  	       (tb_enable)   		,
	.i_r_type          (tb_i_rx_type)       ,
	.i_r_type_next     (tb_i_rx_type_next)  ,	
	.i_rx_data	       (tb_i_rx_data)       ,
	.i_rx_control	   (tb_i_rx_control)    ,
	.o_rx_raw_data     (tb_o_rx_raw_data)   ,
	.o_rx_raw_control  (tb_o_rx_raw_control)				
	);

always #2.5 tb_clock = ~tb_clock;
endmodule