/*Se tendran 2 brams, una de 66 bits de largo de palabra para almacenar el bloque codificado
  y otra de 4 bits de largo de palabra para almacenar el tipo de bloque codificado. 
  Se utilizara el mismo controlador para ambas brams.
*/

module bram_driver
  #(
    parameter                               NB_WORD_RAM         = 64,
    parameter                               RAM_DEPTH           = 16,
    parameter                               NB_ADDR_RAM         = $clog2(RAM_DEPTH)
    )
    (				 
    input wire								i_clock,
    input wire								i_reset,
    input wire								i_run,
    input wire								i_read_enb,
    input wire  [NB_ADDR_RAM-1 : 0] 	    i_read_addr,
    input wire  [NB_WORD_RAM-1 : 0]	        i_data,
    output wire [NB_WORD_RAM-1 : 0]         o_data,
    output reg                              o_mem_full
    );

	//La logica de escritura es la misma, se habilitan y deshabilitan ambas memorias al mismo tiempo
	//y se escribe y se lee sobre la misma direccion en las dos memorias al mismo tiempo.

    reg         [NB_ADDR_RAM-1 : 0]	        addr_counter;
    reg 									write_enable;
    reg 									run;
    reg                                     write_control;
    wire 									read_enable;
    assign read_enable = i_read_enb & o_mem_full;
    

    always@(posedge i_clock)
    begin
        run <= i_run;
        
        if(i_reset)
        begin
            write_enable <= 0;
            write_control <= 0;
        end
        else if(!run && i_run)
        begin
            write_enable <= 1;
            write_control <= 1;
        end
        else if(!run && i_run && write_control)
        begin
            write_enable <= 0;
            write_control <= write_control;
        end
    end
   

    always@(posedge i_clock) 
    begin
        if(i_reset) 
        begin
            addr_counter	<= 0;
            o_mem_full      <= 0;
        end
        /*else if (!run && i_run) 
        begin 
    
          addr_counter 	 	<= 0;
          write_enable 	 	<= 1;
          o_mem_full		<= 0;
        end*/
        else if(!write_enable && write_control) 
        begin
                if(addr_counter<RAM_DEPTH) 
                begin
                //    write_enable 		 <= 1;
                    addr_counter 		 <= addr_counter +1;
                    write_control        <= write_control;
                end
                else if(addr_counter==RAM_DEPTH-1) 
                begin
                o_mem_full               <= 1; 
          //      write_enable 		     <= 0;
                addr_counter 		     <= addr_counter;
                write_control           <= 0;
                end
        end
       /* else 
        begin
          write_enable 		<= write_enable;
          o_mem_full       	<= o_mem_full;
          addr_counter 		<= addr_counter;
        end*/

    end


bram#(
    .NB_WORD_RAM(NB_WORD_RAM),
    .RAM_DEPTH(RAM_DEPTH),
    .NB_ADDR_RAM(NB_ADDR_RAM)
   	) 
u_bram
    (
    .i_clock(i_clock),
    .i_write_enable(write_enable),
    .i_read_enable(read_enable)  ,
    .i_write_addr(addr_counter)  ,
    .i_read_addr(i_read_addr)    ,
    .i_data(i_data)              ,
    .o_data(o_data)
   	);
endmodule