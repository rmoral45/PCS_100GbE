
/*
 * Verificar : si i_data entraria con esta forma o con la otra 
 * i_data = [phy_lane_0_data, phy_lane_1_data, ...... , phy_lane_19_data]
 *
 *
 */
`timescale 1ns/100ps

module parallel_converter_N_to_1
#(
	parameter LEN_CODED_BLOCK 	= 66,
	parameter N_LANES 			= 20,
	parameter NB_DATA_BUS		= (LEN_CODED_BLOCK * N_LANES) 
 )
 (
 	input  wire 						i_clock, //system clock
 	input  wire 						i_reset, //system reset
 	input  wire 						i_enable,
 	input  wire 						i_valid, //valid del clock mas rapido, osea el del scrambler
 	input  wire [NB_DATA_BUS-1 : 0] 	i_data,
 	output wire [LEN_CODED_BLOCK-1 : 0] o_data
 );


//LOCALPARAMS
localparam NB_INDEX = $clog2(N_LANES);


//INTERNAL SIGNALS

reg [NB_INDEX-1 : 0] index;

//PORTS

assign o_data = i_data[(index*LEN_CODED_BLOCK)-1 -: LEN_CODED_BLOCK];


always @ (posedge i_clock)
begin
	if (i_reset)
		index <= N_LANES;
	else if (i_enable && i_valid)
		index <= (index > 1) ? index - 1'b1 : N_LANES;
end

/*
//Update index
always @ (posedge i_clock)
begin
	if (i_reset)
		index <= {NB_INDEX{1'b0}};

	else if (i_enable && i_valid)
	begin
		index <= {NB_INDEX{1'b0}}; //laslanes indican dato nuevo,se reinicia el indice de salida  
	end
	else if (i_enable // && pulso que indica que debe cambiar la salida(data_request))
	begin
		if(index < N_LANES-1)
			index <= index + 1; 
	end
end
*/


endmodule
