
from common_functions import *
from common_variables import *
import copy
import bip_calculator as bip

NB_BIP	   = 8
BIP3_INDEX = 24
BIP7_INDEX = 56

class AmInsertionModule(object):
	
	def __init__(self, phy_lane_id):
		self._phy_lane_id = phy_lane_id
		self._aligner_marker = [align_marker_dict[phy_lane_id]]
		self._bip3 = [0]*8
		self._bip7 = [0]*8
		self._bipCalculator = bip.bipCalculator()

	def run(self, block_counter, block):	 #funcion destinada a correr la bip calculator e insertar la paridad en caso de ser necesario

		if(block['flag'] == 1): #si se cumple esto, tengo que retornar el am con la paridad insertada y resetar el bip
			tmp = self.insertParity()
			self._bipCalculator.reset() #reseteamos los registros de bip calc
			(self._bip3, self._bip7) = self._bipCalculator.calculateParity(tmp)
			return ([1,0]+tmp)

		else:
			self._bipCalculator.calculateParity(block['data'])	
			return ([0,1]+block['data'])
	
	def insertParity(self):

		#tmp = hex_to_bit_list(self._aligner_marker['payload'])
		tmp = [0]*64

		for index3 in range(0, NB_BIP):
			tmp[BIP3_INDEX+index3] = self._bipCalculator.bip3[index3]

		for index7 in range(0, NB_BIP):
			tmp[BIP7_INDEX+index7] = self._bipCalculator.bip7[index7]

		return tmp