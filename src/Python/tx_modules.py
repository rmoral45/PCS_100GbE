
import random
import numpy as np
from pdb import set_trace as bp



################# VARIABLES ####################
NIDLE = 5
NDATA = 16
NLANES = 20

################################################

def parallel_conversion(tx_fifo,lanes):
	"""Funcionalidad de conversor de paralelismo 1:N

	
	Args:
		tx_fifo: lista de entrada al conversor. <type 'list'>
		lanes: una matriz donde cada fila se corresponde a una lane de transmision

	Returns:
		pc_ready: booleano que indica si tx_fifo tenia suficientes elementos
		para realizar la conversion de paralelismo.

		tx_fifo: luego de haber extraido elementos para insertar en la matriz de lanes, o
		una copia del parametro tx_fifo en caso de no tener suficientes elementos para
		realizar la conversion de paralelismo.

		lanes: luego de haber insertado los elementos extraidos de tx_fifo,inserta
		un elemento en cada fila de la matriz , o una copia del parametro lanes 
		en caso de no tener suficientes elementos para realizar la conversion de paralelismo.
	 
	"""
	if ( len(tx_fifo) < len(lanes) ) and  ( (len(tx_fifo) % len(lanes) ) != 0 ) :
		pc_ready = False
		return tx_fifo, lanes, pc_ready
	else :
		pc_ready = True
		for i in range(0,len(lanes)) :
			block = tx_fifo.pop(0)
			lanes[i].append(block)
		return tx_fifo , lanes, pc_ready			
				 

def swap_lanes(nlanes):
	"""Intercambia elementos de una lista.

	Genera una lista de enteros de 0 a 19 ordenados e intercambia
	elementos de forma aleatoria, la lista resultante al igual que 
	la primera no contiene elementos repetidos.

	
	Args:
		nlanes: cantidad de elementos para intercambiar, debe ser multiplo de 2 y menor a 20

	Returns:
		retorna una lista de enteros.
		ejemplo: nlanes = 2 -> [15, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 0, 16, 17, 18, 19]
	 
	"""
	if (nlanes % 2) or nlanes > 20 :
		raise ValueError('numero de lanes a intercambiar invalido \n\n')
	
	else :
		NLANES = 20
		swap_index = random.sample(xrange(0, 20), nlanes)
		order_index = range(0,NLANES)
		for i in range(0, (nlanes/2) ):
			lane1 = swap_index.pop(0)
			lane2 = swap_index.pop(0)
			order_index[lane1] = lane2
			order_index[lane2] = lane1

		return	order_index




def list_to_hex(hex_list):
	"""Genera un numero a partir de una lista.
	
	Args:
		hex_list: lista de enteros de 8 bits
	Comentarios:
		Concatena los elementos de una lista de octetos para formar un unico numero equivalente,
		el numero resutante tiene al octeto de la posicion 0 de la lista
		como sus bits mas significativos
	"""
	result = 0x000000000
	counter = ( len(hex_list)-1 )
	for value in hex_list:
		result |= (value << (counter*8))
		counter-=1
	#return hex(result).rstrip('L')
	return result

def block_to_hex(block):
	"""Genera un numero a partir de los valores en un diccionario.

	Concatena los elementos de un bloque para formar un unico numero equivalente,
	con la forma {sh, block_type, payload}.
	"""
	hex_list = []
	hex_list.append(block['sh'])
	hex_list.append(block['block_type'])
	for payload in block['payload'] :
		hex_list.append(payload)
	hexnum = list_to_hex(hex_list)
	return hexnum	


################# ESTADOS ######################

TX_INIT = 0
TX_C = 1
TX_D = 2
TX_T = 3
TX_E = 4

state_name = ['TX_INIT', 'TX_C', 'TX_D','TX_T', 'TX_E']

#######################################################


############## CGMII CHARACTERS########################
 
D0 = 0x70 # 'p'
D1 = 0x68 # 'h'
D2 = 0x79 # 'y'
D3 = 0x73 # 's'
D4 = 0x69 # 'i'
D5 = 0x63 # 'c'
D6 = 0x61 # 'a'
D7 = 0x6c # 'l'

S = 0xFB
T = 0xFD
I = 0x07
Q = 0x9C
Fsig = 0x5C
Z = 0x00
E = 0xFE
############## 100GBE CHARACTERS ######################

I_100G = 0x00
E_100G = 0x1E

##############################################

############ RAW_BLOCKS ################################

DATA_BLOCK = [0x00, D0, D1, D2, D3, D4, D5, D6, D7] 

