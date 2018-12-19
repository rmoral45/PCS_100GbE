

import random
import numpy as np
from pdb import set_trace as bp
import tx_modules as tx 
import copy
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
	SEED = np.random.randint(0,2,58)
	tx_scrambler_module.shift_reg = copy.deepcopy(SEED)
	#rx_scrambler_module.shift_reg = copy.deepcopy(SEED)
	#rx_scrambler = Scrambler()

	for clock in range (0,NCLOCK): # MAIN LOOP
		
		
		tx_raw = cgmii_module.tx_raw #bloque recibido desde cgmii
		#codificacion
		if tx_raw['block_name'] in tx.ENCODER : 
			tx_coded = tx.ENCODER[ tx_raw['block_name'] ]
		else :
			tx_coded = tx.ENCODER['ERROR_BLOCK']
		
		coded_vector.append(tx_coded) #solo para debugging
		
		#rx_decoder_module.change_state(tx_coded) #
		
		cgmii_module.change_state(0)
		
		send = tx_scrambler_module.tx_scrambling(tx_coded)
		receive = rx_scrambler_module.rx_scrambling(send)
		print 'send : ' ,hex(tx_coded['block_type']), map(hex,tx_coded['payload'])
		print ' \n\n'
		print 'receive : ' , hex(receive['payload'])
		bp()
		#tx_scrambler_module.shift_reg = copy.deepcopy(SEED)
		#rx_scrambler_module.shift_reg = copy.deepcopy(SEED)
		



	

if __name__ == '__main__':
    main()
