
from pdb import set_trace as bp
import texttable as tt



def main():

	with open("./verilog_outputs/verilog-decoded-data-output.txt") as verilog_decoded_output:
		decoded_output = verilog_decoded_output.readlines()

	with open("./verilog_outputs/para_comparar.txt") as verilog_cgmii_input:
		cgmii_input = verilog_cgmii_input.readlines()

	result = []
	no_matches = []

	
	decoded_output = [x.strip() for x in decoded_output] 
	cgmii_input = [x.strip() for x in cgmii_input] 


	table = tt.Texttable()
	columns = ('Encoder_Input', 'Decoder_Output', 'Match' )
	table.header(columns)
	table.set_cols_width([64,64,8])
	table.set_cols_dtype(['t', 't', 't'])
	table.set_cols_align(['c', 'c', 'c'])


	for x in range(len(cgmii_input)):		 
		aux = decoded_output[x] == cgmii_input[x]
	
		if(not aux):
		 	no_matches.append(x)

		result.append(aux)

	
	for row in zip(cgmii_input, decoded_output, result):
		table.add_row(row)
		 
	plot = table.draw()
	print plot

	print "No_matches: ", len(no_matches)
	print 'No_match_vector', no_matches
    

if __name__ == '__main__':
    main()

