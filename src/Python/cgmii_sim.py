

import random
import numpy as np
from pdb import set_trace as bp
import tx_modules as tx 
NCLOCK = 40
NIDLE = 5
NDATA = 16
NLANES = 20





def main():
	#------------------------init--------------------#
	tx_fifo = []
	coded_vector = []
	lanes = [[] for y in range(NLANES)]

	cgmii_module = tx.CgmiiFSM()
	tx_scrambler_module = tx.Scrambler()
	#rx_scrambler = Scrambler()

	for clock in range (0,NCLOCK): # MAIN LOOP
		
		raw_block = cgmii_module.tx_raw #bloque recibido desde cgmii
		raw_block = list_to_hex(raw_block)
		
		#codificacion
		if raw_block in encoder : 
			coded_block = tx.encoder[raw_block]
		else :
			coded_block = CODED_ERROR_BLOCK

		coded_vector.append(coded_block) #solo para debugging
		cgmii_module.change_state(0)



		if 

	bp() 


	

if __name__ == '__main__':
    main()
