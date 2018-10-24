import numpy





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

		if count == NLANES :
			return True

		else :
			return False


	def add_block(self,block) :
		self._lanes_fifo[self._InsertIterator].insert(0,block)
		self._InsertIterator += 1
		if self._InsertIterator == NLANES :
			self._InsertIterator = 0

	def get_block(self):
		block = self._lanes_fifo[self._PopIterator].pop()
		self._PopIterator += 1
		if self._PopIterator == NLANES:
			self._PopIterator = 0
		return block