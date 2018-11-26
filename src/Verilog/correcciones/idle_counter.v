


module  idle_counter
#(
	parameter N_IDLE = 20
 )
 (
 	input  wire i_clock,
 	input  wire i_reset,
 	input  wire i_block_count_done,
 	input  wire i_enable,
 	input  wire i_idle_detected,

 	output wire o_idle_count_done
 );

//LOCALPARAMS
localparam NB_COUNT = $clog2(N_IDLE);


//INTERNAL SIGNALS
reg [NB_COUNT : 0] counter;

//Update counter
always @ (posedge i_clock)
begin
	if ( i_reset || i_block_count_done )
		counter <= 0;
	else if ( i_enable && i_idle_detected)
		if (counter < N_IDLE)
			counter <= counter + 1;
		else
			counter <= counter;
end

//PORTS
assign o_idle_count_done = (counter == N_IDLE) ? 1'b1 : 1'b0;


endmodule