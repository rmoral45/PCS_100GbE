
/*

en el encoder, si es uun ordered set solamente se debe verificarel primer octeto,lo de los ceros esta al pedo 
y esta mal checkearlo para que cumpla con la condicion, en el DECODER SI importan que los ultimos ocettos sean Z


*/



/*
  task para mapear caracteres de formato cmgii a formato pcs
*/
localparam [7:0] CGMII_IDLE  = 8'h07;
localparam [7:0] CGMII_ERROR = 8'hFE; // REVISAR CARACTERES !!!!!!!!1
localparam [6:0] PCS_IDLE    = 7'h00;
localparam [6:0] PCS_ERROR   = 7'h1E;


task automatic cgmii_to_pcs_char;
input  [7:0] char_in;
output		 valid_out;
output [6:0] char_out; 

begin
	if(char_in == CGMII_IDLE)
	begin
		char_out = PCS_IDLE;
		valid_out = 1'b1;
	end
	else if (char_in == CGMII_ERROR) 
	begin
		char_out = PCS_ERROR;
		valid_out = 1'b1;
	end
	else 
	begin
		char_out = 7'hFF; // seteo algun valor que no sirva por defecto
		valid_out = 1'b0;
	end
end
endtask


task automatic pcs_to_cgmii_char;
input  [6:0] char_in;
output		 valid_out;
output [7:0] char_out; 

begin
	if(char_in == PCS_IDLE)
	begin
		char_out = CGMII_IDLE;
		valid_out = 1'b1;
	end
	else if (char_in == PCS_ERROR) 
	begin
		char_out = CGMII_ERROR;
		valid_out = 1'b1;
	end
	else 
	begin
		char_out = 7'hFF; // seteo algun valor que no sirva por defecto
		valid_out = 1'b0;
	end
end
endtask   