/*
	Falta FSM y contador de errores.
	Faltan agregar salidas del modulo(resync,)

*/


module am_lock_module
#(
	parameter LEN_CODED_BLOCK = 66,
	parameter N_ALIGNER = 20
 )
 (
 	input  wire i_clock,
 	input  wire i_reset,
 	input  wire i_enable,
 	input  wire i_valid,//significa que hay un nuevo bloque listo para testear
 	input  wire i_data, //bloque recibido
 	input wire [N_ALIGNER-1 : 0] i_match_mask,

 	output reg o_data,
	output wire o_lane_id,
	output wire o_am_lock
 );


//LOCALPARAMS
localparam LEN_AM    = 48;

localparam AM_LANE_0  = 48'hC168213E97DE;
localparam AM_LANE_1  = 48'h9D718E628E71;
localparam AM_LANE_2  = 48'h594BE8A6B417;
localparam AM_LANE_3  = 48'h4D957BB26A84;
localparam AM_LANE_4  = 48'hF507090AF8F6;
localparam AM_LANE_5  = 48'hDD14C222EB3D;
localparam AM_LANE_6  = 48'h9A4A2665B5D9;
localparam AM_LANE_7  = 48'h7B456684BA99;
localparam AM_LANE_8  = 48'hA024765FDB89;
localparam AM_LANE_9  = 48'h68C9FB973604;
localparam AM_LANE_10 = 48'hFD6C99029366; //check
localparam AM_LANE_11 = 48'hB99155466EAA;
localparam AM_LANE_12 = 48'h5CB9B2A3464D;
localparam AM_LANE_13 = 48'h1AF8BDE50742;
localparam AM_LANE_14 = 48'h83C7CA7C3835;
localparam AM_LANE_15 = 48'h3536CDCAC932;
localparam AM_LANE_16 = 48'hC4314C3BCEB3;
localparam AM_LANE_17 = 48'hADD6B7522948;
localparam AM_LANE_18 = 48'h5F662AA099D5;
localparam AM_LANE_19 = 48'hC0F0E53F0F1A;

localparam CTRL_SH = 2'b10; //[CHECK]

localparam PCS_IDLE = 7'h00;
//INTERNAL SIGNALS

integer i;

reg [LEN_AM*N_ALIGNER-1 : 0] 	  aligners; 
reg [N_ALIGNER-1 : 0] 			  match_mask; //salida de fsm
reg [N_ALIGNER-1 : 0] 			  match_vector;//salida de comparadores
reg [N_ALIGNER-1 : 0] 			  match_expected_am;
reg [LEN_AM-1 : 0] 				  am_value;// bits
reg [LEN_CODED_BLOCK-1:0]		  data;
//maybe in another module :P
reg match_payload;
reg enable;
reg match;
reg enable_mask;

wire [7:0] bip3;
wire [7:0] bip7;
wire timer_done;
wire timer_restart;

//Update input
always @ (posedge i_clock)
begin
	if(i_reset)
		data <= {LEN_CODED_BLOCK{1'b0}};
	else if (i_valid && i_enable)
		data <= i_data;
end

//Output mux
always @ *
begin
	if(match) //match es la salida del bloque comparador
		o_data = { 2'b10, {8{PCS_IDLE}} };
	else
		o_data = data;
 end

//Instances
/*
am_lock_error_counter
#(
 )
 (
 	.i_clock(),
 	.i_reset(),
 	.i_enable(//match),
 	.i_rx_bip3(),//bip calc from am
 	.i_rx_bip7(),
 	.i_self_bip3(bip3), //bip calc from bip calculator
 	.i_self_bip7(bip7)
 );
*/

am_lock_comparator
#(
 	.LEN_AM(LEN_AM),
 	.N_ALIGNER(N_ALIGNER)
 )
	u_am_lock_comparator
	(
		.i_enable_mask(),
		.i_timer_done(),
		.i_am_value(),
		.i_match_mask(),

		.o_match()
		.o_match_vector()
	)
bip_calculator
#(
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK)
 )
	u_bip_calculator
	 (
	 	.i_clock(i_clock),
	 	.i_reset(i_reset),
	 	.i_data(data),
	 	.i_enable(i_enable),

	 	.o_bip3(bip3),
	 	.o_bip7(bip7)
	 );

am_timer
#(
	.N_BLOCKS(16383)
 )
	u_am_timer
	 (
	 	.i_clock(i_clock),
		.i_reset(i_reset),
	 	.i_restart(timer_restart),//input from fsm
	 	.i_valid(i_valid),
	 	.i_enable(i_enable),

	 	.o_timer_done(timer_done)
	 );

endmodule

