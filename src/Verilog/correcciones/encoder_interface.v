/*
	este bloque implementa un Mux para seleccion de bloques segun
	las senales de control recibidas desde el bloque que realiza insert/delete
	de idles
*/


module encoder_interface
#(
	parameter LEN_TX_DATA = 64,
	parameter LEN_TX_CTRL = 8 
 )
 (
 	input  wire 					i_valid, // valid signal from idle_insertion block
 	input  wire 					i_am_flag,
 	input  wire [LEN_TX_DATA-1 : 0] i_tx_data,
 	input  wire [LEN_TX_CTRL-1 : 0] i_tx_ctrl,

 	output reg						o_am_flag,
 	output reg  [LEN_TX_DATA-1 : 0] o_tx_data,
 	output reg  [LEN_TX_CTRL-1 : 0] o_tx_ctrl

 );

//LOCALPARAMS

localparam CGMII_IDLE  = 8'h07;
localparam CGMII_ERROR = 8'hFE;

 always @ *
 begin
 	case( {i_am_flag,i_valid} )
 		2'b00:begin//CONDICION DE ERROR
 			o_am_flag = 0; 
 			o_tx_data = {8{CGMII_ERROR}};
 			o_tx_ctrl = 8'hFF;
 		end
 		2'b01:begin//BYPASS
 			o_am_flag = 0; 
 			o_tx_data = i_tx_data ;
 			o_tx_ctrl = i_tx_ctrl;
 		end
 		2'b10:begin //SEND AM IDLE
 			o_am_flag = 1; 
 			o_tx_data = {8{CGMII_IDLE}};
 			o_tx_ctrl = 8'hFF;
 		end
 		2'b11:begin//CONDICION DE ERROR
 			o_am_flag = 0;	
 			o_tx_data = {8{CGMII_ERROR}};
 			o_tx_ctrl = 8'hFF;
 		end
 	endcase

 end

endmodule