

module tb_bip_calc;

localparam LEN_CODED_BLOCK = 66;
reg [9:0] counter;
reg clock;
reg reset;
reg enable;
reg [LEN_CODED_BLOCK-1 : 0] data;
reg							am_insert;
reg [0 : LEN_CODED_BLOCK-1] temp_data;
reg							temp_am_insert;
wire [7:0] bip3, bip7;


integer fid_bip_data_input;
integer fid_bip_aminsert_input;
integer fid_bip_calculator_output;
integer ptr_data_input;
integer ptr_aminsert_input;
integer code_error_data_input;
integer code_error_aminsert_input;

initial 
begin


	fid_bip_data_input = $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/run/bip_calculator/bip-input-data.txt", "r");
    if(fid_bip_data_input==0)
    begin
        $display("\n\nLa entrada para bip-data-input no pudo ser abierta\n\n");
        $stop;
    end
    fid_bip_aminsert_input = $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/run/bip_calculator/bip-input-aminsert.txt", "r");
    if(fid_bip_aminsert_input==0)
    begin
        $display("\n\nLa entrada para bip-aminsert-input no pudo ser abierta\n\n");
        $stop;
    end

    fid_bip_calculator_output = $fopen("/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Python/run/bip_calculator/bip-calc-output.txt", "w");
    if(fid_bip_calculator_output==0)
    begin
    	$display("\n\nLa entrada para bip-calc-output no pudo ser abierta\n\n");
        $stop;
    end



	clock = 0;
	reset = 1;
	counter = 0;
	enable = 0;
	data = {LEN_CODED_BLOCK{1'b0}};
	#6 reset  = 0;
	#4 enable = 1;
/*	   data   = 66'b00_11111111_10000000_10000000_10000000_10000000_10000000_10000000_10000000;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_01000000_01000000_01000000_01000000_01000000_01000000_01000000;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00100000_00100000_00100000_00100000_00100000_00100000_00100000;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00010000_00010000_00010000_00010000_00010000_00010000_00010000;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00001000_00001000_00001000_00001000_00001000_00001000_00001000;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00000100_00000100_00000100_00000100_00000100_00000100_00000100;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00000010_00000010_00000010_00000010_00000010_00000010_00000010;
	#4 reset  = 1;
	   enable = 0;
	#4 reset  = 0;
	   enable = 1;
	   data   = 66'b00_11111111_00000001_00000001_00000001_00000001_00000001_00000001_00000001;

*/
end

always #2 clock = ~clock;

always @(posedge clk) 
begin
	if(enable) 
	begin
		for(ptr_data_input = 0; ptr_data_input < LEN_CODED_BLOCK; ptr_data_input = ptr_data_input+1)
		begin
			
			code_error_data_input <= $fscanf(fid_bip_data_input, "%b\n", temp_data[ptr_data_input]);
			if(code_error_data_input != 1)
			begin
				$display("bip_data_input: El caracter leido no es valido..");
                $stop;
			end

		end	
		
		code_error_aminsert_input <= $fscanf(fid_bip_aminsert_input, "%b\n", temp_am_insert);
		if(code_error_aminsert_input != 1)
		begin
			$display("bip_am_insert_input: El caracter leido no es valido..");
            $stop;			
		end

		$fwrite(fid_bip_calculator_output, "%b\n", o_bip3);

		data <= temp_data;
		am_insert <= temp_am_insert
		
	end
end


bip_calculator
#(
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK)
 )
	u_bip_calculator
	(
		.i_clock(clock)   		,
		.i_reset(reset)   		,
		.i_enable(enable) 		,
		.i_data(data)     		,
		.i_am_insert(am_insert)	,
		.o_bip3(bip3)     		,
		.o_bip7(bip7)
	);

endmodule