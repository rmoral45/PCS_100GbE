
from pdb import set_trace as bp
import texttable as tt
import copy as cp
import numpy as np

def allign_vector(python_vector, verilog_vector):

	ver_index_left  = 9
	ver_index_right = 6
	py_index_left   = 2
	py_index_right  = 6

	new_pyvector = cp.deepcopy(python_vector[py_index_left:-py_index_right])
	new_vevector = cp.deepcopy(verilog_vector[ver_index_left:-ver_index_right])

	return new_pyvector, new_vevector


def convert_vect_to_hex(python_vector,verilog_vector):
	pyvect  = []
	vervect = []
	for i in python_vector:
		pyvect.append( hex(int(i,2)) )
	for i in verilog_vector:
		vervect.append( hex(int(i,2)) )
	return pyvect, vervect

def main():

	result = []
	no_matches = []

	with open("./verilog_outputs/verilog-decoded-data-output.txt") as verilog_decoded_output:
		decoded_output = verilog_decoded_output.readlines()

	with open("./encoder-input-data.txt") as verilog_cgmii_input:
		cgmii_input = verilog_cgmii_input.readlines()

	
	for i in range(len(cgmii_input)):
		cgmii_input[i]=filter(lambda x: x!=' ',cgmii_input[i])
	
	decoded_output = [x.strip() for x in decoded_output] 
	cgmii_input = [x.strip() for x in cgmii_input] 
	cgmii_input, decoded_output = allign_vector(cgmii_input, decoded_output)
	cgmii_input, decoded_output = convert_vect_to_hex(cgmii_input, decoded_output)

	bp()

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


