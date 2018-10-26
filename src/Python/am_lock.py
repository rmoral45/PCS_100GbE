from common_variables import *
from common_functions import *
import copy

ALIGN_LOCK_STATES = ['AM_LOCK_INIT','AM_RESET_CNT','FIND_1ST','COUNT_1','COMP_2ND','2_GOOD','COMP_AM','GOOD_AM','INVALID_AM','COUNT_2','SLIP']


class AlignMarkerLockModule(object):
	
	def __init__(self):
		self.state = 'AM_LOCK_INIT'
		self.am_lock = False
		self.test_am = False
		self.am_invld_cnt = 0
		self.am_slip_done = False
		self.first_am = 0x0
		self.am_valid = False
		self.BLOCKS_BETWEEN_AM = AM_BLOCK_GAP  # var definida en common_variables
		self.lane_id = 0
		self.block = {
						'block_name' : '',
						'payload'    : 0
					 }
		self._dbg_seq = []


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
			self._dbg_seq.append(self.state) 
			self.am_lock = False
			self.test_am = False
			self.state = 'AM_RESET_CNT' #transcision incondicional
			self._dbg_seq.append(self.state)


		elif self.state == 'AM_RESET_CNT' : 
			self.am_invld_cnt = 0
			self.am_slip_done = False
			self.test_am = block_ready

			if  self.test_am == True  : 
				self.state = 'FIND_1ST'
				self._dbg_seq.append(self.state)


		elif self.state == 'FIND_1ST' : 
			self.test_am = False
			self.first_am = self.block['payload']
			self.am_valid = search_valid_am(self.block)

			if  self.am_valid  : 
				self.state = 'COUNT_1'
				self.am_counter = 0 #!!!!!!!!!!!! revisar este seteo  !!!!!!!!!!!!!
				self._dbg_seq.append(self.state)

			else  :	
				self.state = 'SLIP'
				self._dbg_seq.append(self.state)

		elif self.state == 'COUNT_1' : 

			if self.am_counter == self.BLOCKS_BETWEEN_AM  : 
				self.state = 'COMP_2ND'
				self._dbg_seq.append(self.state)

		elif self.state == 'COMP_2ND' : 
			"""
				habra que considerar el SH al hacer la comparacion?
			"""
			#self.am_counter = 0 # RESETEO CONTADOR DE BLOQUES
			if  self.first_am == self.block['payload']  : 
				self.state = '2_GOOD'
				self._dbg_seq.append(self.state)
			else  :	
				self.state = 'SLIP'
				self._dbg_seq.append(self.state) 

		elif self.state == '2_GOOD' : 
			self.am_lock = True
			self.lane_id = align_marker_list.index(self.first_am)
			self.state = 'COUNT_2'
			self.am_counter = 0  #!!!!!!!!!!!! revisar este seteo  !!!!!!!!!!!!!
			self._dbg_seq.append(self.state) 

		elif self.state == 'COUNT_2' : #estado 6
			#self.am_counter += 1

			if self.am_counter == self.BLOCKS_BETWEEN_AM  : 
				self.state = 'COMP_AM'
				self._dbg_seq.append(self.state)

		elif self.state == 'COMP_AM':
			"""
				habra que considerar el SH al hacer la comparacion?
			"""
			##self.am_counter = 0 # RESETEO CONTADOR DE BLOQUES#No xq reseteo cuando paso a los stados count
			if  self.first_am == self.block['payload']  : 
				self.state = 'GOOD_AM'
				self.am_invld_cnt = 0
				self._dbg_seq.append(self.state)
			else  :	
				self.state = 'INVALID_AM'
				self.am_invld_cnt += 1
				self._dbg_seq.append(self.state)

		elif self.state == 'GOOD_AM':
			
			#self.am_invld_cnt = 0
			self.state = 'COUNT_2'
			self.am_counter = 0
			self._dbg_seq.append(self.state)

		elif self.state == 'INVALID_AM':

			#self.am_invld_cnt += 1
			if self.am_invld_cnt < 4 :
				self.state = 'COUNT_2'
				self.am_counter = 0
				self._dbg_seq.append(self.state)
			elif self.am_invld_cnt == 4 :
				self.state = 'SLIP'
				self._dbg_seq.append(self.state)

		elif self.state == 'SLIP' :
			self.am_lock = False
			##revisar implementacion de AM_SLIP	
			self._dbg_seq.append(self.state)


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
		self.am_counter += 1
		self.test_am = True
		self.block = copy.deepcopy(recv_block)
	
	def get_block(self):
		"""
			Quizas aca se pueda implementar devolver un bloque idle cuando el bloque
			actual es un AM,el cual hay que eliminar
		"""
		"""
		La insercion de idles para compensar la remocion de am debe hacerse quizas entre medio del decoder y CGMII
		para no shitear el estado interno del scrambler
		block = {	
					'block_name' :'',
					'payload'    : 0

				}
		if self.block['payload'] in align_marker_list:
			block['block_name'] = 'Clock_Compensation_Idle_Block'
			block['payload']    =
		"""
			
		return copy.deepcopy(self.block)



	def lane_id(self):
		return self.lane_id


