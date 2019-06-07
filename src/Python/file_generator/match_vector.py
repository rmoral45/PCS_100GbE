
from pdb import set_trace as bp
import texttable as tt
import copy as cp
import numpy as np

def allign_vector(python_vector, verilog_vector):

	ver_index_left  = 2
	ver_index_right = 1
	py_index_left   = 1
	py_index_right  = 18

	#new_pyvector = cp.deepcopy(python_vector[py_index_left:-py_index_right])
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

	result_data = []
	result_ctrl = []
	no_matches_ctrl = []
	no_matches_data = []
#-----------------------------------------------------------------------
	
	with open("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/bip_calculator/bip-data-output-verilog.txt") as verilog_decoded_data_output:
		decoded_data_output = verilog_decoded_data_output.readlines()

	
	#with open("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/bip_calculator/bip-data-output-verilog.txt") as verilog_decoded_ctrl_output:
	#	decoded_ctrl_output = verilog_decoded_ctrl_output.readlines()

	#with open("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/bip_calculator/bip-data-output-verilog.txt") as verilog_cgmii_ctrl_input:
	#	cgmii_ctrl_input = verilog_cgmii_ctrl_input.readlines()

	with open("/media/ramiro/1C3A84E93A84C16E/PPS/src/Python/run/bip_calculator/bip-output-data.txt") as verilog_cgmii_data_input:
		cgmii_data_input = verilog_cgmii_data_input.readlines()
	
	
	for i in range(len(cgmii_data_input)):
		cgmii_data_input[i]=filter(lambda x: x!=' ',cgmii_data_input[i])


	#for i in range(len(cgmii_ctrl_input)):
	#	cgmii_ctrl_input[i]=filter(lambda x: x!=' ',cgmii_ctrl_input[i])
	
	decoded_data_output = [x.strip() for x in decoded_data_output] 
	#decoded_ctrl_output = [x.strip() for x in decoded_ctrl_output]
	cgmii_data_input = [x.strip() for x in cgmii_data_input] 
	#cgmii_ctrl_input = [x.strip() for x in cgmii_ctrl_input]

	cgmii_data_input, decoded_data_output = allign_vector(cgmii_data_input, decoded_data_output)
	#cgmii_ctrl_input, decoded_ctrl_output = allign_vector(cgmii_ctrl_input, decoded_ctrl_output)
	cgmii_data_input, decoded_data_output = convert_vect_to_hex(cgmii_data_input, decoded_data_output)
	#cgmii_ctrl_input, decoded_ctrl_output = convert_vect_to_hex(cgmii_ctrl_input, decoded_ctrl_output)

#-----------------------------------------------------------------------
	table_data = tt.Texttable()
	columns = ('Encoder-data-input', 'Decoder-data-output', 'Match' )
	table_data.header(columns)
	table_data.set_cols_width([64,64,8])
	table_data.set_cols_dtype(['t', 't', 't'])
	table_data.set_cols_align(['c', 'c', 'c'])

	for x in range(len(cgmii_data_input)):		 
		aux = decoded_data_output[x] == cgmii_data_input[x]
	
		if(not aux):
		 	no_matches_data.append(x)

		result_data.append(aux)

	
	for row in zip(cgmii_data_input, decoded_data_output, result_data):
		table_data.add_row(row)
		 
	plot = table_data.draw()
	print plot
	'''
#-----------------------------------------------------------------------
	table_ctrl = tt.Texttable()
	columns1 = ('Encoder-ctrl-input', 'Decoder-ctrl-output', 'Match' )
	table_ctrl.header(columns1)
	table_ctrl.set_cols_width([20,20,8])
	table_ctrl.set_cols_dtype(['t', 't', 't'])
	table_ctrl.set_cols_align(['c', 'c', 'c'])

	for x in range(len(cgmii_ctrl_input)):		 
		aux1 = decoded_ctrl_output[x] == cgmii_ctrl_input[x]
	
		if(not aux1):
		 	no_matches_ctrl.append(x)

		result_ctrl.append(aux1)

	
	for row in zip(cgmii_ctrl_input, decoded_ctrl_output, result_ctrl):
		table_ctrl.add_row(row)
		 
	plot1 = table_ctrl.draw()
	print plot1
#-----------------------------------------------------------------------
	'''
	print "No_matches_data: ", len(no_matches_data)
	print 'No_match_data_vector', no_matches_data
    
	#print "no_matches_ctrl: ", len(no_matches_ctrl)
	#print 'No_match_ctrl_vector', no_matches_ctrl


	print "Length Cgmii Input Data:", len(cgmii_data_input)
	#print "Length Cgmii Input Ctrl:", len(cgmii_ctrl_input)

if __name__ == '__main__':
    main()


