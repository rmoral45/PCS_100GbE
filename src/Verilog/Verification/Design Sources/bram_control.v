/*Se tendran 2 brams, una de 66 bits de largo de palabra para almacenar el bloque codificado
  y otra de 4 bits de largo de palabra para almacenar el tipo de bloque codificado. 
  Se utilizara el mismo controlador para ambas brams.
*/

module bram_control
#(
    parameter								                RAM_WIDTH_ENCODER 	= 66,
	  parameter							                  RAM_WIDTH_TYPE			= 4,
	  parameter								                RAM_ADDR_NBIT 			= 5
 )
 (				 
	  input	wire								              i_clock,
    input wire									            i_reset,
    input wire									            i_run,
 //   input wire									            i_read_enb,
 //   input wire  [RAM_ADDR_NBIT-1 : 0] 	    i_read_addr,
    input wire  [RAM_WIDTH_ENCODER-1 : 0]	  i_data_coded,
    input wire  [RAM_WIDTH_TYPE-1 : 0]	    i_data_type,

 //   output wire [RAM_WIDTH_ENCODER-1 : 0]   o_data_coded,
 //   output wire [RAM_WIDTH_TYPE-1 : 0]      o_data_type,
    output reg                              o_mem_full
);

	localparam 								                RAM_DEPTH = 2**RAM_ADDR_NBIT;

	//La logica de escritura es la misma, se habilitan y deshabilitan ambas memorias al mismo tiempo
	//y se escribe y se lee sobre la misma direccion en las dos memorias al mismo tiempo.

    reg [RAM_ADDR_NBIT-1 : 0] 				        addr_counter;
    reg 									                  write_enable;
    reg 									                  run;
   // wire 									                  read_enable = i_read_enb && o_mem_full;
    

    always@(posedge i_clock) 
    begin

        run               <= i_run;               //detector de flanco de i_run 

        if(i_reset) 
        begin
            addr_counter	<= 0;
            write_enable 	<= 0;
            run         <= 0;
            o_mem_full    <= 1;
        end
        else if (!run && i_run) 
        begin 
    
          addr_counter 	 	<= 0;
          write_enable 	 	<= 0;
         	o_mem_full		  <= 0;
        end
        else if(!o_mem_full) 
        begin
                if(addr_counter<RAM_DEPTH) 
                begin
                    write_enable 		 <= 1;
                    addr_counter 		 <= addr_counter +1;
                end
                else if(addr_counter==RAM_DEPTH) 
                begin
            		o_mem_full    		   <= 1; 
                write_enable 		     <= 0;
                addr_counter 		     <= addr_counter;
                end
            end
        else 
        begin
          write_enable 		       <= write_enable;
          o_mem_full       	     <= o_mem_full;
          addr_counter 		       <= addr_counter;
        end

    end


bram #(
      .RAM_WIDTH(RAM_WIDTH_ENCODER),
      .RAM_ADDR_NBIT(RAM_ADDR_NBIT)
   	  ) 
bram_encoder_u(
       		.i_clock(i_clock),
       		.i_write_enable(write_enable),
//       		.i_read_enb_enable(read_enable),
       		.i_write_addr(addr_counter),
//       		.i_read_addr(i_read_addr),
       		.i_data(i_data_coded)
//       		.o_data(o_data_coded)
   			);

bram #(
    	.RAM_WIDTH(RAM_WIDTH_TYPE),
    	.RAM_ADDR_NBIT(RAM_ADDR_NBIT)
   	) 
bram_type_u(
       		.i_clock(i_clock),
       		.i_write_enable(write_enable),
//       		.i_read_enb_enable(read_enable),
       		.i_write_addr(addr_counter),
//       		.i_read_addr(i_read_addr),
       		.i_data(i_data_type)
//       		.o_data(o_data_type)
   		   );
    
endmodule