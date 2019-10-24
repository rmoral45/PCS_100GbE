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
NCLOCK      = 100
#AM_PERIOD   = 16384 #chequear si no es 16383
AM_PERIOD   = 30
NB_DATA     = 66


def main():
    


    data = range(AM_PERIOD*NLANES*NCLOCK)
    tag_vector = [1]*20
    zeros_vector = [0]*(AM_PERIOD*NLANES-len(tag_vector))
    am_insert_vector = (tag_vector+zeros_vector)*NCLOCK

    am_insert_vector_zip = zip(am_insert_vector, data)

    data_input = open("data-input.txt", "w")

    for clock in range(AM_PERIOD*NLANES*NCLOCK):

        bin_data = bin(am_insert_vector_zip[clock][1])[2:].zfill(NB_DATA)
        am_insert_bit = bin(am_insert_vector_zip[clock][0])[2:]
        am_insert_vector = am_insert_bit + bin_data

        am_insert_vector_tmp = am_insert_vector
        am_insert_vector_tmp = ''.join(map(lambda x: x+' ', am_insert_vector_tmp))
        data_input.write(am_insert_vector_tmp + '\n')

    
    data_input.close()




if __name__ == '__main__':
    main()