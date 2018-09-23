

import random
import numpy as np
from pdb import set_trace as bp
from tx_modules import *

NCLOCK = 40
NIDLE = 5
NDATA = 16





def main():
	bp()
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


<<<<<<< HEAD
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
		
=======
>>>>>>> cce3534754ac640885eaf054854ac1cee08a259f

	

if __name__ == '__main__':
    main()
