`timescale 1ns/100ps
module scrambler
#(
	parameter NB_SCRAMBLER   = 58,
	parameter NB_DATA_CODED = 66,
	parameter NB_DATA_TAGGED	= 67,
	parameter NB_SH 	  = 2,
	parameter SEED		  = 0
 )
 (
 	input wire  						i_clock,
 	input wire  						i_reset,
 	input wire  						i_enable,
	input wire							i_valid,
 	input wire							i_bypass,		//OR entre señal del RF y alligner_tag
    input wire							i_alligner_tag,
	input wire						i_idle_pattern_mode,
 	input wire  [NB_DATA_CODED-1 : 0] 			i_data,

 	output wire [NB_DATA_TAGGED-1 : 0] 			o_data
 );

//LOCALPARAMS
localparam [NB_DATA_CODED-1 : 0] IDLE_BLOCK = 66'h21E00000000000000;

//INTERNAL SIGNALS
integer i;
wire [NB_SH-1 : 0]				 sync_header;
(* keep = "true" *) reg  [NB_DATA_CODED-1 : 0] output_data;
reg  [NB_DATA_CODED-1 : 0] scrambled_data; 
reg  [NB_DATA_CODED-1 : 0] input_data; 

(* keep = "true" *) reg  [NB_SCRAMBLER-1   : 0] scrambler_state;
//reg  [NB_SCRAMBLER-1   : 0] scrambler_state;
reg  [NB_SCRAMBLER-1   : 0] scrambler_state_next;
reg out_bit_N;
reg	idle_tag; 

assign sync_header = i_data[NB_DATA_CODED-1 -: 2];

//PORTS
assign o_data = {idle_tag, output_data};

//scrambler state
always @(posedge i_clock)
begin
	if (i_reset)
		scrambler_state <= SEED;
	else if (i_enable && (!i_bypass))
 		scrambler_state <= scrambler_state_next;
end

//output
 always @ (posedge i_clock)
 begin 
 	if(i_reset)begin
 		output_data <= {NB_DATA_CODED{1'b0}};
 	end 
 	else if (i_enable && (!i_bypass) && i_valid)begin
 		output_data <= scrambled_data; 
 	end
 	else if (i_enable &&  i_bypass && i_valid)begin
 		output_data <= i_data;			
 	end
 end

//tag registring
 always @ (posedge i_clock)
 begin
		if(i_reset)
			idle_tag <= 1'b0;
	    else if(i_enable && i_valid)
			idle_tag <= i_alligner_tag;
 end

//ALGORITHM BEGIN
always @ *
begin // etapa 1
	out_bit_N = 0;
	scrambled_data 		 = {sync_header,{NB_DATA_CODED-2{1'b0}}};
	scrambler_state_next = scrambler_state;
	if (i_idle_pattern_mode)
		input_data = IDLE_BLOCK;
	else 
		input_data = i_data;

	for(i=NB_DATA_CODED-3; i >= 0; i=i-1)
	begin
		//out_bit_N = (i_data[i] ^ scrambler_state_next[38] ^ scrambler_state_next[57]);
		out_bit_N = (input_data[i] ^ scrambler_state_next[57-38] ^ scrambler_state_next[0]);
		scrambled_data[i] = out_bit_N;
		scrambler_state_next = {out_bit_N,scrambler_state_next[NB_SCRAMBLER-1 : 1]} ;

	end 
end



endmodule
