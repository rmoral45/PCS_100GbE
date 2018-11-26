


module descrambler
#(
	parameter LEN_SCRAMBLER   = 58,
	parameter LEN_CODED_BLOCK = 66,
	parameter SEED			  = 0 //verificar de que tamanio
 )
 (
 	input wire  						i_clock,
 	input wire  						i_reset,
 	input wire  						i_enable,
 	input wire							i_bypass,
 	input wire  [LEN_CODED_BLOCK-1 : 0] i_data,

 	output wire [LEN_CODED_BLOCK-1 : 0] o_data
 );

//LOCALPARAM
localparam NB_SH = 2;
//INTERNAL SIGNALS

integer i;
wire [NB_SH-1 : 0]			 sync_header;
reg  [LEN_CODED_BLOCK-1 : 0] output_data;
reg  [LEN_CODED_BLOCK-1 : 0] descrambled_data;

// (* keep = "true" *)reg  [LEN_SCRAMBLER-1   : 0] scrambler_state;
reg  [LEN_SCRAMBLER-1   : 0] descrambler_state;
reg  [LEN_SCRAMBLER-1   : 0] descrambler_state_next;
reg out_bit_N;

assign sync_header = i_data[LEN_CODED_BLOCK-1 -: 2];

//PORTS
assign o_data = output_data;

//descrambler state
always @(posedge i_clock)
begin
	if (i_reset)
		descrambler_state <= SEED;
	else if (i_enable && (!i_bypass))
 		descrambler_state <= descrambler_state_next;


end

//output
 always @ (posedge i_clock)
 begin

 	if (i_enable && (!i_bypass))begin
 		output_data <= descrambled_data;
 	end
 	else if (i_enable &&  i_bypass)begin
 		output_data <= i_data;
 	end
 end


//ALGORITHM BEGIN
always @ *
begin
	out_bit_N = 0;
	descrambled_data = { sync_header,{LEN_CODED_BLOCK-2{1'b0}} };
	descrambler_state_next = descrambler_state;
	for(i=LEN_CODED_BLOCK-3; i>=0; i=i-1)
	begin
		out_bit_N = (i_data[i] ^ descrambler_state_next[38] ^ descrambler_state_next[57]);
		descrambled_data[i] = out_bit_N;
		descrambler_state_next = {i_data[i],descrambler_state_next[LEN_SCRAMBLER-1 : 1]};
	end
end


endmodule