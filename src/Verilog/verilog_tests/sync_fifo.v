

module  sync_fifo
#(
	parameter NB_DATA = 72,
	parameter NB_ADDR = 5
 )
 (
 	input  wire 				i_clock,
 	input  wire 				i_reset,
 	input  wire 				i_enable,
 	input  wire 				i_write_enb,
 	input  wire 				i_read_enb,
 	input  wire [NB_DATA-1 : 0] i_data,

 	output wire 				o_empty,
 	output wire [NB_DATA-1 : 0] o_data
 );


 //LOCALPARAM
 localparam DEPTH = 2**NB_ADDR;


 //INTERNAL SIGNALS
 reg [NB_ADDR-1 : 0] write_ptr;
 reg [NB_ADDR-1 : 0] read_ptr;



//INSTANCIAS

fifo_memory
	#(
	  	.NB_DATA(NB_DATA),
	  	.NB_ADDR(NB_ADDR)
	 )
	 u_fifo_memory
	 (
	 	.i_clock     (i_clock)    ,
	 	.i_write_enb (i_write_enb),
	 	.i_read_enb  (i_read_enb) ,
	 	.i_write_addr(write_ptr)  ,
	 	.i_read_addr (read_ptr)   ,
	 	.i_data		 (i_data)     ,
	 	.o_data		 (o_data)
	 );



 //Update write pointer
 always @ (posedge i_clock)
 begin
 	if(i_reset)
 		/*
 		   Empieza en 1 para que luego de deletear 20 idles no se pisen los puntros de lectura y escritura,
 		   es la solucion mas simple que encontre ya que todo lo demas funciona correctamente
 		*/
 		write_ptr <= 1; 
 	else if (i_enable && i_write_enb)
 	begin
 		if(write_ptr == DEPTH-1 )
 			write_ptr <= 0;
 		else
 			write_ptr <= write_ptr + 1;
 	end
 end


//Update read pointer
always @ (posedge i_clock)
begin
	if (i_reset)
		read_ptr <= 0;
	else if (i_enable && i_read_enb)
	begin
		if(read_ptr == DEPTH-1 )
 			read_ptr <= 0;
 		else
 			read_ptr <= read_ptr + 1;
	end
end

//PORTS

assign o_empty = (read_ptr == write_ptr) ? 1'b1 : 1'b0;

endmodule