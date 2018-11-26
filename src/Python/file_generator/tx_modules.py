
import random
import numpy as np
from pdb import set_trace as bp
from common_variables import *
from common_functions import *



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







################# ESTADOS ######################

TX_INIT = 0
TX_C = 1
TX_D = 2
TX_T = 3
TX_E = 4

state_name = ['TX_INIT', 'TX_C', 'TX_D','TX_T', 'TX_E']

#######################################################


##################### ENCODER TABLE ##########################

ENCODER = {

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
	 
CGMII_TRANSMIT = { 
			
			'ERROR_BLOCK'		:{		'block_name'		: 'ERROR_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: [E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII]		
		    					},

		    'START_BLOCK':{ 			'block_name'		: 'START_BLOCK',
		    							'TXC'				: 0x80,
		    							'TXD'				: [S, D1, D2, D3, D4, D5, D6, D7]	
		    					},

		    'DATA_BLOCK':{ 				'block_name'		: 'DATA_BLOCK',
		    							'TXC'				: 0x00,
		    							'TXD'				: [D0, D1, D2, D3, D4, D5, D6, D7]	
		    					},

		    'Q_ORD_BLOCK':{ 			'block_name'		: 'Q_ORD_BLOCK',
		    							'TXC'				: 0x80,
		    							'TXD'				: [Q, D1, D2, D3, Z, Z, Z, Z]		
		    					},


		    'Fsig_ORD_BLOCK':{ 			'block_name'		: 'Fsig_ORD_BLOCK',
		    							'TXC'				: 0x80,
		    							'TXD'				: [Fsig, D1, D2, D3, Z, Z, Z, Z] 	
									},

			'IDLE_BLOCK':{ 				'block_name'		: 'IDLE_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: [I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]		
								},					    

			'T0_BLOCK':{				'block_name'		: 'T0_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: [T, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]		
							},

			'T1_BLOCK':{				'block_name'		: 'T1_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: [D0, T, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]		
							},

			'T2_BLOCK':{				'block_name'		: 'T2_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: [D0, D1, T, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]		
							},

			'T3_BLOCK':{				'block_name'		: 'T3_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: [D0, D1, D2, T, I_CGMII, I_CGMII, I_CGMII, I_CGMII]		
							},

			'T4_BLOCK':{				'block_name'		: 'T4_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: [D0, D1, D2, D3, T, I_CGMII, I_CGMII, I_CGMII]		
							},

			'T5_BLOCK':{				'block_name'		: 'T5_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: [D0, D1, D2, D3, D4, T, I_CGMII, I_CGMII]	
							},

			'T6_BLOCK':{				'block_name'		: 'T6_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: [D0, D1, D2, D3, D4, D5, T, I_CGMII]		
							},

			'T7_BLOCK':{				'block_name'		: 'T7_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: [D0, D1, D2, D3, D4, D5, D6, T]		
							},
		   
	    	}

################################################################







def align_marker_insertion(lanes,block_counter):
	"""Inserta los marcadores correspondientes a cada lane solo si
   	   ya fueron enviados 16383 bloques por cada lane (AM_BLOCK_GAP - 1).	
	"""
	AM_BLOCK_GAP = 16384
	if ( (block_counter % AM_BLOCK_GAP) == 0 ):
		for i in range(0, len(lanes)):
			AM = align_marker_dict[i]
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
		self.xor = 0	
	def tx_scrambling(self,in_block):
		output = { 'block_name' : in_block['block_name'],
				   'sh'			: in_block['sh'],
				   'payload'    : 0x00000000 	
				  }
		'''
			OJO !!!! DEBERIA INVERTIR EL ORDEN DE LOS OCTETOS
		''' 
		hex_payload = block_to_hex(in_block,block_format = 'encoder')
		for i in reversed(range(0,self.BLOCK_CODED_LEN)):
			self.xor = ( (hex_payload & (1<<i) ) >>i ) ^ self.shift_reg[self.polynom_1] ^ self.shift_reg[self.polynom_2]
			self.shift_reg = np.roll(self.shift_reg,1)
			output['payload'] |= self.xor << i
			self.shift_reg[0] = self.xor
			
		return output

	def rx_scrambling(self,in_block):
		output = { 'block_name' : in_block['block_name'],
				   'sh'			: in_block['sh'],
				   'payload'    : 0x00000000	
				  }
		'''
			OJO !!!! DEBERIA INVERTIR EL ORDEN DE LOS OCTETOS 
		''' 
		for i in reversed(range(0,self.BLOCK_CODED_LEN)):
			self.xor = ( (in_block['payload'] & (1<<i) ) >>i ) ^ self.shift_reg[self.polynom_1] ^ self.shift_reg[self.polynom_2]
			self.shift_reg = np.roll(self.shift_reg,1)
			output['payload'] |= self.xor << i
			self.shift_reg[0] = ( (in_block['payload'] & (1<<i) ) >>i )
			
		return output

#############################################################################################################
#############################################################################################################


class CgmiiFSM(object) :
	def __init__(self):
		self.state = TX_INIT
		self.tx_raw = CGMII_TRANSMIT['Q_ORD_BLOCK']
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
			Falta agregar la funcionalidad para que, dado el estado actual se transmita un bloque que 
			genera un error en la secuencia recibida, es decir forzar una transmision de trama erronea
			'''
		else :
			if self.state == TX_INIT :
				self.variables.append( state_name[self.state] ) # LOGEO
				
				#######funcionalidad#####
				self.tx_raw = CGMII_TRANSMIT['IDLE_BLOCK']
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
					self.tx_raw = CGMII_TRANSMIT['IDLE_BLOCK']
					self.idle_counter+=1
					self.state = TX_C
				else :
					self.tx_raw = CGMII_TRANSMIT['START_BLOCK']
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
					self.tx_raw = CGMII_TRANSMIT['DATA_BLOCK']
					self.state = TX_D
					self.data_counter+=1
				else:
					self.tx_raw = CGMII_TRANSMIT['T0_BLOCK']
					self.state = TX_T
				#############################

				self.variables.append( state_name[self.state] )# LOGEO
				self.variables.append( self.tx_raw  )		   # LOGEO
				self.state_sequence.append(self.variables) # LOGEO
				

			elif self.state == TX_T:
				self.variables.append( state_name[self.state] ) # LOGEO

				#####funcionalidad############
				self.tx_raw = CGMII_TRANSMIT['IDLE_BLOCK']
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
				self.tx_raw = CGMII_TRANSMIT['ERROR_BLOCK']
				self.state = TX_E
				########################			         

				self.variables.append( state_name[self.state] )# LOGEO
				self.variables.append( self.tx_raw	)		   # LOGEO
				self.state_sequence.append(self.variables) # LOGEO		


#############################################################################################################
#############################################################################################################