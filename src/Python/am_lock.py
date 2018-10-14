from common_variables import *
from common_functions import *

#estados = ['AM_LOCK_INIT','AM_RESET_CNT','FIND_1ST','COUNT_1','COMP_2ND','2_GOOD','COMP_AM','GOOD_AM','INVALID_AM','COUNT_2','SLIP']


class AlignMarkerLockModule(object):
	
	def __init__(self):
		self.state = 'AM_LOCK_INIT'
		self.am_lock = False
		self.test_am = False
		self.am_invld_cnt = 0
		self.am_slip_done = False
		self.first_am = 0x0
		self.am_valid = False
		self.BLOCKS_BETWEEN_AM = 16835 # puse cualquier valor,revisar
		self.lane_id = 0


	def  FSM_change_state(block_lock_x,block_ready,recv_block):
		"""
			Vars:
				- block_ready : funciona como enable,es un flag que se recibe desde el modulo
				  block sync indicando que se acumularon los bits correspondientes a un bloque
				- recv_block : bloque enviado desde BlockSyncModule  
			CUIDADO,debe recibir siempre bloques,los AM se eliminan aca o en otro modulo?
			agregar funcion de bypass para bloques quie no son AM	
		"""
		
		if block_lock_x == False:
			self.state = 'AM_LOCK_INIT'
			self.am_lock = False
			self.test_am = False
			self.am_counter = 0
			self.first_am = 0x0

		elif self.state == 'AM_LOCK_INIT' : 
			self.am_lock = False
			self.test_am = False
			self.state = 'AM_RESET_CNT' #transcision incondicional


		elif self.state == 'AM_RESET_CNT' : 
			self.am_invld_cnt = 0
			self.am_slip_done = False
			self.test_am = block_ready

			if  self.test_am == True  : 
				self.state = 'FIND_1ST'


		elif self.state == 'FIND_1ST' : 
			self.test_am = False
			self.first_am = recv_block['payload']
			self.am_valid = search_valid_am(recv_block)

			if  self.am_valid  : 
				self.state = 'COUNT_1'

			else  :	
				self.state = 'SLIP' 

		elif self.state == 'COUNT_1' : 
			self.am_counter += 1

			if self.am_counter == self.BLOCKS_BETWEEN_AM  : 
				self.state = 'COMP_2ND' 

		elif self.state == 'COMP_2ND' : 
			"""
				habra que considerar el SH al hacer la comparacion?
			"""
			self.am_counter = 0 # RESETEO CONTADOR DE BLOQUES
			if  self.first_am == recv_block['payload']  : 
				self.state = '2_GOOD'
			else  :	
				self.state = 'SLIP' 

		elif self.state == '2_GOOD' : 
			self.am_lock = True
			self.lane_id = align_marker_list.index(self.first_am)
			self.state = 'COUNT_2'

		elif self.state == 'COUNT_2' : #estado 6
			self.am_counter += 1

			if self.am_counter == self.BLOCKS_BETWEEN_AM  : 
				self.state = 'COMP_AM' 
		elif self.state == 'COMP_AM':
			"""
				habra que considerar el SH al hacer la comparacion?
			"""
			self.am_counter = 0 # RESETEO CONTADOR DE BLOQUES
			if  self.first_am == recv_block['payload']  : 
				self.am_invld_cnt = 0
				self.state = 'GOOD_AM'
			else  :	
				self.state = 'INVALID_AM'
		elif self.state == 'INVALID_AM':
			self.am_invld_cnt += 1
			if self.am_invld_cnt < 4 :
				self.state = 'COUNT_2'
			elif self.am_invld_cnt == 4 :
				self.state = 'SLIP' 
		elif self.state == 'SLIP' :
			self.am_lock = False
			##revisar implementacion de AM_SLIP	


	def search_valid_am(block):
		"""
			compara tmb usando el sh,pero block sync puede recibir
			sh invalidos en estado de regimen,cuidado con eso
		"""
		return block['payload'] in align_marker_list

