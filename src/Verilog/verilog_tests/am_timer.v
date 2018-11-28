


module am_timer
#(
	parameter N_BLOCKS = 16383 //[check]
 )
 (
 	input  wire i_clock,
 	input  wire i_reset,
 	input  wire i_enable,
 	input  wire i_valid,
 	input  wire i_restart,

 	output wire o_timer_done
 );

//LOCALPARAMS
localparam NB_COUNTER = $clog2(N_BLOCKS);

//INTERNAL SIGNALS
reg [NB_COUNTER-1 : 0] counter;


//Update counter
always @ (posedge i_clock)
begin
	if(i_reset || i_restart)
		counter <= 0;
	else if(i_enable && i_valid)
	begin
		if(counter < N_BLOCKS - 1)
			counter <= counter + 1;
		else
			counter <= 0;
	end
end

//PORTS
/*
	verificar cual de las dos
*/
//assign o_timer_done = (counter == {NB_COUNTER{1'b0}}) ? 1'b1 : 1'b0; // overflow
assign o_timer_done = (counter == {NB_COUNTER{1'b1}}) ? 1'b1 : 1'b0; // salida en 1 cuando counter alcanzo el valor maximo