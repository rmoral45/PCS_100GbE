import sys
sys.path.append('../')
import common_variables as comvar
import random
import copy
import re
from pdb import set_trace as bp
def main():
        #raw_data_0 = gen_lane_data(0);
        raw_data_1 = gen_lane_data(1);
        #in_data_0  = gen_lane_skew(raw_data_0, 0, 3)
        in_data_1  = gen_lane_skew(raw_data_1, 5, 7)
        


def gen_lane_data(lane_id):
        #config
        N_LANES       = 20
        AM_PERIOD     = 100 #NO INCLUSIVO (los AM van a estar en la posicion AM_PERIOD, AM_PERIOD*2,....) osea en 101 bloques hay un am
        N_SIM_PERIOD  = 4
        SH_SHIFT      = 3 
        #data generation
        period_data = [[0]*AM_PERIOD for i in range(N_SIM_PERIOD)]
        
        '''
                genero datos de la forma:
                [0        ,           1, ..., AM_PERIOD-1    , ALIGNER_MARKER]
                [AM_PERIOD, AM_PERIOD+1, ..., AM_PERIOD*2 -1 , ALIGNER_MARKER]
                
        '''
        for i in range(N_SIM_PERIOD):
                for j in range(AM_PERIOD):
                        rand_sh = bin(random.randint(1,2))[2:].zfill(2)
                        period_data[i][j] = rand_sh + bin(i*AM_PERIOD + j)[2:].zfill(64)
        # agrego AM
        for i in range(N_SIM_PERIOD) :
                algo = bin(comvar.align_marker_list[lane_id])[2:].zfill(66)
                period_data[i].append(bin(comvar.align_marker_list[lane_id])[2:].zfill(66))

        #concateno
        data = []
        for pd in period_data:
                data += copy.copy(pd)
        '''
        data = ''.join(data)
        
        #agrego defasaje de SH
        trash = ''
        for i in range(SH_SHIFT):
                trash += bin(random.randint(0,1))[2:]
        data = trash + data
        #desarmo en bloques de 66 bits
        data = re.findall('.{66}', data)
        '''
        return data
        
        
def gen_lane_skew(data, block_skew, sh_shift):

        #config
        MAX_SKEW = 16
        #agrego skew de bloque
        for i in range(block_skew):
                trash_block = '10' + bin(random.randint(0,372947932142))[2:].zfill(64)
                data.insert(0,trash_block)

        #agrego bloques al final para asegurarme que todos los vectores de datos
        #en cada lane tengan el mismo largo
        for i in range(MAX_SKEW - block_skew):
                trash_block = '10' + bin(random.randint(0,372947932142))[2:].zfill(64)
                data.append(trash_block)

        data = ''.join(data)
        #agrego defasaje de SH(agrego SH_SHIFT bits al inicio del stream de datos)
        trash = ''
        for i in range(sh_shift):
                trash += bin(random.randint(0,1))[2:]
        data = trash + data
        #desarmo en bloques de 66 bits
        data = re.findall('.{66}', data)
        return data




if __name__ == "__main__" :
        main()
