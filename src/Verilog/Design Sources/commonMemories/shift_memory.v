module shift_memory
#(
	parameter NB_DATA = 72,
	parameter NB_ADDR = 5
 )
 (
 	input wire  				i_clock,
 	input wire  				i_write_enb,
 	input wire  				i_read_enb, // capas no lo necesito en este nivel
 	input wire  [NB_DATA-1 : 0] i_data,
 	input wire  [NB_ADDR-1 : 0] i_read_addr,

 	output wire [NB_DATA-1 : 0] o_data
 );


 localparam						DEPTH = 2**NB_ADDR;
 integer						i;


reg [NB_DATA-1 : 0]    memory       [0 : DEPTH-1];
reg [NB_DATA-1 : 0]    output_data               ;
reg [NB_DATA-1 : 0]    out               		 ;


//write
always @ (posedge i_clock) 
begin
	if(i_write_enb) 
	begin
		memory[0] <= i_data;	

		for(i = 1; i < DEPTH; i = i+1)
		begin
			memory[i] <= memory[i-1];
		end
	end
end


//read
always @ (posedge i_clock)
begin
	if(i_read_enb)
	begin
		output_data <= memory[i_read_addr];
	end
end


assign o_data = output_data;

endmodule