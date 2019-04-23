
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
		self._aligner_marker = align_marker_dict[phy_lane_id]
		self._bip3 = [0]*8
		self._bip7 = [0]*8
		self._bipCalculator = bip.bipCalculator()

	def run(self, block_counter, data):		#funcion destinada a correr la bip calculator e insertar la paridad en caso de ser necesario

		(self._bip3, self._bip7) = self._bipCalculator.calculateParity(data)	

		if(block_counter%AM_BLOCK_GAP == 0): #si se cumple esto, tengo que retornar el am con la paridad insertada y resetar el bip
			tmp = self.insertParity()
			tmp.insert(0,1)
			tmp.insert(1,0)
			return (tmp, 1)

		else:
			return (data, 0)
	
	def insertParity(self):

		tmp = hex_to_bit_list(self._aligner_marker['payload'])

		for index3 in range(0, NB_BIP):
			tmp[BIP3_INDEX+index3] = self._bip3[index3]

		for index7 in range(0, NB_BIP):
			tmp[BIP7_INDEX+index7] = self._bip7[index7]

		self._bipCalculator.reset() #reseteamos los registros para calcular la paridad en un nuevo periodo

		return tmp