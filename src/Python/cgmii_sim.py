

import random
import numpy as np
from pdb import set_trace as bp
import tx_modules as tx 
import rx_modules as rx
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
	rx_cgmii = rx.rx_FSM()
	tx_scrambler_module = tx.Scrambler()
	rx_scrambler_module = tx.Scrambler()
	#rx_scrambler = Scrambler()

	for clock in range (0,NCLOCK): # MAIN LOOP
		
		
		tx_raw = cgmii_module.tx_raw #bloque recibido desde cgmii
		#codificacion
		if tx_raw['block_name'] in tx.ENCODER : 
			tx_coded = tx.ENCODER[ tx_raw['block_name'] ]
		else :
			tx_coded = tx.ENCODER['ERROR_BLOCK']
		if clock == 23 :
			tx_coded = tx.ENCODER['T0_BLOCK']	
		coded_vector.append(tx_coded) #solo para debugging
		rx_cgmii.transition(tx_coded)
		
		cgmii_module.change_state(0)
		'''
		send = tx_scrambler_module.tx_scrambling(tx_coded)
		receive = rx_scrambler_module.rx_scrambling(send)
		'''

	bp()

	

if __name__ == '__main__':
    main()
