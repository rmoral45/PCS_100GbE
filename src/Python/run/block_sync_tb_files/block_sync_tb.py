import random
from pdb import set_trace as bp
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

	'''
		Esta funcion genera bloques con el sh en una determinada posicion dada por
		sh_index, el tipo de sh generado depende de una variable aleatoria 'rand'
	'''

	rand_sh 		 = random.randint(1,19)
	block 			 = { 'block_name': 'SH_TEST_BLOCK', 'payload' : 0}
	block['payload'] = random.getrandbits(66)
	block['payload'] &= ~(0x3 << sh_index)

	if(rand_sh % 2):
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

	#fsm config params
	sh_invld_limit 		= 64
	locked_time_limit 	= 64
	unlocked_time_limit = 2048

	#Simulation variables
	sh_index 			= 64 #con 64 se engancha en 64 ciclos de clock 
	break_flag 			= False
	'''
		En el peor de los casos va a demorar NB_BLOCK*locked_time_limit en engarcharse,es decir va
		a encontrar todos sh validos en la posicion 64 excepto en ultimo, y va a comenzar a buscar en la
		posicion 63 y asi hasta llegar a la  0 en la que se va a enganchar finalmente.
	'''
	next_param_change 	= random.randint(500,1500)

	#module init
	Block_Sync_Module = bs.BlockSyncModule(0, locked_time_limit, unlocked_time_limit, sh_invld_limit)
	Block_Sync_Module.reset()

	#Files
	block_sync_input  = open( "block-sync-input.txt"  , "w" )
	block_sync_output = open( "block-sync-output.txt" , "w" )
	block_lock_flag   = open( "block-lock-flag.txt"   , "w" )


#main loop
	for clock in range(NCLOCK):

		in_block = gen_block(sh_index)
		print 'clock :' ,clock
		in_block = break_sh(in_block,break_flag,sh_index)
		Block_Sync_Module.receive_block(in_block)
		Block_Sync_Module.FSM_change_state()

		out_block   = Block_Sync_Module.get_block()

		bin_input   = block_to_bin(in_block)
		bin_output  = block_to_bin(out_block)
		bin_flag    = bin(Block_Sync_Module.block_lock)[2:]

		if Block_Sync_Module.block_lock == 1:
			print 'in  : ' , bin_input
			print 'out : ', bin_output

		'''
		if (clock == next_param_change) :
			print ' Current  params :\n'

			print 'clock : '		,clock
			print 'sh_index : '		,sh_index
			print 'block_index : '	,Block_Sync_Module.block_index
			print 'last out block'	,bin_output
			bp()
			next_param_change = random.randint(clock+50, clock+2048)
			sh_index = random.randint(0,64)
		'''

		"""

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
		"""
		




if __name__ == '__main__':
    main()