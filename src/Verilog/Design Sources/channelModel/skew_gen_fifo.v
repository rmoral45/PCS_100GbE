`timescale 1ns/100ps


module skew_gen_fifo
#(
        parameter NB_CODED_BLOCK = 66,
        parameter FIFO_DEPTH     = 20,
        parameter MAX_SKEW       = 16,
        parameter NB_SKEW_SELECT = $clog2(MAX_SKEW)
 )
 (
        input  wire                             i_clock,
        input  wire                             i_reset,
        input  wire                             i_enable,
        input  wire                             i_valid,
        input  wire [NB_CODED_BLOCK-1 : 0]      i_data,
        input  wire                             i_aligner_tag,
        input  wire                             i_rf_update,
        input  wire [NB_SKEW_SELECT-1 : 0]      i_rf_skew,

        output wire                             o_data,
        output wire                             o_aligner_tag
 );


//LOCALPARAMS

localparam NB_ADDR_CNT = $clog2(FIFO_DEPTH);
localparam NB_MEM_DATA = NB_CODED_BLOCK + 1; //incluye el tag de alineador


//INTERNAL SIGNALS

reg [NB_ADDR_CNT-1 : 0] wr_addr;
reg [NB_ADDR_CNT-1 : 0] rd_addr;



//ALGORITHM BEGIN

/*
        [CHECK] : ver los valores iniciales de wr_ptr y rd_ptr
*/

//Update write address
always @ (posedge i_clock)
begin
        if (i_reset)
                wr_ptr <= {NB_ADDR_CNT{1'b0}};

        else if (i_rf_update)
                wr_ptr <=

        else if (wr_addr_limit)
                wr_ptr <= {NB_ADDR_CNT{1'b0}};

        else
                wr_ptr <= wr_addr + 1'b1;
end
assign wr_addr_limit = (wr_addr == FIFO_DEPTH-1) ? 1'b1 : 1'b0;

//Update read address
always @ (posedge i_clock)
begin
        if (i_reset)
                rd_addr <= {NB_ADDR_CNT{1'b0}};

        else if (i_rf_update)
                rd_addr <=

        else if (rd_addr_limit)
                rd_addr <= {NB_ADDR_CNT{1'b0}};

        else
                rd_addr <= rd_addr + 1'b1;
end

//INSTANCES


bram
#(
        .NB_WORD_RAM(),
        .RAM_DEPTH  ()
 )
        u_bram
        (
                .i_clock        (),
                .i_write_enable (),
                .i_read_enable  (),
                .i_write_addr   (),
                .i_read_addr    (),
                .i_data         (),

                .o_data         ()
        );
endmodule
