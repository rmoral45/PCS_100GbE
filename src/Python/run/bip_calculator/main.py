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
NCLOCK = 20 
LANEID = 0

def main():


	bip_input_data_file = open("bip-input-data.txt", "w")

	am_insertion = am.AmInsertionModule(LANEID) #am insertion para lane 0

	data = cv.data_dict['data']						#primer bloque que agregamos con todos 0

	for clock in range(0, NCLOCK):

		for index in range(2, len(data)):
			data[index] = random.randint(0,1)

		result = am_insertion.run(clock, data)


		bin_data = map(str, data)

		bin_data = ''.join(map(lambda x: x+' ', bin_data))

		bip_input_data_file.write(bin_data + '\n')

		print data


	bip_input_data_file.close()


if __name__ == '__main__':
	main()



		
