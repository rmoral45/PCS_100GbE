

from common_functions import *
from pdb import set_trace as bptr

class ParallelToSerialModule(object):
	def __init__(self,phy_lane_id):
		"""
			Args:
				-<type int> phy_lane_id : linea fisica a por la cual enviar de manera serial los bits de cada bloque
		"""
		self._phy_lane_id = phy_lane_id
		self._bit_fifo = []


	def block_to_bit_stream(self,block):
		"""
			Args:
				-<type dict> block : bloque para transmitir de manera serial
			Sets:
				-<type list> _bit_fifo : lista de 66 bits con formato [bit7 D7,......,bit0 D0,bit1 SH,bit0 SH ]
		"""
		#aux = [[],[],[],[]] usada para debug
		bit_stream = []
		sh_bit_0 = ( block['sh'] & (1<<1) ) >> 1
		sh_bit_1 = ( block['sh'] & 1 )
		bit_stream.insert(0,sh_bit_0)
		bit_stream.insert(0,sh_bit_1)
		payload = num_to_hex_list(block) #convierto a lista de bytes
		
		for iter_byte in range(0,len(payload)):
			for iter_bit in range(0,8):
				byte = payload[iter_byte]
				bit = (byte & (1 << iter_bit)) >> iter_bit
				bit_stream.insert(0,bit)
			#aux[0].append(hex(payload[iter_byte]))
			#aux[1].append(bin(payload[iter_byte]))
			#aux[2].append(bit_stream[0:8])
		bit_stream = map(int,bit_stream)
		self._bit_fifo[0:-len(self._bit_fifo)] =  bit_stream	

	def get_bit(self):
		bit_fifo = copy.deepcopy(self._bit_fifo.pop())
		return bit_fifo

	def lane_id(self):
		return self._phy_lane_id
	