import random
import numpy as np
from pdb import set_trace as bp
import copy 

NLANES      = 20
MAX_SKEW    = 16  #son 21 bits en realidad, modificar despues de primer vector matching
MAX_DELAY   = 32
NCLOCK      = 1000
AM_PERIOD   = 16384 #chequear si no es 16383

def main():

    sol_matrix = [[0 for ncols in range(NLANES)] for nrows in range(NCLOCK)]
    resync_vector = [0]*NLANES
    am_lock_vector = [0]*NLANES


#COMO CARAJO SIMULO EL TIEMPO DE LLEGADA DEL SOL? 

    simulate_skew(clock, sol_matrix, resync_vector, am_lock_vector)



def simulate_skew(clock, sol_matrix, resync_vector, am_lock_vector):
    
    lock_time = 0
    lock_delay = random.randint(0, NLANES*4)
    #lockeo una linea en un tiempo random
    
    #for clock in range(NCLOCK):
    lock_time = random.randint(lock_delay+AM_PERIOD-MAX_SKEW, lock_delay+AM_PERIOD)
    lane_locked = random.randint(NLANES)

    if(not(am_lock_vector[lane_locked])):
        am_lock_vector[lane_locked] = 1     #lockeamos la linea
    
    for lane in range(NLANES)
        if(am_lock_vector[lane])
            sol_matrix[clock][lane] = 1

    

