module cgmii
	#(
	parameter		N_IDLE = 5,
	parameter		N_DATA = 5,
	parameter		N_ERROR = 5
	)
	(
	input 			i_clock,
	input 			i_reset,
	input  wire     i_enable,
	input	[3:0]	i_debug_pulse,			//senial utilizada para forzar transiciones de estados
	output	[7:0]	o_tx_ctrl,	
	output	[63:0]	o_tx_data
	);

//Bloques
localparam			ERROR_BLOCK 	= 64'hFEFEFEFEFEFEFEFE;
localparam			START_BLOCK 	= 64'hFB6879736963616C;
localparam			DATA_BLOCK 		= 64'h706879736963616C;
localparam			Q_ORD_BLOCK 	= 64'h9C68797300000000;
localparam			Fsig_ORD_BLOCK 	= 64'h5C68797300000000;
localparam			IDLE_BLOCK 		= 64'h0707070707070707;
localparam			T0_BLOCK 		= 64'hFD07070707070707;
localparam			T1_BLOCK 		= 64'h70FD070707070707;
localparam			T2_BLOCK 		= 64'h7068FD0707070707;
localparam			T3_BLOCK 		= 64'h706879FD07070707;
localparam			T4_BLOCK 		= 64'h70687973FD070707;
localparam			T5_BLOCK 		= 64'h7068797369FD0707;
localparam			T6_BLOCK 		= 64'h706879736963FD07;
localparam			T7_BLOCK 		= 64'h70687973696361FD;

//Estados
localparam	[4:0] 	INIT 			= 5'b00001;
localparam	[4:0] 	TX_C 			= 5'b00010;
localparam	[4:0] 	TX_D 			= 5'b00100;
localparam	[4:0] 	TX_T 			= 5'b01000;
localparam	[4:0] 	TX_E 			= 5'b10000;

//Registros
reg 		[63:0]	tx_data;
reg 		[63:0]	tx_data_next;
reg 		[7:0]	tx_ctrl;
reg 		[7:0]	tx_ctrl_next;
reg 		[4:0]	actual_state;
reg 		[4:0]	next_state;
reg 		[2:0]	idle_counter;
reg 		[2:0]	idle_counter_next;
reg 		[2:0]	data_counter;
reg 		[2:0]	data_counter_next;
reg 		[2:0]	error_counter;
reg 		[2:0]	error_counter_next;

//Asigns
assign o_tx_data = tx_data;
assign o_tx_ctrl = tx_ctrl;


always @ (posedge i_clock or posedge i_reset)begin
	
	if(i_reset)begin
		tx_data 		<= Q_ORD_BLOCK;
		tx_ctrl 		<= 8'h80;
        actual_state     <= INIT;
        data_counter    <= {N_DATA{1'b0}};
        idle_counter    <= {N_IDLE{1'b0}};
        error_counter    <= {N_ERROR{1'b0}};
	end
	else begin
		tx_data 		<= tx_data_next;
		tx_ctrl         <= tx_ctrl_next;
		idle_counter 	<= idle_counter_next;
		data_counter 	<= data_counter_next;
		error_counter 	<= error_counter_next;
		actual_state 	<= next_state;
	end
end



always @ * begin
	
	tx_data_next = tx_data;
	tx_ctrl_next = tx_ctrl;
	next_state = actual_state;
	idle_counter_next = idle_counter;
	data_counter_next = data_counter;
	error_counter_next = error_counter;

	if(i_enable && i_debug_pulse == 4'b0000)begin  					//Operacion normal

		case(actual_state)

		INIT:
		begin
			tx_data_next = IDLE_BLOCK;
			tx_ctrl_next = 8'hFF;
			idle_counter_next = idle_counter+1;
			next_state = TX_C;
		end

		TX_C:
		begin
		     if(idle_counter <= N_IDLE)begin
			     tx_data_next = IDLE_BLOCK;
			     tx_ctrl_next = 8'hFF;
			     idle_counter_next = idle_counter+1;
			     next_state = actual_state;
			end
			else begin
			     tx_data_next = START_BLOCK;
			     tx_ctrl_next = 8'h80;
			     idle_counter_next = 3'b000;
			     next_state = TX_D;
			end
		end

		TX_D:
		begin
			if(data_counter <= N_DATA)begin	
				tx_data_next = DATA_BLOCK;
				tx_ctrl_next = 8'h00;
				data_counter_next = data_counter+1;
				next_state = actual_state;
			end
			else begin
				tx_data_next = T0_BLOCK;
				tx_ctrl_next = 8'hFF;
				data_counter_next = 3'b000;
				next_state = TX_T;
			end
		end

		TX_T:
		begin
			tx_data_next = IDLE_BLOCK;
			tx_ctrl_next = 8'hFF;
			idle_counter_next = 3'b000;
			data_counter_next = 3'b000;
			error_counter_next = 3'b000;
//			next_state = INIT;
		end

		TX_E:
		begin
			if(error_counter <= N_ERROR)begin	
				tx_data_next = ERROR_BLOCK;
				tx_ctrl_next = 8'hFF;				
				error_counter_next = error_counter+1;
				next_state = actual_state;
			end
			else begin
				tx_data_next = IDLE_BLOCK;
				tx_ctrl_next = 8'hFF;
				error_counter_next = 3'b000;
				next_state = TX_C;
			end
		end

		default:										 //aca se genera la condicion de error
		begin
			idle_counter_next = idle_counter;
			data_counter_next = data_counter;
			error_counter_next = error_counter+1;
			tx_data_next = ERROR_BLOCK;
			tx_ctrl_next = 8'hFF;
			next_state = TX_E;
		end
		endcase
	end

	else if(i_enable && i_debug_pulse == 4'b0001)begin 				//Forzamos estado de error
		next_state = TX_E;
		idle_counter_next = 0;
		data_counter_next = 0;
		error_counter_next = 1;
		tx_data_next = ERROR_BLOCK;
		tx_ctrl_next = 8'hFF;
	end

	else if(i_enable && i_debug_pulse == 4'b0010)begin 				//Forzamos estado de control
		tx_data_next = Q_ORD_BLOCK;
		tx_ctrl_next = 8'h80;
		next_state = TX_C;
	end

	else if(i_enable && i_debug_pulse == 4'b0100)begin 				//Forzamos estado de inicio de trama		
		tx_data_next = START_BLOCK;
		tx_ctrl_next = 8'h80;
		next_state = TX_D;
	end

	else if(i_enable && i_debug_pulse == 4'b1000)begin 				//Forzamos estado de envio de datos
		tx_data_next = DATA_BLOCK;
		tx_ctrl_next = 8'h00;
		data_counter_next = 1;
	end

	else if(i_enable && i_debug_pulse == 4'b1111)begin 				//Forzamos estado de finalizacion de trama		
		tx_data_next = T0_BLOCK;
		tx_ctrl_next = 8'hFF;
		next_state = TX_T;
	end

end

endmodule

