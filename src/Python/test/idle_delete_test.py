'''
Programa para hacer el testing del modulo de insecion/eliminacion de idles

	Casos  de prueba:
		1)flujo 'normal' de datos de cgmii
			pass : cada NLANES*NBLOCKS debe haber 20 idles iniciales
					la cant de idles generada por la cgmii debe ser igual 
					a la cant que sale del modulo de idle_delete (no se insertaron de mas ni sacaron de menos)
		2)no se recibe ningun idle desde cgmii hasta al menos clock > NLANES
			pass : debe haber 20 idles inicales y ninguno al menos hasta NLANES*2 bloques
		3)se reciben todos idle mientras 0 < clock < NLANES y ninguno clock >= NLANE
			pass : la entrada al encoder debe contene SOLO 20 idles iniciales consecutivos
		4)se reciben todos idle mientras 0 < clock < NLANES + M
			pass : la entrada al encoder debe tener NLANES + M idles
		5) se reciben M ( < NLANES ) idles mientras clock < 20
			pass : la entrada al encoder debe tener solo NLANES idles
'''

import sys
sys.path.insert(0, '../file_generator')
sys.path.insert(0, '../modules')

import random
import numpy as np
from pdb import set_trace as bp
import tx_modules as tx
import test_bench_functions as tb
import idle_deletion as idl
import useful_functions

useful_functions.create_filedump_dir(__file__)
bp()
NCLOCK 		= 1000
NIDLE  		= 10
NDATA  		= 25
NLANES 		= 20
AM_PERIOD 	= 16383
EXTRA_TIME  = 32 
CLOCK_VECT  = [NLANES*AM_PERIOD*3, NLANES*2,NLANES*2, ((NLANES*2)+EXTRA_TIME), NLANES*3]

TEST_CASE = 5 # Variable ppara seleccionar el caso de prueba
NCLOCK = CLOCK_VECT[TEST_CASE-1] # selecciono cantidad de iterariones necesarioas segun el tipo de test
NCLOCK += EXTRA_TIME


def main():

	#Init
	cgmii_module 	  = tx.CgmiiFSM(NIDLE,NDATA)
	idle_del_module   = idl.IdleDeletionModule(AM_PERIOD,NLANES)
	cgmii_vector  	  = []
	idle_del_vector   = []
	test_input_vector = generate_stimulus_vector()
	bp()

	for clock in range(NCLOCK):

		if TEST_CASE == 1 :
			cgmii_output = cgmii_module.tx_raw
			cgmii_module.change_state(0)
			cgmii_output = tb.TB_CGMII_TRANSMIT[cgmii_output['block_name']] # mapeo de bloque del sim a su forma binaria
			cgmii_vector.append(cgmii_output) #debug only

			idle_del_module.add_block(cgmii_output)
			idle_del_output = idle_del_module.get_block()
			idle_del_vector.append(idle_del_output)
		else :
			cgmii_output = copy.deepcopy(test_input_vector[clock])
			idle_del_module.add_block(cgmii_output)
			idle_del_output = idle_del_module.get_block()
			idle_del_vector.append(idle_del_output)



def generate_stimulus_vector():
	if TEST_CASE == 1:
		vect = []
	elif TEST_CASE == 2:
		if NLANES <= 2 :
			raise ValueError('no es posible realizar este test para una cantidad de lineas menor a 3')
		n_idle = random.randint(1,NLANES-1)
		vect =  [tb.TB_CGMII_TRANSMIT['DATA_BLOCK'] for y in range(NLANES)]
		vect += [tb.TB_CGMII_TRANSMIT['IDLE_BLOCK'] for y in range(n_idle)]
	elif TEST_CASE == 3:
		vect =  [tb.TB_CGMII_TRANSMIT['IDLE_BLOCK'] for y in range(NLANES)]
		vect += [tb.TB_CGMII_TRANSMIT['DATA_BLOCK'] for y in range(NCLOCK - NLANES)]
	elif TEST_CASE == 4:
		vect =  [tb.TB_CGMII_TRANSMIT['IDLE_BLOCK'] for y in range(NLANES+EXTRA_TIME)]
		vect += [tb.TB_CGMII_TRANSMIT['DATA_BLOCK'] for y in range(NLANES)]
	elif TEST_CASE == 5:
		if NLANES <= 2 :
			raise ValueError('no es posible realizar este test para una cantidad de lineas menor a 3')
		n_idle = random.randint(1,NLANES-1)
		vect =  [tb.TB_CGMII_TRANSMIT['IDLE_BLOCK'] for y in range(n_idle)]
		vect += [tb.TB_CGMII_TRANSMIT['DATA_BLOCK'] for y in range(NCLOCK - n_idle)]
	return  vect



if __name__ == '__main__' : 
	main()