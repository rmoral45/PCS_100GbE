from common_variables import *
from common_functions import *
import copy
from pdb import set_trace as bp


BLOCK_SYNC_STATES = ['UNLOCKED', 'LOCKED']


class BlockSyncModule(object):
	
	def __init__(self,phy_lane_id,i_locked_timer_lim, i_unlocked_timer_lim, i_sh_invalid_max):

		#Vars agregadas para matchear el nuevo disenio de fsm
		self.search_index 			= 0
		self.block_index 			= 0
		self.timer_search 			= 0
		self.locked_timer_limit 	= i_locked_timer_lim #ventana de tiempo al final de la cual se evalua si cumplo la cond p perder LOCK o continuo
		self.unlocked_timer_limit 	= i_unlocked_timer_lim #ventana de tiempo al final de la cual se evalua si cumplo la cond p pasar a LOCKED
		self.sh_invalid_limit	  	= i_sh_invalid_max
		self.NB_BLOCK 				= 66
		#end 
		self.phy_lane_id 	= phy_lane_id
		self.state 			= 'UNLOCKED'
		self.block_lock 	= 0
		self.sh_invld_cnt 	= 0
		self.locked_bcount 	= 0 # solo se incrementa al llamar get_block

		self.previous_block = {
								'block_name'  : 'Initial previous block',
								'payload' 	  :  0x20000000000000000 #66bits
							  }

		self.extended_block = {
								'block_name'  : 'Initial extended block',
								'payload' 	  : 0x0 
							  }

		self.new_block      = {
								'block_name'  : 'New block',
								'payload' 	  :  0x0 
							  }

		self._dgb_seq = []				 

		

	def reset(self):
		self.state = 'UNLOCKED'
		self.block_lock = 0

	def  FSM_change_state(self):
		
		if (self.state == 'UNLOCKED') :
			self.block_lock = 0

			if (self.check_sync_header() == False) :
				self.timer_search = 0
				self.sh_invld_cnt = 0
				if (self.search_index == self.NB_BLOCK):
					self.search_index = 0
				else :
					self.search_index += 1

			elif (self.timer_search == self.unlocked_timer_limit) :
				self.timer_search = 0
				self.sh_invld_cnt = 0
				self.block_index = self.search_index
				self.state = 'LOCKED'

		elif (self.state == 'LOCKED'):
			self.block_lock = 1

			if (self.timer_search == self.locked_timer_limit):
				self.timer_search = 0
				self.sh_invld_cnt = 0
			elif (self.sh_invld_cnt == self.sh_invalid_limit):
				self.timer_search = 0
				self.sh_invld_cnt = 0
				self.search_index = 0
				self.state = 'UNLOCKED'
				




	def receive_block(self,recv_block):
		"""
			Concatena el payload del bloque recibido con el anterior {66bit_NewBlock , 66bitPrevBlock }
			Args :
				-<type dict> recv_block : nuevo bloque recibido desde SerialToParallelConverter
			Sets :
				-<type bool> tesh_sh : indica que se recibio un nuevo bloque,es usada por la FSM
		"""
		self.test_sh = True
		self.extended_block['payload'] = 0
		self.extended_block['payload'] |= self.previous_block['payload']
		self.extended_block['payload'] |= (recv_block['payload'] << 66)
		#en la prox llamada el bloque actual va a ser prev block
		self.previous_block = copy.deepcopy(recv_block)
		"""
			Antes de irme deberia setear tesh_sh en False ??
		"""

	def check_sync_header(self):
		"""
			Revisa la validez de sh

			Retuns :
				-<type bool> : True si el sh es valido, False si no lo es
			Sets :
				-<type int> sh_cnt : incrementa en 1
				-<type int> sh_invld_cnt : incrementa en 1 si el sh testeado es invalido (0b00/0b11)
		"""

		sh_bit_0 = (self.extended_block['payload'] & (1<< (130 - self.search_index)) ) >> (130 - self.search_index)
		sh_bit_1 = (self.extended_block['payload'] & (1<<(130 - self.search_index + 1))) >> (130 - self.search_index + 1)
		if ( sh_bit_0 ^ sh_bit_1 ) :
			return True
		else :
			self.sh_invld_cnt += 1
			return False
	

	def get_block(self):
		"""
			funcion que utiliza el modulo siguiente(en este caso Aligment Lock) para solicitar un bloque
			Returns :
				-<type dict> block: Bloque correcto si la variable 'block_lock' se encuentra en True,
									o un bloque con basura si esta se encuentra en False
		"""
		self.timer_search += 1
		block = {	
					'block_name' : '',
					'payload' : 0

				}
		if self.block_lock == 1 :
			payload = (self.extended_block['payload'] &  (0x3ffffffffffffffff << (66 - self.block_index)) ) >> (66 - self.block_index)
			name = 'locked_block_' + str(self.locked_bcount)
			self.locked_bcount += 1
		else :
			payload = 0
			name = 'trash_block'
		block['block_name'] = name
		block['payload'] = payload
		return block

	def debug_state_seq(self):
		"""
			Compara la secuencia de estados alcanzados con todos los estados posibles
			e imprime en pantalla aquellos estados no alcanzados
		"""
		for i in BLOCK_SYNC_STATES :
			if i not in self._dgb_seq :
				print (' Estado no alcanzado :  ' , i)
				print ('\n\n\n')





