import random
import numpy as np
from pdb import set_trace as bp
import tx_modules as tx 
import idle_deletion as iddel
import test_bench_functions as tb
import copy
#import rx_modules as rx
NCLOCK  = 10000
NBLOCKS = 100
NLANES  = 20



def main():
	#--------------------init----------------------#

	#sim variables
	cgmii_module 	 = tx.CgmiiFSM(40,12)
	idle_del_module  = iddel.IdleDeletionModule(NBLOCKS,NLANES)
	tx_encoder_input = []
	tx_raw_input	 = []

	#files
	idle_del_input_data_file  = open( "idle-deletion-input-data.txt" , "w" )
	idle_del_input_ctrl_file  = open( "idle-deletion-input-ctrl.txt" , "w" )
	idle_del_output_data_file = open( "idle-deletion-output-data.txt", "w" )
	idle_del_output_ctrl_file = open( "idle-deletion-output-ctrl.txt", "w" )


	#-------------simulation begin------------------#

	for clock in range (0,NCLOCK): # MAIN LOOP
		
		tx_raw = cgmii_module.tx_raw #bloque recibido desde cgmii
		#tx_raw_input.append(tx_raw)
		cgmii_module.change_state(0)

		(bin_input_data , bin_input_ctrl) = tb.cgmii_block_to_bin(tx_raw)
		idle_del_module.add_block(tx_raw)

		tx_block = idle_del_module.get_block()
		(bin_output_data , bin_output_ctrl) = tb.cgmii_block_to_bin(tx_block)
		#tx_encoder_input.append(tx_block)
		print '\n\n NAME:', tx_block['block_name']

		#format 
		bin_input_data  = ''.join(map(lambda x: x+' ' ,  bin_input_data  ))
		bin_input_ctrl  = ''.join(map(lambda x: x+' ' ,  bin_input_ctrl  ))
		bin_output_data = ''.join(map(lambda x: x+' ' ,  bin_output_data ))
		bin_output_ctrl = ''.join(map(lambda x: x+' ' ,  bin_output_ctrl ))
		#write
		idle_del_input_data_file.write(bin_input_data + '\n')
		idle_del_input_ctrl_file.write(bin_input_ctrl + '\n')
		idle_del_output_data_file.write(bin_output_data + '\n')
		idle_del_output_ctrl_file.write(bin_output_ctrl + '\n')

		 
	bp()



	

if __name__ == '__main__':
    main()