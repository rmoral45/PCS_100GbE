import random
import numpy as np
from pdb import set_trace as bp
import copy
N_LANES = 20
MAX_DELAY = 10
NCLOCK = 1000
AM_PERIOD = 16384
'''
	Basicamente este test consiste en generar las senales de estimulo del bloque deskew, las
	cuales serial start-of-lane , resync, am_lock.
'''

def main():
#Init
	'''
	matriz de NCLOCK columnas por N_LANES filas
	cada columna se corresponde con el estado de la seniales en un instante de tiempo
	'''
	sol 	= [[0 for i in range(NCLOCK)] for j in range(N_LANES)]
	resync  = [[0 for i in range(NCLOCK)] for j in range(N_LANES)] 
	am_lock = 0
	bp()









if __name__ == '__main__':
    main()