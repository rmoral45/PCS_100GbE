module bram_encoder
#(
	parameter 								RAM_WIDTH_ENCODER 	= 66,
	parameter 								RAM_ADDR_NBIT 		= 5
 )
 (				 
	input 									i_clock,
	input 									i_write_enable,
	input 									i_read_enable,
	input 		[RAM_ADDR_NBIT-1 : 0]		i_write_addr,
	input 		[RAM_ADDR_NBIT-1 : 0]		i_read_addr,
	input 		[RAM_WIDTH_ENCODER-1 : 0] 	i_data_encoder,
	output reg 	[RAM_WIDTH_ENCODER-1 : 0] 	o_data_encoder
);

	localparam 								RAM_DEPTH = 2**RAM_ADDR_NBIT;

    reg			[RAM_WIDTH_ENCODER-1 : 0]	bram [RAM_DEPTH-1 : 0];


    always@(posedge i_clock) 
    begin
        if(i_write_enable) 
        	bram[i_write_addr] <= i_data_encoder;
    end

    always @(posedge i_clock) 
    begin
        if(i_read_enable) 
        	o_data_encoder <= bram[i_read_addr];	
    end

endmodule