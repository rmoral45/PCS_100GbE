from pdb import set_trace as bp
import sys
sys.path.append('../modules')

import common_variables as cv

def main():

#############  read output from am_insertion mods

        aligner_search_mask = 0x2ffffff00ffffff00
        bip_set_mask        = 0x000000000000000ff
        data_search_mask    = 0x10000000000000000 #solo debe ser correcto el encabezado
        
        #Process PC_N_to_1 output
        with open('') as fd:
                am_blocks = []
                contents  = ''
                contents  = fd.read()

                #start file content formatting
                contents  = contents.split('\n')
                for data in contents:
                        am_blocks.append(data[:-1]) # CHECK, creo que esto era por el tema del tag  !!!!!!!
                am_blocks     = list(map(lambda x : int(x,2), am_blocks))
                masked_blocks = list(map(lambda x : ((x & aligner_search_mask) | bip_set_mask), am_blocks))

                #start checking correct am prescense
                period_start_index  = masked_blocks.index(cv.align_marker_list[0])
                am_blocks           = am_blocks[period_start_index :] #los bloques antes de eso pertenecen l transitorio, por lo tanto son invalidos
                masked_blocks       = masked_blocks[period_start_index :] 
                n_simulated_periods = len(am_blocks) /(AM_BLOCK_PERIOD * N_LANES) # obtengo cantidad de periodos COMPLETOS (division entera)
                am_blocks           = am_blocks[:n_simulated_periods * AM_BLOCK * N_LANES]
                masked_blocks       = masked_blocks[:n_simulated_periods * AM_BLOCK * N_LANES]

                #check am every period
                for i in range(n_simulated_periods):
                        if masked_blocks[i*N_LANES*AM_BLOCK_PERIOD : i*N_LANES*AM_BLOCK_PERIOD + N_LANES] \
                           != cv.align_marker_list :
                                print("\nPERIOD NUMBER : %i\n", %(i))
                                raise Exception("Aligner Mismatch")
                
                #parse data blocks 
                out_data_blocks  = list(filter(lambda x : ((x & data_search_mask) != 0) , am_blocks))

        #process frame generator output
        with open('') as fd:
                gen_blocks = []
                contents  = fd.read()
                #start file content formatting
                contents  = contents.split('\n')
                for data in contents:
                        gen_blocks.append(data[:-1]) # CHECK !!!!! creo que esto era por el tema del tag que estaba puesto


                '''
                Dejo esta linea por las dudas, pero no deberia tener que ajustar este vector, ya que
                no tiene estado transitorio por que es primer salida
                gen_blocks = gen_blocks[period_start_index : n_simulated_periods * AM_BLOCK_PERIOD * N_LANES]
                '''

                gen_blocks = list(map(lambda x : int(x,2), gen_blocks))
                #parse data blocks
                in_data_blocks  = list(filter(lambda x : ((x & data_search_mask) != 0) , gen_blocks))


        ###################  TEST DATA MATCH  #################
        print("Generated data block count        : %i\n", %(len(in_data_blocks)))
        print("Am insert output data block count : %i\n", %(len(out_data_blocks)))

        if in_data_blocks != out_data_blocks :
                raise Exception("Data Mismatch")


if __name__ == '__main__':
        main()
