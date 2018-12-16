


module rom_memory;
#(
   parameter ROM_WIDTH = 64;
   parameter ROM_ADDR_BITS = 5;
   parameter FILE = ""
 )

 (
   input  wire                       i_clock,
   input  wire [ROM_ADDR_BITS-1 : 0] i_read_addr,
   input  wire                       i_enable,

   output wire [ROM_WIDTH-1 : 0]     o_data
 );
 
   reg [ROM_WIDTH-1:0] ROM [(2**ROM_ADDR_BITS)-1:0];
   reg [ROM_WIDTH-1:0] output_data;

   initial
      $readmemb(FILE, ROM, 0, (2**ROM_ADDR_BITS)-1);

   always @(posedge i_clock)
      if(i_enable)
         output_data <= ROM [i_read_addr];
				