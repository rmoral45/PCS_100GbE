`timescale 1ns/100ps

module am_insertion_toplevel
#(
	parameter 							            LEN_TAGGED_BLOCK     = 67,
    parameter                                       LEN_CODED_BLOCK      = 66,
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
    input wire  [(LEN_TAGGED_BLOCK*N_LANES)-1 : 0]  i_data,

    output wire [(LEN_CODED_BLOCK*N_LANES)-1 : 0]   o_data
);

    //Vector que almacena los tags de cada lane
    wire        [(LEN_CODED_BLOCK*N_LANES)-1 : 0]     out_data;  
        

    assign                                          o_data = out_data;


    genvar i;
    //generate

    for (i=0; i<N_LANES; i=i+1)
    begin :ger_block
        am_insertion
        #(
            .LEN_CODED_BLOCK     (LEN_CODED_BLOCK),
            .AM_ENCODING_LOW    (AM_ENCODING_LOW),
            .AM_ENCODING_HIGH   (AM_ENCODING_HIGH),
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