

from common_functions import *
from pdb import set_trace as bptr

class ParallelToSerialModule(object):
	def __init__(self,phy_lane_id):
		self._phy_lane_id = phy_lane_id
		self._bit_fifo = []


	def block_to_bit_stream(self,block):
		#aux = [[],[],[],[]] usada para debug
		bit_stream = []
		sh_bit_0 = ( block['sh'] & (1<<1) ) >> 1
		sh_bit_1 = ( block['sh'] & 1 )
		bit_stream.insert(0,sh_bit_0)
		bit_stream.insert(0,sh_bit_1)
		payload = num_to_hex_list(block) #convierto a lista de bytes,REVISAR QUE DEVUELVA LOS OCTETOS DE LA MANER DESEADA
		
		for iter_byte in range(0,len(payload)):
			for iter_bit in range(0,8):
				byte = payload[iter_byte]
				bit = (byte & (1 << iter_bit)) >> iter_bit
				bit_stream.insert(0,bit)
			#aux[0].append(hex(payload[iter_byte]))
			#aux[1].append(bin(payload[iter_byte]))
			#aux[2].append(bit_stream[0:8])
		bit_stream = map(int,bit_stream)
		#for i in range(len(payload)):
			#print'\n\n',aux[0][i],aux[1][i],aux[2][i]
		"""
			 agrego la lista de bit del bloque recibido a la lista existente.
			 ejemplo:
			 self._bit_fifo = [0,1,0,1]
			 bit_stream = [0,0,0,1,1,1]
			 self._bit_fifo[0:-len(self._bit_fifo)] =  bit_stream
			 luego
			 self._bit_fifo = [0,0,0,1,1,1, 0,1,0,1]
		"""
		self._bit_fifo[0:-len(self._bit_fifo)] =  bit_stream	

	def get_bit(self):
		return self._bit_fifo.pop()
	def lane_id(self):
		return self._phy_lane_id
	