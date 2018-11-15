/*
  Scrambling en base al polinomio definido en el estandar, 1+ x^39 + x^58.
*/

module parallel_scrambler
#(
	parameter LEN_SCRAMBLER   = 58,
	parameter LEN_CODED_BLOCK = 66,
	parameter SEED			  = 0
 )
 (
 	input wire  						i_clock,
 	input wire  						i_reset,
 	input wire  						i_enable,
 	input wire							i_bypass,
 	input wire  [LEN_CODED_BLOCK-1 : 0] i_data,

 	output wire [LEN_CODED_BLOCK-1 : 0] o_data
 );


//LOCALPARAMS
localparam NB_STAGE_ONE   = 39;
localparam NB_STAGE_TWO   = 19;
localparam NB_STAGE_THREE = 8;

//INTERNAL SIGNALS
integer i, j, k;
wire [1 : 0]				 sync_header;
reg  [LEN_CODED_BLOCK-1 : 0] output_data;
reg  [LEN_CODED_BLOCK-1 : 0] scrambled_data; 
reg  [LEN_SCRAMBLER-1   : 0] scrambler_state;
reg  [NB_STAGE_ONE-1:0] out_1;
reg  [NB_STAGE_TWO-1:0] out_2;
reg  [NB_STAGE_THREE-1:0] out_3;
assign sync_header = i_data[LEN_CODED_BLOCK-1 -: 2];

//PORTS
assign o_data = output_data;

//scrambler state
always @(posedge i_clock)
begin
	if (i_reset)
		scrambler_state <= SEED;
	else if (i_enable && (!i_bypass))
 		scrambler_state <= scrambled_data[57:0];

 	else if (i_enable &&  i_bypass)
 		scrambler_state <= scrambler_state;

end

//output
 always @ (posedge i_clock)
 begin 
 	if(i_reset)
 		output_data <= {LEN_CODED_BLOCK{1'b0}};

 	else if (i_enable && (!i_bypass))
 		output_data <= scrambled_data;

 	else if (i_enable &&  i_bypass)
 		output_data <= i_data;
 end


/*
	el proceso de scrambling se divide en 3 partes.
	1: la salida del scrambler solo depende del estado del scrambler y los bits de entrada
	2: la salida del scrambler depende los del estado del scrambler y algunas salidas de la etapa 1
	3: la salida del scrambler depende de las salidas de la etapa 1.
	Si hacemos el desarrollo temporal del proceso de scrambling secuencial utilizando al registro de estado
	como un shift register, aplicando el polinomio indicado en el estandar obtenemos una salida equivalente a 
	esta realizacion en paralelo.
*/

//ALGORITHM BEGIN
always @ *
begin // etapa 1
	out_1 = {NB_STAGE_ONE{1'b0}};
	for(i=0; i<NB_STAGE_ONE; i=i+1)
		out_1[(NB_STAGE_ONE-1)-i] = (i_data[63-i] ^ scrambler_state[57-i] ^ scrambler_state[38-i]);
end

always @ *
begin // etapa 2
	out_2 = {NB_STAGE_TWO{1'b0}};
	for(j=0; j<NB_STAGE_TWO; j=j+1)
		out_2[(NB_STAGE_TWO-1)-j] = (i_data[24-j] ^ scrambler_state[18-j] ^ out_1[(NB_STAGE_ONE-1)-j]);
end

always @ *
begin // etapa 3
	out_3 ={NB_STAGE_THREE{1'b0}};
	for(k=0; k<NB_STAGE_THREE; k=k+1)
		out_3[(NB_STAGE_THREE-1)-k] = (i_data[5-k] ^ out_1[(NB_STAGE_ONE-1) - k] ^ out_1[(NB_STAGE_ONE-20-1)-k])

	scrambled_data = {sync_header,out_1,out_2,out_3};
end

endmodule