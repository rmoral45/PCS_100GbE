
/*
  Calculadora de paridad intercalada
*/

module bip_calculator
#(
    parameter LEN_CODED_BLOCK = 66,
    parameter AM_ENCODING_LOW  = 24'd0, //{M0,M1,M2} tabla 82-2
	parameter AM_ENCODING_HIGH = 24'd0,  //{M4,M5,M6} tabla 82-2
    parameter NB_BIP = 8
 )
 (
    input wire                          i_clock,
    input wire                          i_reset,
    input wire  [LEN_CODED_BLOCK-1 : 0] i_data,
    input wire                          i_enable,
    input wire				            i_am_insert,

    output wire [NB_BIP-1 : 0]          o_bip3,
    output wire [NB_BIP-1 : 0]          o_bip7
 );


localparam CTRL_SH = 2'b10;

//INTERNAL SIGNALS
integer i;
reg  [0 : LEN_CODED_BLOCK-1] data;
reg  [NB_BIP-1 : 0] bip,bip_next,bip_rst;
reg  [0 : LEN_CODED_BLOCK-1] am_inv;
reg  [LEN_CODED_BLOCK-1: 0] am_block;


//PORTS
assign o_bip3 = bip;
assign o_bip7 = ~bip;


//Update state
always @ (posedge i_clock)
 begin
    if(i_reset) //[CHECK]
        bip <= {8{1'b1}};
    else if (i_enable && ~i_am_insert)
        bip <= bip_next;
    else if (i_enable && i_am_insert)
    	bip <= bip_rst;
 end

//Parity calculation
always @ *
begin
    bip_next 	= bip[NB_BIP-1 : 0];
    bip_rst 	= {NB_BIP{1'b1}};
    //am_block 	= data <= {CTRL_SH,AM_ENCODING_LOW,bip,AM_ENCODING_HIGH,~bip};
    am_block 	= {CTRL_SH,AM_ENCODING_LOW,bip,AM_ENCODING_HIGH,~bip};
    am_inv 		= am_block;

    data = i_data;
    for(i=0; i<((LEN_CODED_BLOCK-2)/8); i=i+1)
    begin
           bip_next[0] = bip_next[0] ^ data[2+(8*i)] ;
           bip_next[1] = bip_next[1] ^ data[3+(8*i)] ;
           bip_next[2] = bip_next[2] ^ data[4+(8*i)] ;
           bip_next[3] = bip_next[3] ^ data[5+(8*i)] ;
           bip_next[4] = bip_next[4] ^ data[6+(8*i)] ;
           bip_next[5] = bip_next[5] ^ data[7+(8*i)] ;
           bip_next[6] = bip_next[6] ^ data[8+(8*i)] ;
           bip_next[7] = bip_next[7] ^ data[9+(8*i)] ;
   end
   bip_next[3] =bip_next[3] ^ data[0];
   bip_next[4] =bip_next[4] ^ data[1];

    for(i=0; i<((LEN_CODED_BLOCK-2)/8); i=i+1)
    begin
       bip_rst[0] = bip_rst[0] ^ am_inv[2+(8*i)] ;
       bip_rst[1] = bip_rst[1] ^ am_inv[3+(8*i)] ;
       bip_rst[2] = bip_rst[2] ^ am_inv[4+(8*i)] ;
       bip_rst[3] = bip_rst[3] ^ am_inv[5+(8*i)] ;
       bip_rst[4] = bip_rst[4] ^ am_inv[6+(8*i)] ;
       bip_rst[5] = bip_rst[5] ^ am_inv[7+(8*i)] ;
       bip_rst[6] = bip_rst[6] ^ am_inv[8+(8*i)] ;
       bip_rst[7] = bip_rst[7] ^ am_inv[9+(8*i)] ;
   end
   bip_rst[3] =bip_rst[3] ^ am_inv[0];
   bip_rst[4] =bip_rst[4] ^ am_inv[1];
end

endmodule
