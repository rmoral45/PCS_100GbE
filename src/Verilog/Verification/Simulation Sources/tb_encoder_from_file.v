`timescale 1ns/100ps

module tb_encoder_comparator   ;

parameter LEN_TX_CTRL           = 8;
parameter LEN_TX_DATA           = 64;
parameter LEN_TX_TYPE           = 4;
parameter LEN_CODED_BLOCK       = 66;
parameter LEN_RX_DATA           = 64;
parameter LEN_RX_CTRL           = 8;
parameter LEN_TYPE              = 4;
parameter SEED                  = 58'd0;

//REGISTROS GENERALES
reg                             tb_clock;
reg                             tb_reset;
reg                             tb_enable;
reg                             tb_bypass;
reg                             tb_enable_files;
reg  [LEN_TX_DATA-1 : 0]        counter;
//REGISTROS PARA ENCODER FROM FILE
reg  [LEN_TX_CTRL-1:0]          tb_tx_ctrl;
reg  [LEN_TX_DATA-1:0]          tb_tx_data;
reg  [0 : LEN_TX_CTRL-1]        temp_tx_ctrl;
reg  [0 : LEN_TX_DATA-1]        temp_tx_data;

//REGISTROS PARA ENCODER_FSM
wire [LEN_CODED_BLOCK-1:0]      tb_tx_coded;
wire [LEN_CODED_BLOCK-1:0]      tb_fsm_tx_coded;
wire [LEN_TYPE-1 : 0]           tb_o_type;

//REGISTROS PARA DECODER
wire [LEN_RX_DATA-1 : 0]        tb_rx_data;
wire [LEN_RX_CTRL-1 : 0]        tb_rx_ctrl;
wire [LEN_TYPE-1:0]             tb_rx_type;

//REGISTROS PARA DECODER_FSM
wire [LEN_TYPE-1:0]             tb_rtype_out;
wire [LEN_TYPE-1:0]             tb_rtype_next_out;

//REGISTROS DE SALIDA DEL DECODER (TO CGMII)
wire [LEN_RX_DATA-1 : 0]        tb_rx_raw_data;
wire [LEN_RX_CTRL-1 : 0]        tb_rx_raw_ctrl;


//REGISTROS PARA SCRAMBLING/DESCRAMBLING
wire [LEN_CODED_BLOCK-1 : 0]    tb_scrambled_data;
wire [LEN_CODED_BLOCK-1 : 0]    tb_descrambled_data;

//VARIABLES PARA ARCHIVOS
integer                         fid_tx_data;
integer                         fid_tx_data1;
integer                         fid_tx_ctrl;
integer                         fid_tx_coded;
integer                         fid_tx_coded_out;
integer                         fid_tx_scrambled_out;
integer                         fid_tx_descrambled_out;
integer                         fid_tx_decoded_data_out;
integer                         fid_tx_decoded_ctrl_out;
integer                         code_error_data;
integer                         code_error_ctrl;
integer                         ptr_data;
integer                         ptr_ctrl;

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
        
    fid_tx_coded_out = $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/file_generator/verilog_outputs/verilog-coded-output.txt", "w");
        if(fid_tx_coded_out==0)
        begin
           $display("\n\nLa entrada para Tx-Coded-Output no pudo ser abierta\n\n");
           $stop;
        end

    fid_tx_scrambled_out = $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/file_generator/verilog_outputs/verilog-scrambled-output.txt", "w");
        if(fid_tx_scrambled_out==0)
        begin
           $display("\n\nLa entrada para Tx-Scrambled-Output no pudo ser abierta\n\n");
           $stop;
        end           

    fid_tx_descrambled_out = $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/file_generator/verilog_outputs/verilog-descrambled-output.txt", "w");
        if(fid_tx_descrambled_out==0)
        begin
           $display("\n\nLa entrada para Tx-Descrambled-Output no pudo ser abierta\n\n");
           $stop;
        end
        

    fid_tx_decoded_data_out = $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/file_generator/verilog_outputs/verilog-decoded-data-outputgggggg.txt", "w");
        if(fid_tx_decoded_data_out==0)
        begin
           $display("\n\nLa entrada para Tx-Decoded-Data-Output no pudo ser abierta\n\n");
           $stop;
        end
 

     fid_tx_decoded_ctrl_out = $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/file_generator/verilog_outputs/verilog-decoded-ctrl-output.txt", "w");
         if(fid_tx_decoded_ctrl_out==0)
         begin
            $display("\n\nLa entrada para Tx-Decoded-Ctrl-Output no pudo ser abierta\n\n");
            $stop;
         end
           
     fid_tx_data1= $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/file_generator/verilog_outputs/para_comparar.txt", "w");
         if(fid_tx_data1==0)
         begin
            $display("\n\nLa entrada para Tx-Data no pudo ser abierta\n\n");
            $stop;
         end     
           
      tb_reset        = 1'b1 ;
      tb_clock        = 1'b1 ;
      tb_bypass       = 1'b0 ;
      tb_enable       = 1'b0 ;
      counter         = {LEN_TX_DATA{1'b0}};
      tb_enable_files = 1'b0 ;
#6    tb_reset        = 1'b0 ;
      tb_enable       = 1'b1 ;
      tb_enable_files = 1'b1 ;
      tb_enable_files = 1'b1 ;       
#100000 $finish;

end


always #1 tb_clock = ~tb_clock;

always @ (posedge tb_clock)
begin
    
    if(tb_enable_files)
    begin

        for(ptr_ctrl = 0; ptr_ctrl < LEN_TX_CTRL ; ptr_ctrl = ptr_ctrl+1)
        begin
                code_error_ctrl <= $fscanf(fid_tx_ctrl, "%b\n", temp_tx_ctrl[ptr_ctrl]);
                if(code_error_ctrl != 1 )
                    $display("\n\nTx-Ctrl: El caracter leido no es valido..\n\n");
        end
    
        for(ptr_data = 0; ptr_data < LEN_TX_DATA ; ptr_data = ptr_data+1)
        begin
                code_error_data <= $fscanf(fid_tx_data, "%b\n", temp_tx_data[ptr_data]);
                if(code_error_data != 1 )
                    $display("Tx-Data: El caracter leido no es valido..");
        end                                
 
        $fwrite(fid_tx_coded_out, "%b\n", tb_fsm_tx_coded);
          
        $fwrite(fid_tx_scrambled_out, "%b\n", tb_scrambled_data);
            
        $fwrite(fid_tx_descrambled_out, "%b\n", tb_descrambled_data);
     
        $fwrite(fid_tx_decoded_data_out, "%b\n", tb_rx_raw_data);      
                       
        $fwrite(fid_tx_decoded_ctrl_out, "%b\n", tb_rx_raw_ctrl);
         
        $fwrite(fid_tx_data1, "%b\n", tb_tx_data); 

        tb_tx_ctrl <= temp_tx_ctrl;
        tb_tx_data <= temp_tx_data;
        
        counter <= counter + 1;

    end
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
scrambler
    #(
     .SEED(SEED)
     )
u_scrambler
     (
     .i_clock   (tb_clock)    ,
     .i_reset   (tb_reset)    ,
     .i_enable  (tb_enable)   ,
     .i_bypass   (tb_bypass)  ,
     .i_data    (tb_fsm_tx_coded),
     .o_data     (tb_scrambled_data)
     );
descrambler
    #(
     .SEED(SEED) 
     )
u_descrambler
     (
     .i_clock   (tb_clock)              ,
     .i_reset   (tb_reset)              ,
     .i_enable  (tb_enable)             ,
     .i_bypass  (tb_bypass)             ,
     .i_data    (tb_scrambled_data)     ,
     .o_data    (tb_descrambled_data)
     );

decoder_comparator
    #(
     .LEN_RX_CTRL    (LEN_RX_CTRL)     ,
     .LEN_CODED_BLOCK(LEN_CODED_BLOCK) ,
     .LEN_RX_DATA    (LEN_RX_DATA)
     )
u_decoder_comparator
     (
     .i_clock    (tb_clock)             ,
     .i_reset    (tb_reset)             ,
     .i_enable   (tb_enable)            ,
     .i_rx_coded (tb_descrambled_data)  ,
     .o_rx_data  (tb_rx_data)           ,
     .o_rx_ctrl  (tb_rx_ctrl)           ,  
     .o_rx_type  (tb_rx_type)
     );
    
decoder_fsm_interface
    #(
    .LEN_TYPE(LEN_TYPE)
     )
u_decoder_interface
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
u_decoder_fsm
     (
     .i_clock        (tb_clock)          ,
     .i_reset        (tb_reset)          ,
     .i_enable       (tb_enable)         ,
     .i_r_type       (tb_rtype_out)      ,
     .i_r_type_next  (tb_rtype_next_out) ,
     .i_rx_data      (tb_rx_data)        ,
     .i_rx_control      (tb_rx_ctrl)     ,
     .o_rx_raw_data  (tb_rx_raw_data)    ,
     .o_rx_raw_control  (tb_rx_raw_ctrl)
     );
   
endmodule