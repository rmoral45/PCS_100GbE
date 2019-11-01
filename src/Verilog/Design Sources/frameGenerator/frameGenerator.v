`timescale 1ns/100ps
module frameGenerator
	#(
	parameter						NB_DATA_RAW 	= 64,
	parameter						NB_CTRL_RAW 	= 8,
	parameter						NB_TERM			= 3,
	parameter						NB_DATA			= 8,
	parameter						NB_IDLE			= 5
	)
	(
	input							i_clock,
	input							i_reset,
	input							i_enable,
	input wire	[NB_DATA -1:0]		i_ndata,
	input wire	[NB_IDLE -1:0]		i_nidle,
	input wire	[NB_TERM -1:0]		i_nterm,
	output wire [NB_DATA_RAW - 1:0]	o_tx_data,
	output wire [NB_CTRL_RAW - 1:0]	o_tx_ctrl
	);

//Bloques
localparam							ERROR_BLOCK 	= 64'hFEFEFEFEFEFEFEFE;
localparam							DATA_BLOCK 		= 64'h706879736963616C;
localparam							Q_ORD_BLOCK 	= 64'h9C68797300000000;
localparam							Fsig_ORD_BLOCK 	= 64'h5C68797300000000;
localparam							IDLE_BLOCK 		= 64'h0707070707070707;
localparam							TERM_CHAR		= 8'hFD;
localparam							IDLE_CHAR		= 8'h07;
localparam                          START_CHAR      = 8'hFB;
localparam							ORD_CTRL		= 8'h80;
localparam							IDLE_CTRL		= 8'hFF;
localparam							START_CTRL		= 8'h80;
localparam							DATA_CTRL		= 8'h00;
localparam							T0_CTRL			= 8'hFF;
localparam							T1_CTRL			= 8'h7F;
localparam							T2_CTRL			= 8'h3F;
localparam							T3_CTRL			= 8'h1F;
localparam							T4_CTRL			= 8'h0F;
localparam							T5_CTRL			= 8'h07;
localparam							T6_CTRL			= 8'h03;
localparam							T7_CTRL			= 8'h01;


//Estados
localparam							N_STATES		= 5;
localparam	[N_STATES-1:0]			INIT 			= 5'b00001;
localparam	[N_STATES-1:0]			TX_C 			= 5'b00010;
localparam	[N_STATES-1:0]			TX_D 			= 5'b00100;
localparam	[N_STATES-1:0]			TX_T 			= 5'b01000;
localparam	[N_STATES-1:0]			TX_E 			= 5'b10000;

//Registros y parametros de debug del generador de datos
localparam							DEBUG_PULSE = 4'b0000;
wire								enable_dataGenerator;

//Registros para uso local del generador de frames
reg	 [NB_DATA_RAW-1 :0] 			tx_data;
reg	 [NB_CTRL_RAW-1 :0] 			tx_ctrl;
reg  [NB_DATA_RAW*8-1 :0]           t_ctrls;
reg  [NB_DATA_RAW*8-1 :0]           t_blocks;
reg  [NB_DATA_RAW-1 :0]				t0_block;
reg  [NB_DATA_RAW-1 :0]				t1_block;
reg  [NB_DATA_RAW-1 :0]				t2_block;
reg  [NB_DATA_RAW-1 :0]				t3_block;
reg  [NB_DATA_RAW-1 :0]				t4_block;
reg  [NB_DATA_RAW-1 :0]				t5_block;
reg  [NB_DATA_RAW-1 :0]				t6_block;
reg  [NB_DATA_RAW-1 :0]				t7_block;
reg  [NB_DATA_RAW-1 :0]             start_block;
wire [NB_DATA_RAW-1 :0]			    data_block;
wire                                start_flag;
wire [N_STATES-1:0]					state;
wire [NB_CTRL_RAW-1 :0]				data0;
wire [NB_CTRL_RAW-1 :0]				data1;
wire [NB_CTRL_RAW-1 :0]				data2;
wire [NB_CTRL_RAW-1 :0]				data3;
wire [NB_CTRL_RAW-1 :0]				data4;
wire [NB_CTRL_RAW-1 :0]				data5;
wire [NB_CTRL_RAW-1 :0]				data6;
wire [NB_CTRL_RAW-1 :0]				data7;


assign 								data0 			= data_block[NB_CTRL_RAW -: 8];
assign 								data1 			= data_block[NB_CTRL_RAW*2 -: 8];
assign 								data2 			= data_block[NB_CTRL_RAW*3 -: 8];
assign 								data3 			= data_block[NB_CTRL_RAW*4 -: 8];
assign 								data4 			= data_block[NB_CTRL_RAW*5 -: 8];
assign 								data5 			= data_block[NB_CTRL_RAW*6 -: 8];
assign 								data6 			= data_block[NB_CTRL_RAW*7 -: 8];
assign 								data7 			= data_block[NB_DATA_RAW-8 -: 8];
assign 								o_tx_data 		= tx_data;
assign 								o_tx_ctrl 		= tx_ctrl;
assign  							enable_dataGenerator = 1'b1;


always @ * begin

	    tx_data = {NB_DATA_RAW{1'b0}};
	    tx_ctrl = {NB_CTRL_RAW{1'b0}};


		t0_block =	{TERM_CHAR, {7{IDLE_CHAR}}};
		t1_block =	{data0, TERM_CHAR, {6{IDLE_CHAR}}};
		t2_block =	{data0, data1, TERM_CHAR, {5{IDLE_CHAR}}};
		t3_block =	{data0, data1, data2, TERM_CHAR, {4{IDLE_CHAR}}};
		t4_block =	{data0, data1, data2, data3, TERM_CHAR, {3{IDLE_CHAR}}};
		t5_block =	{data0, data1, data2, data3, data4, TERM_CHAR, {2{IDLE_CHAR}}};
		t6_block =	{data0, data1, data2, data3, data4, data5, TERM_CHAR, IDLE_CHAR};
		t7_block =	{data0, data1, data2, data3, data4, data5, data6, TERM_CHAR};
		
		start_block = {START_CHAR, data1, data2, data3, data4, data5, data6, data7};
	
		t_blocks =	{t0_block, t1_block, t2_block, t3_block, t4_block, t5_block, t6_block,
					t7_block}; 

		t_ctrls =	{T0_CTRL, T1_CTRL, T2_CTRL, T3_CTRL, T4_CTRL, T5_CTRL, T6_CTRL, 
					T7_CTRL};

		case(state)

		INIT:
		begin
			tx_data = Q_ORD_BLOCK;
			tx_ctrl = ORD_CTRL;
		end

		TX_C:
		begin
			if(start_flag)begin
			     tx_data = start_block;
			     tx_ctrl = START_CTRL;
			end
			else begin
			     tx_data = {8{IDLE_CHAR}};
			     tx_ctrl = IDLE_CTRL;
			end
		end

		TX_D:
		begin
			tx_data = data_block;
			tx_ctrl = DATA_CTRL;
		end

		TX_T:
		begin
			tx_data = t_blocks[((NB_DATA_RAW*8-1) - (i_nterm*NB_DATA_RAW)) -: NB_DATA_RAW]; //n_term salida de la awgn
			tx_ctrl = t_ctrls[((NB_CTRL_RAW*8-1) - (i_nterm*NB_CTRL_RAW)) -: NB_CTRL_RAW]; //n_term salida de la awgn
		end
	
		TX_E:
		begin
        	tx_data = ERROR_BLOCK;
	        tx_ctrl = IDLE_CTRL;
    	end
	
		default:
		begin
		    tx_data = tx_data;
		    tx_ctrl = tx_ctrl;
    	end
    	endcase

end


cgmiiFSM#(
	)
u_cgmiiFSM
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(i_enable),
	.i_debug_pulse(DEBUG_PULSE),
	.i_ndata(i_ndata),         //salida de la awgn
	.i_nidle(i_nidle),         //salida de la awgn
	.o_start_flag(start_flag),
	.o_actual_state(state)
	);

dataGenerator#(
	)
u_dataGenerator
	(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(enable_dataGenerator),
	.o_data_block(data_block)
	);

endmodule
