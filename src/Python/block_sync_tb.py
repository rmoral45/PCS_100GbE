import random
import numpy as np
from pdb import set_trace as bp
import tx_modules as tx 
import block_sync as bs
import copy

#CONSTANTS
NCLOCK = 200

#FUNCT
def break_sh(block,break_flag,sh_index):
	rand = random.randint(1,19)

	if (break_flag == True):
		if(rand % 2):#rompo sh pponiendolo en 11
			block['payload'] |= 3 << sh_index
			return block
		else:

			block['payload'] &= (~(3 << sh_index))
			return block
	else:
		return block

def gen_block(sh_index):
	rand = random.randint(1,19)
	block= { 'block_name': 'SH_TEST_BLOCK', 'payload' : 125}

	if(rand % 2):
		block['payload'] |= 2 << sh_index
		return block
	else:
		block['payload'] |= 1 << sh_index
		return block	


def main():

#Init
	sh_index = 64 #3con 64 se engancha en ciclos de clock 
	break_flag = False
	#sh_cnt_limit   = 64 parametro para la fsm
	#sh_invld_limit = 32 parametro para la fsm
	Block_Sync_Module = bs.BlockSyncModule(0)
	Block_Sync_Module.reset()

#main loop
	for clock in range(NCLOCK):

		block = gen_block(sh_index)
		block = break_sh(block,break_flag,sh_index)

		Block_Sync_Module.receive_block(block)

		for i in range(5):
			Block_Sync_Module.FSM_change_state()

		block = Block_Sync_Module.get_block()
		if Block_Sync_Module.block_lock and clock < 65:
			bp()
			break_flag = True
		if clock > 70 and Block_Sync_Module.block_lock == False :
			bp()




if __name__ == '__main__':
    main()