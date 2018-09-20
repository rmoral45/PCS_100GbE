
#################ESTADOS########################

possibles_states = ['RX_INIT', 'RX_C', 'RX_D', 'RX_E', 'RX_T']
																
############## CGMII CARACTERS########################
 
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
I = 0x07
Q = 0x9C
Fsig = 0x5C
Z = 0x00
E = 0xFE
##########################################################################

############################ - BLOQUES - #################################

data_block = [0X00, D0, D1, D2, D3, D4, D5, D6, D7]
start_block = [0x80, S, D0, D1, D2, D3, D4, D5, D6]
seq_orderset_block = [0x80, Q, D1, D2, D3, Z, Z, Z, Z]
sig_orderset_block = [0x80, Fsig, D0, D1, D2, Z, Z, Z, Z]
error_block = [0xFE, E, E, E, E, E, E, E, E]
idle_block = [0xFF, I, I, I, I, I, I, I, I]
ter0_block = [0xFF, T, I, I, I, I, I, I, I]
ter1_block = [0x7F, D0, T, I, I, I, I, I, I] 
ter2_block = [0x3F, D0, D1, T, I, I, I, I, I] 
ter3_block = [0x7F, D0, D1, D2, T, I, I, I, I] 
ter4_block = [0x7F, D0, D1, D2, D3, T, I, I, I] 
ter5_block = [0x7F, D0, D1, D2, D3, D4, T, I, I]
ter6_block = [0x7F, D0, D1, D2, D3, D4, D5, T, I]
ter7_block = [0x7F, D0, D1, D2, D3, D4, D5, D6, T]

##########################################################################


##TODO: - Implementar RX_TYPE_NEXT
#		- Hacer los prints de los estados
# 		- Codificar para la CGMII

class rx_FSM(object):																	

	def __init__(self, frame):
		self.state = 'RX_INIT'
		self.rx_coded = frame								#Trama que recibo
		self.rx_raw = []									#Trama a enviar	
	
	def transition(self, frame):

		self.rx_coded = frame

		if(self.state == 'RX_INIT'):
			
			rx_raw = seq_orderset_frame

			if(rx_coded == idle_frame or rx_coded == seq_orderset_frame):
				self.state = 'RX_C'
			elif(rx_coded == start_frame):
				self.state = 'RX_D'
			elif(rx_coded == E or rx_coded == data_frame or rx_coded == ter0_frame):
				self.state = 'RX_E'
	
		elif(self.state == 'RX_C'):

			if(rx_coded == idle_frame or rx_coded == seq_orderset_frame):
				self.state = self.state
			elif(rx_coded == E or rx_coded == data_frame or rx_coded == ter0_frame):
				self.state = 'RX_E'rx_coded
			elif(rx_coded == start_frame):
				self.state = 'RX_D'

		elif(self.state == 'RX_D'):

			if(rx_coded == data_frame )
				self.state = self.state
			elif(rx_coded == ter0_frame):
				self.state = 'RX_T'
			else:
				self.state = 'RX_E'

		elif(self.state == 'RX_T'):
			if(rx_coded == idle_frame or rx_coded == seq_orderset_frame):
				self.state = 'RX_C'
			elif(rx_coded == start_frame):
				self.state = 'RX_D'

		elif(self.state == 'RX_E'):
			if(rx_coded == idle_frame or rx_coded == seq_orderset_frame):
				self.state = 'RX_C'
			elif(rx_coded == data_frame):
				self.state = 'RX_D'

		else:
			print 'Unknown state'
			rx_raw = error_frame





			








