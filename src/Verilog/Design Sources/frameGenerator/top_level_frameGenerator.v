module top_level_frameGenerator
	#(
	parameter							NB_DATA_RAW		= 64,
	parameter							NB_CTRL_RAW		= 8
	)
	(
	input								i_clock,
	input								i_reset,
	input								i_enable,
	output wire	[NB_DATA_RAW-1 : 0]		o_tx_data,
	output wire	[NB_CTRL_RAW-1 : 0]		o_tx_ctrl
	);


//Registros y parametros para parametrizacion y generacion de ruido
localparam								NB_GNG			= 16;
localparam								NB_TERM			= 3;
localparam								NB_DATA			= 8;
localparam								NB_IDLE			= 5;
wire									noise_enable;
wire                                	noise_valid;
wire [NB_GNG-1:0]						noise_data;
wire [NB_TERM-1:0]						nterm;
wire [NB_DATA-1:0]						ndata;
wire [NB_IDLE-1:0]						nidle;

assign 									noise_enable 	= 1'b1;
assign  								nterm 			= noise_data[NB_GNG-8 -: NB_TERM];	//3 bits mas significativos para establecer el numero de terminate

assign  								ndata 			= (noise_data[NB_GNG-4 -: NB_DATA] > 8'D189) ? 
                                                        8'D189 : (noise_data[NB_GNG-4 -: NB_DATA] == 0) ?
														8'D1 :	noise_data[NB_GNG-4 -: NB_DATA]; //8 bits siguientes para data
assign  								nidle 			= noise_data[NB_GNG-8 -: NB_IDLE]; //6 bits menos significativos para idle



//Registros y parametros para el generador de frames
wire									frameGenerator_enb;
assign 									frameGenerator_enb	= (noise_valid && i_enable) ? 1'b1 : 1'b0;

frameGenerator#(
	.NB_DATA_RAW(NB_DATA_RAW),
	.NB_CTRL_RAW(NB_CTRL_RAW),
	.NB_TERM(NB_TERM),
	.NB_DATA(NB_DATA),
	.NB_IDLE(NB_IDLE)
)
u_frameGenerator(
	.i_clock(i_clock),
	.i_reset(i_reset),
	.i_enable(frameGenerator_enb),
	.i_ndata(ndata),
	.i_nidle(nidle),
	.i_nterm(nterm),
	.o_tx_data(o_tx_data),
	.o_tx_ctrl(o_tx_ctrl)	
	);

gng#(
	)
u_GaussianNoiseGenerator
	(
	.clk(i_clock),
	.rstn(~i_reset),
	.ce(noise_enable),
	.valid_out(noise_valid),
	.data_out(noise_data)
	);

endmodule