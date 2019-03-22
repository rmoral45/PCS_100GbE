module am_sol_timer
#(
	parameter N_BLOCKS = 16383, //[check]
	parameter EXTRA_DELAY = 0 //depends on reset conditiones
 )
 (
 	input  wire i_clock,
 	input  wire i_reset,
 	input  wire i_enable,
 	input  wire i_valid,
 	input  wire i_restart,
 	output reg 	o_start_of_lane
 );

//LOCALPARAMS
localparam NB_COUNTER = $clog2(N_BLOCKS);
localparam N_STATES	    = 2;
localparam INIT         = 2'b10;
localparam LOCKED		= 2'b01;

//INTERNAL SIGNALS
reg [NB_COUNTER-1 : 0] counter;
reg [NB_COUNTER-1 : 0] counter_next;
reg [N_STATES-1	  : 0] state;

reg [N_STATES-1	  : 0] state_next;


//Update counter
always @ (posedge i_clock)
begin
	if(i_reset || i_restart)
	begin
		counter <= 0;
		state 	<= INIT;
	end
	else if(i_enable && i_valid)
	begin
		counter <= counter_next;
		state 	<= state_next;
	end
end

always @ * begin 
	state_next = state;
	counter_next = counter + 1;
	o_start_of_lane = 0;
	case(state)
	INIT:
	begin
		if (counter == N_BLOCKS-EXTRA_DELAY)
		begin
			o_start_of_lane = 1;
			counter_next = {NB_COUNTER{1'b0}};
			state_next = LOCKED;
		end
	end
	LOCKED:
	begin
		if (counter == N_BLOCKS)
		begin
		    counter_next = {NB_COUNTER{1'b0}};
			o_start_of_lane = 1;
			state_next = LOCKED;
		end			
	end
	
	endcase
end

//PORTS
/*	
	State INIT
	La cuenta se realiza hasta 2 menos que el periodo entre alineadores debido a que la fms introduce
	1 ciclo de clock de delay para setear la flag que resetea el timer y el contador interno
	demora 1 ciclo mas en volverse a cero.

	State LOCKED
	La cuenta se realiza durante todo el periodo entre alineadores.
*/
endmodule
