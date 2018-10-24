from pdb import set_trace as bp
from common_variables import *
from common_functions import *

CGMII_DECODER = { 
			
			'CODED_ERROR_BLOCK':{		'block_name'		: 'ERROR_BLOCK',
		    							'RXC'				: 0xFF,
		    							'RXD'				: [E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII]		
		    					},

		    'CODED_START_BLOCK':{ 		'block_name'		: 'START_BLOCK',
		    							'RXC'				: 0x80,
		    							'RXD'				: [S, D1, D2, D3, D4, D5, D6, D7]	
		    					},

		    'CODED_DATA_BLOCK':{ 		'block_name'		: 'DATA_BLOCK',
		    							'RXC'				: 0x00,
		    							'RXD'				: [D0, D1, D2, D3, D4, D5, D6, D7]	
		    					},

		    'CODED_Q_ORD_BLOCK':{ 		'block_name'		: 'Q_ORD_BLOCK',
		    							'RXC'				: 0x80,
		    							'RXD'				: [Q, D1, D2, D3, Z, Z, Z, Z]		
		    					},


		    'CODED_Fsig_ORD_BLOCK':{ 	'block_name'		: 'Fsig_ORD_BLOCK',
		    							'RXC'				: 0x80,
		    							'RXD'				: [Fsig, D1, D2, D3, Z, Z, Z, Z] 	
									},

			'CODED_IDLE_BLOCK':{ 		'block_name'		: 'IDLE_BLOCK',
		    							'RXC'				: 0xFF,
		    							'RXD'				: [I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]		
								},					    

			'CODED_T0_BLOCK':{			'block_name'		: 'T0_BLOCK',
		    							'RXC'				: 0xFF,
		    							'RXD'				: [T, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]		
							},

			'CODED_T1_BLOCK':{			'block_name'		: 'T1_BLOCK',
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, T, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]		
							},

			'CODED_T2_BLOCK':{			'block_name'		: 'T2_BLOCK',
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, T, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]		
							},

			'CODED_T3_BLOCK':{			'block_name'		: 'T3_BLOCK',
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, D2, T, I_CGMII, I_CGMII, I_CGMII, I_CGMII]		
							},

			'CODED_T4_BLOCK':{			'block_name'		: 'T4_BLOCK',
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, D2, D3, T, I_CGMII, I_CGMII, I_CGMII]		
							},

			'CODED_T5_BLOCK':{			'block_name'		: 'T5_BLOCK',
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, D2, D3, D4, T, I_CGMII, I_CGMII]	
							},

			'CODED_T6_BLOCK':{			'block_name'		: 'T6_BLOCK',
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, D2, D3, D4, D5, T, I_CGMII]		
							},

			'CODED_T7_BLOCK':{			'block_name'		: 'T7_BLOCK',
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, D2, D3, D4, D5, D6, T]		
							},
		   
	    	}
##########################################################################

payload_nbytes = 8

