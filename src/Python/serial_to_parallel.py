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
			self._block_ready = True

	def block_ready(self):
		return self._block_ready