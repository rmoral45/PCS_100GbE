

import random
import numpy as np
from pdb import set_trace as bp
from tx_modules import *

NCLOCK = 40
NIDLE = 5
NDATA = 16





def main():
	bp()
	coded_vector = []

	cgmii_module = CgmiiFSM()
	tx_scrambler_module = Scrambler()
	#rx_scrambler = Scrambler()

	for clock in range (0,NCLOCK): # MAIN LOOP
		#bloque recibido desde cgmii
		raw_block = cgmii_module.tx_raw
		raw_block = list_to_hex(raw_block)
		
		#codificacion
		if raw_block in encoder : 
			coded_block = encoder[raw_block]
		else :
			coded_block = CODED_ERROR_BLOCK

		coded_vector.append(coded_block)
		cgmii_module.change_state(0)

	bp()



	

if __name__ == '__main__':
    main()
