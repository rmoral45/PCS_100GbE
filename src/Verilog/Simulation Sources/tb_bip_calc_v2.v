`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2019 10:55:06 AM
// Design Name: 
// Module Name: tb_bip_calc_v2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_bip_calc_v2;

localparam LEN_CODED_BLOCK = 66;
localparam LEN_PARITY = 8;
reg clock;
reg reset;
reg enable;
reg [9:0] counter;
reg [LEN_CODED_BLOCK-1 : 0] data;
reg [LEN_CODED_BLOCK-1 : 0] py_out;
reg [LEN_PARITY-1 : 0]      py_parity;        
reg							am_insert;
wire [LEN_CODED_BLOCK-1 : 0] out_data;

initial
begin

clock = 0;
counter = 0;
reset = 1;
enable = 0;
data = {LEN_CODED_BLOCK{1'b0}};
#6 reset  = 0;
   enable = 1;
   data = {LEN_CODED_BLOCK{1'b1}};
#10000000 $finish;


end

always #1 clock = ~clock;
always @(posedge clock)
begin
	
	counter = counter + 1;
	
	case(counter)
	
	10'D10:
	begin
	   data = 66'b101010000011000101110000100110000010011010110011001011101011001101;
	   am_insert = 1'b1;
	end

	10'D11:
	begin
	   data = 66'b011100011011000010100110101101010110110010101010010011110101101111;
	   am_insert = 1'b0;
	end	

	10'D12:
	begin
	   data = 66'b010010000110111101111110101110000001011110111111001101000111000001;
	   am_insert = 1'b0;
	end
	
	10'D13:
    begin
       data = 66'b010000000000001001000110100111100000001110000001010010110011100001;
       am_insert = 1'b0;
    end
    
 	10'D14:
    begin
       data = 66'b011101011001100001010010111011000011011110001111010001101101000111;
       am_insert = 1'b0;
    end
    
 	10'D15:
    begin
       data = 66'b010011101000011001111111011000101001111010111010111011100010001010;
       am_insert = 1'b0;
    end
    
 	10'D16:
    begin
       data = 66'b010110100101101001011001010111100101011111001101110011011000111010;
       am_insert = 1'b0;
    end
    
 	10'D17:
    begin
       data = 66'b010110111101110101001100000111010001110110101011011111101000000001;
       am_insert = 1'b0;
    end
    
 	10'D18:
    begin
       data = 66'b010010110101011001110100111100101000100110011011101101001111111010;
       am_insert = 1'b0;
    end   
 	
 	10'D19:
    begin
       data = 66'b011110000011011001111111110001111100010011101111110001001010100110;
       am_insert = 1'b0;
    end
 
	10'D20:
    begin
       data = 66'b101101100000000101111101110101110101111100001010001011001000100001;
       am_insert = 1'b1;
    end
	
	10'D21:
    begin
       data = 66'b010100010000011100110100010001110111110000010110100101111001001100;
       am_insert = 1'b0;
    end

	10'D22:
    begin
       data = 66'b010101011011011000111110111000010011000110000111110111110101111110;
       am_insert = 1'b0;
    end    

	10'D23:
    begin
       data = 66'b011111011101001101011010110100101110100001001001011011111101011001;
       am_insert = 1'b0;
    end

	10'D24:
    begin
       data = 66'b010001110011111111101001000111001000111100100100001010100101100001;
       am_insert = 1'b0;
    end

	10'D25:
    begin
       data = 66'b011111010010010000000101011100010111100011100111010000001011101011;
       am_insert = 1'b0;
    end

	10'D26:
    begin
       data = 66'b010000110001100110011101100010010100111100100111000011100100111111;
       am_insert = 1'b0;
    end

	10'D27:
    begin
       data = 66'b010010110011011111001000011000111110111011111010101100110111110111;
       am_insert = 1'b0;
    end

	10'D28:
    begin
       data = 66'b011100001011010001101100110101100101101010010110110100110010100111;
       am_insert = 1'b0;
    end

	10'D29:
    begin
       data = 66'b011001010101100010110101110011011100111101111010001111000100001000;
       am_insert = 1'b0;
    end

  10'D30:
    begin
       data = 66'b101011001111101010001000110110101101100111100101110110010111110011;
       am_insert = 1'b1;
    end

  10'D31:
    begin
       data = 66'b011000110010000001101100111000101110011100100101000011100001111001;
       am_insert = 1'b0;
    end                                

  10'D32:
    begin
       data = 66'b010100100001001001000101011111110011100010011011111000100110110101;
       am_insert = 1'b0;
    end 


  10'D33:
    begin
       data = 66'b010011000111100100110111111101110110010100011100101000000101111100;
       am_insert = 1'b0;
    end 

  10'D34:
    begin
       data = 66'b010010110111110110000111010001010101011000101100001101101101100110;
       am_insert = 1'b0;
    end 

  10'D35:
    begin
       data = 66'b011111101011110001110001011111010101101000000011001000000101111001;
       am_insert = 1'b0;
    end 

  10'D36:
    begin
       data = 66'b011100010101000100011100101100000110110011111110011110000010101010;
       am_insert = 1'b0;
    end 

  10'D37:
    begin
       data = 66'b011111111110000000000010000000000010110100011001111001001001001111;
       am_insert = 1'b0;
    end 

  10'D38:
    begin
       data = 66'b010101111001011100110000000011000100110110110111110011011100011001;
       am_insert = 1'b0;
    end                         

  10'D39:
    begin
       data = 66'b010001100100011100000111111101001110010000101101101000110111111010;
       am_insert = 1'b0;
    end

  10'D40:
    begin
       data = 66'b101101000111001100000011010111000101101100100000000110001011000011;
       am_insert = 1'b1;
    end
    endcase
end


am_insertion
#(
  .LEN_CODED_BLOCK(LEN_CODED_BLOCK)
 )
	u_am_insertion
	(
		.i_clock(clock)   		,
		.i_reset(reset)   		,
		.i_enable(enable) 		,
		.i_data(data)     		,
		.i_am_insert(am_insert)	,
		.o_data(out_data)
	);

endmodule
