import random
import numpy as np
from pdb import set_trace as bp
from common_variables import * 
import am_lock as am
import copy
N_LANES = 20
MAX_DELAY = 10
AM_PERIOD = 16384
'''
hay cosas que no sirven y otras que si..INCOMPLETO-MAL
'''

def add_block(lanes):

	fill_block = {'block_name' : 'Fill Block' , 'payload' : 0 }
	for lane in lanes :
		lane.insert(0,copy.deepcopy(fill_block))
		lane.pop()



def main():
#Init
	init_block = {'block_name' : 'Init Block', 'payload' : 0 }
	lanes      = [[copy.deepcopy(init_block) for i in range(MAX_DELAY)] for j in range(N_LANES)]
	delay_vect =
	for i in range(N_LANES):	
		delay_vect[i] = i









if __name__ == '__main__':
    main()