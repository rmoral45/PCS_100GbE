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
//wire [LEN_PARITY-1 : 0]      out_parity;        
reg							am_insert;
wire [LEN_CODED_BLOCK-1 : 0] out_data;


integer fid_bip_data_output_verilog;
integer fid_bip_parity_output_verilog;

//reg [0 : LEN_CODED_BLOCK-1] temp_data_output;



initial
begin

    fid_bip_data_output_verilog = $fopen("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/bip_calculator/bip-data-output-verilog.txt", "w");
    if(fid_bip_data_output_verilog==0)
    begin
    	$display("\n\nLa entrada para bip-calc-output no pudo ser abierta\n\n");
        $stop;
    end
    
    fid_bip_parity_output_verilog = $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/run/bip_calculator/bip-parity-output-verilog.txt", "w");
    if(fid_bip_parity_output_verilog==0)
    begin
        $display("\n\nLa entrada para bip-calc-output no pudo ser abierta\n\n");
        $stop;
    end


clock = 0;
counter = 0;
reset = 1;
enable = 0;
data = {LEN_CODED_BLOCK{1'b0}};
#6 reset  = 0;
#4 enable = 1;
   data = {LEN_CODED_BLOCK{1'b1}};
#10000000 $finish;


end

always #1 clock = ~clock;
always @(posedge clock)
begin
	if(enable)
	begin

        counter = counter + 1;
        
        case(counter)
        
        10'D10:
        begin
           data = 66'b100011101100101000100110111100110010101100111000111111110100100000;
            

           am_insert = 1'b1;
        end
    
        10'D11:
        begin
           data = 66'b010011000001001110011001011100010100100100110001111011111111110000;
           

           am_insert = 1'b0;
        end	
    
        10'D12:
        begin
           data = 66'b011001011111011011100010011111001100111010000000110111010100101111;
            

           am_insert = 1'b0;
        end
        
        10'D13:
        begin
           data = 66'b011110010011111101100000001111101000011100100111100101001011000100;
            

           am_insert = 1'b0;
        end
        
        10'D14:
        begin
           data = 66'b010111010111011111011010000101010110011100001011100101111010110111;
            

           am_insert = 1'b0;
        end
        
        10'D15:
        begin
           data = 66'b011110010110010111101000010000111101100010110111001010101101000001;
            

           am_insert = 1'b0;
        end
        
        10'D16:
        begin
           data = 66'b011000001101001000110011110111110100010000010110010011111110110011;
            
            
           am_insert = 1'b0;
        end
        
        10'D17:
        begin
           data = 66'b011101011011011010000100111101010011011000011010001010001001011010;
            

            

           am_insert = 1'b0;
        end
        
        10'D18:
        begin
           data = 66'b010101110010101110101100010101011110000011100110001111111001110000;
           am_insert = 1'b0;
        end   
        
        10'D19:
        begin
           data = 66'b011011010000010001110010011100010111111001011011000011010010011010;
           am_insert = 1'b0;
        end
     
        10'D20:
        begin
           data = 66'b101001101001100100010000001011000100000010010011101000011101011101;
           am_insert = 1'b1;
        end
        
        10'D21:
        begin
           data = 66'b010110010000000100100110100101101001011000001101100110001001101010;
           am_insert = 1'b0;
        end
    
        10'D22:
        begin
           data = 66'b011011101111011001010111111010011100010000000110001010100111010011;
           am_insert = 1'b0;
        end    
    
        10'D23:
        begin
           data = 66'b011011110011000000100111011111001100010100110111010101011010100011;
           am_insert = 1'b0;
        end
    
        10'D24:
        begin
           data = 66'b010110100111000110010000011110010000011100111100000100111110000111;
           am_insert = 1'b0;
        end
    
        10'D25:
        begin
           data = 66'b011010100110100011101101010001110100000111100100100011011011101110;
           am_insert = 1'b0;
        end
    
        10'D26:
        begin
           data = 66'b011110100000101000111110010011001111011101010101010001110011101101;
           am_insert = 1'b0;
        end
    
        10'D27:
        begin
           data = 66'b011011100011010011010000100000011011000101000010110011001000001011;
           am_insert = 1'b0;
        end
    
        10'D28:
        begin
           data = 66'b011011010000000101011001111010001110001000110011001010100111101010;
           am_insert = 1'b0;
        end
    
        10'D29:
        begin
           data = 66'b010001101000001010010011010110000010110110010010010000000111111111;
           am_insert = 1'b0;
        end
    
      10'D30:
        begin
           data = 66'b101000001010101001100111100110010100000011000001000100111100000010;
           am_insert = 1'b1;
        end
    
      10'D31:
        begin
           data = 66'b011001111000011010001001001000000101110000100000100010010110100110;
           am_insert = 1'b0;
        end                                
    
      10'D32:
        begin
           data = 66'b010001111111101001011011011000010011010101011110111111000101001010;
           am_insert = 1'b0;
        end 
    
    
      10'D33:
        begin
           data = 66'b011001110011010111100000001001111111101011000010100111110010100010;
           am_insert = 1'b0;
        end 
    
      10'D34:
        begin
           data = 66'b011001110010000001001100111001110000001000101011100000100011100011;
           am_insert = 1'b0;
        end 
    
      10'D35:
        begin
           data = 66'b010100001000000100011110111111101001101000100110010010100111011001;
           am_insert = 1'b0;
        end 
    
      10'D36:
        begin
           data = 66'b010110000110101100111111011100110011000111110011000011000000101011;
           am_insert = 1'b0;
        end 
    
      10'D37:
        begin
           data = 66'b011100101101111101011001101111100100000100110111000000100100001000;
           am_insert = 1'b0;
        end 
    
      10'D38:
        begin
           data = 66'b011110000101000100011100000111100101100101100111001001111101101110;
           am_insert = 1'b0;
        end                         
    
      10'D39:
        begin
           data = 66'b010001010101101111010001110000001110110100011001010011001111011100;
           am_insert = 1'b0;
        end
    
      10'D40:
        begin
           data = 66'b101001110001100110011100110100101011111101101010011011110010110001;
           am_insert = 1'b1;
        end
        endcase
        
        $fwrite(fid_bip_data_output_verilog, "%b\n", out_data);
        //$fwrite(fid_bip_parity_output_verilog, "%b\n", out_parity);

   end

end


am_insertion
#(
  .NB_CODED_BLOCK(LEN_CODED_BLOCK)
 )
	u_am_insertion
	(
		.i_clock(clock)   		,
		.i_reset(reset)   		,
		.i_enable(enable) 		,
		.i_data(data)     		,
		.i_am_insert(am_insert)	,
		//.o_parity(out_parity)   ,
		.o_data(out_data)
	);

endmodule
