/*Se tendran 2 brams, una de 66 bits de largo de palabra para almacenar el bloque codificado
  y otra de 4 bits de largo de palabra para almacenar el tipo de bloque codificado. 
  Se utilizara el mismo controlador para ambas brams.
*/

module bram_encoder_control
#(
	parameter 								RAM_WIDTH_ENCODER 		= 66,
	parameter								RAM_WIDTH_TYPE			= 4,
	parameter 								RAM_ADDR_NBIT 			= 5
 )
 (				 
	input 									i_clock,
    input 									i_reset,
    input 									i_run,
    input 									i_read,
    input [RAM_ADDR_NBIT-1 : 0] 			i_address,
    input [RAM_WIDTH_ENCODER-1 : 0]			i_data_encoder,
    input [RAM_WIDTH_TYPE-1 : 0]			i_data_type,

    output reg 								o_mem_full_encoder,
    output reg 								o_mem_full_type,
    output wire [RAM_WIDTH_ENCODER-1 : 0] 	o_data_encoder,
    output wire [RAM_WIDTH_TYPE-1 : 0]		o_data_type
);

	localparam 								RAM_DEPTH = 2**RAM_ADDR_NBIT;

	//La logica de escritura es la misma, se habilitan y deshabilitan ambas memorias al mismo tiempo
	//y se escribe y se lee sobre la misma direccion en las dos memorias al mismo tiempo.

    reg [RAM_ADDR_NBIT : 0] 				addr_counter;
    reg [RAM_ADDR_NBIT-1 : 0] 				write_addr;
    reg 									write_enable;
    reg 									run;
    wire 									read_enable = i_read && o_mem_full;
    

    always@(posedge i_clock) 
    begin
        if (i_reset) 
        begin
            addr_counter	  <= 0;
            write_addr 		  <= 0;
            write_enable 	  <= 0;
            run 			  <= 0;
            o_mem_full_type	  <= 1;
            o_mem_full_encoder<= 1;
        end
        else
        begin
      
            run 				 	 <= i_run;		            //detector de flanco de i_run
      
            if (!run && i_run) 
            begin
                addr_counter 	 	 <= 0;
                write_enable 	 	 <= 0;
            	o_mem_full_type		 <= 0;
            	o_mem_full_encoder	 <= 0;                
            end
            else if (!o_mem_full) 
            begin
                if (addr_counter<RAM_DEPTH) 
                begin
                    write_enable 		 <= 1;
                    addr_counter 		 <= addr_counter +1;
                    write_addr 	 		 <= addr_counter[RAM_ADDR_NBIT-1 : 0];
                end
                else 
                begin
            		o_mem_full_type		 <= 0;
            		o_mem_full_encoder	 <= 0;   
                    write_enable 		 <= 0;
                    addr_counter 		 <= addr_counter;
                end
            end
            else 
            begin
                write_enable 		 <= write_enable;
                o_mem_full_type 	 <= o_mem_full_type;
                o_mem_full_encoder 	 <= o_mem_full_encoder;
                addr_counter 		 <= addr_counter;
                write_addr 	 		 <= write_addr;
            end
            
        end
    end


bram_encoder #(
       		.RAM_WIDTH_ENCODER(RAM_WIDTH_ENCODER),
       		.RAM_ADDR_NBIT(RAM_ADDR_NBIT)
   			) 
bram_encoder_u(
       		.i_clock(i_clock),
       		.i_write_enable(write_enable),
       		.i_read_enable(read_enable),
       		.i_write_addr(write_addr),
       		.i_read_addr(i_address),
       		.i_data_encoder(i_data_encoder),
       		.o_data_encoder(o_data_encoder)
   			);

bram_type #(
       		.RAM_WIDTH_TYPE(RAM_WIDTH_TYPE),
       		.RAM_ADDR_NBIT(RAM_ADDR_NBIT)
   			) 
bram_type_u(
       		.i_clock(i_clock),
       		.i_write_enable(write_enable),
       		.i_read_enable(read_enable),
       		.i_write_addr(write_addr),
       		.i_read_addr(i_address),
       		.i_data_encoder(i_data_type),
       		.o_data_encoder(o_data_type)
   		   );
    
endmodule