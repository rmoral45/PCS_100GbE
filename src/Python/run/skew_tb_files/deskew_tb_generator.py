import random
import numpy as np
from pdb import set_trace as bp
import copy
NLANES    = 20
MAX_SKEW  = 16 #revisar standard
MAX_DELAY = 32
NCLOCK    = 1000
AM_PERIOD = 16384
'''
	Basicamente este test consiste en generar las senales de estimulo del bloque deskew, las
	cuales serial start-of-lane , resync, am_lock.
'''
'''
	REVISAR : En la FSM de am_lock el sol se envia solo en estado de regimen,
	no en la transcision wait2nd -> locked, aca si quizas el pulso resync
'''

def main():
#Init
	'''
	matriz de NLANES columnas por NCLOCK filas
	cada fila se corresponde a un instante de tiempo,mientras que cada columna
	con las seniales enviadas al bloque deskew por cada uno de los bloques detectores de ALIGNERS
	'''
	sol        = [[0 for i in range(NLANES)] for j in range(NCLOCK)]
	resync     = [0]*NCLOCK	 
	am_lock    = [0]*NCLOCK
	#Crear tmp dir y abrir archivos

	#Sim starts
	set_init_time_delay(am_lock,sol,resync)
	for clock in range(NCLOCK):
		am_lock = (sum(lane_lock[clock]) == NLANES) #todas las lanes declararon lock



def set_init_time_delay(lock_vect, sol_matrix, resync_vect,test_type = 'valid skew'):
	#tiempo aleatorio hasta que todas las lineas declaran lock	
	lock_delay = random.randint(0,NLANES*2)
	#desde init_delay en adelante am_lock = 1
	lock_vect[lock_delay : ] = [1]*len(lock_vect[lock_delay : ])
	#El pulso de resync se pone en alto enn el mismo instante de tiempo que am_lock
	resync_vect[lock_delay]  = 1

	if test_type == 'valid skew' :
		'''
			Condicion A :
			Se declara el lock cuando la linea con mas skew recibe el segundo alineador consecutivo,
			por lo que esta linea enviara un pulso sol en el tiempo lock_delay+AM_PERIOD, pero la
			linea con menos skew lo hara en un tiempo posterior a lock_delay+AM_PERIOD-MAX_SKEW 
			pero menor a lock_delay+AM_PERIOD,suponiendo que el skew sea aceptable,osea
			el sol de la linea de menor skew va a llegar antes que el de la linea de mayor skew
			pero esa diferencia temporal NO puede ser mayor al maximo skew permitido.
		'''
		'''
			Condicion B :
			Como pueden llegar todas las lanes al mimso tiempo, o algunas si y otras no,
			o todas diferentes, el vector sol_delay que determina el instante de tiempo
			en que cada lane recibio el alineador debe poder servir para generar de manera
			aleatoria todas las posibilidades,como el test se realizo tomando NLANES cantidad
			de muestras aleatorias para determinar el skew de cada linea,la poblacion debe contener
			al menos NLANES individuos de cada valor de skew posible
		'''

		#revisar : ambos indices son inclusivos en randint
		skew_possibilities = range(lock_delay+AM_PERIOD-MAX_SKEW, lock_delay+AM_PERIOD)*NLANES
		sol_delay = random.sample(skew_possibilities,NLANES)
		bp()
		for lane_iter in range(NLANES) :
			time = sol_delay[lane_iter]
			sol_matrix[time][lane_iter] = 1
	
		

	else:
		RaiseError('test type undefined, BOLUDO')










if __name__ == '__main__':
    main()