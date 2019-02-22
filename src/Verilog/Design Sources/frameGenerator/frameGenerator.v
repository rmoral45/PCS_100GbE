module frameGenerator
	#(
	parameter			LEN_TX_DATA = 64,
	parameter			LEN_TX_CTRL = 8
	)
	(
	input							i_clock,
	input							i_reset, 
	output wire [LEN_TX_DATA - 1:0]	o_tx_data,
	output wire [LEN_TX_CTRL - 1:0]	o_tx_ctrl
	);

//Bloques
localparam				ERROR_BLOCK 	= 64'hFEFEFEFEFEFEFEFE;
localparam				START_BLOCK 	= 64'hFB6879736963616C;
localparam				DATA_BLOCK 		= 64'h706879736963616C;
localparam				Q_ORD_BLOCK 	= 64'h9C68797300000000;
localparam				Fsig_ORD_BLOCK 	= 64'h5C68797300000000;
localparam				IDLE_BLOCK 		= 64'h0707070707070707;
localparam				TERM_CHAR		= 8'hFD;
localparam				IDLE_CHAR		= 7'h07;
localparam				ORD_CTRL		= 8'h80;
localparam				IDLE_CTRL		= 8'hFF;
localparam				START_CTRL		= 8'h80;
localparam				DATA_CTRL		= 8'h00;
localparam				T0_CTRL			= 8'hFF;
localparam				T1_CTRL			= 8'h7F;
localparam				T2_CTRL			= 8'h3F;
localparam				T3_CTRL			= 8'h1F;
localparam				T4_CTRL			= 8'h0F;
localparam				T5_CTRL			= 8'h07;
localparam				T6_CTRL			= 8'h03;
localparam				T7_CTRL			= 8'h01;


//Estados
localparam				N_STATES	= 5;
localparam	[4:0] 		INIT 		= 5'b00001;
localparam	[4:0] 		TX_C 		= 5'b00010;
localparam	[4:0] 		TX_D 		= 5'b00100;
localparam	[4:0] 		TX_T 		= 5'b01000;
localparam	[4:0] 		TX_E 		= 5'b10000;

reg  [LEN_TX_DATA-1 :0] data_block;
reg	 [LEN_TX_DATA-1 :0] tx_data;
reg	 [LEN_TX_CTRL-1 :0] tx_ctrl;
wire [N_STATES-1:0]		state;

assign o_tx_data = tx_data;
assign o_tx_ctrl = tx_ctrl;

always @ * begin

	t0_block =	{TERM_CHAR, {7{IDLE_CHAR}}};
	t1_block =	{i_data0, TERM_CHAR, {6{IDLE_CHAR}}};
	t2_block =	{i_data0, i_data1, TERM_CHAR, {5{IDLE_CHAR}}};
	t3_block =	{i_data0, i_data1, i_data2, TERM_CHAR, {4{IDLE_CHAR}}};
	t4_block =	{i_data0, i_data1, i_data2, i_data3, TERM_CHAR, {3{IDLE_CHAR}}};
	t5_block =	{i_data0, i_data1, i_data2, i_data3, i_data4, TERM_CHAR, {2{IDLE_CHAR}}};
	t6_block =	{i_data0, i_data1, i_data2, i_data3, i_data4, i_data5, TERM_CHAR, IDLE_CHAR};
	t7_block =	{i_data0, i_data1, i_data2, i_data3, i_data4, i_data5, i_data6, TERM_CHAR};
	
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
		tx_data = {8{IDLE_CHAR}};
		tx_ctrl = IDLE_CTRL;
	end

	TX_D:
	begin
		tx_data = data_block;
		tx_ctrl = DATA_CTRL;
	end

	TX_T:
	begin
		tx_data = t_blocks[nterm*LEN_TX_DATA -: LEN_TX_DATA];
		tx_ctrl = t_ctrls[nterm*LEN_TX_CTRL -: LEN_TX_CTRL];
	end

end
