/*
	AGREGAR PUERTOS QUE FALTEN(max_invaklid_am por ej)
	VER POR QUE CARAJOS LA SINTESIS ME DICE :
		design lane_id_decoder has unconnected port i_match_mask[0]

*/


module am_lock_module
#(
	parameter LEN_CODED_BLOCK 	= 66,
	parameter NB_BIP 			= 8,
	parameter NB_SH				= 2,
	parameter NB_ERROR_COUNTER  = 32,
	parameter N_ALIGNER 		= 20,
	parameter NB_LANE_ID		= $clog2(N_ALIGNER),
	parameter N_BLOCKS 		 	= 16383, //***FIX cambiar a 16384 p q incluya el am en el periodo
	parameter MAX_INV_AM        = 8,
	parameter NB_INV_AM			= $clog2(MAX_INV_AM)
 )
 (
 	input  wire 							i_clock,
 	input  wire 							i_reset,
 	input  wire 							i_enable,
 	input  wire 							i_valid,//significa que hay un nuevo bloque listo para testear
 	input  wire 							i_block_lock,
 	input  wire [LEN_CODED_BLOCK-1 : 0] 	i_data,
 	input  wire [NB_INV_AM-1 : 0]			i_max_invalid_am,  
 
 	output wire [LEN_CODED_BLOCK-1 : 0] 	o_data,
	output wire [NB_LANE_ID-1 : 0]			o_lane_id,
	output wire [NB_ERROR_COUNTER-1 : 0]	o_error_counter,
	output wire 							o_am_lock,
	output wire 							o_resync,
	output wire 							o_start_of_lane
 );


//LOCALPARAMS
localparam LEN_AM    		= 48;
localparam CTRL_SH 	 		= 2'b10; 
localparam PCS_IDLE  		= 7'h00;
localparam BLOCK_TYPE_CTRL 	= 8'h1E; //[CHECK]


//INTERNAL SIGNALS
reg  [LEN_CODED_BLOCK-1:0]	input_data,output_data;
wire sh_valid;
//Module connect wires
wire [N_ALIGNER-1 : 0]		match_mask; 	//done
wire [N_ALIGNER-1 : 0]		match_vector; 	//done
//wire [TAMANIO DEL CONTADOR : 0]			bip_error_count;//asignar a puerto
wire [LEN_AM-1 : 0] 		am_value;		//done
wire [NB_BIP-1:0] 			calculated_bip, recived_bip;
wire 						timer_done;
wire 						timer_restart;
wire 						am_match; 		//done
wire 						ignore_sh; 		//done
wire 						enable_mask;	//done
wire 						restore_am;		//done




//Update input
always @ (posedge i_clock)
begin
	if (i_valid && i_enable)
		input_data <= i_data;
end

//Output mux
always @ (posedge i_clock)
begin
	//if(i_enable && i_valid && restore_am)
	if(i_enable && i_valid && am_match)
		output_data <= { CTRL_SH,BLOCK_TYPE_CTRL,{8{PCS_IDLE}} }; //CHECK
	//else if(i_enable && i_valid && !restore_am)
	else if(i_enable && i_valid && !am_match)
		output_data <= input_data;
end



assign sh_valid = ( (input_data[LEN_CODED_BLOCK-1 -: NB_SH] == CTRL_SH) | ignore_sh );
assign am_value = {input_data[LEN_CODED_BLOCK-3 -: 24], input_data[31 -: 24]}; //PARAMETRIZAR
assign o_data = output_data;
//Instances

am_lock_comparator
#(
 	.LEN_AM(LEN_AM),
 	.N_ALIGNER(N_ALIGNER)
 )
	u_am_lock_comparator
	(
		.i_enable_mask	(enable_mask),
		.i_timer_done	(timer_done),
		.i_am_value		(am_value),
		.i_match_mask	(match_mask),
		.i_sh_valid		(sh_valid),
		.o_am_match		(am_match),
		.o_match_vector	(match_vector)
	);

am_lock_fsm
#(
	.N_BLOCKS(N_BLOCKS)
 )
 	u_am_lock_fsm
 	(
 		.i_clock		(i_clock),
		.i_reset  		(i_reset),
		.i_enable 		(i_enable),
	 	.i_valid		(i_valid),
	 	.i_block_lock	(i_block_lock),
	 	.i_am_valid		(am_match),
	 	.i_timer_done	(timer_done),
	 	.i_am_invalid_limit(i_max_invalid_am), 
	 	.i_match_vector (match_vector),

	 	.o_match_mask	(match_mask),
	 	.o_ignore_sh	(ignore_sh),
	 	.o_enable_mask	(enable_mask),
	 	.o_reset_count  (timer_restart),
	 	.o_restore_am	(restore_am),
	 	.o_am_lock		(o_am_lock),
	 	.o_resync		(o_resync),
	 	.o_start_of_lane(o_start_of_lane)
 	);

am_timer
#(
	.N_BLOCKS(N_BLOCKS),
	.EXTRA_DELAY(2)
 )
	u_am_timer
	 (
	 	.i_clock		(i_clock),
		.i_reset  		(i_reset),
	 	.i_restart		(timer_restart),//input from fsm
	 	.i_valid		(i_valid),
	 	.i_enable 		(i_enable),

	 	.o_timer_done	(timer_done)
	 );

lane_id_decoder
#(
	.N_ALIGNER(N_ALIGNER)
 )
	u_lane_id_decoder
	(
		.i_match_mask	(match_mask),

		.o_lane_id		(o_lane_id)
	);

/*
am_error_counter
#(
	.NB_BIP(NB_BIP),
	.NB_COUNTER(NB_ERROR_COUNTER)
 )
	u_am_error_counter
	 (
	 	.i_clock 		 (i_clock),
	 	.i_reset 		 (i_reset),
	 	.i_enable 		 (i_enable),
	 	.i_match 		 (am_match),
	 	.i_recived_bip 	 (recived_bip),
	 	.i_calculated_bip(calculated_bip),
	 	.o_error_count	 (bip_error_count)
	 );
*/
/**checkear puertos y logica
bip_calculator
#(
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK)
 )
	u_bip_calculator
	 (
	 	.i_clock(i_clock),
	 	.i_reset(i_reset),
	 	.i_data(input_data),
	 	.i_enable(i_enable),

	 	.o_bip3(bip3),
	 	.o_bip7(bip7)
	 );
*/

endmodule

