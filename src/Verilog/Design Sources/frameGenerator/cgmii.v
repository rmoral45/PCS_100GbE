module cgmii
	#(
	parameter					DATA_LIM_HIGH	= 12,
	parameter					DATA_LIM_LOW	= 0, 
	parameter					TERM_LIM_HIGH	= 3,
	parameter					TERM_LIM_LOW	= 0,
	parameter					IDLE_LIM_HIGH	= 12,
	parameter					IDLE_LIM_LOW	= 0,
	parameter					ERROR_LIM_HIGH	= 12,
	parameter					ERROR_LIM_LOW	= 0,
	parameter					DATA_NBIT 		= DATA_LIM_HIGH - DATA_LIM_LOW,
	parameter					TERM_NBIT		= TERM_LIM_HIGH - TERM_LIM_LOW,
	parameter					IDLE_NBIT		= IDLE_LIM_HIGH - IDLE_LIM_LOW
	parameter					ERROR_NBIT		= ERROR_LIM_HIGH - ERROR_LIM_LOW
	)
	(
	input 							i_clock,
	input 							i_reset,
	input		[3:0]				i_debug_pulse,			//senial utilizada para forzar transiciones de estados
	input wire 	[DATA_NBIT - 1:0]	i_ndata,
	input wire 	[IDLE_NBIT - 1:0]	i_nidle,
	input wire 	[TERM_NBIT - 1:0]	i_nterm,
	input wire 	[ERROR_NBIT - 1:0] 	i_nerror,
	input wire	[DATA_BYTE - 1:0]	i_data0,
	input wire	[DATA_BYTE - 1:0]	i_data1,		
	input wire	[DATA_BYTE - 1:0]	i_data2,
	input wire	[DATA_BYTE - 1:0]	i_data3,
	input wire	[DATA_BYTE - 1:0]	i_data4,
	input wire	[DATA_BYTE - 1:0]	i_data5,
	input wire	[DATA_BYTE - 1:0]	i_data6,
	input wire	[DATA_BYTE - 1:0]	i_data7,
	output		[7:0]				o_tx_ctrl,	
	output		[63:0]				o_tx_data
	);

//Bloques
localparam			ERROR_BLOCK 	= 64'hFEFEFEFEFEFEFEFE;
localparam			START_BLOCK 	= 64'hFB6879736963616C;
localparam			DATA_BLOCK 		= 64'h706879736963616C;
localparam			Q_ORD_BLOCK 	= 64'h9C68797300000000;
localparam			Fsig_ORD_BLOCK 	= 64'h5C68797300000000;
localparam			IDLE_BLOCK 		= 64'h0707070707070707;
localparam			T0_CHAR			= 							//definir los caracteres de terminate.
/*localparam			T0_BLOCK 		= 64'hFD07070707070707;
localparam			T1_BLOCK 		= 64'h70FD070707070707;
localparam			T2_BLOCK 		= 64'h7068FD0707070707;
localparam			T3_BLOCK 		= 64'h706879FD07070707;
localparam			T4_BLOCK 		= 64'h70687973FD070707;
localparam			T5_BLOCK 		= 64'h7068797369FD0707;
localparam			T6_BLOCK 		= 64'h706879736963FD07;
localparam			T7_BLOCK 		= 64'h70687973696361FD;*/
localparam			BLOCK_SIZE		= 64;
localparam			N_STATES		= 5;

//Estados
localparam	[4:0] 	PARAM 			= 5'b00000;					//estado de parametrizacion de registros y contadores
localparam	[4:0] 	INIT 			= 5'b00001;
localparam	[4:0] 	TX_C 			= 5'b00010;
localparam	[4:0] 	TX_D 			= 5'b00100;
localparam	[4:0] 	TX_T 			= 5'b01000;
localparam	[4:0] 	TX_E 			= 5'b10000;

//Registros
reg 		[63:0]				tx_data;
reg 		[63:0]				tx_data_next;
reg 		[7:0]				tx_ctrl;
reg 		[7:0]				tx_ctrl_next;
reg 		[N_STATES - 1:0]	actual_state;
reg 		[N_STATES - 1:0]	next_state;
reg 		[IDLE_NBIT - 1:0]	idle_counter;
reg 		[IDLE_NBIT - 1:0]	idle_counter_next;
reg 		[IDLE_NBIT - 1:0]	data_counter;
reg 		[IDLE_NBIT - 1:0]	data_counter_next; 
reg 		[ERROR_NBIT- 1:0]	error_counter;
reg 		[ERROR_NBIT- 1:0]	error_counter_next;
reg 		[TERM_NBIT - 1:0]	finish_counter;
reg 		[TERM_NBIT - 1:0]	finish_counter_next;

reg 		[IDLE_NBIT - 1:0]	n_idle;
reg 		[DATA_NBIT - 1:0]	n_data;
reg 		[TERM_NBIT - 1:0]	n_term;
reg 		[TERM_NBIT - 1:0]	n_term_next;
reg 		[ERROR_NBIT - 1:0]	n_error;




//Asigns
assign o_tx_data = tx_data;
assign o_tx_ctrl = tx_ctrl;


