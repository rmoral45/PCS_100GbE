`timescale 1ns/100ps

module tb_encoder_comparator   ;

parameter LEN_TX_CTRL = 8      ;
parameter LEN_TX_DATA = 64     ;
parameter LEN_CODED_BLOCK = 66 ;


reg tb_clock  ;
reg tb_reset  ;
reg tb_enable ;

reg [9:0] counter ;

reg  [LEN_TX_CTRL-1:0]      tb_tx_ctrl    ;
reg  [LEN_TX_DATA-1:0]      tb_tx_data    ;
reg [LEN_CODED_BLOCK-1:0]   tb_tx_coded   ;
reg  [LEN_TX_CTRL-1:0]      temp_tx_ctrl  ;
reg  [LEN_TX_DATA-1:0]      temp_tx_data  ;
reg [LEN_CODED_BLOCK-1:0]   temp_tx_coded ;
wire [3:0] 				    tb_o_type     ;


integer                     fid_tx_data ;
integer                     fid_tx_ctrl ;
integer                     fid_tx_coded;
integer                     code_error_data   ;
integer                     code_error_ctrl   ;
integer                     code_error_coded  ;
integer                     ptr_data  ;
integer                     ptr_ctrl  ;
integer                     ptr_error ;

initial
begin
	tb_reset  = 1'b0 ;
	tb_clock  = 1'b0 ;
	tb_enable = 1'b0 ;
	counter   = 0    ;
end

always @ (posedge tb_clock)
begin
    for(ptr_data = 0 ; )
        code_error_data <= $fscanf(fid_tx_data, "%b", temp_tx_data);
end




comparator_test
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