START_BLOCK = [0x80, S, D1, D2, D3, D4, D5, D6, D7]

Q_ORD_BLOCK = [0x80, Q, D1, D2, D3, Z, Z, Z, Z]
 
Fsig_ORD_BLOCK = [0x80, Fsig, D1, D2, D3, Z, Z, Z, Z]
 
IDLE_BLOCK = [0xFF, I, I, I, I, I, I, I, I]
 
T0_BLOCK = [0xFF, T, I, I, I, I, I, I, I]

T1_BLOCK = [0xFF, D0, T, I, I, I, I, I, I]

T2_BLOCK = [0xFF, D0, D1, T, I, I, I, I, I]

T3_BLOCK = [0xFF, D0, D1, D2, T, I, I, I, I]

T4_BLOCK = [0xFF, D0, D1, D2, D3,T, I, I, I]

T5_BLOCK = [0xFF, D0, D1, D2, D3, D4, T, I, I]

T6_BLOCK = [0xFF, D0, D1, D2, D3, D4, D5, T, I]

T7_BLOCK = [0xFF, D0, D1, D2, D3, D4, D5, D6, T]

###############################################################


##################### CODED BLOCKS ############################

# cuidado!! esta codificacion es lo mas parecida posible a la que debemos implementar pero
# no es exactamente igual

CODED_DATA_BLOCK = [0x01, D0, D1, D2, D3, D4, D5, D6, D7] 

CODED_START_BLOCK = [0x02,0x78, D1, D2, D3, D4, D5, D6, D7]

CODED_Q_ORD_BLOCK = [0x02,0x4B, D1, D2, D3, Z, Z, Z, Z]
 
CODED_Fsig_ORD_BLOCK = [0x02,0x4B, D1, D2, D3, 0XF0, Z, Z, Z]
 
CODED_IDLE_BLOCK = [I, I, I, I, I, I, I] ##cuidado

CODED_ERROR_BLOCK = [0x02,0x1E, E, E, E, E, E, E, E]
 
CODED_T0_BLOCK   = [0x02,0x87, I, I, I, I, I, I, I]

CODED_T1_BLOCK   = [0x02,0x99, D0, I, I, I, I, I, I]

CODED_T2_BLOCK   = [0x02,0xAA, D0, D1, I, I, I, I, I]

CODED_T3_BLOCK   = [0x02,0xB4, D0, D1, D2, I, I, I, I]

CODED_T4_BLOCK   = [0x02,0xCC, D0, D1, D2, D3, I, I, I]

CODED_T5_BLOCK   = [0x02,0xD2, D0, D1, D2, D3, D4, I, I]

CODED_T6_BLOCK   = [0x02,0xE1, D0, D1, D2, D3, D4, D5, I]

CODED_T7_BLOCK   = [0x02,0xFF, D0, D1, D2, D3, D4, D5, D6]

###############################################################
#desordenar import random
# random.sample(xrange(0, 20), 20)

##################### ENCODER TABLE ##########################

