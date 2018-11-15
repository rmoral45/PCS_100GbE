


module dual_port_ram
#(
	parameter NB_DATA = 72,
	parameter NB_ADDR = 5
 )
 (
 	input wire  				i_clock,
 	input wire  				i_wr_enb,
 	input wire  				i_rd_enb,
 	input wire  [NB_DATA-1 : 0] i_data,
 	input wire  [NB_ADDR-1 : 0] i_wr_addr,
 	input wire  [NB_ADDR-1 : 0] i_rd_addr,

 	output wire [NB_DATA-1 : 0] o_data
 );


//LOCALPARAMS

localparam DEPTH = 2**NB_ADDR;


//INTERNAL SIGNALS

reg [NB_DATA-1 : 0]    memory       [0 : DEPTH-1];
reg [NB_DATA-1 : 0]    output_data               ;

//write
always @ ( posedge i_clock )
begin
	if(i_wr_enb)
		memory[i_wr_addr] <= i_data;
end

//read
always @ (posedge i_clock)
begin
	if(i_rd_enb)
		output_data <= memory[i_rd_addr];
end

//PORTS
assign o_data = output_data;


endmodule