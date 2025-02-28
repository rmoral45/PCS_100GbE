
from common_functions import *
from common_variables import *
import copy
import bip_calculator as bip

NB_BIP	   = 8
BIP3_INDEX = 26
BIP7_INDEX = 58

class AmInsertionModule(object):
	
	def __init__(self, phy_lane_id):
		self._phy_lane_id = phy_lane_id
		self._aligner_marker = [align_marker_dict[phy_lane_id]]
		self._bip3 = [0]*8
		self._bip7 = [0]*8
		self._tmp  = [0]*66
		self._bipCalculator = bip.bipCalculator()

	def run(self, block_counter, block):	 #funcion destinada a correr la bip calculator e insertar la paridad en caso de ser necesario

		if(block['flag'] == 1): 			 #si se cumple esto, tengo que retornar el am con la paridad insertada y resetar el bip
			self._tmp = self.insertParity()

			
			self._bipCalculator.reset() 	 #reseteamos los registros de bip calc
			(self._bip3, self._bip7) = self._bipCalculator.calculateParity(self._tmp)
			return (self._tmp)

		else:
			self._bipCalculator.calculateParity(block['data'])
			#bp()
			return (block['data'])
	
	def insertParity(self):

		#tmp = hex_to_bit_list(self._aligner_marker['payload'])
		tmp = [0]*66

		for index3 in range(NB_BIP):
			tmp[BIP3_INDEX+index3] = self._bipCalculator.bip3[index3]

		for index7 in range(NB_BIP):
			tmp[BIP7_INDEX+index7] = self._bipCalculator.bip7[index7]
		
		tmp[0] = 1
		tmp[1] = 0

		#bp()

		return tmp