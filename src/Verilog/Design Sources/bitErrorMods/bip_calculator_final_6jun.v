
/*
  Calculadora de paridad intercalada.Version Final.
	  Se agrego condicion de reset por SOL para funcionar en modo RX.
  
*/
`timescale 1ns/100ps

module bip_calculator
#(
    parameter                           NB_DATA_CODED   = 66,
    parameter                           NB_BIP          = 8
 )
 (
    input wire                          i_clock,
    input wire                          i_reset,
    input wire  [NB_DATA_CODED-1 : 0]   i_data,
    input wire                          i_enable,
    input wire                          i_valid,
    input wire                          i_start_of_lane,
    input wire					        i_am_insert,

    output wire [NB_BIP-1 : 0]          o_bip3,
    output wire [NB_BIP-1 : 0]          o_bip7
 );

//LOCALPARAMS
localparam                              NB_SH           = 2;
localparam                              BIP_START_POS   = NB_DATA_CODED-NB_SH-24-1;
localparam                              BIP_FINAL_POS   = 48;
//INTERNAL SIGNALS
integer                                 i;
reg            [0 : NB_DATA_CODED-1]    data;
reg            [NB_BIP-1 : 0]           bip, bip_next;

//PORTS
assign                                  o_bip3          = bip;
assign                                  o_bip7          = ~bip;


//Update state
always @ (posedge i_clock)
 begin
    if (i_reset)
		bip <= {8{1'b1}};
    else if (i_enable && i_valid)
       		bip <= bip_next;
 end

//Parity calculation
always @ *
begin

    if (i_am_insert || i_start_of_lane)
        	bip_next = {NB_BIP{1'b1}};
    else
        	bip_next = bip;

    data = i_data;
    
    for (i=0; i<((NB_DATA_CODED-2)/8); i=i+1)
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

endmodule
