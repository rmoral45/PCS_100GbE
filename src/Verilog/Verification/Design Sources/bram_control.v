/*Se tendran 2 brams, una de 66 bits de largo de palabra para almacenar el bloque codificado
  y otra de 4 bits de largo de palabra para almacenar el tipo de bloque codificado. 
  Se utilizara el mismo controlador para ambas brams.
*/

module bram_control
  #(
    parameter                               LEN_CODED_BLOCK     = 66,
    parameter								LEN_DATA_BLOCK 	    = 64,
	parameter        					    LEN_CTRL_BLOCK		= 8,
	parameter                               LEN_TYPE            = 4,
	parameter								NB_ADDR_RAM 		= 5
    )
    (				 
    input wire								i_clock,
    input wire								i_reset,
    input wire								i_run,
    input wire								i_read_enb,
    input wire  [NB_ADDR_RAM-1 : 0] 	    i_read_addr,
    input wire  [LEN_CODED_BLOCK-1 : 0]	    i_data_decoded,
    input wire  [LEN_TYPE-1 : 0]	        i_ctrl_decoded,
    output wire [LEN_CODED_BLOCK-1 : 0]     o_data_decoded,
    output wire [LEN_TYPE-1 : 0]            o_ctrl_decoded,
    output reg                              o_mem_full
    );

	localparam 								RAM_DEPTH = 2**NB_ADDR_RAM;

	//La logica de escritura es la misma, se habilitan y deshabilitan ambas memorias al mismo tiempo
	//y se escribe y se lee sobre la misma direccion en las dos memorias al mismo tiempo.

    reg         [NB_ADDR_RAM-1 : 0]	    addr_counter;
    reg 									write_enable;
    reg 									run;
    wire 									read_enable = i_read_enb && o_mem_full;
    

    always@(posedge i_clock) 
    begin

        run               <= i_run;               //detector de flanco de i_run 

        if(i_reset) 
        begin
            addr_counter	<= 0;
            write_enable 	<= 0;
            run             <= 0;
            o_mem_full      <= 0;
        end
        else if (!run && i_run) 
        begin 
    
          addr_counter 	 	<= 0;
          write_enable 	 	<= 0;
         	o_mem_full		<= 0;
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
                o_mem_full               <= 1; 
                write_enable 		     <= 0;
                addr_counter 		     <= addr_counter;
                end
            end
        else 
        begin
          write_enable 		<= write_enable;
          o_mem_full       	<= o_mem_full;
          addr_counter 		<= addr_counter;
        end

    end


bram#(
    .NB_WORD_RAM(LEN_DATA_BLOCK),
    .NB_ADDR_RAM(NB_ADDR_RAM)
   	) 
u_data_bram
    (
    .i_clock(i_clock),
    .i_write_enable(write_enable),
    .i_read_enable(read_enable),
    .i_write_addr(addr_counter),
    .i_read_addr(i_read_addr),
    .i_data(i_data_decoded),
    .o_data(o_data_decoded)
   	);

bram#(
    .NB_WORD_RAM(LEN_TYPE),
    .NB_ADDR_RAM(NB_ADDR_RAM)
   	) 
u_ctrl_bram
    (
    .i_clock(i_clock),
    .i_write_enable(write_enable),
    .i_read_enable(read_enable),
    .i_write_addr(addr_counter),
    .i_read_addr(i_read_addr),
    .i_data(i_ctrl_decoded),
    .o_data(o_ctrl_decoded)
   	);
    
endmodule