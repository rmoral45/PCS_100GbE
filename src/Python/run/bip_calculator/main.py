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
NCLOCK = 200 
LANEID = 0

def main():


	bip_input_data_file = open("bip-input-data.txt", "w")
	bip_output_data_file = open("bip-output-data.txt", "w")
	bip_input_aminsert_file = open("bip-input-aminsert.txt", "w")

	am_insertion = am.AmInsertionModule(LANEID) #am insertion para lane 0

	data = cv.data_dict['data']						#primer bloque que agregamos con todos 0

	for clock in range(0, NCLOCK):

		block = genBlock(clock)

		data = am_insertion.run(clock, block)

		bin_am_insert_flag = str(block['flag'])
		bin_input_data = map(str, [0,1]+block['data'])
		bin_input_data = ''.join(map(lambda x: x+' ', bin_input_data))
		bin_output_data = map(str, data)
		bin_output_data = ''.join(map(lambda x: x+' ', bin_output_data))

		bip_output_data_file.write(bin_output_data + '\n')
		bip_input_data_file.write(bin_input_data + '\n')
		bip_input_aminsert_file.write(bin_am_insert_flag + '\n')

		print "Data: ", data
		print "am_insert: ", block['flag']

	bip_output_data_file.close()


def genBlock(clock):

	block = { 'flag':0,
			  'data':[0]*64 
				}

	for index in range(2, len(block['data'])):
			block['data'][index] = random.randint(0,1)

	if(clock%cv.AM_BLOCK_GAP == 0):
		block['flag'] = 1

	return block


if __name__ == '__main__':
	main()



		
