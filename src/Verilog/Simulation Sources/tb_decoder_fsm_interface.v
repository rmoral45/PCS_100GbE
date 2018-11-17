`timescale 1ns/100ps

module tb_decoder_fsm_interface	 		 ;

parameter LEN_R_TYPE = 4		 		 ;

reg 					tb_clock 		 ;
reg 					tb_reset 		 ;						
reg 					tb_enable		 ;
reg [LEN_R_TYPE-1 : 0]	tb_i_r_type	 	 ;

wire [LEN_R_TYPE-1 : 0]	tb_o_r_type		 ;
wire [LEN_R_TYPE-1 : 0]	tb_o_r_type_next ;	


localparam [3:0] 		TYPE_D  = 4'b1000;
localparam [3:0] 		TYPE_S  = 4'b0100;
localparam [3:0] 		TYPE_C  = 4'b0010;
localparam [3:0] 		TYPE_T  = 4'b0001;
localparam [3:0] 		TYPE_E  = 4'b0000;

initial
begin
	tb_clock		= 1'b0 	;
	tb_reset		= 1'b0 	;
	tb_enable		= 1'b0 	;	
	#10 tb_r_type	= TYPE_S;
	#2 	tb_r_type	= TYPE_D;
	#2 	tb_r_type	= TYPE_T;
	#2 	tb_r_type	= TYPE_C;
	#2 	tb_r_type	= TYPE_E;
	#2 	tb_r_type	= TYPE_C;
end

decoder_fsm_interface
	#(
	.LEN_R_TYPE(LEN_R_TYPE)
	)

test_decoder_fsm_interface
	(
	.i_clock   	       (tb_clock)    		,
	.i_reset   	       (tb_reset)    		,
	.i_enable  	       (tb_enable)   		,
	.i_r_type          (tb_i_r_type)		,
	.o_r_type 		   (tb_o_r_type)		,
	.o_r_type_next	   (tb_o_r_type_next)		       
	)