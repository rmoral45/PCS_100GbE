#Script destinado al testing del am_insertion y la calculadora de bip
import sys
sys.path.append('../../modules')
import common_variables as cv
import common_functions as cf
import am_insertion as am
import bip_calculator as bip

from pdb import set_trace as bp
import random

#NCLOCK = 2^14
NCLOCK = 2000
LANEID = 0

def main():


	bip_input_data_file = open("bip-input-data.txt", "w")
	bip_output_data_file = open("bip-output-data.txt", "w")
	bip_input_aminsert_file = open("bip-input-aminsert.txt", "w")
	bip_output_parity_file = open("bip-output-parity.txt", "w")

	am_insertion = am.AmInsertionModule(LANEID) #am insertion para lane 0

	data = cv.data_dict['data']						#primer bloque que agregamos con todos 0

	for clock in range(0, NCLOCK):

		block = genBlock(clock)

		data = am_insertion.run(clock, block)
		#bp()
		

		bin_output_parity = map(str, am_insertion._bipCalculator.bip3)
		bin_output_parity = ''.join(map(lambda x: x+' ', bin_output_parity))
		bin_am_insert_flag = str(block['flag'])
		bin_input_data = map(str, block['data'])
		bin_input_data = ''.join(map(lambda x: x+' ', bin_input_data))
		bin_output_data = map(str, data)
		bin_output_data = ''.join(map(lambda x: x+' ', bin_output_data))

		bip_output_parity_file.write(bin_output_parity + '\n')
		bip_output_data_file.write(bin_output_data + '\n')
		bip_input_data_file.write(bin_input_data + '\n')
		bip_input_aminsert_file.write(bin_am_insert_flag + '\n')


	bip_input_data_file.close()	
	bip_input_aminsert_file.close()	
	bip_output_data_file.close()
	bip_output_parity_file.close()


def genBlock(clock):

	block = { 'flag':0,
			  'data':[0]*64 
				}

	for index in range(0, len(block['data'])):
			block['data'][index] = random.randint(0,1)

	if(clock%cv.AM_BLOCK_GAP == 0):
		block['flag'] = 1
		block['data'] = [1,0] + block['data']

	else :
		block['flag'] = 0
		block['data'] = [0,1] + block['data']

	return block


if __name__ == '__main__':
	main()



		
