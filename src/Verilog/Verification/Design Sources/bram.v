module bram
#(
	parameter                           NB_WORD_RAM        = 66,
	parameter 							NB_ADDR_RAM 	   = 5
 )
 (				 
	input wire							i_clock,
	input wire							i_write_enable,
	input wire							i_read_enable,
	input wire	[NB_ADDR_RAM-1 : 0]	    i_write_addr,
	input wire	[NB_ADDR_RAM-1 : 0]	    i_read_addr,
	input wire 	[NB_WORD_RAM-1 : 0]     i_data,
	output reg 	[NB_WORD_RAM-1 : 0]     o_data
);

	localparam 							RAM_DEPTH = 2**NB_ADDR_RAM;

    reg			[NB_WORD_RAM-1 : 0]     bram [RAM_DEPTH-1 : 0];


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