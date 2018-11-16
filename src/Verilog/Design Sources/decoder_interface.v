/*

este bloque tiene como entrada un bloque codificado y como salida
el bloque actual y el bloque previo,cada salida va a un bloque comparador para aplicar la funcion
R_TYPE y R_TYPE_NEXT

*/

module decoder_interface
#(
	parameter LEN_CODED_BLOCK = 66,
    parameter LEN_RX_DATA 	  =	64,
    parameter LEN_RX_CTRL 	  = 8
 )
 (
 	input wire  						i_clock,
 	input wire  						i_reset,
 	input wire  						i_enable,
 	input wire  [LEN_CODED_BLOCK-1 : 0] i_rx_coded,

 	output wire [LEN_CODED_BLOCK-1 : 0] o_rx_coded,
 	output wire [LEN_CODED_BLOCK-1 : 0] o_rx_coded_next
 );

 reg [LEN_CODED_BLOCK-1 : 0] rx_coded;
 reg [LEN_CODED_BLOCK-1 : 0] rx_coded_next;


 assign o_rx_coded      = rx_coded;
 assign o_rx_coded_next = rx_coded_next;


 always @ (posedge i_clock)
 begin

 	if(i_reset)
 	begin
 		rx_coded      <= {LEN_CODED_BLOCK{1'b0}};
 		rx_coded_next <= {LEN_CODED_BLOCK{1'b0}};
 	end
 	else if(i_enable)
 	begin
 		rx_coded      <= rx_coded_next;
 		rx_coded_next <= i_rx_coded;
 	end

 end

endmodule 