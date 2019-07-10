import random
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

    sol_matrix = [[0 for ncols in range(NLANES)] for nrows in range(NCLOCK)]
    resync_vector = [[0 for ncols in range(NLANES)] for nrows in range(NCLOCK)]
    am_lock_vector = [0]*NCLOCK
    am_lock_lanes = [0]*NLANES

    simulate_skew(sol_matrix, resync_vector, am_lock_lanes)

    for clock in range(NCLOCK):
        if(sum(am_lock_lanes) == NLANES):
            am_lock_vector[clock] = 1

def simulate_skew(sol_matrix, resync_vector, am_lock_lanes):

    delay_vector = [0,0,5,3,4,5,6,7,8,9,10,5,12,13,14,15,16,17,18,19]

    for index, value in enumerate(delay_vector):
        sol_matrix[index][value] = 1
        resync_vector[index][value] = 1
        sol_matrix[value+AM_PERIOD*index][index] = 1
        am_lock_lanes[index] = 1
        bp()

    
if __name__ == '__main__':
    main()