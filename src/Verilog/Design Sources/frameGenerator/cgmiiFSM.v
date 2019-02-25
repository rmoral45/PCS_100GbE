module cgmiiFSM
	#(
	parameter						DATA_NBIT	= 8,
	parameter						IDLE_NBIT	= 5,
	parameter						TERM_NBIT	= 3,
	parameter						DEBUG_NBIT	= 4,
	parameter						N_STATES	= 5
	)
	(
	input 							i_clock,
	input 							i_reset,
	input		[DEBUG_NBIT - 1:0]	i_debug_pulse,			//senial utilizada para forzar transiciones de estados
	input wire 	[DATA_NBIT - 1:0]	i_ndata,
	input wire 	[IDLE_NBIT - 1:0]	i_nidle,
	output wire [N_STATES - 1:0]	o_actual_state
	);

//Estados
localparam	[N_STATES-1:0]			INIT 		= 5'b00001;
localparam	[N_STATES-1:0]			TX_C 		= 5'b00010;
localparam	[N_STATES-1:0]			TX_D 		= 5'b00100;
localparam	[N_STATES-1:0]			TX_T 		= 5'b01000;
localparam	[N_STATES-1:0]			TX_E 		= 5'b10000;

//Registros
reg 		[N_STATES - 1:0]		actual_state;
reg 		[N_STATES - 1:0]		next_state;
reg 		[IDLE_NBIT - 1:0]		idle_counter;
reg 		[IDLE_NBIT - 1:0]		idle_counter_next;
reg 		[IDLE_NBIT - 1:0]		data_counter;
reg 		[IDLE_NBIT - 1:0]		data_counter_next; 
reg 		[IDLE_NBIT - 1:0]		n_idle;
reg 		[IDLE_NBIT - 1:0]		n_idle_next;
reg 		[DATA_NBIT - 1:0]		n_data;
reg 		[DATA_NBIT - 1:0]		n_data_next;

//Asigns
assign 								o_actual_state = actual_state;

always @ (posedge i_clock)begin
	
	if(i_reset)begin
        actual_state    <= INIT;
        data_counter    <= {DATA_NBIT{1'b0}};
        idle_counter 	<= {IDLE_NBIT{1'b0}};
        n_idle 			<= i_nidle;
        n_data 			<= i_ndata;
	end
	else begin
		idle_counter 	<= idle_counter_next;
		data_counter 	<= data_counter_next;
		actual_state 	<= next_state;
		n_data			<= n_data_next;
	end
end



always @ * begin
	
	next_state 			= actual_state;
	idle_counter_next 	= idle_counter;
	data_counter_next 	= data_counter;

	if(i_debug_pulse == 4'b0000)begin  					//Operacion normal

		case(actual_state)

		INIT:
		begin
			next_state 				= TX_C;
		end

		TX_C:
		begin
		     if(idle_counter <= n_idle)begin
			     idle_counter_next 	= idle_counter+1;
			     next_state 		= actual_state;
			end
			else begin
				 idle_counter_next 	= {IDLE_NBIT{1'b0}};
			     next_state 		= TX_D;
			end
		end

		TX_D:
		begin
			if(data_counter <= n_data)begin	
				data_counter_next 	= data_counter+1;
				next_state 			= actual_state;
			end
			else begin
				data_counter_next 	= {DATA_NBIT{1'b0}};
				next_state 			= TX_T;
			end
		end

		TX_T:
		begin
				n_idle = i_nidle;
				n_data = i_ndata;
				next_state = INIT;
		end

		TX_E:
		begin
				next_state 			= TX_C;
		end

		default:										 //aca se genera la condicion de error
		begin
			idle_counter_next 		= idle_counter;
			data_counter_next 		= data_counter;
			next_state 				= TX_E;
		end
		endcase
	end

	else if(i_debug_pulse == 4'b0001)begin 				//Forzamos estado de error
		next_state 			= TX_E;
		idle_counter_next 	= 0;
		data_counter_next 	= 0;
	end

	else if(i_debug_pulse == 4'b0010)begin 				//Forzamos estado de control
		next_state 	= TX_C;
	end

	else if(i_debug_pulse == 4'b0100)begin 				//Forzamos estado de inicio de trama		
		next_state = TX_D;
	end

	else if(i_debug_pulse == 4'b1000)begin 				//Forzamos estado de envio de datos
		data_counter_next = 1;
	end

	else if(i_debug_pulse == 4'b1111)begin 				//Forzamos estado de finalizacion de trama		
		next_state = TX_T;
	end

end

endmodule

