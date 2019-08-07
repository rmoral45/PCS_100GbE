`timescale 1ns/100ps


/* 
 *
 *
 *
 */



module sh_shifter
#(
        parameter NB_CODED_BLOCK = 66,
        parameter NB_SHIFT_INDEX = $clog2(NB_CODED_BLOCK)
 )
 (
        input  wire                             i_clock,
        input  wire                             i_reset,
        input  wire                             i_valid,
        input  wire                             i_rf_update,
        input  wire [NB_CODED_BLOCK-1 : 0]      i_data,
        input  wire [NB_SHIFT_INDEX-1 : 0]      i_rf_sh_pos

        output wire [NB_CODED_BLOCK-1 : 0]      o_data
 );


//LOCALPARAMS
localparam  NB_STORE    = NB_CODED_BLOCK * 2 ;

//internal prbs params
localparam PRBS_SEED    = ;
localparam PRBS_NUM     = 32;
localparam PRBS_EXP1    = ;
localparam PRBS_EXP2    = ;
localparam PRBS_HL      = ;
localparam PRBS_LL      = ;
localparam NB_PRBS_OUT  = PRBS_HL - PRBS_LL;
localparam N_CONCAT     = (NB_STORE / NB_PRBS_OUT) + 1; 

//INTERNAL SIGNALS
reg   [NB_STORE-1 : 0]          store;
wire  [NB_STORE-1 : 0]          next_store;

wire                            static_prbs_enable,  static_prbs_valid;
wire [PRBS_HL - PRBS_LL : 0]    out_prbs;
wire [NB_STORE-1 : 0]           setup_store;

//PORTS
assign o_data = store[NB_STORE-1 -: NB_CODED_BLOCK]

//ALGORITHM BEGIN
always @ (posedge i_clock)
begin
        if (i_reset)
                store <= {NB_STORE{1'b0}};
        else if (i_rf_update)
                store <= setup_store;
        else if (i_valid)
                store <= next_store ;
end

assign next_store = { store[NB_STORE-1-NB_CODED_BLOCK-i_sh_pos -: i_rf_sh_pos], i_data, {NB_CODED_BLOCK-i_sh_pos{1'b0}} };

assign setup_store = {N_CONCAT{out_prbs}};


//Instances

assign static_prbs_enable = 1'b1;
assign static_prbs_valid  = 1'b1;
prbs
#(
        .SEED           (PRBS_SEED),
        .EXP1           (PRBS_EXP1),
        .EXP2           (PRBS_EXP2),
        .N_BITS         (PRBS_NUM),
        .HIGH_LIM       (PRBS_HL),
        .LOW_LIM        (PRBS_LL)
 )
        u_prbs
        (
                .i_clock        (i_clock),
                .i_reset        (i_reset),
                .i_enable       (static_prbs_enable),
                .i_valid        (static_prbs_valid),

                .o_sequence     (out_prbs)
        );

endmodule 
