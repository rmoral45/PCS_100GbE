

module rom_mem_ctrl
#(
 	parameter LEN_DATA_BLOCK = 64,
 	parameter ROM_DEPTH      = 1024,
   	parameter NB_ADDR_ROM    = $clog2(ROM_DEPTH),
   	parameter FILE = ""
 )
 (
 	input  wire 				  		i_clock,
 	input  wire 				  		i_reset,
 	input  wire 				  		i_enable,

 	output wire [LEN_DATA_BLOCK-1 : 0] 	o_data
 );

 reg [NB_ADDR_ROM-1 : 0] read_ptr;
 reg					 rom_enable;

 always @ (posedge i_clock)
 begin
 	if(i_reset)
 	begin
 		read_ptr <= {NB_ADDR_ROM{1'b0}};
 		rom_enable <= 1;
 	end
 	else if (i_enable)
 	begin
 		if(read_ptr == ROM_DEPTH - 1)
 		begin
 			read_ptr <= read_ptr;
 			rom_enable <= 0;
 		end
 		else
 			read_ptr <= read_ptr + 1;
 	end
 end

//Instances

rom_memory
#(
	.ROM_WIDTH(LEN_DATA_BLOCK),
	.ROM_ADDR_BITS(NB_ADDR_ROM),
	.FILE(FILE)
 )
	u_rom_memory
	(
		.i_clock(i_clock),
		.i_read_addr(read_ptr),
		.i_enable(rom_enable),

		.o_data(o_data)
	);



 endmodule



