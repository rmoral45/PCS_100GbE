`timescale 1ns/100ps


/*
 * Recibe como entrada los datos de las N lineas, 
 * los ID's reordenados(osea,el equivalente al selector de cada mux)
 * la idea es que al ya estar ordenados los ids ya tendriamos el orden
 * en el que debemos leer los datos, por ejemplo :
 * si la lane_fisica_9 esta recibiendo los datos de la lane_logica_0,
 * y la lane_fisica_2 los de la lane_logica_1, el bus de id va a estar
 * ordenado de la siguiente forma [ 9, 2, ......] entonces, si tenemos 
 * un unico mux de N_LANES*NB_DATA de entrada y NB_DATA de salida
 * el selector del mux deberia ir tomando sucesivamente el valor
 * 9, 2,..etc lo cual se puede expresar como shift register, de esa forma
 * esta cumpliendo dos funciones, la de reordenamiento y la de conversor
 * de paralelismo de N a 1.
 * 
 * Las entradas se asumen de la sioguiente forma :
 *      i_lane_ids = {lane_0_selector,.....lane_N_selector}
 *      i_data     = {phy_lane_0, ...., phy_lane_N}
 */
module lane_swap_v2
#(
        parameter NB_DATA     = 66,
        parameter N_LANES     = 20,
        parameter NB_ID       = $clog2(N_LANES),
        parameter NB_DATA_BUS = NB_DATA * N_LANES,
        parameter NB_ID_BUS   = NB_ID   * N_LANES
 )
 (
        input  wire                     i_clock,
        input  wire                     i_reset,
        input  wire                     i_enable,
        input  wire                     i_valid,
        input  wire                     i_reorder_done,
        input  wire [NB_DATA_BUS-1 : 0] i_data,
        input  wire [NB_ID_BUS-1 : 0]   i_lane_ids,

        output wire [NB_DATA-1 : 0]     o_data
 );


//LOCALPARAMS

//INTERNAL SIGNALS

reg  [NB_ID_BUS-1 : 0]  lane_id_sr;
wire [NB_ID-1 : 0]      rd_ptr;
wire [NB_DATA-1 : 0]  lane_data  [N_LANES-1 : 0];

//PORTS
assign o_data = lane_data[rd_ptr];

always @ (posedge i_clock)
begin
        if (i_reset)
                lane_id_sr <= {NB_ID_BUS{1'b0}};
        else if (i_reorder_done || i_valid)
                lane_id_sr <= i_lane_ids;
        else if (i_enable)
                lane_id_sr <= {lane_id_sr[NB_ID_BUS - NB_ID - 1 : 0], lane_id_sr[NB_ID_BUS-1 -: NB_ID]};
end
assign rd_ptr = lane_id_sr[NB_ID_BUS-1 -: NB_ID];

genvar i;
generate

        for (i = 0; i< N_LANES; i = i + 1)
        begin : SPLIT_LANES 
             assign  lane_data[i] = i_data[NB_DATA_BUS-(NB_DATA*i)-1 -: NB_DATA];
        end

endgenerate
endmodule
