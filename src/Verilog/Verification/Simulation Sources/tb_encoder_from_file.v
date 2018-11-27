`timescale 1ns/100ps

module tb_encoder_comparator   ;

parameter LEN_TX_CTRL 		    = 8;
parameter LEN_TX_DATA 		    = 64;
parameter LEN_TX_TYPE		    = 4;
parameter LEN_CODED_BLOCK       = 66;
parameter LEN_RX_DATA           = 64;
parameter LEN_RX_CTRL           = 8;
parameter LEN_TYPE              = 4;


//REGISTROS GENERALES
reg                             tb_clock;
reg                             tb_reset;
reg                             tb_enable;

//REGISTROS PARA ENCODER FROM FILE
reg  [LEN_TX_CTRL-1:0]          tb_tx_ctrl;
reg  [LEN_TX_DATA-1:0]          tb_tx_data;
reg  [0 : LEN_TX_CTRL-1]        temp_tx_ctrl;
reg  [0 : LEN_TX_DATA-1]        temp_tx_data;
reg  [0 : LEN_CODED_BLOCK-1]    temp_tx_coded;

//REGISTROS PARA ENCODER_FSM
wire [LEN_CODED_BLOCK-1:0]      tb_tx_coded;
wire [LEN_CODED_BLOCK-1:0]      tb_fsm_tx_coded;
wire [LEN_TYPE-1 : 0] 	        tb_o_type;

//REGISTROS PARA DECODER
wire [LEN_CODED_BLOCK-1 : 0]    tb_rx_coded;
wire [LEN_CODED_BLOCK-1 : 0]    tb_rx_coded_next;
wire [LEN_RX_DATA-1 : 0]        tb_rx_data;
wire [LEN_RX_CTRL-1 : 0]        tb_rx_ctrl;
wire [LEN_TYPE-1:0]             tb_rx_type;

//REGISTROS PARA DECODER_FSM
wire [LEN_TYPE-1:0]             tb_rtype_out;
wire [LEN_TYPE-1:0]             tb_rtype_next_out;

//REGISTROS DE SALIDA DEL DECODER (TO CGMII)
wire [LEN_RX_DATA-1 : 0]        tb_rx_raw_data;
wire [LEN_RX_CTRL-1 : 0]        tb_rx_raw_ctrl;

integer                         fid_tx_data;
integer                         fid_tx_ctrl;
integer                         fid_tx_coded;
integer                         code_error_data;
integer                         code_error_ctrl;
integer                         code_error_coded;
integer                         ptr_data;
integer                         ptr_ctrl;
integer                         ptr_coded;

initial
begin
	
	fid_tx_ctrl= $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/file_generator/encoder-input-ctrl.txt", "r");
		if(fid_tx_ctrl==0)
		begin
			$display("\n\nLa entrada para Tx-Ctrl no pudo ser abierta\n\n");
			$stop;
		end
	fid_tx_data= $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/file_generator/encoder-input-data.txt", "r");
		if(fid_tx_data==0)
		begin
			$display("\n\nLa entrada para Tx-Data no pudo ser abierta\n\n");
			$stop;
		end
		
	fid_tx_coded= $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/file_generator/encoder-output.txt", "r");
        if(fid_tx_coded==0)
        begin
           $display("\n\nLa entrada para Tx-Coded no pudo ser abierta\n\n");
           $stop;
        end

	tb_reset  = 1'b1 ;
	tb_clock  = 1'b0 ;
	tb_enable = 1'b0 ;
	tb_enable = 1'b1 ;
#6	tb_reset  = 1'b0 ;
end


always #2 tb_clock = ~tb_clock;

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
        
        for(ptr_coded = 0; ptr_coded < LEN_CODED_BLOCK ; ptr_coded = ptr_coded+1)
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
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK) ,
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

encoder_fsm
    #(
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK)
     )
u_encoder_fsm
    (
    .i_clock   (tb_clock)    ,
    .i_reset   (tb_reset)    ,
    .i_enable  (tb_enable)   ,
    .i_tx_type (tb_o_type)   ,
    .i_tx_coded(tb_tx_coded) ,
    .o_tx_coded(tb_fsm_tx_coded)
    );

decoder_comparator
    #(
	.LEN_RX_CTRL    (LEN_RX_CTRL)     ,
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK) ,
    .LEN_RX_DATA    (LEN_RX_DATA)
    )
u_decoder_comparator
    (
    .i_clock    (tb_clock)          ,
    .i_reset    (tb_reset)          ,
    .i_enable   (tb_enable)         ,
    .i_rx_coded (tb_fsm_tx_coded)   ,
    .o_rx_data  (tb_rx_data)        ,
    .o_rx_ctrl  (tb_rx_ctrl)        ,
    .o_rx_type  (tb_rx_type)
    );
    
    
decoder_fsm_interface
    #(
    .LEN_TYPE(LEN_TYPE)
    )
    (
    .i_clock        (tb_clock)          ,
    .i_reset        (tb_reset)          ,
    .i_enable       (tb_enable)         ,
    .i_r_type       (tb_rx_type)        ,
    .o_r_type       (tb_rtype_out)      ,
    .o_r_type_next  (tb_rtype_next_out) 
    );
    
decoder_fsm
    #(
    .LEN_RX_DATA(LEN_RX_DATA),
    .LEN_RX_CTRL(LEN_RX_CTRL)
    )
    (
    .i_clock        (tb_clock)          ,
    .i_reset        (tb_reset)          ,
    .i_enable       (tb_enable)         ,
    .i_r_type       (tb_rtype_out)      ,
    .i_r_type_mext  (tb_rtype_next_out) ,
    .i_rx_data      (tb_rx_data)        ,
    .i_rx_ctrl      (tb_rx_ctrl)        ,
    .o_rx_raw_data  (tb_rx_raw_data)    ,
    .o_rx_raw_ctrl  (tb_rx_raw_ctrl)
    );
   
endmodule