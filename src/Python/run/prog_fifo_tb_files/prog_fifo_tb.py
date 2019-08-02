import sys
sys.path.append('../../modules')
import programmable_fifo as programmableFifo
import common_functions as cf
import common_variables as cv
from pdb import set_trace as bp
import copy


NCLOCK  = 1000
NLANES  = 20
ENABLE  = 1


def main():

    prog_fifo = programmableFifo.programmableFifo(NLANES, ENABLE)

    data_matrix = gen_data(NLANES)

#    for clock in range(NCLOCK):



def gen_data(NLANES):

    index_vector = range(NLANES)
    
    #Matriz de datos de 20x40
    data_matrix = [[0 for row in range(NLANES)] for col in range(NLANES+1)]    

    for row in range(NLANES):
        data_matrix[row][row] = row
    
    #bp()

    return data_matrix

    
if __name__ == '__main__':
    main()