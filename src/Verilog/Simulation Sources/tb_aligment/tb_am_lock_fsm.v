`timescale 1ns/100ps

module tb_am_lock_fsm;

localparam N_ALIGNERS 	  = 20;
localparam N_BLOCKS   	  = 10;
localparam MAX_INVALID_AM = 8;
localparam MAX_VALID_AM   = 20;
localparam NB_INVALID_CNT = $clog2(MAX_INVALID_AM);
localparam NB_VALID_CNT   = $clog2(MAX_VALID_AM);

// simulation control regs
/*
	El parametro TEST_TYPE define que tipo de test se desea realizar,
	estos son enumerados a continuacion :

		-LOCK_STRAIGHT : 
						Descripcion : Setea tb_am_valid = 1, luego vuelve a hacerlo cada N_BLOCK,esto simula
						 			  la llegada continua de alineadores validos siempre en la misma posicion.

						Resultado   : Se deberia alcanzar el estado locked y permanecer en este hasta el fin
									  de la simulacion.

		-LOCK_RESYNC   : 
						Descripcion : Setea tb_am_valid = 1, luego vuelve a hacerlo cada N_BLOCK MAX_VALID_AM veces
						 			  para lograr alcanzar el estado LOCKED, luego comienza a setear tb_am_valid = 1
						 			  en una posicion distinta, para forzar a que se busque la nueva posicion de alineador.

						Resultado   : Se deberia enviar la senal o_resync_by_am_start. //COMPLETAR

		-LOCK_NO_RESYNC :
						Descripcion : Setea tb_am_valid = 1, luego vuelve a hacerlo cada N_BLOCK MAX_VALID_AM veces
						 			  para lograr alcanzar el estado LOCKED, luego comienza a setear tb_am_valid = 0
						 			  cada N_BLOCKS (MAX_INVALID_AM veces) hasta perder el estado LOCKED, y vuelve a
						 			  setear tb_am_valid = 1 cada N_BLOCKS en la misma posicion que en la que se obtuvo
						 			  el estado LOCKED.

						Resultado   : Se deberia recuperar el estado LOCKED sin o_resync_by_am_start;
*/
// tipos de test

localparam LOCK_STRAIGHT 	= 0;
localparam LOCK_RESYNC 		= 1;
localparam LOCK_NO_RESYNC 	= 2;

//parametros de simulacion
localparam TEST_TYPE 			= LOCK_NO_RESYNC;
localparam MAX_CLOCK_RISING_CNT = 100000;
localparam NB_CLK_CNT 			= $clog2(MAX_CLOCK_RISING_CNT);

//LOCK_RESYNC
localparam AM_PHASE   = 3; //por ej si se deberia recibir am valido en tiempo t, en STAGE_1 y STAGE_2 
						  // se recibiran en t+AM_PHASE

localparam LR_STAGE_0_LL = 0;	//inicio intervalo de tiempo en el que obtengo LOCKED
localparam LR_STAGE_0_HL = N_BLOCKS*MAX_VALID_AM;	//fin intervalo 

localparam LR_STAGE_1_LL = LR_STAGE_0_HL + AM_PHASE;	//inicio intervalo en que los am empiezan a llegar en disitntos momentos
localparam LR_STAGE_1_HL = LR_STAGE_1_LL + (N_BLOCKS*MAX_INVALID_AM*20);//fin intervalo

//LOCK_NO_RESYNC
localparam LNR_STAGE_0_LL = 150; //random
localparam LNR_STAGE_0_HL = LNR_STAGE_0_LL + (N_BLOCKS*MAX_VALID_AM*2);

localparam LNR_STAGE_1_LL = LNR_STAGE_0_HL;
localparam LNR_STAGE_1_HL = LNR_STAGE_1_LL + (N_BLOCKS*MAX_INVALID_AM);

localparam LNR_STAGE_2_LL = LNR_STAGE_1_HL;
localparam LNR_STAGE_2_HL = LNR_STAGE_1_HL + (N_BLOCKS*MAX_VALID_AM*3);


reg simulation_start;
reg [NB_CLK_CNT-1 : 0]sim_clock_counter;
//reg [MAX_CLOCK_RISING_CNT-1 : 0] tb_gen_signal_valid;

// FSM input and outputs
reg 						tb_clock;
reg 						tb_reset;
reg 						tb_enable;
reg 						tb_valid;
reg 						tb_block_lock;
//reg 						tb_am_valid;
reg [N_ALIGNERS-1 : 0]		tb_match_vector;
reg [NB_VALID_CNT-1 : 0]	tb_lock_thr;
reg [NB_INVALID_CNT-1 : 0]	tb_unlock_thr;

wire  						tb_am_valid;
wire 						tb_enable_mask;
wire 						tb_am_lock;
wire 						tb_resync_by_am_start;
wire 						tb_start_of_lane;
wire 						tb_restore_am;
wire [N_ALIGNERS-1 : 0] 	tb_match_mask;

always #1 tb_clock = ~tb_clock;

initial
begin
	simulation_start 	= 0;
	sim_clock_counter 	= {NB_CLK_CNT{1'b0}};

	tb_clock  		= 0;
	tb_reset  		= 1;
	tb_enable 		= 0;
	tb_valid  		= 0;
	tb_block_lock 	= 0;
	//tb_am_valid 	= 0;
	tb_match_vector = 0;
	tb_lock_thr 	= 3;
	tb_unlock_thr 	= 5;	

	#10	tb_reset  = 0;
		tb_enable = 1;

	#10 tb_valid  = 1;
		simulation_start = 1;

	#20 tb_block_lock = 1;

end

integer i;
generate //START_GENERATE

if (TEST_TYPE == LOCK_STRAIGHT)
begin : gen_AM_VALID_LOCK_STRAIGHT

	reg [MAX_CLOCK_RISING_CNT-1 : 0] tb_gen_signal_valid = {MAX_CLOCK_RISING_CNT{1'b0}};
	always @ (posedge tb_clock)
	begin
		for( i = 0; i < MAX_CLOCK_RISING_CNT; i = i+1)
		begin
			if ((i % N_BLOCKS) == 0)
				tb_gen_signal_valid[i] = 1;
		end
	end
	assign tb_am_valid = tb_gen_signal_valid[sim_clock_counter];

end//end_gen_AM_VALID_LOCK_STRAIGHT

else if (TEST_TYPE == LOCK_RESYNC)
begin : gen_AM_VALID_LOCK_RESYNC
	
	reg [MAX_CLOCK_RISING_CNT-1 : 0] tb_gen_signal_valid = {MAX_CLOCK_RISING_CNT{1'b0}};
	always @ (posedge tb_clock)
	begin

		for( i = LR_STAGE_0_LL; i < LR_STAGE_0_HL; i = i+1)
		begin
			if ((i % N_BLOCKS) == 0)
				tb_gen_signal_valid[i] = 1;	
		end

		for( i = LR_STAGE_1_LL; i < LR_STAGE_1_HL; i = i+1)
		begin
			if ((i % N_BLOCKS) == AM_PHASE)
				tb_gen_signal_valid[i] = 1;	
		end
	end
	assign tb_am_valid = tb_gen_signal_valid[sim_clock_counter];

end//end_gen_AM_VALID_LOCK_RESYNC

else if (TEST_TYPE == LOCK_NO_RESYNC)
begin : gen_AM_VALID_LOCK_NO_RESYNC
	
	reg [MAX_CLOCK_RISING_CNT-1 : 0] tb_gen_signal_valid = {MAX_CLOCK_RISING_CNT{1'b0}};
	always @ (posedge tb_clock)
	begin

		for( i = LNR_STAGE_0_LL; i < LNR_STAGE_0_HL; i = i+1)
		begin
			if ((i % N_BLOCKS) == 0)
				tb_gen_signal_valid[i] = 1;	
		end

		for( i = LNR_STAGE_1_LL; i < LNR_STAGE_1_HL; i = i+1)
		begin
				tb_gen_signal_valid[i] = 0;	
		end


		for( i = LNR_STAGE_2_LL; i < LNR_STAGE_2_HL; i = i+1)
		begin
			if ((i % N_BLOCKS) == 0)
				tb_gen_signal_valid[i] = 1;	
		end

	end
	assign tb_am_valid = tb_gen_signal_valid[sim_clock_counter];

end//end_gen_AM_VALID_LOCK_NO_RESYNC

else
begin : gen_TEST_TYPE_UNDEFINED

	reg [MAX_CLOCK_RISING_CNT-1 : 0] tb_gen_signal_valid = {MAX_CLOCK_RISING_CNT{1'b0}};
	always @ (posedge tb_clock)
	begin
		tb_gen_signal_valid = {MAX_CLOCK_RISING_CNT{1'b1}};	
	end	
	assign tb_am_valid = tb_gen_signal_valid[sim_clock_counter];

end // end_gen_TEST_TYPE_UNDEFINED

endgenerate //END_GENERATE


always @( posedge tb_clock )
begin
	if (tb_reset)
		sim_clock_counter <= 0 ; 
	else if ( simulation_start )
		sim_clock_counter <= sim_clock_counter + 1'b1;
end



am_lock_fsm
#(
	.N_ALIGNERS 	(N_ALIGNERS),
	.N_BLOCKS  		(N_BLOCKS),	 
	.MAX_INVALID_AM (MAX_INVALID_AM),
	.MAX_VALID_AM   (MAX_VALID_AM),
	.NB_INVALID_CNT (NB_INVALID_CNT),
	.NB_VALID_CNT   (NB_VALID_CNT)
 )
u_am_lock_fsm
 (
 	.i_clock 				(tb_clock),
 	.i_reset 				(tb_reset),
 	.i_enable 				(tb_enable),
 	.i_valid 				(tb_valid),
 	.i_block_lock			(tb_block_lock),
 	.i_am_valid 			(tb_am_valid),
 	.i_match_vector 		(tb_match_vector),
 	.i_lock_thr 			(tb_lock_thr),
 	.i_unlock_thr 			(tb_unlock_thr),


 	.o_match_mask 			(tb_match_mask),
 	.o_enable_mask 			(tb_enable_mask),
 	.o_am_lock 				(tb_am_lock),
 	.o_resync_by_am_start	(tb_resync_by_am_start),
 	.o_start_of_lane 		(tb_start_of_lane),
 	.o_restore_am 			(tb_restore_am)
 );

 endmodule
