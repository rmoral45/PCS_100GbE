




module parallel_converter_N_to_1
#(
	parameter LEN_CODED_BLOCK 	= 66,
	parameter N_LANES 			= 20,
	parameter NB_INPUT 			= (LEN_CODED_BLOCK * N_LANES) 
 )
 (
 	input  wire 							i_clock,
 	input  wire 							i_reset,
 	input  wire 							i_enable,
 	input  wire 							i_valid,
 	input  wire [NB_INPUT-1 : 0] 			i_data,
 	output wire [LEN_CODED_BLOCK-1 : 0] 	o_data
 );


//LOCALPARAMS
localparam NB_INDEX = $clog2(N_LANES);


//INTERNAL SIGNALS

reg [NB_INPUT-1 : 0] data;
reg [NB_INDEX-1 : 0] index;


//PORTS

assign o_data = data[(index*LEN_CODED_BLOCK) +: LEN_CODED_BLOCK];

//Update index
always @ (posedge i_clock)
begin
	if (i_reset)
		index <= {NB_INDEX{1'b0}};

	else if (i_enable && i_valid)
	begin
		index <= {NB_INDEX{1'b0}}; //laslanes indican dato nuevo,se reinicia el indice de salida  
	end
	else if (i_enable /* && pulso que indica que debe cambiar la salida(data_request)*/)
	begin
		if(index < N_LANES-1)
			index <= index + 1; 
	end
end

always @ (posedge i_clock)
begin
	if(i_enable && i_valid)
		data <= i_data;
end




endmodule
