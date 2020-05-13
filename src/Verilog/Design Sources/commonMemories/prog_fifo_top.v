module prog_fifo_top
#(
    parameter                           N_LANES           = 20,
    parameter                           NB_DATA_CODED     = 66,
    parameter                           NB_DATA_BUS       = NB_DATA_CODED*N_LANES,
	parameter                           FIFO_DEPTH        = 20,
	parameter                           NB_ADDR           = $clog2(FIFO_DEPTH),
    parameter                           MAX_SKEW          = 16,
    parameter                           NB_DELAY_COUNT    = $clog2(FIFO_DEPTH),
    parameter                           NB_DELAY_BUS      = NB_DELAY_COUNT*N_LANES
)
(
 	input wire  				        i_clock,
	input wire				            i_reset,
    input wire                          i_valid,
    input wire                          i_set_fifo_delay,
 	input wire  				        i_write_enb,
 	input wire  		                i_read_enb,
    input wire  [NB_DELAY_BUS-1 : 0]    i_delay_vector,  
 	input wire  [NB_DATA_BUS-1 : 0]     i_data,

 	output wire [NB_DATA_BUS-1 : 0]     o_data
);

//generate
    genvar                              i;

for(i=0; i<N_LANES; i = i + 1)
begin: gen_fifos

        prog_fifo
        #(
            .N_LANES                    (N_LANES),
            .NB_DATA_CODED              (NB_DATA_CODED),
            .FIFO_DEPTH                 (FIFO_DEPTH),
            .NB_ADDR                    (NB_ADDR)
        )
        u_prog_fifo
        (
            .i_clock                    (i_clock),
            .i_reset                    (i_reset),
            .i_valid                    (i_valid),
            .i_set_fifo_delay           (i_set_fifo_delay),
            .i_write_enb                (i_write_enb),
            .i_read_enb                 (i_read_enb),
            .i_read_addr                (i_delay_vector[NB_DELAY_BUS-(i*NB_DELAY_COUNT)-1 -: NB_DELAY_COUNT]),
            .i_data                     (i_data[NB_DATA_BUS-(i*NB_DATA_CODED)-1 -: NB_DATA_CODED]),
            .o_data                     (o_data[NB_DATA_BUS-(i*NB_DATA_CODED)-1 -: NB_DATA_CODED])
        );
end //endgenerate

endmodule
