from common_variables import *
from common_functions import *
import copy


BLOCK_SYNC_STATES = ['LOCK_INIT','RESET_CNT','TEST_SH','VALID_SH','64_GOOD','TEST_SH2','INVALID_SH','VALID_SH2','SLIP']


class BlockSyncModule(object):
	
	def __init__(self,phy_lane_id):
		self.phy_lane_id = phy_lane_id
		self.state = 'LOCK_INIT'
		self.block_lock = False
		self.test_sh = False #esta  variable esta en false hasta que el bloque haya acumulado 66bits
		self.sh_cnt = 0
		self.sh_invld_cnt = 0
		self.shift = 0 #variable que se incrementa en el estado SLIP
		self.recv_bit_cnt = 0
		self.locked_bcount = 0 # solo se incrementa al llamar get_block
		self.previous_block = {
								'block_name'  : 'Initial previous block',
								'payload' 	  :  0x20000000000000000 #66bits
							 }
		self.extended_block= {
								'block_name'  : 'Initial extended block',
								'payload' 	  : 0x0 
							 }
		self.new_block  = {
								'block_name'  : 'New block',
								'payload' 	  :  0x0 
							 }
		self._dgb_seq = []				 

		

	def reset(self):
		self.state = 'RESET_CNT'
		self.block_lock = False
		self.test_sh = False
		self._dgb_seq.append('LOCK_INIT')
		self._dgb_seq.append(self.state)

	def  FSM_change_state(self):
		
		if self.state == 'RESET_CNT' :

			self.sh_cnt=0
			self.sh_invld_cnt=0
			if self.test_sh == True and self.block_lock == False :
				self.state = 'TEST_SH'
				self._dgb_seq.append(self.state)
			elif self.test_sh == True and self.block_lock == True :	
				self.state = 'TEST_SH2'
				self._dgb_seq.append(self.state)

		elif self.state == 'TEST_SH'	:

			self.test_sh = False 
			if self.check_sync_header() :
				self.state = 'VALID_SH'
				self._dgb_seq.append(self.state)
			else : 
				self.state = 'SLIP'	
				self._dgb_seq.append(self.state)

		elif self.state == 'VALID_SH':

			if self.test_sh == True and self.sh_cnt < 64 :
				self.state = 'TEST_SH'
				self._dgb_seq.append(self.state)
			elif self.sh_cnt == 64 :
				self.state = '64_GOOD'
				self._dgb_seq.append(self.state)

		elif self.state == '64_GOOD' :
			self.block_lock = True
			self.state = 'RESET_CNT'
			self._dgb_seq.append(self.state)

		elif self.state == 'TEST_SH2' :
			self.test_sh = False

			if self.check_sync_header() :
				self.state = 'VALID_SH2'
				self._dgb_seq.append(self.state)
			else:
				self.state = 'INVALID_SH'
				self._dgb_seq.append(self.state)

		elif self.state == 'VALID_SH2':

			if self.test_sh == True and self.sh_cnt < 1024 :
				self.state = 'TEST_SH2'
				self._dgb_seq.append(self.state)
			elif self.sh_cnt == 1024 :
				self.state = 'RESET_CNT'
				self._dgb_seq.append(self.state)

		elif self.state == 'INVALID_SH' :

			if self.sh_invld_cnt == 65 :
				self.state = 'SLIP'
				self._dgb_seq.append(self.state)
			elif self.sh_cnt == 1024 and self.sh_invld_cnt < 65 :
				self.state = 'RESET_CNT'
				self._dgb_seq.append(self.state)
			elif self.test_sh == True and self.sh_cnt < 1024 and self.sh_invld_cnt < 65 :
				self.state = 'TEST_SH2'
				self._dgb_seq.append(self.state)

		elif self.state == 'SLIP' :

			self.block_lock = False
			self.shift += 1
			"""
				if self.shift == 65
					sacar alguna flag de error???
					reset self.shift

			"""
			self.state = 'RESET_CNT'
			self._dgb_seq.append(self.state)				




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

		sh_bit_0 = (self.extended_block['payload'] & (1<< (130 - self.shift)) ) >> (130 - self.shift)
		sh_bit_1 = (self.extended_block['payload'] & (1<<(130 - self.shift + 1))) >> (130 - self.shift + 1)
		if ( sh_bit_0 ^ sh_bit_1 ) :
			self.sh_cnt += 1
			return True
		else :
			self.sh_cnt += 1
			self.sh_invld_cnt += 1
			return False
	

	def get_block(self):
		"""
			funcion que utiliza el modulo siguiente(en este caso Aligment Lock) para solicitar un bloque
			Returns :
				-<type dict> block: Bloque correcto si la variable 'block_lock' se encuentra en True,
									o un bloque con basura si esta se encuentra en False
		"""
		block = {	
					'block_name' : '',
					'payload' : 0

				}
		if self.block_lock == True :
			payload = (self.extended_block['payload'] &  (0x3ffffffffffffffff << (66 - self.shift)) ) >> (66 - self.shift)
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
				print ' Estado no alcanzado :  ' , i
				print '\n\n\n'





