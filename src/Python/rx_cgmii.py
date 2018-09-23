##########################################################################
def list_to_hex(hex_list):
	result = 0x000000000
	counter = 8
	for value in hex_list:
		result |= (value << (counter*8))
		counter-=1
	#return hex(result).rstrip('L')
	return result
########################  - ESTADOS - ####################################

possibles_states = ['RX_INIT', 'RX_C', 'RX_D', 'RX_E', 'RX_T']
																
######################## - CGMII CARACTERS - #############################
D0 = 0x70 # 'p'
D1 = 0x68 # 'h'
D2 = 0x79 # 'y'
D3 = 0x73 # 's'
D4 = 0x69 # 'y'
D5 = 0x63 # 'c'
D6 = 0x61 # 'a'
D7 = 0x6c # 'l'
S = 0xFB
T = 0xFD
I_CMGII = 0x07
E_CGMII = 0x1E
Q = 0x9C
Fsig = 0x5C
Z = 0x00
######################## - CGMII BLOCKS- ################################

I = 0x00
E = 0x1E

CODED_DATA_BLOCK = [0x01, D0, D1, D2, D3, D4, D5, D6, D7] 

CODED_START_BLOCK = [0x02,0x78, D1, D2, D3, D4, D5, D6, D7]

CODED_Q_ORD_BLOCK = [0x02,0x4B, D1, D2, D3, Z, Z, Z, Z]
 
CODED_Fsig_ORD_BLOCK = [0x02,0x4B, D1, D2, D3, 0XF0, Z, Z, Z]
 
CODED_IDLE_BLOCK = [I, I, I, I, I, I, I]

CODED_ERROR_BLOCK = [0x02,0x1E, E, E, E, E, E, E, E]
 
CODED_T0_BLOCK   = [I, I, I, I, I, I, I]

CODED_T1_BLOCK   = [0x02,0x99, D0, I, I, I, I, I, I]

CODED_T2_BLOCK   = [0x02,0xAA, D0, D1, I, I, I, I, I]

CODED_T3_BLOCK   = [0x02,0xB4, D0, D1, D2, I, I, I, I]

CODED_T4_BLOCK   = [0x02,0xCC, D0, D1, D2, D3, I, I, I]

CODED_T5_BLOCK   = [0x02,0xD2, D0, D1, D2, D3, D4, I, I]

CODED_T6_BLOCK   = [0x02,0xE1, D0, D1, D2, D3, D4, D5, I]

CODED_T7_BLOCK   = [0x02,0xFF, D0, D1, D2, D3, D4, D5, D6]

##########################################################################
CGMII_DECODER = { 
			
			'CODED_ERROR_BLOCK':{		'block_name'		: 'ERROR_BLOCK'
		    							'RXC'				: 0xFF,
		    							'RXD'				: [E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII, E_CGMII]		
		    					},

		    'CODED_START_BLOCK':{ 		'block_name'		: 'START_BLOCK'
		    							'RXC'				: 0x80,
		    							'RXD'				: [S, D1, D2, D3, D4, D5, D6, D7]	
		    					},

		    'CODED_DATA_BLOCK':{ 		'block_name'		: 'START_BLOCK'
		    							'RXC'				: 0x00,
		    							'RXD'				: [D0, D1, D2, D3, D4, D5, D6, D7]	
		    					},

		    'CODED_Q_ORD_BLOCK':{ 		'block_name'		: 'START_BLOCK'
		    							'RXC'				: 0x80,
		    							'RXD'				: [Q, D1, D2, D3, Z, Z, Z, Z]		
		    					},


		    'CODED_Fsig_ORD_BLOCK':{ 	'block_name'		: 'START_BLOCK'
		    							'RXC'				: 0x80,
		    							'RXD'				: [Fsig, D1, D2, D3, Z, Z, Z, Z] 	
									},

			'CODED_IDLE_BLOCK':{ 		'block_name'		: 'IDLE_BLOCK'
		    							'RXC'				: 0xFF,
		    							'RXD'				: [I_CMGII, I_CMGII, I_CMGII, I_CMGII, I_CMGII, I_CMGII, I_CMGII, I_CMGII]		
								},					    

			'CODED_T0_BLOCK':{			'block_name'		: 'IDLE_BLOCK'
		    							'RXC'				: 0xFF,
		    							'RXD'				: [T, I_CMGII, I_CMGII, I_CMGII, I_CMGII, I_CMGII, I_CMGII, I_CMGII]		
							},

			'CODED_T1_BLOCK':{			'block_name'		: 'IDLE_BLOCK'
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, T, I_CMGII, I_CMGII, I_CMGII, I_CMGII, I_CMGII, I_CMGII]		
							},

			'CODED_T2_BLOCK':{			'block_name'		: 'IDLE_BLOCK'
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, T, I_CMGII, I_CMGII, I_CMGII, I_CMGII, I_CMGII]		
							},

			'CODED_T3_BLOCK':{			'block_name'		: 'IDLE_BLOCK'
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, D2, T, I_CMGII, I_CMGII, I_CMGII, I_CMGII]		
							},

			'CODED_T4_BLOCK':{			'block_name'		: 'IDLE_BLOCK'
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, D2, D3, T, I_CMGII, I_CMGII, I_CMGII]		
							},

			'CODED_T5_BLOCK':{			'block_name'		: 'IDLE_BLOCK'
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, D2, D3, D4, T, I_CMGII, I_CMGII]	
							},

			'CODED_T6_BLOCK':{			'block_name'		: 'IDLE_BLOCK'
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, D2, D3, D4, D5, T, I_CMGII]		
							},

			'CODED_T7_BLOCK':{			'block_name'		: 'IDLE_BLOCK'
		    							'RXC'				: 0xFF,
		    							'RXD'				: [D0, D1, D2, D3, D4, D5, D6, T]		
							},
		   
	    	}