encoder = {

			'DATA_BLOCK' : {'block_name'   : 'CODED_DATA_BLOCK',
							'sh' 		   : 0x1  ,
							'block_type'   : D0   ,
							'payload' 	   : [D1, D2, D3, D4, D5, D6, D7] 
							} ,
			
			'START_BLOCK' : {'block_name'  : 'CODED_START_BLOCK',
							 'sh' 		   : 0x2  ,
							 'block_type'  : 0x78 ,
							 'payload' 	   : [D1, D2, D3, D4, D5, D6, D7]
							} ,

			'Q_ORD_BLOCK' : {'block_name'  : 'CODED_Q_ORD_BLOCK',
							 'sh' 		   : 0x2  ,
							 'block_type'  : 0x4B ,
							 'payload' 	   : [D1, D2, D3, Z, Z, Z, Z]
							} ,

		 'Fsig_ORD_BLOCK' : {'block_name'  : 'CODED_Fsig_ORD_BLOCK',
	   						 'sh' 		   : 0x2  ,
							 'block_type'  : 0x4B ,
							 'payload' 	   : [D1, D2, D3, 0XF0, Z, Z, Z]
							} ,

			'IDLE_BLOCK' : {'block_name'   : 'CODED_IDLE_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x1E ,
							'payload' 	   : [I_100G,I_100G,I_100G,I_100G,I_100G,I_100G,I_100G]
							} ,

			'ERROR_BLOCK' : {'block_name'  : 'CODED_ERROR_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x1E ,
							'payload' 	   : [E_100G,E_100G,E_100G,E_100G,E_100G,E_100G,E_100G]
							} ,

			'T0_BLOCK' 	  : {'block_name'  : 'CODED_T0_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x87 ,
							'payload' 	   : [I_100G,I_100G,I_100G,I_100G,I_100G,I_100G,I_100G]
							} ,

			'T1_BLOCK' 	  : {'block_name'  : 'CODED_T1_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x87 ,
							'payload' 	   : [D0,I_100G,I_100G,I_100G,I_100G,I_100G,I_100G]
							} ,

			'T2_BLOCK' 	  : {'block_name'  : 'CODED_T2_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xAA ,
							'payload' 	   : [D0,D1,I_100G,I_100G,I_100G,I_100G,I_100G]
							} ,

			'T3_BLOCK' 	  : {'block_name'  : 'CODED_T3_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xB4 ,
							'payload' 	   : [D0,D1,D2,I_100G,I_100G,I_100G,I_100G]
							} ,

			'T4_BLOCK' 	  : {'block_name'  : 'CODED_T4_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xCC ,
							'payload' 	   : [D0,D1,D2,D3,I_100G,I_100G,I_100G]
							} ,

			'T5_BLOCK' 	  : {'block_name'  : 'CODED_T5_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xD2 ,
							'payload' 	   : [D0, D1, D2, D3, D4, I_100G, I_100G]
							} ,

			'T6_BLOCK' 	  : {'block_name'  : 'CODED_T6_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xE1 ,
							'payload' 	   : [D0, D1, D2, D3, D4, D5, I_100G]
							} ,
							
			'T7_BLOCK' 	  : {'block_name'  : 'CODED_T7_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xFF ,
							'payload' 	   : [D0, D1, D2, D3, D4, D5, D6]
							} 
		 }

################################################################

####################### ALIGNER MARKERS ########################

"""Los alineadores no estan definidos como listas o diccionarios
   debido a que se insertan luego de la fase de codificacion y scrambling
   en la cual los bloques se representan como un unico numero entero.   
"""

align_marker_list = [ 0x2C16821003E97DEff ,
					  0x29D718E00628E71ff ,
					  0x2594BE800A6B417ff ,
					  0x24D957B00B26A84ff ,
					  0x2F50709000AF8F6ff ,
					  0x2DD14C20022EB3Dff ,
					  0x29A4A260065B5D9ff ,
					  0x27B45660084BA99ff ,
					  0x2A02476005FDB89ff ,
					  0x268C9FB00973604ff ,
					  0x2FD6C9900029366ff ,
					  0x2B9915500466EAAff ,
					  0x25CB9B200A3464Dff ,
					  0x21AF8BD00E50742ff ,
					  0x283C7CA007C3835ff ,
					  0x23536CD00CAC932ff ,
					  0x2C4314C003BCEB3ff ,
					  0x2ADD6B700522948ff ,
					  0x25F662A00A099D5ff ,
					  0x2C0F0E5003F0F1Aff
					]

################################################################



def reverse_byte(num):
	"""Invierte el orden de los bits de un numero
	
	Ejemplo:
		param: num = 225 = 0xE1 = 0b11100001 ; return: 135 = 0x87 = 0b10000111
	Comentario:
		esta funcion en necesaria por la manera en que el estandar define la  transmision de datos		
	"""
	binary = bin(num) 
	reverse = binary[-1:1:-1] 
	return int(reverse,2)	

def align_marker_insertion(lanes,block_counter):
	"""Inserta los marcadores correspondientes a cada lane solo si
   	   ya fueron enviados 16383 bloques por cada lane (AM_BLOCK_GAP - 1).	
	"""
	AM_BLOCK_GAP = 16384
	if ( (block_counter % AM_BLOCK_GAP) == 0 ):
		for i in range(0, len(lanes)):
			AM = align_marker_list[i]
			lanes[i].insert(0,AM)
		return lanes
	else :
		return lanes		



#############################################################################################################
#############################################################################################################

