import random
import numpy as np
from pdb import set_trace as bp
from common_variables import * 
import am_lock as am
import copy
N_CLOCK = 10000
MAX_DELAY = 10
AM_PERIOD = 10 # seteo asi por la sim,el bloque 16384 es un marker
AM_INV = 4
PHY_LANE_ID = 0

def main():
#Init
	Am_Lock_Module = am.AlignMarkerLockModule(AM_PERIOD,AM_INV)
	tx_block = []
	rx_block = []

	for clock in range(N_CLOCK):
		block = {
					'block_name' : 'ASD',
					'sh'		 : 1 ,
					'payload'    : 0
				}
		if (clock % AM_PERIOD) == 0 and clock > 0:
			block['block_name'] = 'ALIGNER'
			block['payload'] = align_marker_list[PHY_LANE_ID]
			bp()
		tx_block.append(block)
		Am_Lock_Module.receive_block(block)
		Am_Lock_Module.FSM_change_state(True,block)
		recv_block =Am_Lock_Module.get_block()
		rx_block.append(recv_block)






if __name__ == '__main__':
    main()