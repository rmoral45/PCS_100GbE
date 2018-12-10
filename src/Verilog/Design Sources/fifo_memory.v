


module fifo_memory
#(
	parameter NB_DATA = 72,
	parameter NB_ADDR = 5
 )
 (
 	input wire  				i_clock,
 	input wire  				i_write_enb,
 	input wire  				i_read_enb, // capas no lo necesito en este nivel
 	input wire  [NB_DATA-1 : 0] i_data,
 	input wire  [NB_ADDR-1 : 0] i_write_addr,
 	input wire  [NB_ADDR-1 : 0] i_read_addr,

 	output wire [NB_DATA-1 : 0] o_data
 );


//LOCALPARAMS

localparam DEPTH = 2**NB_ADDR;


//INTERNAL SIGNALS

reg [NB_DATA-1 : 0]    memory       [0 : DEPTH-1];
reg [NB_DATA-1 : 0]    output_data               ;
reg [NB_DATA-1 : 0]    out               		 ;


//write
always @ ( posedge i_clock )
begin
	if(i_write_enb)
		memory[i_write_addr] <= i_data;
end

/*
//read

always @ (posedge i_clock)
begin
	if(i_read_enb)
		output_data <= memory[i_read_addr];
		
		out <= output_data; //registro auxiliar usado p mejorar el timing de la memoria,es eliminado en la sintesis pero
							//la herramienta interpreta que quiero una BRAM con la salida registrada y deja de dar advertencias
							//de timing en la sintesis
		
end
*/

//PORTS
assign o_data = memory[i_read_addr];
//assign o_data = output_data;
endmodule