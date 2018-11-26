`timescale 1ns/100ps

module tb_encoder_comparator   ;

parameter LEN_TX_CTRL 		= 8;
parameter LEN_TX_DATA 		= 64;
parameter LEN_TX_CODED   	= 66;
parameter LEN_TX_TYPE		= 4;


reg tb_clock  ;
reg tb_reset  ;
reg tb_enable ;

reg  [LEN_TX_CTRL-1:0]      tb_tx_ctrl    ;
reg  [LEN_TX_DATA-1:0]      tb_tx_data    ;
wire [LEN_TX_CODED-1:0]  tb_tx_coded   ;
reg  [0 : LEN_TX_CTRL-1]    temp_tx_ctrl  ;
reg  [0 : LEN_TX_DATA-1]    temp_tx_data  ;
reg  [0 : LEN_TX_CODED-1]  temp_tx_coded ;
wire [3:0] 				    tb_o_type     ;


integer                     fid_tx_data ;
integer                     fid_tx_ctrl ;
integer                     fid_tx_coded;
integer                     code_error_data   ;
integer                     code_error_ctrl   ;
integer                     code_error_coded  ;
integer                     ptr_data  ;
integer                     ptr_ctrl  ;
integer                     ptr_coded ;

initial
begin
	
	fid_tx_ctrl= $fopen("/home/ramiro/Fundacion/PPS/src/Python/file_generator/encoder-input-ctrl.txt", "r");
		if(fid_tx_ctrl==0)
		begin
			$display("\n\nLa entrada para Tx-Ctrl no pudo ser abierta\n\n");
			$stop;
		end
	fid_tx_data= $fopen("/home/ramiro/Fundacion/PPS/src/Python/file_generator/encoder-input-data.txt", "r");
		if(fid_tx_data==0)
		begin
			$display("\n\nLa entrada para Tx-Data no pudo ser abierta\n\n");
			$stop;
		end
		
	fid_tx_coded= $fopen("/home/ramiro/Fundacion/PPS/src/Python/file_generator/encoder-output.txt", "r");
                if(fid_tx_coded==0)
                begin
                    $display("\n\nLa entrada para Tx-Coded no pudo ser abierta\n\n");
                    $stop;
                end

	tb_reset  = 1'b1 ;
	tb_reset  = 1'b0 ;
	tb_clock  = 1'b0 ;
	tb_enable = 1'b0 ;
	tb_enable = 1'b1 ;
end


always #2.5 tb_clock = ~tb_clock;

always @ (posedge tb_clock)
begin
    
    for(ptr_ctrl = 0; ptr_ctrl < LEN_TX_CTRL ; ptr_ctrl = ptr_ctrl+1)
        begin
            code_error_ctrl <= $fscanf(fid_tx_ctrl, "%b\n", temp_tx_ctrl[ptr_ctrl]);
            if(code_error_ctrl != 1)
            begin
                $display("\n\nTx-Ctrl: El caracter leido no es valido..\n\n");
                $stop;
            end
        end
    
    
        for(ptr_data = 0; ptr_data < LEN_TX_DATA ; ptr_data = ptr_data+1)
        begin
            code_error_data <= $fscanf(fid_tx_data, "%b\n", temp_tx_data[ptr_data]);
            if(code_error_data != 1)
            begin
                $display("Tx-Data: El caracter leido no es valido..");
                $stop;
            end
        end
        
        for(ptr_coded = 0; ptr_coded < LEN_TX_CODED ; ptr_coded = ptr_coded+1)
        begin
            code_error_coded <= $fscanf(fid_tx_coded, "%b\n", temp_tx_coded[ptr_coded]);
            if(code_error_coded != 1)
            begin
                $display("Tx-Coded: El caracter leido no es valido..");
                $stop;
            end
        end
        
        
   

    tb_tx_ctrl <= temp_tx_ctrl;
    tb_tx_data <= temp_tx_data;

end




encoder_comparator
	#(
	.LEN_TX_CTRL    (LEN_TX_CTRL)     ,
	.LEN_CODED_BLOCK(LEN_TX_CODED) ,
	.LEN_TX_DATA    (LEN_TX_DATA)
 	)
u_encoder_comparator
	(
	.i_clock   (tb_clock)    ,
	.i_reset   (tb_reset)    ,
	.i_enable  (tb_enable)   ,
	.i_tx_ctrl (tb_tx_ctrl)  ,
	.i_tx_data (tb_tx_data)  ,
	.o_tx_type  (tb_o_type)  ,
	.o_tx_coded(tb_tx_coded)
	);
	
endmodule