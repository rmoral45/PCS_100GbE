import random
import numpy as np
from pdb import set_trace as bp
import tx_modules as tx 
import idle_deletion as iddel
import copy
#import rx_modules as rx
NCLOCK  = 45
NBLOCKS = 10
NLANES  = 3





def main():
	#------------------------init--------------------#

	cgmii_module 	 = tx.CgmiiFSM(40,5)
	idle_del_module  = iddel.IdleDeletionModule(NBLOCKS,NLANES)
	tx_encoder_input = []
	cgmii_out		 = []

	for clock in range (0,NCLOCK): # MAIN LOOP
		
		tx_raw = cgmii_module.tx_raw #bloque recibido desde cgmii
		cgmii_out.append(tx_raw)
		cgmii_module.change_state(0)
		idle_del_module.add_block(tx_raw)
		tx_block = idle_del_module.get_block() 
		tx_encoder_input.append( tx_block )
	bp()



	

if __name__ == '__main__':
    main()