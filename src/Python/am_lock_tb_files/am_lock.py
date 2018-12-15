from common_variables import *
from common_functions import *
import copy

ALIGN_LOCK_STATES = ['INIT', 'WAIT_1ST', 'WAIT_2ND', 'LOCKED']


class AlignMarkerLockModule(object):
	
	def __init__(self,AM_BLOCK_GAP,AM_INV_LIMIT):
		self.state = 'INIT'
		self.am_lock = False
		self.am_invld_cnt = 0
		self.first_am = 0x0
		self.am_valid = False
		self.am_invalid_limit = AM_INV_LIMIT
		self.BLOCKS_BETWEEN_AM = AM_BLOCK_GAP  # var definida en common_variables
		self.block_counter = 0
		self.lane_id = 0
		self.block = {
						'block_name' : '',
						'payload'    : 0
					 }
		self._dbg_seq = []


	def  FSM_change_state(self,block_lock_x,recv_block):
		"""
			Vars:
				- block_ready : funciona como enable,es un flag que se recibe desde el modulo
				  block sync indicando que se acumularon los bits correspondientes a un bloque
				- recv_block : bloque enviado desde BlockSyncModule  
			CUIDADO,debe recibir siempre bloques,los AM se eliminan aca o en otro modulo?
			agregar funcion de bypass para bloques quie no son AM	
		"""
		
		if self.state == 'INIT' :
			self.am_lock = False
			self.state = 'WAIT_1ST'

		elif self.state == 'WAIT_1ST' :
			self.am_valid = self.search_valid_am(recv_block)
			if (self.am_valid):
				self.first_am = recv_block
				self.state = 'WAIT_2ND'
				self.block_counter = 0

		elif self.state == 'WAIT_2ND':
			self.am_valid = self.search_valid_am(recv_block)
			if (self.am_valid and (self.block_counter == self.BLOCKS_BETWEEN_AM )):
				self.am_lock = True
				self.block_counter = 0
				self.state = 'LOCKED'
			elif ( (self.am_valid==False) and (self.block_counter == self.BLOCKS_BETWEEN_AM ) ):
				self.state = 'WAIT_1ST'

		elif self.state == 'LOCKED':
			self.am_valid = self.search_valid_am(recv_block)
			if (self.am_valid and (self.block_counter == self.BLOCKS_BETWEEN_AM )):
				self.am_invld_cnt = 0
				self.block_counter = 0
			elif ( (self.am_valid==False) and (self.block_counter == self.BLOCKS_BETWEEN_AM ) ):
				if(self.am_invld_cnt >= self.am_invalid_limit):
					self.state = 'WAIT_1ST'
					self.am_lock = False
				else:
					self.am_invld_cnt += 1
					self.block_counter = 0





	def search_valid_am(self,block):
		"""
			compara tmb usando el sh,pero block sync puede recibir
			sh invalidos en estado de regimen,cuidado con eso
		"""
		return block['payload'] in align_marker_list

	def receive_block(self,recv_block):
		"""
			Concatena el payload del bloque recibido con el anterior {66bit_NewBlock , 66bitPrevBlock }
			Args :
				-<type dict> recv_block : nuevo bloque recibido desde BlockSync
			Sets :
				-<type bool> tesh_am : indica que se recibio un nuevo bloque,es usada por la FSM
		"""
		self.block_counter += 1
		self.block = copy.deepcopy(recv_block)
	
	def get_block(self):
		
		if self.block['payload'] in align_marker_list:
			self.block['block_name'] = 'Clock_Compensation_Idle_Block'
			self.block['payload']    = 0x20000000000000000
			
		return copy.deepcopy(self.block)



	def lane_id(self):
		return self.lane_id


