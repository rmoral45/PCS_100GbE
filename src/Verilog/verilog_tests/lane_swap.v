/*
	Basicamente un multiplexor de N entradas de 66 bits.
	Recibe como entrada las 20 lanes de recepcion,cada una de 66bits
	y da como salida una de las lanes segun lo indicado
	por la entrada ID
*/


module lane_swap
#(
	parameter NB_CODED_BLOCK = 66,
	parameter N_LANES		 = 20,
	parameter NB_ID			 = $clog2(N_LANES)
 )
 (
 	input  wire [NB_CODED_BLOCK*N_LANES-1 : 0] 	i_data,
 	input  wire [NB_ID-1 : 0] 					i_ID,

 	output wire [NB_CODED_BLOCK-1 : 0] 			o_data
 );

assign	o_data =(i_ID < N_LANES) ? i_data[(i_ID*NB_CODED_BLOCK ) +: NB_CODED_BLOCK] : {NB_CODED_BLOCK{1'b1}} ;

endmodule