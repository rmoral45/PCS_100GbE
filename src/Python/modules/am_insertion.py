
from common_variables import *
import copy
import bip_calculator as bip


class AmInsertionModule(object):
	
	def __init__(self, phy_lane_id):
		self._phy_lane_id = phy_lane_id
		self._aligner_marker = align_marker_dict[phy_lane_id]
		self._bip3 = 0x0000000000000000
		self._bip7 = 0x0000000000000000
		self._bipCalculator = bip.bipCalculator()

	def run(self, block_counter, data):

		(self._bip3, self._bip7) = self._bipCalculator.calculateParity(data)	

		if(block_counter == AM_BLOCK_GAP): #si se cumple esto, tengo que retornar el am con la paridad insertada y resetar el bip

			return self._aligner_marker['payload'] |=	
			self._bipCalculator.reset(phy_lane_id)
		else:
			return data
	
	'''
	def get_block(self,block_counter):
		if block_counter == AM_BLOCK_GAP:
			return copy.deepcopy(self._aligner_marker)
		else:
			return self._block_fifo.pop()

	'''

