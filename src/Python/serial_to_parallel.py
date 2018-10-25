import copy
from pdb import set_trace as bp
from common_functions import *
import copy




class SerialToParallelModule(object):
	
	def __init__(self,phy_lane_id):
		self._block = {
						'payload' : 0
				     }
		self._block_ready = False #se setea a true cuando se acumularon 66 bits desde PMA
		self._bit_counter = 66 #se decrementa cada vez que obtiene un bit
		self._phy_lane_id = phy_lane_id
	def get_66_bit(self):
		block = copy.deepcopy(self._block)
		self._block['payload'] = 0
		self._bit_counter = 66
		self._block_ready = False
		return block
		

	def acumulate_bit(self,channel):
	
		new_bit = channel.get_bit(self._phy_lane_id)
		self._bit_counter -= 1
		self._block['payload'] |= (new_bit << self._bit_counter)
		if self._bit_counter == 0:
			self.reorder_block()
			self._block_ready = True

	def block_ready(self):
		return self._block_ready
	def reorder_block(self):
		block = {
					'payload' : 0
				}
		block['sh'] = (self._block['payload'] & (1<<64) ) >> 64
		block['sh'] |= ((self._block['payload'] & (1<<65) ) >> 65) << 1
		self._block['payload'] = (self._block['payload'] & 0xffffffffffffffff)
		
		for i in reversed(range(8)):
			byte = ((self._block['payload'] & (0xff<<8*i)) >> 8*i)
			byte = reverse_num(byte,8)
			block['payload'] |= byte << 8*i
		block['payload'] |= block['sh'] << 64
		del block['sh']
		self._block = copy.deepcopy(block)