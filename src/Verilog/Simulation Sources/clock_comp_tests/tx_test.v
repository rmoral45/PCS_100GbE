`timescale 1ns/100ps


module tx_tests;

localparam NB_DATA              = 66;
localparam N_LANES              = 20;
localparam AM_BLOCK_PERIOD      = 60;

localparam PATH_IN_DATA          = "/home/dabratte/PPS/src/Python/modules/idle_del/tx_input_data_case_1.txt";
localparam PATH_OUT_DATA         = "/home/dabratte/PPS/src/Python/modules/idle_del/tx_output_data_case_1.txt";
localparam PATH_IN_TAG           = "/home/dabratte/PPS/src/Python/modules/idle_del/tx_output_tag_case_1.txt";
localparam PATH_VERI_DATA           = "/home/dabratte/PPS/src/Python/modules/idle_del/verilog.txt";
// inputs  signals to tested module
reg                             tb_i_clock;
reg                             tb_i_reset;
reg                             tb_i_enable;
reg                             tb_i_valid;
reg [NB_DATA-1 : 0]             tb_i_data;

//outputs from tested module
wire 			        tb_o_tag;
wire [NB_DATA-1: 0]               tb_o_data;

//file handler signals
reg                             tb_enable_files;
reg                             python_output_tag;
reg                             temp_tag;
reg  [0 : NB_DATA-1]            temp_data;
reg  [0 : NB_DATA-1]            py_temp_data;
reg  [0 : NB_DATA-1]            python_output_data;


integer                         fid_input_data;
integer                         fid_output_tag;
integer                         fid_output_data;
integer                         fid_verilog_data;
integer                         code_error_data;
integer                         code_error_data_py;
integer                         code_error_tag;
integer                         ptr_data;
integer                         ptr_data_py;

initial
begin

	fid_input_data = $fopen(PATH_IN_DATA, "r");
	if(fid_input_data == 0)
	begin
		$display("\n\n NO SE PUDO ABRIR ARCHIVO DE INPUT DATA");
		$stop;
	end
	
	fid_output_tag = $fopen(PATH_IN_TAG, "r");
        if (fid_output_tag == 0)
        begin
                $display("\n\n NO SE PUDO ABRIR ARCHIVO DE OUTPUT PYTHON");
                $stop;
        end

	fid_output_data = $fopen(PATH_OUT_DATA, "r");
        if (fid_output_data == 0)
        begin
                $display("\n\n NO SE PUDO ABRIR ARCHIVO DE OUTPUT PYTHON");
                $stop;
         end
	fid_verilog_data = $fopen(PATH_VERI_DATA, "w");
        if (fid_verilog_data == 0)
        begin
                $display("\n\n NO SE PUDO ABRIR ARCHIVO DE OUTPUT PYTHON");
                $stop;
         end

	tb_i_clock 		= 0;
	tb_i_reset 		= 1;
	tb_i_enable 		= 0;
	tb_i_valid 		= 0;
	tb_i_data 		= 66'd0;
	tb_enable_files         =0;


	#3 	tb_i_reset  = 0;
	        tb_enable_files = 1;
		tb_i_enable = 1;
		tb_i_valid  = 1;
end

always #1 tb_i_clock= ~tb_i_clock;



always @ (posedge tb_i_clock)
begin
	if(tb_enable_files)
	begin

		//LECTURA DE ARCHIVO
		for(ptr_data=0; ptr_data < NB_DATA; ptr_data=ptr_data+1)
		begin
			code_error_data <= $fscanf(fid_input_data, "%b\n", temp_data[ptr_data]);
			if(code_error_data != 1)
			begin
				$display("Tx-Data: El caracter leido no es valido..");
               	                $stop;
			end
		end
		
		for(ptr_data_py=0; ptr_data_py < NB_DATA; ptr_data_py=ptr_data_py+1)
		begin
			code_error_data_py <= $fscanf(fid_output_data, "%b\n", py_temp_data[ptr_data_py]);
			if(code_error_data_py != 1)
			begin
				$display("Tx-Data: El caracter leido no es valido..");
               	                $stop;
			end
		end

		code_error_tag <= $fscanf(fid_output_tag, "%b\n", temp_tag);
		if(code_error_data != 1)
		begin
			$display("Tx-Tag: El caracter leido no es valido..");
                        $stop;
		end
		$fwrite(fid_verilog_data, "%b\n", {tb_o_data,tb_o_tag});
		python_output_tag   <= temp_tag;
                python_output_data  <= py_temp_data;
		tb_i_data           <= temp_data;

	end

end
 
clock_comp_tx
        #(
                .NB_DATA        (NB_DATA),
                .AM_BLOCK_PERIOD(AM_BLOCK_PERIOD),
                .N_LANES        (N_LANES)
        )
        u_comp
        (
                .i_clock         (tb_i_clock),
                .i_reset         (tb_i_reset),
                .i_enable        (tb_i_enable),
                .i_valid         (tb_i_valid),
                .i_data          (tb_i_data),
      
                .o_data          (tb_o_data),
                .o_aligner_tag   (tb_o_tag)
         );


endmodule
