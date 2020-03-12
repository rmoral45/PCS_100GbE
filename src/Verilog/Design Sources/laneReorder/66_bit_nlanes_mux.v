`timescale 1ns/100ps

module _66_bit_nlanes_mux
#(
        parameter NB_CODED_BLOCK = 66,
        parameter N_LANES        = 20,
        parameter IN_DATA_BUS    = NB_CODED_BLOCK*N_LANES
 )
 (
        input wire  [N_LANES-1 : 0]             i_lane_id,
        input wire  [IN_DATA_BUS-1 : 0]         i_data,

        output wire [NB_CODED_BLOCK-1 : 0]      o_data
 );

genvar  i;

        for (i=0; i < NB_CODED_BLOCK; i=i+1)
        begin : GEN_BIT_MUXS

                integer j;
                reg [N_LANES-1 : 0] input_data;
                // Al mux que selecciona el bit 0 (bit de mas a la izquierda de cada lane)
                // debo darle como dato de entrada el bit de mas a la izquierda del bus de entrada,
                // es decir el de la posicion IN_DATA_BUS-1(bit 0 de la lane 0), el bit
                // IN_DATA_BUS-1-NB_CODED_BLOCK (bit 0 de la lane 1), y asi sucesivamente
                always @ *
                begin
                        for (j = 0; j < N_LANES; j = j+1)
                        begin
                                input_data[j] = i_data[IN_DATA_BUS-1-(j*NB_CODED_BLOCK)-i];
                        end
                end
                one_hot_20_to_1_mux
	        #(
	  	        .N_LANES(N_LANES)
	         )
	        u_20_bit_mux
	        (
	   	        //INPUT
                        .i_lane_id      (i_lane_id),
                        .i_data         (input_data),

                        //OUTPUT
                        //.o_data           (o_data[i])
                        .o_data         (o_data[NB_CODED_BLOCK-1-i])
	         );

                
        end

endmodule
