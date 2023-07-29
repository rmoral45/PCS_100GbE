


module descrambler
#(
	parameter 							LEN_SCRAMBLER   	= 58,
	parameter 							LEN_CODED_BLOCK 	= 66,
	parameter 							SEED			  	= 0
 )
 (
 	input wire  						i_clock,
 	input wire  						i_reset,
 	input wire  						i_enable,
 	input wire                  		i_valid,
 	input wire							i_bypass,
 	input wire  [LEN_CODED_BLOCK-1 : 0]	i_data,
    input wire                          i_tag,
    input wire                  		i_deskew_done,

 	output wire [LEN_CODED_BLOCK-1 : 0] o_data,
 	output wire                         o_valid,
    output wire                         o_tag
 );

//LOCALPARAM
localparam 			   								NB_SH = 2;

//INTERNAL SIGNALS

integer i;
wire 					[NB_SH-1 : 0]				sync_header;
(* keep = "true" *) reg [LEN_CODED_BLOCK-1 : 0] 	output_data;
		    		reg [LEN_CODED_BLOCK-1 : 0] 	descrambled_data;
(* keep = "true" *) reg [LEN_SCRAMBLER-1   : 0] 	descrambler_state;
		    		reg [LEN_SCRAMBLER-1   : 0] 	descrambler_state_next;
reg 												out_bit_N;
reg 												tag;
reg 												valid_d;

wire    				[LEN_CODED_BLOCK-1 : 0]		frame_generated;

assign sync_header = i_data[LEN_CODED_BLOCK-1 -: NB_SH];

//PORTS
assign o_data = output_data;
assign o_tag  = tag;
assign o_valid = valid_d;

//valid registrring
always @(posedge i_clock)
begin
    if(i_reset)
        valid_d <= 1'b0;
    else if(i_enable)
        valid_d <= i_valid;
end

//descrambler state
always @(posedge i_clock)
begin
	if (i_reset)
		descrambler_state <= SEED;
	else if (i_enable && (!i_bypass))
 		descrambler_state <= descrambler_state_next;

end

always @ (posedge i_clock)
begin
    if (i_reset)
        tag <= 0;
    else if (i_enable && i_valid)
        tag <= i_tag;
end

//output
always @ (posedge i_clock)
begin
    if(i_reset)
        output_data <= {LEN_CODED_BLOCK{1'b0}};

 	else if (i_enable && (!i_bypass))begin
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
		out_bit_N = (i_data[i] ^ descrambler_state_next[57-38] ^ descrambler_state_next[0]);
		descrambled_data[i] = out_bit_N;
		descrambler_state_next = {i_data[i],descrambler_state_next[LEN_SCRAMBLER-1 : 1]};
	end
end


frame_generator_rx
u_frame_generator_rx
(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_enable(i_enable & i_deskew_done),
    .i_valid(i_valid),

    .o_data(frame_generated)
);

endmodule
