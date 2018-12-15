import random
import numpy as np
from pdb import set_trace as bp
from common_variables import * 
import am_lock as am
import copy
N_CLOCK = 500
AM_PERIOD =10 #16384 # seteo asi por la sim,el bloque 16384 es un marker
AM_INV = 4
PHY_LANE_ID = 7
def block_to_bin(block):
	binary = bin(block['payload'])
	binary = binary[2:].zfill(66)
	return binary

def main():
	#simulation variables
	Am_Lock_Module = am.AlignMarkerLockModule(AM_PERIOD,AM_INV)
	tx_block = []
	rx_block = []

	#file variables
	am_lock_input  = open("am-lock-input-file.txt","w")
	am_lock_output = open("am-lock-output-file.txt","w")
	am_lock_flag   = open("am-lock-flag-file.txt","w")

	for clock in range(N_CLOCK):
		block = {
					'block_name' : 'ASD',
					'payload'    : 0x10000000000000000 
				}
		if (clock % AM_PERIOD) == 0 and clock > 0:
			block['block_name'] = 'ALIGNER'
			block['payload'] = align_marker_list[PHY_LANE_ID]
		tx_block.append(block)
		Am_Lock_Module.receive_block(block)
		Am_Lock_Module.FSM_change_state(True,block)
		recv_block = Am_Lock_Module.get_block()
		rx_block.append(recv_block)

		#bin convert
		bin_input_block = block_to_bin(block)
		bin_output_block = block_to_bin(recv_block)
		bin_am_flag  = bin(Am_Lock_Module.am_lock)[2:]
		#format

		bin_input_block   = ''.join(map(lambda x: x+' ' ,  bin_input_block  ))
		bin_output_block  = ''.join(map(lambda x: x+' ' ,  bin_input_block  ))

		am_lock_input.write(bin_input_block + '\n')
		am_lock_output.write(bin_output_block + '\n')
		am_lock_flag.write(bin_am_flag + '\n')







if __name__ == '__main__':
    main()