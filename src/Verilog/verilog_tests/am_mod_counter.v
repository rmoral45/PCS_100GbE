


module am_mod_counter
#(
	parameter N_BLOCKS = 16383, //[REVISAR] cantidad de bloquen entre am y am
	parameter N_LANES  = 20,
 )
 (
 	input  wire i_reset,
 	input  wire i_clock,
 	input  wire i_enable,
 	input  wire i_valid, // coontrol de flujo de cgmii, puede estar siempre en 1
 	
 	output wire o_block_count_done,
 	output wire o_insert_am_idle
 );


//LOCALPARAMS

localparam MAX_COUNT = N_LANES*N_BLOCKS;
localparam NB_COUNT  = $clog2(N_LANES*N_BLOCKS);

//INTERNAL SIGNALS

reg [NB_COUNT-1 : 0] counter;


//Update counter
always @ (posedge i_clock)
begin
	if(i_reset)
		counter <= {NB_COUNT{1'b0}};
	else if(i_enable && i_valid)
	begin
		if(counter == MAX_COUNT-1)
			counter <= 0;
		else 
			counter <= counter+1;
	end
 	
end 


//PORTS
assign o_reset_idle_count = (counter == {NB_COUNT{1'b0}}) ? 1'b1 : 1'b0;
assign o_insert_am_idle   = (counter < N_LANES)			  ? 1'b1 : 1'b0;




endmodule
