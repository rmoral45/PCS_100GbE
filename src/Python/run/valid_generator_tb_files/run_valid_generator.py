import sys
sys.path.append('../../modules')
import common_functions as cf
import common_variables as cv
import random as rand
import numpy as np
from pdb import set_trace as bp
import copy

'''
Funciones:
    - generate_blocks: genera filas de 20 bloques en donde el bloque 0 es un 0 en 66bits,
                       el 1 es un 1 en 66 bits y asi sucesivamente. La segunda fila tendra
                       los bloques del 20 al 39. Sirve de entrada para el PC_20_to_1.
    
    - generate_numbers: genera filas de 1 bloque de 66 bits. La priemra fila corresponde al numero 0
                        la segunda al numero 1 y asi sucesivamente. Sirve de entrada para el PC_1_to_20.
'''

NCLOCK      = 1000
NB_DATA     = 66
NLANES      = 20

def main():

    data_input_20_to_1 = open("valid-gen-data-input-20-to-1.txt", "w")
    data_input_1_to_20 = open("valid-gen-data-input-1-to-20.txt", "w")


    blocks = generate_blocks()
    numbers = generate_numbers()
    #bp()

    #file writing for PC_20_to_1
    for clock1 in range(NCLOCK):        
        wr_data_20_to_1 = ''
        for index in range(NLANES):
            blocks_tmp = bin(blocks[clock1][index])[2:].zfill(NB_DATA)
            blocks_tmp = ''.join(map(lambda x: x+' ', blocks_tmp))
            wr_data_20_to_1 += blocks_tmp

        data_input_20_to_1.write(wr_data_20_to_1+'\n')


    #file writing for PC_1_to_20
    for clock2 in range(NCLOCK*NLANES):
        numbers_tmp = bin(numbers[clock2])[2:].zfill(NB_DATA)
        numbers_tmp = ''.join(map(lambda x: x+' ', numbers_tmp))
        data_input_1_to_20.write(numbers_tmp + '\n')


    data_input_20_to_1.close()
    data_input_1_to_20.close()

def generate_numbers():
    numbers = [[0]*NB_DATA for x in range(NCLOCK*NLANES)]

    for counter in range(NCLOCK*NLANES):
        numbers[counter] = counter
    return numbers

def generate_blocks():
    blocks = [[0]*NB_DATA for x in range(NCLOCK)]

    data = range(NLANES*NCLOCK)

    for counter in range(NCLOCK):
        blocks[counter] = data[0:NLANES]
        del(data[0:NLANES])
    return blocks


if __name__ == '__main__':
    main()