##########################################################################

##TODO: - Implementar RX_TYPE_NEXT

class rx_FSM(object):																	

	def __init__(self, frame):
		self.state = 'RX_INIT'
		self.rx_coded = frame								#Trama que recibo --- Es un diccionario de campos: block_name, sh, btype_field y payload
		self.rx_raw = []									#Trama a enviar	
	
	def transition(self, frame):

		self.rx_coded = frame

		if(self.state == 'RX_INIT'):

			rx_raw = Q_ORD_BLOCK

			print "Estado actual: ", self.state

			if(rx_coded == IDLE_BLOCK):
				self.state = 'RX_C'
				rx_raw = hex(encoder[IDLE_BLOCK])

			elif(rx_coded == Q_ORD_BLOCK):
				self.state = 'RX_C'
				rx_raw = hex(encoder[Q_ORD_BLOCK])


			elif(rx_coded == START_BLOCK):
				self.state = 'RX_D'
				rx_raw = hex(encoder[START_BLOCK])

			elif(rx_coded == ERROR_BLOCK):
				self.state = 'RX_E'
				rx_raw = hex(encoder[ERROR_BLOCK])


			elif(rx_coded == DATA_BLOCK):
				self.state = 'RX_E'
				rx_raw = hex(encoder[ERROR_BLOCK])

			elif(rx_coded == T0_BLOCK):
				self.state = 'RX_E'
				rx_raw = hex(encoder[ERROR_BLOCK])


			print "Send to CGMII: ", self.rx_raw
			print "Proximo estado: ", self.state
	
	
		
		elif(self.state == 'RX_C'):

			print "Estado actual: ", self.state

			if(rx_coded == IDLE_BLOCK): 
				self.state = self.state
				rx_raw = hex(encoder[IDLE_BLOCK])

			elif(rx_coded == Q_ORD_BLOCK):
				self.state = self.state
				rx_raw = hex(encoder[Q_ORD_BLOCK])


			elif(rx_coded == DATA_BLOCK):
				self.state = 'RX_E'
				rx_raw = hex(encoder[ERROR_BLOCK])

			elif(rx_coded == T0_BLOCK):
				self.state = 'RX_E'
				rx_raw = hex(encoder[ERROR_BLOCK])


			elif(rx_coded == START_BLOCK):
				rx_raw = hex(encoder[START_BLOCK])
				self.state = 'RX_D'

			print "Send to CGMII: ", self.rx_raw
			print "Proximo estado: ", self.state



		elif(self.state == 'RX_D'):

			print "Estado actual: ", self.state
			
			if(rx_coded == DATA_BLOCK):
				rx_raw = hex(encoder[DATA_BLOCK])
				self.state = self.state

			elif(rx_coded == T0_BLOCK):
				rx_raw = hex(encoder[T0_BLOCK])
				self.state = 'RX_T'


			else:
				rx_raw = hex(encoder[ERROR_BLOCK])				
				self.state = 'RX_E'

			print "Send to CGMII: ", self.rx_raw
			print "Proximo estado: ", self.state



		elif(self.state == 'RX_T'):

			print "Estado actual: ", self.state

			if(rx_coded == IDLE_BLOCK): 
				self.state = 'RX_C'
				rx_raw = hex(encoder[IDLE_BLOCK])

			elif(rx_coded == Q_ORD_BLOCK):
				self.state = 'RX_C'
				rx_raw = hex(encoder[Q_ORD_BLOCK])


			elif(rx_coded == START_BLOCK):
				self.state = 'RX_D'
				rx_raw = hex(encoder[DATA_BLOCK])

			print "Send to CGMII: ", self.rx_raw
			print "Proximo estado: ", self.state



		elif(self.state == 'RX_E'):

			if(rx_coded == IDLE_BLOCK): 
				self.state = 'RX_C'
				rx_raw = hex(encoder[IDLE_BLOCK])

			elif(rx_coded == Q_ORD_BLOCK):
				self.state = 'RX_C'
				rx_raw = hex(encoder[Q_ORD_BLOCK])

			elif(rx_coded == DATA_BLOCK):
				self.state = 'RX_D'
				rx_raw = hex(encoder[DATA_BLOCK])

			print "Send to CGMII: ", self.rx_raw
			print "Proximo estado: ", self.state



		else:
			print 'Unknown state'
			rx_raw = hex(encoder[ERROR_BLOCK])

			print "Send to CGMII: ", self.rx_raw
			print "Proximo estado: ", self.state




			








