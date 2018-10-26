
from common_variables import *
import copy


class AmInsertionModule(object):
	
	def __init__(self,phy_lane_id):
		self._block_fifo = []
		self._phy_lane_id = phy_lane_id
		self._aligner_marker = align_marker_dict[phy_lane_id]

	def add_block(self,block):
		self._block_fifo.insert(0,block) #inserto en pos 0 xq saco con pop()
		
	def get_block(self,block_counter):
		if block_counter == AM_BLOCK_GAP:
			return copy.deepcopy(self._aligner_marker)
		else:
			return self._block_fifo.pop()

	"""
	def calculate_bip(self,block):
		self._bip_index = [ 
						[2,10,18....]
						[3,11,19....]
					]
		self.BIP3 = [bit0,bit1,.....]
	"""