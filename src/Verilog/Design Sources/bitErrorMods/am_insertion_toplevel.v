`timescale 1ns/100ps

module am_insertion_toplevel
#(
	parameter 							            NB_TAGGED_BLOCK     = 67,
    parameter                                       NB_CODED_BLOCK      = 66,
    parameter                                       N_LANES             = 20,
	parameter 							            AM_ENCODING_LOW     = 24'd0, //{M0,M1,M2} tabla 82-2
	parameter 							            AM_ENCODING_HIGH    = 24'd0,  //{M4,M5,M6} tabla 82-2
	parameter 							            NB_BIP              = 8
)
(
    input wire                                      i_clock,
    input wire                                      i_reset,
    input wire                                      i_valid,
    input wire                                      i_enable,
    input wire  [(NB_TAGGED_BLOCK*N_LANES)-1 : 0]   i_data,

    output wire [(NB_CODED_BLOCK*N_LANES)-1 : 0]    o_data
);

    //Vector que almacena los tags de cada lane
    reg         [N_LANES-1 : 0]                     am_insert_vector;
    reg         [NB_CODED_BLOCK*N_LANES : 0]        out_data;
    //reg         [NB_CODED_BLOCK*N_LANES-1 : 0]      data_vector;

    assign                                          o_data = out_data;

    genvar i;
    //generate

    for (i=0; i<N_LANES; i=i+1)
    begin :ger_block
        am_insertion
        #(
            .NB_CODED_BLOCK     (NB_CODED_BLOCK),
            .N_LANES            (N_LANES),
            .AM_ENCODING_LOW    (AM_ENCODING_LOW),
            .AM_ENCODING_HIGH   (AM_ENCODING_HIGH),
            .NB_BIP             (NB_BIP)
        )
        u_am_insertion
        (
            .i_clock            (i_clock),
            .i_reset            (i_reset),
            .i_enable           (i_enable),
            .i_am_insert        (i_data[(NB_TAGGED_BLOCK*N_LANES)-1 - i*NB_TAGGED_BLOCK]),
            .i_data             (i_data[(NB_CODED_BLOCK*N_LANES)-1 -: i*NB_CODED_BLOCK]),
            .o_data             (out_data[(NB_CODED_BLOCK*N_LANES)-1 -: i*NB_CODED_BLOCK])
        );
        
    end

    //endgenerate

endmodule