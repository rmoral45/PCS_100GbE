
/*
  Calculadora de paridad intercalada
*/

module bip_calculator
#(
    parameter LEN_CODED_BLOCK = 66,
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

//INTERNAL SIGNALS
integer i;
reg  [0 : LEN_CODED_BLOCK-1] data;
reg  [NB_BIP-1 : 0] bip,bip_next;

//PORTS
assign o_bip3 = bip;
assign o_bip7 = ~bip;


//Update state
always @ (posedge i_clock)
 begin
    if(i_reset || i_am_insert) //[CHECK]
        bip <= {8{1'b1}};
    else if (i_enable)
        bip <= bip_next;
 end

//Parity calculation
always @ *
begin
    bip_next = bip[NB_BIP-1 : 0];
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
    /*
    if(i_enable)
    begin
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
   end
   */
end

endmodule
