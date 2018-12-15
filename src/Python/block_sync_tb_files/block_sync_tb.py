import random
import numpy as np
from pdb import set_trace as bp
import tx_modules as tx 
import block_sync as bs
import copy

#CONSTANTS
NCLOCK = 10000

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
	block= { 'block_name': 'SH_TEST_BLOCK', 'payload' : 0}

	if(rand % 2):
		block['payload'] |= 2 << sh_index
		return block
	else:
		block['payload'] |= 1 << sh_index
		return block

def block_to_bin(block):
	N_BITS = 66
	binary = (bin(block['payload'])[2:].zfill(N_BITS))
	return binary

def main():

#Init
	#Simulation variables
	sh_index = 65 #con 64 se engancha en 64 ciclos de clock 
	break_flag = False
	#sh_cnt_limit   = 64 parametro para la fsm
	#sh_invld_limit = 32 parametro para la fsm
	Block_Sync_Module = bs.BlockSyncModule(0)
	Block_Sync_Module.reset()
	random_change = random.randint(70,233)

	#Files
	block_sync_input  = open( "block-sync-input.txt"  , "w" )
	block_sync_output = open( "block-sync-output.txt" , "w" )
	block_lock_flag   = open( "block-lock-flag.txt"   , "w" )


#main loop
	for clock in range(NCLOCK):

		in_block = gen_block(sh_index)
		in_block = break_sh(in_block,break_flag,sh_index)
		Block_Sync_Module.receive_block(in_block)

		for i in range(5):
			Block_Sync_Module.FSM_change_state()

		out_block   = Block_Sync_Module.get_block()

		bin_input   = block_to_bin(in_block)
		bin_output  = block_to_bin(out_block)
		bin_flag    = bin(Block_Sync_Module.block_lock)[2:]

		#format
		bin_input   = ''.join(map(lambda x: x+' ' ,  bin_input  ))
		bin_output  = ''.join(map(lambda x: x+' ' ,  bin_output ))

		block_sync_input.write(bin_input   + '\n')
		block_sync_output.write(bin_output + '\n')
		block_lock_flag.write(bin_flag     + '\n')
		
		if((clock % random_change) == 0):
			sh_index -=1
		if(sh_index < 0):
			bp()
			break




if __name__ == '__main__':
    main()