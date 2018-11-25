module bram
#(
	parameter 							RAM_WIDTH         	= 66,
	parameter 							RAM_ADDR_NBIT 		= 5
 )
 (				 
	input wire							i_clock,
	input wire							i_write_enable,
	input wire							i_read_enable,
	input wire	[RAM_ADDR_NBIT-1 : 0]	i_write_addr,
	input wire	[RAM_ADDR_NBIT-1 : 0]	i_read_addr,
	input wire 	[RAM_WIDTH-1 : 0] 	    i_data,
	output reg 	[RAM_WIDTH-1 : 0] 	    o_data
);

	localparam 							RAM_DEPTH = 2**RAM_ADDR_NBIT;

    reg			[RAM_WIDTH-1 : 0] 	    bram [RAM_DEPTH-1 : 0];


    always@(posedge i_clock) 
    begin
        if(i_write_enable) 
        	bram[i_write_addr] <= i_data;
    end

    always @(posedge i_clock) 
    begin
        if(i_read_enable) 
        	o_data <= bram[i_read_addr];	
    end

endmodule