class rx_FSM(object):																	

	def __init__(self):
		self.state = 'RX_INIT'
		self.rx_coded=[]
		self.rx_coded_next ={'block_name'  : 'CODED_Q_ORD_BLOCK',
							 'sh' 		   : 0x2  ,
							 'block_type'  : 0x4B ,
							 'payload' 	   : [D1, D2, D3, Z, Z, Z, Z]
							}
		self.rx_raw = CGMII_DECODER['CODED_Q_ORD_BLOCK']	#Trama a enviar	

		

	'''
	def R_TYPE(self,block):

		if(block['block_name'] == 'CODED_IDLE_BLOCK' or block['block_name'] == 'CODED_Q_ORD_BLOCK' or 
			block['block_name'] == 'CODED_Fsig_ORD_BLOCK'):
			return 'C'
		elif(block['block_name'] == 'CODED_T0_BLOCK' or block['block_name'] == 'CODED_T1_BLOCK' or 
			block['block_name'] == 'CODED_T2_BLOCK' or block['block_name'] == 'CODED_T3_BLOCK' or 
			block['block_name'] == 'CODED_T4_BLOCK' or block['block_name'] == 'CODED_T5_BLOCK' or 
			block['block_name'] == 'CODED_T6_BLOCK' or block['block_name'] == 'CODED_T7_BLOCK'):
			return 'T'
		elif(block['block_name'] == 'CODED_START_BLOCK'):
			return 'S'
		elif(block['sh'] == 0x1):
			return 'D'
		else:
			return 'E'

	def change_state(self, received_block):
		self.rx_coded = self.rx_coded_next
		self.rx_coded_next = received_block		


		TYPE = self.R_TYPE(self.rx_coded)
		TYPE_NEXT = self.R_TYPE(self.rx_coded_next)
		

		if(self.rx_coded['sh'] == 0x2 or self.rx_coded['sh'] == 0x1):


			if(self.state == 'RX_INIT'):

				print "Estado actual: ", self.state
				
				if( TYPE == 'C'):
					self.state = 'RX_C'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif(TYPE == 'S'):
					self.state = 'RX_D'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif(TYPE in ['E', 'D', 'T']):
					self.state = 'RX_E'
					self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']


				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state			
			
				
			elif(self.state == 'RX_C'):
				
				print "Estado actual: ", self.state

				if(TYPE == 'C'): 
					self.state = 'RX_C'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif(TYPE == 'S'):
					self.state = 'RX_D'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif(TYPE in ['E', 'D', 'T']):
					self.state = 'RX_E'
					self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']

				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state


			elif(self.state == 'RX_D'):

				print "Estado actual: ", self.state
				
				if(TYPE == 'D'):
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]
					self.state = 'RX_D'

				elif(TYPE == 'T' and TYPE_NEXT in ['S','C']):
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]
					self.state = 'RX_T'

				elif((TYPE == 'T' and TYPE_NEXT in ['E', 'D', 'T']) or TYPE in ['E', 'C', 'S']):
					self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']
					self.state = 'RX_E'

				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state
				

			elif(self.state == 'RX_T'):

				print "Estado actual: ", self.state

				if(TYPE == 'C'): 
					self.state = 'RX_C'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]
				elif(TYPE == 'S'):
					self.state = 'RX_D'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state


			elif(self.state == 'RX_E'):

				if(TYPE == 'C'): 
					self.state = 'RX_C'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif(TYPE == 'D'):
					self.state = 'RX_D'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif((TYPE == 'T' and (TYPE_NEXT in ['E', 'D', 'S'])) or TYPE in ['E', 'S']):
					self.state = 'RX_E'
					self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']

				elif(TYPE == 'T' and TYPE_NEXT in ['S', 'C']):
					self.state = 'RX_T'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]


				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state


			else:
				print 'Unknown state'
				self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']
				self.state = 'RX_E'

				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state
			
		else:
			print'SH ERROR: Sending error to CMGII'
			self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']
			self.state = 'TX_E'

	'''

	#Version verificacion de tipo de bloque 

	def R_TYPE(self, block):
		
		payload = block['payload']
		block_type = (payload & (0xff << (payload_nbytes - 1)*8)) >> ((payload_nbytes - 1)*8)
		
		sh = block['sh']
		if(sh == 0x1):
			block['block_name'] = 'CODED_DATA_BLOCK'
			return 'D'
		elif(block_type == 0x1e):
			block['block_name'] = 'CODED_IDLE_BLOCK'
			block['btype'] = 0x1e			
			return 'C'
		elif(block_type == 0x4b):
			block['block_name'] = 'CODED_Q_ORD_BLOCK'
			block['btype'] = 0x4b
			return 'C'
		elif(block_type == 0x4b && (payload & (0xff << 24)) == 0xf0):
			block['block_name'] = 'CODED_Fsig_ORD_BLOCK'
			block['btype'] = 0x4b
			return 'C'
		elif(block_type == 0x87):
			block['block_name'] = 'CODED_T0_BLOCK'
			block['btype'] = 0x87
			return 'T'
		elif(block_type == 0x99):
			block['block_name'] = 'CODED_T1_BLOCK'
			block['btype'] = 0x99
			return 'T'
		elif(block_type == 0xaa):
			block['block_name'] = 'CODED_T2_BLOCK'
			block['btype'] = 0xaa
			return 'T'
		elif(block_type == 0xb4):
			block['block_name'] = 'CODED_T3_BLOCK'
			block['btype'] = 0xb4
			return 'T'
		elif(block_type == 0xcc):
			block['block_name'] = 'CODED_T4_BLOCK'
			block['btype'] = 0xcc
			return 'T'
		elif(block_type == 0xd2):
			block['block_name'] = 'CODED_T5_BLOCK'
			block['btype'] = 0xd2
			return 'T'
		elif(block_type == 0xe1):
			block['block_name'] = 'CODED_T6_BLOCK'
			block['btype'] = 0xe1
			return 'T'
		elif(block_type == 0xff):
			block['block_name'] = 'CODED_T7_BLOCK'
			block['btype'] = 0xff
			return 'T'
		elif(block_type == 0x78):
			block['block_name'] = 'CODED_START_BLOCK'	
			block['btype'] = 0x78		
			return 'S'
		else
			block['block_name'] = 'CODED_ERROR_BLOCK'
			block['btype'] = 0x1e
			return 'E'

	#TODO: TERMINAR BLOCK_CHECKER

	#Funcion destinada a controlar el payload de los bloques, sin mirar el block type
	def BLOCK_CHECKER(self, block):

		payload = block['payload']

		if(block['btype'] == 0x1e && ['block_name'] = 'CODED_ERROR_BLOCK'):

			for i in range(1, payload_nbytes+1): #Recorremos al payload desde el 2do byte (salteamos el btype)
				
				check_condition = (payload & (0xff << i*8)) >> i*8
				if(!(check_condition == E_100G)):
					##ERROR







	#VERSION DE MAQUINA DE ESTADOS DEL RX CON BLOQUES GENERICOS COMPUESTOS POR SH + payload

	#El received_block sera un diccionario compuesto por SH y payload
	#Se debe verificar el primer octeto del payload para ver el tipo de bloque, luego verificar los 7 octetos restantes
	#para verificar el orden.

	def change_state(self, received_block):

		self.rx_coded = self.rx_coded_next
		self.rx_coded_next = received_block		


		TYPE = self.R_TYPE(self.rx_coded)
		TYPE_NEXT = self.R_TYPE(self.rx_coded_next)
		

		if(self.rx_coded['sh'] == 0x2 or self.rx_coded['sh'] == 0x1):


			if(self.state == 'RX_INIT'):

				print "Estado actual: ", self.state
				
				if( TYPE == 'C'):
					self.state = 'RX_C'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif(TYPE == 'S'):
					self.state = 'RX_D'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif(TYPE in ['E', 'D', 'T']):
					self.state = 'RX_E'
					self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']


				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state			
			
				
			elif(self.state == 'RX_C'):
				
				print "Estado actual: ", self.state

				if(TYPE == 'C'): 
					self.state = 'RX_C'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif(TYPE == 'S'):
					self.state = 'RX_D'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif(TYPE in ['E', 'D', 'T']):
					self.state = 'RX_E'
					self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']

				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state


			elif(self.state == 'RX_D'):

				print "Estado actual: ", self.state
				
				if(TYPE == 'D'):
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]
					self.state = 'RX_D'

				elif(TYPE == 'T' and TYPE_NEXT in ['S','C']):
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]
					self.state = 'RX_T'

				elif((TYPE == 'T' and TYPE_NEXT in ['E', 'D', 'T']) or TYPE in ['E', 'C', 'S']):
					self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']
					self.state = 'RX_E'

				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state
				

			elif(self.state == 'RX_T'):

				print "Estado actual: ", self.state

				if(TYPE == 'C'): 
					self.state = 'RX_C'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]
				elif(TYPE == 'S'):
					self.state = 'RX_D'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state


			elif(self.state == 'RX_E'):

				if(TYPE == 'C'): 
					self.state = 'RX_C'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif(TYPE == 'D'):
					self.state = 'RX_D'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]

				elif((TYPE == 'T' and (TYPE_NEXT in ['E', 'D', 'S'])) or TYPE in ['E', 'S']):
					self.state = 'RX_E'
					self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']

				elif(TYPE == 'T' and TYPE_NEXT in ['S', 'C']):
					self.state = 'RX_T'
					self.rx_raw = CGMII_DECODER[self.rx_coded['block_name']]


				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state


			else:
				print 'Unknown state'
				self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']
				self.state = 'RX_E'

				print "Send to CGMII: ", self.rx_raw
				print "Proximo estado: ", self.state
			
		else:
			print'SH ERROR: Sending error to CMGII'
			self.rx_raw = CGMII_DECODER['CODED_ERROR_BLOCK']
			self.state = 'TX_E'


			




