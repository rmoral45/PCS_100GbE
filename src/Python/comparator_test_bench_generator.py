from pdb import set_trace as bp
import test_bench_functions as tb


NCLOCK = 80

def main():
	#--------------open files---------------------------
	enco_input_data_file  = open("encoder-rand-input-data.txt" ,"w")
	enco_input_ctrl_file  = open("encoder-rand-input-ctrl.txt" ,"w")
	enco_output_file      = open("encoder-rand-output.txt","w")

	#------------- sim starts ---------------------------


	for clock in range (0,NCLOCK): # MAIN LOOP
		"""
			aca genero inputs aleatorias al comparador(bloques cgmii) 
			y su salida codificada correspondiente(bloques codificados)

		"""
		(bin_tx_data , bin_tx_ctrl , bin_tx_coded) = tb.random_comparator_IO()

		enco_input_data_file.write(bin_tx_data + '\n')
		enco_input_ctrl_file.write(bin_tx_ctrl + '\n')
		enco_output_file.write(bin_tx_coded    + '\n')

	#-------------close files-----------------------
	enco_input_data_file.close()
	enco_input_ctrl_file.close()
	enco_output_file.close()





	

if __name__ == '__main__':
    main()