class Scrambler(object) :
	def __init__(self):
		self.BLOCK_CODED_LEN = 64
		self.SCRAMBLER_LEN = 58
		self.polynom_1 = 38
		self.polynom_2 = 57
		self.shift_reg = map(int,np.zeros(58))
		self.output = 0x000000000000000000
		self.xor = 0	
	def tx_scrambling(self,in_block):
		#bypass de los dos bit de sh
		self.output |= ( in_block & (1 << 65) )
		self.output |= ( in_block & (1 << 64) )
		#realizo scrambling
		'''
			OJO !!!! DEBERIA INVERTIR EL ORDEN DE LOS OCTETOS creo
		''' 
		for i in reversed(range(0,self.BLOCK_CODED_LEN)):
			self.xor = ( (in_block & (1<<i) ) >>i ) ^ self.shift_reg[self.polynom_1] ^ self.shift_reg[self.polynom_2]
			self.shift_reg = np.roll(self.shift_reg,1)
			self.output |= self.xor << i
			self.shift_reg[0] = self.xor
			
		return self.output
	def rx_scrambling(self,in_block):
		#bypass de los dos bit de sh
		self.output |= ( in_block & (1 << 65) )
		self.output |= ( in_block & (1 << 64) )
		#realizo scrambling
		'''
			OJO !!!! DEBERIA INVERTIR EL ORDEN DE LOS OCTETOS 
		''' 
		for i in reversed(range(0,self.BLOCK_CODED_LEN)):
			self.xor = ( (in_block & (1<<i) ) >>i ) ^ self.shift_reg[self.polynom_1] ^ self.shift_reg[self.polynom_2]
			self.shift_reg = np.roll(self.shift_reg,1)
			self.output |= self.xor << i
			self.shift_reg[0] = ( (in_block & (1<<i) ) >>i )
			
		return self.output

#############################################################################################################
#############################################################################################################


class CgmiiFSM(object) :
	def __init__(self):
		self.state = TX_INIT
		self.tx_raw = Q_ORD_BLOCK
		self.data_counter = 0
		self.idle_counter = 0
		self.state_sequence =[]
		
	def print_state_seq(self):
		for i in self.state_sequence:
			print '\n\n',i

	def change_state(self,force_error = False):
		# en self.variables voy a almacenar en el siguiente orden: [estado actual,prox estado,bloque enviado]
		self.variables = []

		if force_error :
			print 'ERROR FORZADO \n'
			'''
			dado el estado actual generar un bloque invalido
			'''
		else :
			if self.state == TX_INIT :
				self.variables.append( state_name[self.state] ) # LOGEO
				
				#######funcionalidad#####
				self.tx_raw = IDLE_BLOCK
				self.idle_counter+=1
				self.state = TX_C
				#########################

				self.variables.append( state_name[self.state]) # LOGEO
				self.variables.append( self.tx_raw )		   # LOGEO
				self.state_sequence.append(self.variables)     # LOGEO

			elif self.state == TX_C:
				self.variables.append( state_name[self.state] ) # LOGEO

				########funcionalidad#########
				
				if self.idle_counter < NIDLE:
					self.tx_raw = IDLE_BLOCK
					self.idle_counter+=1
					self.state = TX_C
				else :
					self.tx_raw = START_BLOCK
					self.state = TX_D
					self.data_counter+=1
				#############################
				
				self.variables.append( state_name[self.state] ) # LOGEO
				self.variables.append( self.tx_raw	)		   # LOGEO
				self.state_sequence.append(self.variables) # LOGEO
				
	
			elif self.state == TX_D:
				self.variables.append( state_name[self.state] ) # LOGEO

				######funcionalidad###########
				if self.data_counter < NDATA:
					self.tx_raw = DATA_BLOCK
					self.state = TX_D
					self.data_counter+=1
				else:
					self.tx_raw = T0_BLOCK
					self.state = TX_T
				#############################

				self.variables.append( state_name[self.state] )# LOGEO
				self.variables.append( self.tx_raw  )		   # LOGEO
				self.state_sequence.append(self.variables) # LOGEO
				

			elif self.state == TX_T:
				self.variables.append( state_name[self.state] ) # LOGEO

				#####funcionalidad############
				self.tx_raw = IDLE_BLOCK
				self.state = TX_C
				self.idle_counter = 0
				self.data_counter = 0
				##############################

				self.variables.append( state_name[self.state] )# LOGEO
				self.variables.append( self.tx_raw	)		   # LOGEO
				self.state_sequence.append(self.variables) # LOGEO

				
			elif self.state == TX_E:
				self.variables.append( state_name[self.state] )# LOGEO

				####funcionalidad#######
				self.tx_raw = ERR_BLOCK
				self.state = TX_E
				########################			         

				self.variables.append( state_name[self.state] )# LOGEO
				self.variables.append( self.tx_raw	)		   # LOGEO
				self.state_sequence.append(self.variables) # LOGEO		


#############################################################################################################
#############################################################################################################