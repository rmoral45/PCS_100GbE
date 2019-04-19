#Script destinado al testing del am_insertion y la calculadora de bip
import sys
sys.path.append('../../modules/')
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

	new_AmInsertionModule = am.AmInsertionModule(LANEID) #am insertion para lane 0
	new_bip_calculator = bip.bipCalculator(LANEID) #calculadora de bip para lane 0

	data = cv.data_dict['data']						#primer bloque que agregamos con todos 0
	alignment_flag = cv.data_dict['alignment_flag'] #no es alineador, asi que esta flag va 0

	for clock in range(0, NCLOCK):

		#new_bip_calculator.reset()

		new_AmInsertionModule.add_block(data)

		if(~NCLOCK%2):
			for index in range(2, len(data)):
				data[index] = random.randint(0,1)


		(bip3, bip7)  = new_bip_calculator.calculateParity(data, alignment_flag)

		
		print('data:', data)
		print('bip3: ', bip3)
		print('bip7: ', bip7)

if __name__ == '__main__':
	main()



		
