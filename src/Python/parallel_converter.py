import numpy
from common_functions import *
from pdb import set_trace as bp




class ParallelConverterModule(object):
	def __init__(self,NLANES):
		#NLANES definida en common_variables
		self.NLANES = NLANES
		self._lanes_fifo = [[] for y in range(NLANES)]
		self._InsertIterator = 0
		self._PopIterator = 0

	def pc_ready(self) :
		count = 0
		#verifico si todas las fifo tienen al menos un elemento
		for i in self._lanes_fifo :
			if len(i) >= 1 :
				count += 1

		if count == self.NLANES :
			return True

		else :
			return False


	def add_block(self,block) :
		"""
			Recibe un bloque y lo almacena en alguna de las fifos de cada lane,el primer bloque en lane_0_fifo,
			el segundo lane_1_fifo y asi sucesivamente hasta lane_n_fifo y vuelve al principio
			Args :
				-<type dict> block
		"""
		self._lanes_fifo[self._InsertIterator].insert(0,block)
		self._InsertIterator += 1
		if self._InsertIterator == self.NLANES :
			self._InsertIterator = 0

	def get_block(self):
		"""
			Inverso de add_block()
			Fix : se deberia modificar para devolver N bloques, donde cada bloque 
			corresponde a una lane de transmision.
		"""
		block = self._lanes_fifo[self._PopIterator].pop()
		self._PopIterator += 1
		if self._PopIterator == self.NLANES:
			self._PopIterator = 0
		return block