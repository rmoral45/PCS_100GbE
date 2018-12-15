`timescale 1ns/100ps


module block_sync_tb_file;

localparam NB_BLOCK = 66;

reg clock,reset,valid,signal_ok;
wire flag_block_lock;
reg tb_enablke_files;

reg  [NB_BLOCK-1 : 0] input_data;
reg  [0 : NB_BLOCK-1] temp_data;
wire [NB_BLOCK-1 : 0] output_data;


integer fid_input_data;
integer fid_output_data;
integer fid_output_lock;

integer code_error_data;

integer ptr_data;

initial
begin

	fid_input_data = $fopen("/home/diego/fundacion/PPS/src/Python/","r");
	if(fid_input_data == 0)
	begin
		$display("\n\n NO SE PUDO ABRIR ARCHIVO DE INPUT DATA");
		$stop;
	end
	fid_output_data = $fopen("/home/diego/fundacion/PPS/src/Python/","w");
	if(fid_output_data==0)
	begin
		$display("\n\n La salida de datos no pudo ser abierta");
		$stop;
	end
	fid_output_lock =$fopen("/home/diego/fundacion/PPS/src/Python/","w");
	if(fid_output_lock==0)
	begin
		$display("\n\n La salida de control no pudo ser abierta");
		$stop;
	end


	clock = 0;
	reset = 1;
	signal_ok = 0;
	valid = 0;
	input_data = 66'd0;
	#3 tb_enable_files = 1;
	#2 	reset = 0;
		signal_ok = 1;
		valid = 1;
end

always #1 clock= ~clock;



always @ (posedge clock)
begin
	if(tb_enable_files)
	begin

		//LECTURA DE ARCHIVO
		for(ptr_data=0; ptr_data < NB_BLOCK; ptr_data=ptr_data+1)
		begin
			code_error_data <= $fscanf(fid_input_data, "%b\n", temp_data[ptr_data]);
			if(code_error_data != 1)
			begin
				$display("Tx-Data: El caracter leido no es valido..");
               	$stop;
			end
		end
		//FIN LECTURA ARCHIVO


		//ESCRITURA
		$fwrite(fid_output_data, "%b\n", output_data);                      
        $fwrite(fid_output_lock, "%b\n", flag_block_lock);
		

		input_data <= temp_data;

	end

end


block_sync


endmodule