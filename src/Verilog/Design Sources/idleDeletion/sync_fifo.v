`timescale 1ns/100ps
//[FIX] Agregar i_valid
module  sync_fifo
#(
	parameter NB_DATA = 72,
	parameter NB_ADDR = 5,
	parameter WR_PTR_AFTER_RESET = 0
 )
 (
 	input  wire 				i_clock,
 	input  wire 				i_reset,
 	input  wire 				i_enable,
 	input  wire                 i_valid,
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

 wire fifo_empty;

 assign fifo_empty = (read_ptr == write_ptr) ? 1'b1 : 1'b0;





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
	 	//.i_read_enb  (i_read_enb) ,
	 	.i_write_addr(write_ptr)  ,
	 	.i_read_addr (read_ptr)   ,
	 	.i_data		 (i_data)     ,
	 	.o_data		 (o_data)
	 );



 //Update write pointer
 always @ (posedge i_clock)
 begin
 	if(i_reset || ~i_enable || fifo_empty)
 		write_ptr <= WR_PTR_AFTER_RESET; 
 	else if ( i_write_enb && i_valid)
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
	if (i_reset || ~i_enable || fifo_empty )
		read_ptr <= 0;
	else if ( i_read_enb && i_valid)
	begin
		if(read_ptr == DEPTH-1 )
 			read_ptr <= 0;
 		else
 			read_ptr <= read_ptr + 1;
	end
end

//PORTS

assign o_empty = fifo_empty;

endmodule