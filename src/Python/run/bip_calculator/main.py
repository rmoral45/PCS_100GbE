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
NCLOCK = 21 
LANEID = 0

def main():


	bip_input_data_file = open("bip-input-data.txt", "w")
	bip_input_aminsert_file = open("bip-input-aminsert.txt", "w")

	am_insertion = am.AmInsertionModule(LANEID) #am insertion para lane 0

	data = cv.data_dict['data']						#primer bloque que agregamos con todos 0

	for clock in range(0, NCLOCK):

		for index in range(2, len(data)):
			data[index] = random.randint(0,1)

		(data, am_insert_flag) = am_insertion.run(clock, data)

		bin_am_insert_flag = str(am_insert_flag)
		bin_data = map(str, data)

		bin_data = ''.join(map(lambda x: x+' ', bin_data))

		bip_input_data_file.write(bin_data + '\n')
		bip_input_aminsert_file.write(bin_am_insert_flag + '\n')

		print "Data: ", data
		print "am_insert: ", am_insert_flag

	bip_input_data_file.close()


if __name__ == '__main__':
	main()



		
