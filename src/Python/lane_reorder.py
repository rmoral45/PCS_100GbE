




class LaneReorderModule(object):

	def __init__(self,NLANES):
		self.NLANES = NLANES
		self.reordered_lanes = [[] for y in range(NLANES)]

	def add_block(self,am_modules_vect,am_status):
		"""
			obtiene un bloque de cada modulo de alineadores de cada lane,si agregamos deskew despues corregimos
		"""
		if am_status == True:
			for i in am_modules_vect :
				lane_id = i.lane_id() 
				block = i.get_block()
				self.reordered_lanes[lane_id].insert(0,block)

	def get_block_vect(self):
		"""
			retorna un vector donde cada elemento es un bloque de cada lane ordenada
		"""
		block_vect = []
		for i in self.reordered_lanes :
			lane_x_block = i.pop()
			block_vect.append(lane_x_block)
		return block_vect
