

module lane_id_decoder
#(
        parameter NB_ONEHOT_ID = 20, //same as number of lanes
        parameter NB_LANE_ID = $clog2(NB_ONEHOT_ID)
 )
 (
        input  wire [NB_ONEHOT_ID-1 : 0] i_id,

        output wire [NB_LANE_ID-1 : 0] o_id
 );


reg [NB_LANE_ID-1 : 0] decimal_id;

assign o_id = decimal_id;
always @(*)
begin
decimal_id = 0;
        case(i_id)
                
                20'b00000000000000000001:
                    decimal_id = 0;
                20'b00000000000000000010:
                    decimal_id = 1;
                20'b00000000000000000100:
                    decimal_id = 2;
                20'b00000000000000001000:
                    decimal_id = 3;
                20'b00000000000000010000:
                    decimal_id = 4;
                20'b00000000000000100000:
                    decimal_id = 5;
                20'b00000000000001000000:
                    decimal_id = 6;
                20'b00000000000010000000:
                    decimal_id = 7;
                20'b00000000000100000000:
                    decimal_id = 8;
                20'b00000000001000000000:
                    decimal_id = 9;
                20'b00000000010000000000:
                    decimal_id = 10;
                20'b00000000100000000000:
                    decimal_id = 11;
                20'b00000001000000000000:
                    decimal_id = 12;
                20'b00000010000000000000:
                    decimal_id = 13;
                20'b00000100000000000000:
                    decimal_id = 14;
                20'b00001000000000000000:
                    decimal_id = 15;
                20'b00010000000000000000:
                    decimal_id = 16;
                20'b00100000000000000000:
                    decimal_id = 17;
                20'b01000000000000000000:
                    decimal_id = 18;
                20'b10000000000000000000:
                    decimal_id = 19;
                
        endcase
end

endmodule