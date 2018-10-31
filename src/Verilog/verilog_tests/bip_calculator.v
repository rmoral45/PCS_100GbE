


module bip_calculator
#(
    parameter LEN_CODED_BLOCK = 66
 )
 (
    input wire  i_clock,
    input wire  i_reset,
    input wire  [LEN_CODED_BLOCK-1 : 0] i_data,
    input wire  i_enable,
    output wire [7:0] o_bip3,
    output wire [7:0] o_bip7
 );



wire bip0,bip1,bip2,bip3,bip4,bip5,bip6,bip7;
/*
assign bip0 = 
^{i_data[2],i_data[10],i_data[18],i_data[26],i_data[34],i_data[42],i_data[50],i_data[58]};
assign bip1 = 
^{i_data[3],i_data[11],i_data[19],i_data[27],i_data[35],i_data[43],i_data[51],i_data[59]};
assign bip2 = 
^{i_data[4],i_data[12],i_data[20],i_data[28],i_data[36],i_data[44],i_data[52],i_data[60]};
assign bip3 = 
^{i_data[5],i_data[13],i_data[21],i_data[29],i_data[37],i_data[45],i_data[53],i_data[61],i_data[0]};
assign bip4 = 
^{i_data[6],i_data[14],i_data[22],i_data[30],i_data[38],i_data[46],i_data[54],i_data[62],i_data[1]};
assign bip5 = 
^{i_data[7],i_data[15],i_data[23],i_data[31],i_data[39],i_data[47],i_data[55],i_data[63]};
assign bip6 = 
^{i_data[8],i_data[16],i_data[24],i_data[32],i_data[40],i_data[48],i_data[56],i_data[64]};
assign bip7 = 
^{i_data[9],i_data[17],i_data[25],i_data[33],i_data[41],i_data[49],i_data[57],i_data[65]};
*/



reg  [LEN_CODED_BLOCK-1 : 0] data;
reg [7:0] bip,bip_next;
integer i;

assign o_bip3 = bip;
assign o_bip7 = ~bip;




always @ (posedge i_clock, posedge i_reset)
 begin
    if(i_reset)
        bip <= {8{1'b1}};
    else
        //bip <= {bip0,bip1,bip2,bip3,bip4,bip5,bip6,bip7};
        bip <= bip_next;
 end

always @ *
begin
    bip_next = bip[7:0];
    data = i_data;
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
end

endmodule
