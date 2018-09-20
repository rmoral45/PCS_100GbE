

import random
import numpy as np
from pdb import set_trace as bp

def list_to_hex(hex_list):
	result = 0x000000000
	counter = 8
	for value in hex_list:
		result |= (value << (counter*8))
		counter-=1
	#return hex(result).rstrip('L')
	return result

NCLOCK = 40
NIDLE = 5
NDATA = 16


#################ESTADOS########################

TX_INIT = 0
TX_C = 1
TX_D = 2
TX_T = 3
TX_E = 4

state_name = ['TX_INIT', 'TX_C', 'TX_D','TX_T', 'TX_E']

###############################################


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
##############################################

########### RAW_BLOCKS ##############################################

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

I = 0x00
E = 0x1E

CODED_DATA_BLOCK = [0x01, D0, D1, D2, D3, D4, D5, D6, D7] 

CODED_START_BLOCK = [0x02,0x78, D1, D2, D3, D4, D5, D6, D7]

CODED_Q_ORD_BLOCK = [0x02,0x4B, D1, D2, D3, Z, Z, Z, Z]
 
CODED_Fsig_ORD_BLOCK = [0x02,0x4B, D1, D2, D3, 0XF0, Z, Z, Z]
 
CODED_IDLE_BLOCK = [0x02,0x1E, I, I, I, I, I, I, I]

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

##################### ENCODER TABLE ###########################

encoder = { 
			list_to_hex(DATA_BLOCK)       : list_to_hex(CODED_DATA_BLOCK) ,	
		    list_to_hex(START_BLOCK)      : list_to_hex(CODED_START_BLOCK) ,
		    list_to_hex(Q_ORD_BLOCK )     : list_to_hex(CODED_Q_ORD_BLOCK) ,
		    list_to_hex(Fsig_ORD_BLOCK)   : list_to_hex(CODED_Fsig_ORD_BLOCK) ,
		    list_to_hex(IDLE_BLOCK)       : list_to_hex(CODED_IDLE_BLOCK) ,
		    list_to_hex(T0_BLOCK)         : list_to_hex(CODED_T0_BLOCK) ,
		    list_to_hex(T1_BLOCK)         : list_to_hex(CODED_T1_BLOCK) ,
		    list_to_hex(T2_BLOCK)         : list_to_hex(CODED_T2_BLOCK) ,
		    list_to_hex(T3_BLOCK)         : list_to_hex(CODED_T3_BLOCK) ,
		    list_to_hex(T4_BLOCK)         : list_to_hex(CODED_T4_BLOCK) ,
		    list_to_hex(T5_BLOCK)         : list_to_hex(CODED_T5_BLOCK) ,
		    list_to_hex(T6_BLOCK)         : list_to_hex(CODED_T6_BLOCK) ,
		    list_to_hex(T7_BLOCK)         : list_to_hex(CODED_T7_BLOCK) ,	
	    		    		    		    		    		    		    		    		    				
	    	}

################################################################


def main():
	coded_vector = []

	cgmii_module = CgmiiFSM()
	tx_scrambler_module = Scrambler()
	#rx_scrambler = Scrambler()

	for clock in range (0,NCLOCK): # MAIN LOOP
		#bloque recibido desde cgmii
		raw_block = cgmii_module.tx_raw
		raw_block = list_to_hex(raw_block)
		
		#codificacion
		if raw_block in encoder : 
			coded_block = encoder[raw_block]
		else :
			coded_block = CODED_ERROR_BLOCK

		coded_vector.append(coded_block)
		cgmii_module.change_state(0)

	bp()

class CgmiiFSM(object) :
	def __init__(self):
		self.state = TX_INIT
		self.tx_raw = Q_ORD_BLOCK
		self.data_counter = 0
		self.idle_counter = 0
		self.state_sequence =[]
		#self.variables = [0,0,0] #aca voy a almacenar en el siguiente orden: [estado actual,prox estado,bloque enviado]
	def print_state_seq(self):
		for i in self.state_sequence:
			print '\n\n',i

	def change_state(self,force_error): # note that the first argument is self
		self.variables = [0,0,0]
		if force_error :
			print 'ERROR FORZADO \n'
		else :
			if self.state == TX_INIT :
				self.variables[0] = state_name[self.state] # LOGEO
				
				#######funcionalidad#####
				self.tx_raw = IDLE_BLOCK
				self.idle_counter+=1
				self.state = TX_C
				#########################

				self.variables[1] = state_name[self.state] # LOGEO
				self.variables[2] = self.tx_raw			   # LOGEO
				self.state_sequence.append(self.variables) # LOGEO

			elif self.state == TX_C:
				self.variables[0] = state_name[self.state] # LOGEO

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
				
				self.variables[1] = state_name[self.state] # LOGEO
				self.variables[2] = self.tx_raw			   # LOGEO
				self.state_sequence.append(self.variables) # LOGEO
				
	
			elif self.state == TX_D:
				self.variables[0] = state_name[self.state] # LOGEO

				######funcionalidad###########
				if self.data_counter < NDATA:
					self.tx_raw = DATA_BLOCK
					self.state = TX_D
					self.data_counter+=1
				else:
					self.tx_raw = T0_BLOCK
					self.state = TX_T
				#############################

				self.variables[1] = state_name[self.state] # LOGEO
				self.variables[2] = self.tx_raw			   # LOGEO
				self.state_sequence.append(self.variables) # LOGEO
				

			elif self.state == TX_T:
				self.variables[0] = state_name[self.state] # LOGEO

				#####funcionalidad############
				self.tx_raw = IDLE_BLOCK
				self.state = TX_C
				self.idle_counter = 0
				self.data_counter = 0
				##############################

				self.variables[1] = state_name[self.state] # LOGEO
				self.variables[2] = self.tx_raw			   # LOGEO
				self.state_sequence.append(self.variables) # LOGEO

				
			elif self.state == TX_E:
				self.variables[0] = state_name[self.state] # LOGEO

				####funcionalidad#######
				self.tx_raw = ERR_BLOCK
				self.state = TX_E
				########################			         

				self.variables[1] = state_name[self.state] # LOGEO
				self.variables[2] = self.tx_raw			   # LOGEO
				self.state_sequence.append(self.variables) # LOGEO
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
			OJO !!!! DEBERIA INVERTIR EL ORDEN DE LOS OCTETOS creo
		''' 
		for i in reversed(range(0,self.BLOCK_CODED_LEN)):
			self.xor = ( (in_block & (1<<i) ) >>i ) ^ self.shift_reg[self.polynom_1] ^ self.shift_reg[self.polynom_2]
			self.shift_reg = np.roll(self.shift_reg,1)
			self.output |= self.xor << i
			self.shift_reg[0] = ( (in_block & (1<<i) ) >>i )
			
		return self.output		
		

def reverse_byte(num):  
	binary = bin(num) 
	reverse = binary[-1:1:-1] 
	return int(reverse,2)
	

if __name__ == '__main__':
    main()
