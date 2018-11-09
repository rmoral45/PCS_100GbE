import random
import numpy as np
from pdb import set_trace as bp
import tx_modules as tx 
import parallel_scrambler as ps
import copy
import scamb_func_generator as gen
#import rx_modules as rx
NCLOCK = 80
NIDLE = 5
NDATA = 16
NLANES = 20





def main():
	#------------------------init--------------------#
	tx_fifo = []
	coded_vector = []
	lanes = [[] for y in range(NLANES)]

	cgmii_module = tx.CgmiiFSM()
	#rx_decoder_module = rx.rx_FSM()
	tx_scrambler_module = tx.Scrambler()
	rx_scrambler_module = tx.Scrambler()
	par_scrambler = ps.ParallelScrambler()
	generator = gen.ScrmGen()
	SEED = np.random.randint(0,2,58)
	#tx_scrambler_module.shift_reg = copy.deepcopy(SEED)
	#rx_scrambler_module.shift_reg = copy.deepcopy(SEED)
	#rx_scrambler = Scrambler()

	for clock in range (0,NCLOCK): # MAIN LOOP
		
		
		tx_raw = cgmii_module.tx_raw #bloque recibido desde cgmii
		#codificacion
		if tx_raw['block_name'] in tx.ENCODER : 
			tx_coded = tx.ENCODER[ tx_raw['block_name'] ]
		else :
			tx_coded = tx.ENCODER['ERROR_BLOCK']
		
		func = generator.scrm_func(tx_coded)
		for i in func :
			print '\n' ,i
		print '\n \n' 
		
	
		coded_vector.append(tx_coded) #solo para debugging
		
		#rx_decoder_module.change_state(tx_coded) #
		
		cgmii_module.change_state(0)
		
		serial = tx_scrambler_module.tx_scrambling(tx_coded)
	
		par = par_scrambler.par_scrambling(tx_coded)
		binpar = ''.join(str(x) for x in par)
		
		print 'serial :  ', bin(serial['payload'])
		print '\n'
		print 'parallel:  ', binpar
		print '\n'
		bp()
		



	

if __name__ == '__main__':
    main()