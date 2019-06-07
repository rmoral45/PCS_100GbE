

module tb_bip_calc;


localparam LEN_CODED_BLOCK = 66;
localparam LEN_PARITY = 8;
reg [9:0] counter;
reg clock;
reg reset;
reg enable;
reg enable_files;
reg [LEN_CODED_BLOCK-1 : 0] data;
reg [LEN_CODED_BLOCK-1 : 0] py_out;
//reg [LEN_PARITY-1 : 0]      temp_parity;
//reg [0 : LEN_PARITY-1]      temp_parity;
//reg [LEN_PARITY-1 : 0]      py_parity;
reg [0 : LEN_PARITY-1]      py_parity;        
reg							am_insert;
reg [0 : LEN_CODED_BLOCK-1] temp_data;
reg [0 : LEN_CODED_BLOCK-1] temp_data_output;
wire [LEN_CODED_BLOCK-1 : 0] out_data;
reg						temp_am_insert;

integer fid_bip_data_input;
integer fid_bip_data_output;
integer fid_bip_aminsert_input;
integer fid_bip_calculator_output;
//integer fid_bip_python_parity;
integer ptr_data_input;
integer ptr_data_output;
integer ptr_python_parity;
integer code_error_python_parity;
integer code_error_data_input;
integer code_error_aminsert_input;
integer code_error_data_output;

initial 
begin


    /*fid_bip_python_parity = $fopen("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/bip_calculator/bip-output-parity.txt", "r");
    if(fid_bip_python_parity==0)
    begin
        $display("\n\nLa entrada para bip-output-parity no pudo ser abierta\n\n");
        $stop;
    end*/

	fid_bip_data_input = $fopen("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/bip_calculator/bip-input-data.txt", "r");
    if(fid_bip_data_input==0)
    begin
        $display("\n\nLa entrada para bip-data-input no pudo ser abierta\n\n");
        $stop;
    end
    
	fid_bip_data_output = $fopen("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/bip_calculator/bip-output-data.txt", "r");
    if(fid_bip_data_output==0)
    begin
        $display("\n\nLa entrada para bip-data-input no pudo ser abierta\n\n");
        $stop;
    end
    fid_bip_aminsert_input = $fopen("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/bip_calculator/bip-input-aminsert.txt", "r");
    if(fid_bip_aminsert_input==0)
    begin
        $display("\n\nLa entrada para bip-aminsert-input no pudo ser abierta\n\n");
        $stop;
    end

    fid_bip_calculator_output = $fopen("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/bip_calculator/bip-data-output-verilog.txt", "w");
    if(fid_bip_calculator_output==0)
    begin
    	$display("\n\nLa entrada para bip-calc-output no pudo ser abierta\n\n");
        $stop;
    end

	clock = 0;
	reset = 1;
	counter = 0;
	enable = 0;
	enable_files = 0;
	data = {LEN_CODED_BLOCK{1'b0}};
	#6 reset  = 0;
	   enable = 1;
	#2 enable_files = 1;
#1000000000 $finish;
end

always #1 clock = ~clock;

always @(posedge clock) 
begin
	if(enable_files) 
	begin
	
	   /*for(ptr_python_parity = 0; ptr_python_parity < LEN_PARITY; ptr_python_parity = ptr_python_parity+1)
       begin       
            code_error_python_parity <= $fscanf(fid_bip_python_parity, "%b\n", temp_parity[ptr_python_parity]);
            if(code_error_python_parity != 1)
            begin
                 $display("python_parity: El caracter leido no es valido..");
                 $stop;
            end
        end */
       
		if(!$feof(fid_bip_data_input) && !$feof(fid_bip_data_output) && !$feof(fid_bip_aminsert_input))
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
		
		for(ptr_data_output = 0; ptr_data_output < LEN_CODED_BLOCK; ptr_data_output = ptr_data_output+1)
        begin
                    
            code_error_data_output <= $fscanf(fid_bip_data_output, "%b\n", temp_data_output[ptr_data_output]);
            if(code_error_data_output != 1)
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

		$fwrite(fid_bip_calculator_output, "%b\n", out_data);


		  data <= temp_data;
		  py_out <= temp_data_output;
		  //py_parity <= temp_parity;
		  am_insert <= temp_am_insert;
		end
	end
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