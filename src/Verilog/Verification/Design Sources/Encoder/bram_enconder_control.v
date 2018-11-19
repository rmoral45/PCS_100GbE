module bram_encoder_control
#(
	parameter 						RAM_WIDTH 	= 32,
	parameter 						RAM_ADDR_NBIT = 5
 )
 (				 
	input 							i_clock,
    input 							i_reset,
    input 							i_run,
    input 							i_read,
    input [RAM_ADDR_NBIT-1 : 0] 	i_address,
    input [RAM_WIDTH-1 : 0] 		i_data,

    output reg 						o_mem_full,
    output wire [RAM_WIDTH-1 : 0] 	o_data
);

	localparam 						RAM_DEPTH = 2**RAM_ADDR_NBIT;

    reg [RAM_ADDR_NBIT : 0] 		addr_counter;
    reg [RAM_ADDR_NBIT-1 : 0] 		write_addr;
    reg 							write_enable;
    reg 							run;

    wire 							read_enable = i_read && o_mem_full;
    

    always@(posedge i_clock) 
    begin
        if (i_reset) 
        begin
            addr_counter		 <= 0;
            write_addr 			 <= 0;
            o_mem_full 			 <= 1;
            write_enable 		 <= 0;
            run 				 <= 0;
        end
        else
        begin
            run 				 <= i_run;
            //detector de flanco de i_run
            if (!run && i_run) 
            begin
                addr_counter 	 <= 0;
                o_mem_full 	 	 <= 0;
                write_enable 	 <= 0;
            end
            else if (!o_mem_full) 
            begin
                if (addr_counter<RAM_DEPTH) 
                begin
                    write_enable <= 1;
                    addr_counter <= addr_counter +1;
                    write_addr 	 <= addr_counter[RAM_ADDR_NBIT-1 : 0];
                end
                else 
                begin
                    o_mem_full 	 <= 1;
                    write_enable <= 0;
                    addr_counter <= addr_counter;
                end
            end
            else 
            begin
                write_enable 	<= write_enable;
                o_mem_full 	 	<= o_mem_full;
                addr_counter 	<= addr_counter;
                write_addr 	 	<= write_addr;
            end
            
        end
    end

    bram_encoder #(
        		.RAM_WIDTH(RAM_WIDTH),
        		.RAM_ADDR_NBIT(RAM_ADDR_NBIT)
    			) 
    bram_encoder_u(
        		.i_clock(i_clock),
        		.i_write_enable(write_enable),
        		.i_read_enable(read_enable),
        		.i_write_addr(write_addr),
        		.i_read_addr(i_address),
        		.i_data(i_data),
        		.o_data(o_data)
    			);
    
endmodule