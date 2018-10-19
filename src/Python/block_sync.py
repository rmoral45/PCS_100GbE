from common_variables import *
from common_functions import *


estados = ['LOCK_INIT','RESET_CNT','TEST_SH','VALID_SH','64_GOOD','TEST_SH2','INVALID_SH','VALID_SH2','SLIP']


class BlockSyncModule(object):
	
	def __init__(self,phy_lane_id):
		self.phy_lane_id = phy_lane_id
		self.state = 'LOCK_INIT'
		self.previous_block = {
								'block_name'  : 'Initial previous block',
								'payload' 	  : 0x0 #66bits
							 }
		self.extended_block= {
								'block_name'  : 'Initial extended block',
								'payload' 	  : 0x0 
							 }
		self.locked_block  = {
								'block_name'  : 'Initial locked block',
								'payload' 	  : 0x0 
							 }
		self.new_block  = {
								'block_name'  : 'New block',
								'payload' 	  :  0x0 
							 }							 

		self.block_lock = False
		self.test_sh = False #esta  variable esta en false hasta que el bloque haya acumulado 66bits
		self.sh_cnt = 0
		self.sh_invld_cnt = 0
		self.shift = 0 #variable que se incrementa en el estado SLIP
		self.initial_phase = 0 #esta variable se utiliza para simular un defasaje con respecto al inicio del bloque(si uso 
		# fifo de TAREA 1 no seria necesario)
		self.recv_bit_cnt = 0


	def  FSM_change_state():
		"""
			CUIDADO,revisar que pasa con la  variable tesh_sh, que por recibir de a bloques deberia estar siempre en TRUE
		"""

		if self.state == 'LOCK_INIT' :
			self.state = 'RESET_CNT'
			self.block_lock = False
			self.test_sh = False

		elif self.state == 'RESET_CNT' :
			self.sh_cnt=0
			self.sh_invld_cnt=0
			if self.test_sh == True and block_lock == False :
				self.state = 'TEST_SH'
			elif self.test_sh == True and block_lock == True :	
				self.state = 'TEST_SH2'

		elif self.state == 'TEST_SH'	:
			# self.test_sh = False # ahora no la voy a poner xq no debo esperar los bits,recib el  bloque completo
			if self.check_sync_header() :
				self.state = 'VALID_SH'
			else : 
				self.state = 'SLIP'	

		elif self.state == 'VALID_SH':
			self.sh_cnt += 1
			if self.test_sh == True and self.sh_cnt < 64 :
				self.state = 'TEST_SH'
			elif self.sh_cnt == 64 :
				self.state = '64_GOOD'

		elif self.state == '64_GOOD' :
			self.block_lock = True
			self.state = 'RESET_CNT'

		elif self.state == 'TEST_SH2' :
			self.test_sh = False

			if self.check_sync_header() :
				self.state = 'VALID_SH2'
			else:
				self.state = 'INVALID_SH'

		elif self.state == 'VALID_SH2':
			self.sh_cnt += 1

			if self.test_sh == True and self.sh_cnt < 1024 :
				self.state = 'TEST_SH2'
			elif self.sh_cnt == 1024 :
				self.state = 'RESET_CNT'

		elif self.state = 'INVALID_SH' :
			self.sh_cnt += 1
			self.sh_invld_cnt += 1

			if self.sh_invld_cnt == 65 :
				self.state = 'SLIP'
			elif self.sh_cnt == 1024 and self.sh_invld_cnt < 65 :
				self.state = 'RESET_CNT'
			elif self.test_sh == True and self.sh_cnt < 1024 and self.sh_invld_cnt < 65 :
				self.state = 'TEST_SH2'

		elif self.state == 'SLIP' :
			self.block_lock = False
			self.shift += 1						




	def receive_block(recv_block):
		#uso recive bit frm PMA aca adentro para coompactar la funcionalidad?????
		self.extended_block['payload'] = 0
		self.extended_block['payload'] |= self.previous_block['payload']
		self.extended_block['payload'] |= recv_block['payload'] << 66

		#en la prox llamada el bloque actual va a ser prev block
		self.previous_block = recv_block

		"""
			Antes de irme deberia setear tesh_sh en False ??
		"""

	def check_sync_header():
		#ver si uso self.initial_phase
		"""
		  CUIDADO,para que esto ande deben llegar invertidos los bits del payload,del scrambler
		  salen SH D1 D2 D3 D4 y deben llegar D4' D3' D2' D2' SH' , donde D1' es el bit reversal de D1
		"""
		sh_bit_0 = (self.extended_block['payload'] & (1<<self.shift)) >> self.shift
		sh_bit_1 = (self.extended_block['payload'] & (1<<self.shift + 1)) >> self.shift + 1
		if sh_bit_0 ^ sh_bit_1 :
			return True
		else :
			return False	


	def recive_bit_from_PMA(channel_fifo):
		"""
			IDEA: esta funcion podria recibir como parametro algo que permita modifica el
			puntero de lectura de la fifo para poder 'romper' la transmision?

			return :
				True acumulo 66 bits
				False No acumulo 66 bits
		"""
		bit = channel.get_bit(self.phy_lane_id)

		self.new_block['payload'] |=  bit << (66 - self.recv_bit_cnt) #los bits se guardan desde la pos 66 hasta 0
		# para recibir bloques del mismo formato que el estandar [b0(sh0) b1(sh1) ................b66]
		self.recv_bit_cnt += 1

		if self.recv_bit_cnt == 66 : # revisar indice
			self.test_sh = True
			self.recv_bit_cnt = 0
			return True


		return False	






