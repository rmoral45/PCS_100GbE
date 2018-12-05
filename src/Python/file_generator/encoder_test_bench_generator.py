
from pdb import set_trace as bp
import tx_modules as tx 
import test_bench_functions as tb


NCLOCK = 700

def main():
	#--------------open files---------------------------
	enco_input_data_file  = open("encoder-input-data.txt" ,"w")
	enco_input_ctrl_file  = open("encoder-input-ctrl.txt" ,"w")
	enco_output_file      = open("encoder-output.txt","w")

	#------------- sim starts ---------------------------

	cgmii_module = tx.CgmiiFSM(16,5)

	for clock in range (0,NCLOCK): # MAIN LOOP
		
		
		tx_raw = cgmii_module.tx_raw #bloque recibido desde cgmii
		
		#codificacion
		if tx_raw['block_name'] in tx.ENCODER : 
			tx_coded = tx.ENCODER[ tx_raw['block_name'] ]
		else :
			tx_coded = tx.ENCODER['ERROR_BLOCK']
		
		cgmii_module.change_state(0)
		(bin_tx_data , bin_tx_ctrl) = tb.cgmii_block_to_bin(tx_raw)
		bin_tx_coded = tb.encoder_block_to_bin(tx_coded)

		bin_tx_data  = ''.join(map(lambda x: x+' ' ,  bin_tx_data))
		bin_tx_ctrl  = ''.join(map(lambda x: x+' ' ,  bin_tx_ctrl))
		bin_tx_coded = ''.join(map(lambda x: x+' ' ,  bin_tx_coded))

		enco_input_data_file.write(bin_tx_data + '\n')
		enco_input_ctrl_file.write(bin_tx_ctrl + '\n')
		enco_output_file.write(bin_tx_coded    + '\n')

	#-------------close files-----------------------
	bp()
	enco_input_data_file.close()
	enco_input_ctrl_file.close()
	enco_output_file.close()





	

if __name__ == '__main__':
    main()
