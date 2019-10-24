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
NCLOCK      = 1000
#AM_PERIOD   = 16384 #chequear si no es 16383
AM_PERIOD   = 30
NB_DATA     = 66


def main():
    


    data = range(AM_PERIOD*NLANES*NCLOCK)
    tag_vector = [1]*20
    zeros_vector = [0]*(AM_PERIOD*NLANES-len(tag_vector))
    am_insert_vector = (tag_vector+zeros_vector)*NCLOCK

    am_insert_vector_temp = zip(am_insert_vector, data)

    data_input = ("data-input.txt")

    bp()

    #for clock in range(AM_PERIOD*NLANES*NCLOCK):




if __name__ == '__main__':
    main()