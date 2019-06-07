

module am_insertion
#(
	parameter LEN_CODED_BLOCK  = 66,
	parameter AM_ENCODING_LOW  = 24'd0, //{M0,M1,M2} tabla 82-2
	parameter AM_ENCODING_HIGH = 24'd0,  //{M4,M5,M6} tabla 82-2
	parameter NB_BIP = 8
 )
 (
 	input  wire 						i_clock ,
 	input  wire 						i_reset ,
 	input  wire 						i_enable,
 	input  wire 						i_am_insert,
 	input  wire [LEN_CODED_BLOCK-1 : 0] i_data,
    output wire [NB_BIP-1 : 0]          o_parity,
 	output wire [LEN_CODED_BLOCK-1 : 0]	o_data

 );

localparam CTRL_SH = 2'b10;

//Internal signals
reg  [LEN_CODED_BLOCK-1 : 0] data;
wire [NB_BIP-1 : 0] bip3, bip7;
reg [7: 0] br;


always @ (posedge i_clock)
begin
    if (i_reset)begin
        data <= {LEN_CODED_BLOCK{1'b0}};
        br <= {NB_BIP{1'b1}};
    end
 	else if (i_enable && ~i_am_insert)begin
 		data <= i_data;
 		br <= bip3;
 	end

 	else if (i_enable && i_am_insert)begin
 		data <= {CTRL_SH,AM_ENCODING_LOW,br,AM_ENCODING_HIGH,(~br)};
 		br <= bip3;
 	end
end
//PORTS
assign o_data = data;
assign o_parity = br;

//instances
bip_calculator
#(
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK)
 )
	u_bip_calculator
 	(
        .i_clock (i_clock)  ,
        .i_reset (i_reset)  ,
     	.i_data  (data)     , // data from internal reg. [FIX]
        .i_enable(i_enable) ,
	    .i_am_insert(i_am_insert),
        .o_bip3(bip3),
        .o_bip7(bip7),
        .i_bip(br)
 	);

endmodule
