import copy
from pdb import set_trace as bp
from common_functions import *
import copy




class SerialToParallelModule(object):
	
	def __init__(self,phy_lane_id):
		"""
			Args:
				-<type int> phy_lane_id : indica a que linea de recepcion fisica corresponde el conversor
		"""
		self._block = {
						'payload' : 0
				     }
		self._block_ready = False #se setea a true cuando se acumularon 66 bits desde PMA
		self._bit_counter = 66 #se decrementa cada vez que obtiene un bit
		self._phy_lane_id = phy_lane_id

	def get_66_bit(self):
		"""
			Returns :
				-block : bloque con un payload conteniendo 66bits acumulados desde pma
		"""
		block = copy.deepcopy(self._block) #por las dudas,para evitar paso por referencia
		self._block['payload'] = 0
		self._bit_counter = 66
		self._block_ready = False 
		return block
		

	def acumulate_bit(self,channel):
		"""
			Args :
				-<type ChannelModel> channel : canal del sistema,el cual esta modelado como matriz donde cada columna corresponde
						   a una lane fisica de transmision
			Uses :
				-<type function> reorder_block() : los octetos se reciben en el mismo orden que se encontraban en el transmisor
				 shbit0 shbit1 D0 D1 ...... D7 pero con el orden de los bit invertidos, se utiliza la funcion para acomodar el orden
				 de los bits
			Sets :
				-<type bool> _block_ready : se setea en true luego de haber acumulado y reordenado 66 bits
		"""
	
		new_bit = channel.get_bit(self._phy_lane_id)
		self._bit_counter -= 1
		self._block['payload'] |= (new_bit << self._bit_counter)
		if self._bit_counter == 0:
			self.reorder_block()
			self._block_ready = True

	def block_ready(self):
		return self._block_ready

	def reorder_block(self):
		"""
			invierte el orden de los bits de cada octeto de payload
		"""
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