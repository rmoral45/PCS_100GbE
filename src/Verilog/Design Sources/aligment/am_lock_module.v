/*
       - Agregar puerto i_rf_compare_mask p reemplazar senal
         interna compare config mask

*/

`timescale 1ns/100ps
module am_lock_module
#(
	parameter NB_CODED_BLOCK   = 66,
	parameter NB_ERROR_COUNTER  = 32,
	parameter N_ALIGNER 	    = 20,
	parameter NB_LANE_ID	    = $clog2(N_ALIGNER),
	parameter N_BLOCKS 	    = 16383, //[FIX] cambiar a 16384 p q incluya el am en el periodo
	parameter MAX_INV_AM        = 8,
	parameter NB_INV_AM	    = $clog2(MAX_INV_AM),
	parameter MAX_VAL_AM        = 20,
    	parameter NB_VAL_AM         = $clog2(MAX_VAL_AM),
        parameter NB_AM             = 48
 )
 (
 	input  wire 				i_clock,		//sys clock
 	input  wire 				i_reset,		//sys or uBlaze reset
 	input  wire 				i_rf_enable,		//from register_file
 	input  wire 				i_valid,		//from clock divider(valid signal generator)
 	input  wire 				i_block_lock,		//from block_sync module
 	input  wire [NB_CODED_BLOCK-1 : 0] 	i_data,			//from block_sync module
 	input  wire [NB_INV_AM-1 : 0]		i_rf_invalid_am_thr,  	//from top level am_lock control module, or register file
 	input  wire [NB_VAL_AM-1 : 0]           i_rf_valid_am_thr, 	//from top level am_lock control module, or register file
        input  wire [NB_AM-1 : 0]               i_rf_compare_mask,      //from register_file, configurable mask for aligner match
 
 	output wire [NB_CODED_BLOCK-1 : 0] 	o_data,			//to programable_fifo/lane_deskew module
	output wire [NB_LANE_ID-1 : 0]		o_lane_id,		//to lane reorder module
	output wire [NB_ERROR_COUNTER-1 : 0]	o_error_counter,	//to register_file/MDIO register
	output wire 				o_am_lock,		//to lane deskew module
	output wire 				o_resync,	 	//to programable_fifo/lane_deskew modul	
	output wire 				o_start_of_lane		//to programable_fifo/lane_deskew modul
 );


//LOCALPARAMS
localparam NB_BIP 	        = 8;
localparam NB_SH		= 2;
localparam BIP_MSB_POS          = NB_CODED_BLOCK-NB_SH-24-1;
localparam CTRL_SH 	 	= 2'b10; 
localparam PCS_IDLE  		= 7'h00;
localparam BLOCK_TYPE_CTRL 	= 8'h1E; 


//INTERNAL SIGNALS
reg  [NB_CODED_BLOCK-1 : 0]	input_data,output_data;

//Module connect wires
wire [N_ALIGNER-1 : 0]		match_mask; 			//done
wire [N_ALIGNER-1 : 0]		match_vector; 			//done
wire [NB_AM-1 : 0] 		am_value;			//done
wire [NB_BIP-1: 0] 		calculated_bip, recived_bip;	//terminar al definir que bip_calc usar
wire 				compare_timer_trigg;		//done
wire 				am_match; 			//done
wire 				enable_mask;			//done
wire 				start_of_lane;                  //done
wire                            resync;                         //done

assign recived_bip = i_data[BIP_MSB_POS -: NB_BIP]; //[CHECK]

//Output mux
always @ *
begin

	if(i_rf_enable && i_valid && start_of_lane)
		output_data = { CTRL_SH,BLOCK_TYPE_CTRL,{8{PCS_IDLE}} }; //CHECK
	else if(i_rf_enable && i_valid && !start_of_lane)
		output_data = i_data;

end


assign am_value 	= {i_data[NB_CODED_BLOCK-3 -: 24], i_data[31 -: 24]}; //PARAMETRIZAR

//PORTS
assign o_data 		= output_data;
assign o_start_of_lane  = start_of_lane;
assign o_resync         = resync;


//Instances

am_lock_comparator_v2
#(
 	.LEN_AM(NB_AM),
 	.N_ALIGNER(N_ALIGNER)
 )
	u_am_lock_comparator
	(
		//INPUTS
		.i_enable_mask	(enable_mask),		//from fsm
		.i_timer_done	(compare_timer_trigg),	//from fsm
		.i_am_value	(am_value),		//internal
		.i_compare_mask (i_rf_compare_mask),	//from top level
		.i_match_mask	(match_mask),		//from fsm

		//OUTPUTS
		.o_am_match	(am_match),		//to fsm
		.o_match_vector	(match_vector)		//to fsm
	);

am_lock_fsm
#(
	.N_BLOCKS(N_BLOCKS)
 )
 	u_am_lock_fsm
 	(
		//INPUTS
 		.i_clock		(i_clock),		//from top  level
		.i_reset  		(i_reset),		//from top level
		.i_enable 		(i_rf_enable),		//from top level
	 	.i_valid		(i_valid),		//from top level
	 	.i_block_lock		(i_block_lock),		//from block_sync
	 	.i_am_valid		(am_match),		//from comparator
	 	.i_match_vector 	(match_vector),		//from comparator
	 	.i_lock_thr     	(i_rf_valid_am_thr),   	//input from top
	 	.i_unlock_thr   	(i_rf_invalid_am_thr), 	//input from top

		//OUTPUTS
	 	.o_match_mask		(match_mask),		//to comparator
	 	.o_enable_mask		(enable_mask),		//to comparator
	 	.o_am_lock		(o_am_lock),		//to top level
	 	.o_resync_by_am_start	(resync),		//to top level
	 	.o_start_of_lane	(start_of_lane),	//to top level
		.o_search_timer_done 	(compare_timer_trigg) 	//to comparator
 	);
 	


lane_id_decoder
#(
	.N_ALIGNER(N_ALIGNER)
 )
	u_lane_id_decoder
	(
		.i_match_mask	(match_mask),	//from fsm

		.o_lane_id	(o_lane_id)	//to top level
	);


am_error_counter
#(
	.NB_BIP(NB_BIP),
	.NB_COUNTER(NB_ERROR_COUNTER)
 )
	u_am_error_counter
	 (
	 	.i_clock 		(i_clock),		//from top level
	 	.i_reset 		(i_reset),		//from top level
	 	.i_enable 		(i_rf_enable),		//from top level
		//
		// [CHECK] <<<< i_match >>>>>>
		// El trigger para calcular el match deberia ser
		// probablemente la senial de SOL, revisar 
		//
	 	.i_match 		(start_of_lane),	//from comparator
                .i_reset_count          (resync),
	 	.i_recived_bip 	 	(recived_bip),		//from input reg
	 	.i_calculated_bip	(calculated_bip),	//from bip_calc
	 	.o_error_count	 	(o_error_counter)	//to top level
	 );


bip_calculator
#(
	.LEN_CODED_BLOCK(NB_CODED_BLOCK)
 )
	u_bip_calculator
	 (
	 	.i_clock	(i_clock),      //from top level
	 	.i_reset	(i_reset),      //from top level
	 	.i_data		(i_data),       //from top level
	 	.i_enable	(i_rf_enable),  //from register file
		.i_start_of_lane(start_of_lane | resync),//from fsm

	 	.o_bip3		(calculated_bip),         //to error counter
	 	.o_bip7		(bip7)          //to error counter
	 );


endmodule

