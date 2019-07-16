import sys
sys.path.append('../../modules')
import deskew_calculator_v2 as deskew
import common_functions as cf
import common_variables as cv
import random as rand
import numpy as np
from pdb import set_trace as bp
import copy 

NLANES      = 20
MAX_SKEW    = 14  #son 928 bits segun estandar, es decir, 14 bloques
MAX_DELAY   = 32
NCLOCK      = 1000
#AM_PERIOD   = 16384 #chequear si no es 16383
AM_PERIOD   = 30


'''
Script destinado a generar las seniales de control para el bloque deskew.
Se tienen 2 matrices, una de start of lanes y otra de resync.
Cada columna de la matriz representa un instante de tiempo. 
Cada vez que llega el primer start of lane de alguna linea, simulamos tambien un resync.
Existe otro vector de am_lock. Tiene tamanio NLANES e indica cuales lineas estan lockeadas.
Cuando este vector tenga todos sus elementos en 1, se declarara el am_lock de todas las lineas.
'''

def main():

    sol_input = open("start-of-lane-input.txt", "w")
    resync_input = open("resync-input.txt", "w")

    sol_matrix = [[0 for ncols in range(NLANES)] for nrows in range(AM_PERIOD)]
    resync_matrix = [[0 for ncols in range(NLANES)] for nrows in range(AM_PERIOD)]

    (sol_matrix, resync_matrix, delay_vector) = simulate_skew(sol_matrix, resync_matrix)

    #### CORREGIDO se resta cada elemento de delay_vector con min(delay_vector) para que quede expresado
    #### 		   correctamente el delay relativo entre las lineas y poder verificar el buen funcionamiento
    delay_vector = list(map(lambda x : x - min(delay_vector), delay_vector))
    deskewCalculator = deskew.deskewCalculator(NLANES)
    
    for clock in range(AM_PERIOD*4):

        #file writing
        sol_tmp = cf.list_to_str(sol_matrix[clock])
        sol_tmp = cf.reverse_string(sol_tmp)
        resync_tmp = cf.list_to_str(resync_matrix[clock])
        sol_tmp = ''.join(map(lambda x: x+' ',  sol_tmp))
        resync_tmp = ''.join(map(lambda x: x+' ', resync_tmp))
        sol_input.write(sol_tmp + '\n')
        resync_input.write(resync_tmp + '\n')


        deskewCalculator.fsm.change_state(sol_matrix[clock], resync_matrix[clock], deskewCalculator.common_counter, MAX_SKEW)

        deskewCalculator.common_counter.update_count(deskewCalculator.fsm.start_counters, deskewCalculator.fsm.stop_common_counter, any(resync_matrix[clock]))

        for ncounters in range(NLANES):
            deskewCalculator.counters[ncounters].update_count(deskewCalculator.fsm.start_counters, deskewCalculator.fsm.stop_lane_counter[ncounters], any(resync_matrix[clock]))


    for index, count in enumerate(deskewCalculator.counters):
        print (index, count._count, delay_vector[index])


    #print 'stop de lanes ', deskewCalculator.fsm.stop_lane_counter
    print ('common', deskewCalculator.common_counter._count, 'max_delay ', max(delay_vector))

    print ('\n\n####################\n\n' ,'Invalid Skew status : ', deskewCalculator.fsm.invalid_skew, '\n\n####################' )
    
    #bp()


def simulate_skew(sol_matrix, resync_matrix):

    delay_vector = [rand.randint(0,MAX_SKEW-1) for x in range(NLANES)]

    for index, value in enumerate(delay_vector):
        sol_matrix[value][index] = 1

    #Matriz de start of lanes con el periodo inter bloque incluido
    sol_matrix = sol_matrix + [[0 for ncols in range(NLANES)] for nrows in range(AM_PERIOD)]

    #Matriz de resync seguida por ceros, queda del mismo tamanio que la sol_matrix
    resync_matrix = copy.copy(sol_matrix) + 2 * [[0 for ncols in range(NLANES)] for nrows in range(AM_PERIOD)]

    sol_matrix = sol_matrix + sol_matrix
    print (delay_vector)

    return sol_matrix, resync_matrix, delay_vector

    
    
if __name__ == '__main__':
    main()