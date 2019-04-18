import sys
sys.path.append('../../modules/')
import common_variables as cv
import common_functions as cf
import bip_calculator as bip

from pdb import set_trace as bp
import random


#NCLOCK = 2^14
NCLOCK = 10 

def main():

	new_bip_calculator = bip.bipCalculator()

	data = cv.data_dict['data']
	alignment_flag = cv.data_dict['alignment_flag']

	for clock in range(0, NCLOCK):

		new_bip_calculator.reset()

		if(~NCLOCK%2):
			for index in range(2, len(data)):
				if(bool(random.getrandbits(1))):
					data[index] = 1
				else:
					data[index] = 0

		(bip3, bip7)  = new_bip_calculator.calculateParity(data, alignment_flag)

		
		print('data:', data)
		print('bip3: ', bip3)
		print('bip7: ', bip7)

if __name__ == '__main__':
	main()



		
