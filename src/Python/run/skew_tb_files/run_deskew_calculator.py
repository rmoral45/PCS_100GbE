import sys
sys.path.append('../../modules')
import deskew_calculator_v2 as deskew
import programmable_fifo as pFifo
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
NB_DATA     = 66
TRASH_DATA  = 9999


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
    fifo_input = open("fifos-input.txt", "w")
    fifo_wr_enb = open("fifo-wr-enb.txt", "w")
    fifo_rd_enb = open("fifo-rd-enb.txt", "w")
    fifo_output = open("fifos-output.txt", "w")     
    #Deskew Calculator
    sol_matrix = [[0 for ncols in range(NLANES)] for nrows in range(AM_PERIOD)] 
    resync_matrix = [[0 for ncols in range(NLANES)] for nrows in range(AM_PERIOD)]
    (sol_matrix, resync_matrix, delay_vector) = simulate_skew(sol_matrix, resync_matrix)
    #### CORREGIDO se resta cada elemento de delay_vector con min(delay_vector) para que quede expresado
    #### 		   correctamente el delay relativo entre las lineas y poder verificar el buen funcionamiento
    delay_vector = list(map(lambda x : x - min(delay_vector), delay_vector))
    deskewCalculator = deskew.deskewCalculator(NLANES)

    #Programmable fifos
    prog_fifo_wr_enable = 0
    prog_fifo_rd_enable = 0
    prog_fifo = pFifo.programmableFifo(NLANES, prog_fifo_wr_enable, prog_fifo_rd_enable, delay_vector)
    data_matrix = [[] for nrows in range(AM_PERIOD)]
    #### Matriz para guardar los datos leidos. Cada fila se corresponde a una linea
    #### El tamanio de cada fila es el mismo que el de la prog_fifo correspondiente a dicha linea             
    data_readed = []                                   
    data_matrix = gen_data(NLANES)

    for k in range(len(delay_vector)):
        for j in range(delay_vector[k]):
            data_matrix[k].insert(0,TRASH_DATA)
            data_matrix[k].pop()

    #file writing
    for counter in range(AM_PERIOD*10):
        sol_tmp = cf.list_to_str(sol_matrix[counter])
        sol_tmp = cf.reverse_string(sol_tmp)
        resync_tmp = cf.list_to_str(resync_matrix[counter])
        sol_tmp = ''.join(map(lambda x: x+' ',  sol_tmp))
        resync_tmp = ''.join(map(lambda x: x+' ', resync_tmp))
        sol_input.write(sol_tmp + '\n')
        resync_input.write(resync_tmp + '\n')
        wr_data = ''


        for nlanes in range(NLANES):
            data_tmp = bin(data_matrix[nlanes][counter])[2:].zfill(NB_DATA)
            #bp()
            data_tmp = ''.join(map(lambda x: x+' ', data_tmp))
            wr_data += data_tmp
            
        fifo_input.write(wr_data + '\n')


    aux_rval = 0

    for clock in range(AM_PERIOD*10):

        deskewCalculator.fsm.change_state(sol_matrix[clock], resync_matrix[clock], deskewCalculator.common_counter, MAX_SKEW)

        deskewCalculator.common_counter.update_count(deskewCalculator.fsm.start_counters, deskewCalculator.fsm.stop_common_counter, any(resync_matrix[clock]))
        for i in range(NLANES):
            deskewCalculator.counters[i].update_count(deskewCalculator.fsm.start_counters, deskewCalculator.fsm.stop_lane_counter[i], any(resync_matrix[clock]))

        if(deskewCalculator.fsm.wr_enb_prog_fifo):
            for ncounters in range(NLANES):
               # deskewCalculator.counters[ncounters].update_count(deskewCalculator.fsm.start_counters, deskewCalculator.fsm.stop_lane_counter[ncounters], any(resync_matrix[clock]))
                prog_fifo.fifos[ncounters].wr_enable = deskewCalculator.fsm.wr_enb_prog_fifo
                prog_fifo.fifos[ncounters].write_fifo(data_matrix[ncounters][aux_rval])  
                 #escritura de fifos

            aux_rval += 1


        if(deskewCalculator.fsm.set_fifo_delay):
            for nfifos in range(NLANES):
                prog_fifo.fifos[nfifos].set_fifo_delay(deskewCalculator.counters[nfifos]._count)                   #seteamos delay

        if(deskewCalculator.fsm.rd_enb_prog_fifo):

            for nfifos in range(NLANES):
                prog_fifo.fifos[nfifos].rd_enable = deskewCalculator.fsm.rd_enb_prog_fifo                          #habilitamos la lectura de las memorias
                data_readed.append(prog_fifo.fifos[nfifos].read_fifo())
      


    bp()

    '''
    for nfifos2 in range(300):
        for fifo in(prog_fifo.fifos):
                data_readed.append(fifo.read_fifo())
    '''
    if(data_readed.count(-99)):
        print '\n\n\nERROR: hay un -99 en los datos leidos\n\n\n'

    for ctr2 in range(len(data_readed)):
        if(ctr2 != data_readed[ctr2]):
            print '\n\n\nERROR: hay datos fuera de orden\n\n\n'

    #bp()
                      
               
    #escritura de salida en archivo
    '''
    for nfifos in range(NLANES):
        fifo_out_tmp = cf.list_to_str(data_readed[nfifos])  
        fifo_out_tmp = cf.reverse_string(fifo_out_tmp)
        fifo_out_tmp = ''.join(map(lambda x: x+' ', fifo_out_tmp))
        fifo_output.write(fifo_out_tmp+ '\n')
    '''
    for index, count in enumerate(deskewCalculator.counters):
        print (index, count._count, delay_vector[index])

    #print 'stop de lanes ', deskewCalculator.fsm.stop_lane_counter
    print ('common', deskewCalculator.common_counter._count, 'max_delay ', max(delay_vector))

    print ('\n\n####################\n\n' ,'Invalid Skew status : ', deskewCalculator.fsm.invalid_skew, '\n\n####################' )

    print ('\n\n################################# PROG FIFO DATA ######################## \n\n')

    for index in range(NLANES):
        print('Indice: {} ---- Data_readed: {} \n'.format(index, data_readed[index]))
    
    bp()


def simulate_skew(sol_matrix, resync_matrix):

    delay_vector = [rand.randint(0,MAX_SKEW-1) for x in range(NLANES)]

    for index, value in enumerate(delay_vector):
        sol_matrix[value][index] = 1

    #Matriz de start of lanes con el periodo inter bloque incluido
    sol_matrix = sol_matrix + [[0 for ncols in range(NLANES)] for nrows in range(AM_PERIOD)]

    #Matriz de resync seguida por ceros, queda del mismo tamanio que la sol_matrix 20x300
    resync_matrix = copy.copy(sol_matrix) + 8 * [[0 for ncols in range(NLANES)] for nrows in range(AM_PERIOD)]
    #bp()

    #Matriz de 20x300
    sol_matrix = 4*sol_matrix + sol_matrix
    print (delay_vector)

    return sol_matrix, resync_matrix, delay_vector


def gen_data(nlanes):
    
    #Matriz de datos de 20x300    
    aux_m  = [[] for col in range(nlanes)]

    for i in range(nlanes):
        aux_m[i] = range(i, AM_PERIOD*10*nlanes, nlanes)

    return aux_m
    
    
if __name__ == '__main__':
    main()
