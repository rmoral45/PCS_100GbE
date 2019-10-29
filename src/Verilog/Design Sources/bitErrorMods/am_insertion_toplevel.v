`timescale 1ns/100ps

module am_insertion_toplevel
#(
	parameter 							            LEN_TAGGED_BLOCK     = 67,
    parameter                                       LEN_CODED_BLOCK      = 66,
    parameter                                       N_LANES             = 20,
	//parameter 							            AM_ENCODING_LOW     = 24'd0, //{M0,M1,M2} tabla 82-2
	//parameter 							            AM_ENCODING_HIGH    = 24'd0,  //{M4,M5,M6} tabla 82-2
    parameter                                       NB_AM_ENCODING      = $clog2(AM_ENCODING_HIGH),
	parameter 							            NB_BIP              = 8
)
(
    input wire                                      i_clock,
    input wire                                      i_reset,
    input wire                                      i_valid,
    input wire                                      i_enable,
    input wire  [(LEN_TAGGED_BLOCK*N_LANES)-1 : 0]  i_data,

    output wire [(LEN_CODED_BLOCK*N_LANES)-1 : 0]   o_data
);

    //LANE_MARKERS'S MATRIX
    localparam [NB_AM_ENCODING-1 : 0] AM_ENCODING_LOW [N_LANES-1 : 0]   = {{8'hC1, 8'h68, 8'h21},
                                                                           {8'h9D, 8'h71, 8'h8E},
                                                                           {8'h59, 8'h4B, 8'hE8},
                                                                           {8'h4D, 8'h95, 8'h7B},
                                                                           {8'hF5, 8'h07, 8'h09},
                                                                           {8'hDD, 8'h14, 8'hC2},
                                                                           {8'h9A, 8'h4A, 8'h26},
                                                                           {8'h7B, 8'h45, 8'h66},
                                                                           {8'hA0, 8'h24, 8'h76},
                                                                           {8'h68, 8'hC9, 8'hFB}
                                                                           {8'hFD, 8'h6C, 8'h99},
                                                                           {8'hB9, 8'h91, 8'h55},
                                                                           {8'h5C, 8'hB9, 8'hB2},
                                                                           {8'h1A, 8'hF8, 8'hBD},
                                                                           {8'h83, 8'hC7, 8'hCA},
                                                                           {8'hC4, 8'h31, 8'h4C},
                                                                           {8'hAD, 8'hD6, 8'hB7},
                                                                           {8'h5F, 8'h66, 8'h2A},
                                                                           {8'hC0, 8'hF0, 8'hE5}}; 
    localparam [NB_AM_ENCODING-1 : 0] AM_ENCODING_HIGH [N_LANES-1 : 0]  = {{8'h3E, 8'h97, 8'hDE},
                                                                           {8'h62, 8'h8E, 8'h71},
                                                                           {8'hA6, 8'hB4, 8'h17},
                                                                           {8'hB2, 8'h6A, 8'h84},
                                                                           {8'h0A, 8'hF8, 8'hF6},
                                                                           {8'h22, 8'hEB, 8'h3D},
                                                                           {8'h65, 8'hB5, 8'hD9},
                                                                           {8'h84, 8'hBA, 8'h99},
                                                                           {8'h5E, 8'hDB, 8'h89},
                                                                           {8'h97, 8'h36, 8'h04}
                                                                           {8'h02, 8'h93, 8'h66},
                                                                           {8'h46, 8'h6E, 8'hAA},
                                                                           {8'hA3, 8'h46, 8'h4D},
                                                                           {8'hE5, 8'h07, 8'h42},
                                                                           {8'h7C, 8'h38, 8'h35},
                                                                           {8'hCA, 8'hC9, 8'h32},
                                                                           {8'h3B, 8'hCE, 8'hB3},
                                                                           {8'h52, 8'h29, 8'h48},
                                                                           {8'hA0, 8'h99, 8'hD5},
                                                                           {8'h3F, 8'h0F, 8'h1A}};                                                                                                                

    //Vector que almacena los tags de cada lane
    wire        [(LEN_CODED_BLOCK*N_LANES)-1 : 0]     out_data;  
        

    assign                                          o_data = out_data;


    genvar i;
    //generate

    for (i=0; i<N_LANES; i=i+1)
    begin :ger_block
        am_insertion
        #(
            .LEN_CODED_BLOCK    (LEN_CODED_BLOCK),
            .AM_ENCODING_LOW    (AM_ENCODING_LOW[i]),
            .AM_ENCODING_HIGH   (AM_ENCODING_HIGH[i]),
            .NB_BIP             (NB_BIP)
        )
        u_am_insertion
        (
            .i_clock            (i_clock),
            .i_reset            (i_reset),
            .i_enable           (i_enable && i_valid),
            .i_valid            (i_valid),
            .i_am_insert        (i_data[(LEN_TAGGED_BLOCK*N_LANES)-1 - i*LEN_TAGGED_BLOCK]),
            .i_data             (i_data[(LEN_TAGGED_BLOCK*N_LANES)-2 -(i*LEN_TAGGED_BLOCK) -: LEN_CODED_BLOCK]),
            .o_data             (out_data[((LEN_CODED_BLOCK*N_LANES)-1) -(i*LEN_CODED_BLOCK) -: LEN_CODED_BLOCK])
        );
        
    end

    //endgenerate

endmodule