always @ (posedge i_clock)begin
	
	if(i_reset)begin
		tx_data 		<= Q_ORD_BLOCK;
		tx_ctrl 		<= 8'h80;
        actual_state    <= INIT;
        data_counter    <= {DATA_NBIT{1'b0}};
        idle_counter 	<= {IDLE_NBIT{1'b0}};
        error_counter 	<= {ERROR_NBIT{1'b0}};
        finish_counter 	<= {TERM_NBIT{1'b0}};
        n_idle 			<= i_nidle;
        n_data 			<= i_ndata;
        n_term 			<= i_nterm;
        n_error 		<= i_nerror;
	end
	else begin
		tx_data 		<= tx_data_next;
		tx_ctrl         <= tx_ctrl_next;
		idle_counter 	<= idle_counter_next;
		data_counter 	<= data_counter_next;
		error_counter 	<= error_counter_next;
		finish_counter 	<= finish_counter_next;
		n_term_next		<= n_term;
		actual_state 	<= next_state;
	end
end



always @ * begin
	
	t0_block = {}	//definir los bloques terminates en base al valor de la entrada.
	terminates = {t0_block, t1_block, t2_block, t3_block, t4_block, t5_block, t6_block
				 , t7_block};
	
	tx_data_next 		= tx_data;
	tx_ctrl_next 		= tx_ctrl;
	next_state 			= actual_state;
	idle_counter_next 	= idle_counter;
	data_counter_next 	= data_counter;
	error_counter_next 	= error_counter;
	n_term_next 		= n_term;
	finish_counter_next = finish_counter;

	if(i_debug_pulse == 4'b0000)begin  					//Operacion normal

		case(actual_state)

		INIT:
		begin
			tx_data_next 			= IDLE_BLOCK;
			tx_ctrl_next 			= 8'hFF;
			idle_counter_next 		= idle_counter+1;
			next_state 				= TX_C;
		end

		TX_C:
		begin
		     if(idle_counter <= n_idle)begin
			     tx_data_next 		= IDLE_BLOCK;
			     tx_ctrl_next 		= 8'hFF;
			     idle_counter_next 	= idle_counter+1;
			     next_state 		= actual_state;
			end
			else begin
			     tx_data_next 		= START_BLOCK;
			     tx_ctrl_next 		= 8'h80;
				 idle_counter_next 	= {IDLE_NBIT{1'b0}};
			     next_state 		= TX_D;
			end
		end

		TX_D:
		begin
			if(data_counter <= n_data)begin	
				tx_data_next 		= DATA_BLOCK;
				tx_ctrl_next 		= 8'h00;
				data_counter_next 	= data_counter+1;
				next_state 			= actual_state;
			end
			else begin
				tx_data_next 		= terminates[n_term*BLOCK_SIZE -: BLOCK_SIZE];
				n_term_next 		= n_term + 1;
				finish_counter_next = finish_counter + 1;
				tx_ctrl_next 		= 8'hFF;
				data_counter_next 	= {DATA_NBIT{1'b0}};
				next_state 			= TX_T;
			end
		end

		TX_T:
		begin

			if(finish_counter <= 7)begin
				tx_data_next 		= IDLE_BLOCK;
				tx_ctrl_next 		= 8'hFF;
				idle_counter_next 	= {IDLE_NBIT{1'b0}};
				data_counter_next 	= {DATA_NBIT{1'b0}};
				error_counter_next 	= {ERROR_NBIT{1'b0}};
				finish_counter_next = {TERM_NBIT{1'b0}};
				next_state = INIT;
			end
			else begin
				tx_data_next 		= IDLE_BLOCK;
				tx_ctrl_next 		= 8'hFF;
				idle_counter_next 	= {IDLE_NBIT{1'b0}};
				data_counter_next 	= {DATA_NBIT{1'b0}};
				error_counter_next 	= {ERROR_NBIT{1'b0}};
				finish_counter_next = {TERM_NBIT{1'b0}};
				next_state 			= PARAM;
			end
		end

		TX_E:
		begin
			if(error_counter <= n_error)begin	
				tx_data_next 		= ERROR_BLOCK;
				tx_ctrl_next 		= 8'hFF;				
				error_counter_next 	= error_counter+1;
				next_state 			= actual_state;
			end
			else begin
				tx_data_next 		= IDLE_BLOCK;
				tx_ctrl_next 		= 8'hFF;
				error_counter_next 	= {ERROR_NBIT{1'b0}};
				next_state 			= TX_C;
			end
		end

		default:										 //aca se genera la condicion de error
		begin
			idle_counter_next 	= idle_counter;
			data_counter_next 	= data_counter;
			error_counter_next 	= error_counter+1;
			tx_data_next 		= ERROR_BLOCK;
			tx_ctrl_next 		= 8'hFF;
			next_state 			= TX_E;
		end
		endcase
	end

	else if(i_debug_pulse == 4'b0001)begin 				//Forzamos estado de error
		next_state = TX_E;
		idle_counter_next = 0;
		data_counter_next = 0;
		error_counter_next = 1;
		tx_data_next = ERROR_BLOCK;
		tx_ctrl_next = 8'hFF;
	end

	else if(i_debug_pulse == 4'b0010)begin 				//Forzamos estado de control
		tx_data_next = Q_ORD_BLOCK;
		tx_ctrl_next = 8'h80;
		next_state = TX_C;
	end

	else if(i_debug_pulse == 4'b0100)begin 				//Forzamos estado de inicio de trama		
		tx_data_next = START_BLOCK;
		tx_ctrl_next = 8'h80;
		next_state = TX_D;
	end

	else if(i_debug_pulse == 4'b1000)begin 				//Forzamos estado de envio de datos
		tx_data_next = DATA_BLOCK;
		tx_ctrl_next = 8'h00;
		data_counter_next = 1;
	end

	else if(i_debug_pulse == 4'b1111)begin 				//Forzamos estado de finalizacion de trama		
		tx_data_next = T0_BLOCK;
		tx_ctrl_next = 8'hFF;
		next_state = TX_T;
	end

end

endmodule

