`timescale 1ns/100ps


module block_skew_generator
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
        //input  wire                             i_aligner_tag, [CHECK IF ITS NECESSARY]
        input  wire                             i_rf_update,
        input  wire [NB_SKEW_SELECT-1 : 0]      i_rf_skew,

        output wire                             o_data,
        output wire                             o_valid,
        output wire                             o_aligner_tag
 );


        assign                                  o_valid = i_valid;

//LOCALPARAMS

localparam NB_ADDR_CNT = $clog2(FIFO_DEPTH);
//localparam NB_MEM_DATA = NB_CODED_BLOCK + 1; //incluye el tag de alineador[FIX quizas]
localparam NB_MEM_DATA = NB_CODED_BLOCK; //CHANGE THIS IF WE NEED ALIGNER TAG CONNECTION
localparam NB_FILL_ADDR = NB_ADDR_CNT - NB_SKEW_SELECT;

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
                wr_addr <= {NB_ADDR_CNT{1'b0}};

        else if (i_rf_update)
                wr_addr <= {{NB_FILL_ADDR{1'b0}},i_rf_skew};

        else if (wr_addr_limit)
                wr_addr <= {NB_ADDR_CNT{1'b0}};

        else
                wr_addr <= wr_addr + 1'b1;
end
assign wr_addr_limit = (wr_addr == FIFO_DEPTH-1) ? 1'b1 : 1'b0;

//Update read address
always @ (posedge i_clock)
begin
        if (i_reset)
                rd_addr <= {NB_ADDR_CNT{1'b0}};

        else if (i_rf_update)
                rd_addr <= {NB_ADDR_CNT{1'b0}};

        else if (rd_addr_limit)
                rd_addr <= {NB_ADDR_CNT{1'b0}};

        else
                rd_addr <= rd_addr + 1'b1;
end
assign rd_addr_limit = (rd_addr == FIFO_DEPTH-1) ? 1'b1 : 1'b0;

//INSTANCES


bram
#(
        .NB_WORD_RAM(NB_MEM_DATA),
        .RAM_DEPTH  (FIFO_DEPTH)
 )
        u_bram
        (
                .i_clock        (i_clock),
                .i_write_enable (i_enable),
                .i_read_enable  (i_enable),
                .i_write_addr   (wr_addr),
                .i_read_addr    (rd_addr),
                .i_data         (i_data),

                .o_data         (o_data)
        );
endmodule
