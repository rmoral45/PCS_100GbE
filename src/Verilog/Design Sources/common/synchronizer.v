module synchronizer
#(
    parameter                           NB_DATA = 1
)
(
    input   wire                        i_clock,
    input   wire    [NB_DATA-1  : 0]    i_data,
    input   wire    [NB_DATA-1  : 0]    o_data
);

/* Delay registers */
reg                 [NB_DATA-1  : 0]    data_d;
reg                 [NB_DATA-1  : 0]    data_2d;

//[FIXME]: PLEASE CHECK THE INITIAL STATE OF THOSE REGS
always @(posedge i_clock) begin
    data_d      <=  i_data;
    data_2d     <=  data_d;    
end

assign o_data   =   data_2d;

endmodule

