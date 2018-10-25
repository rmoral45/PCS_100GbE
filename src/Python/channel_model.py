import numpy as np



class ChannelModel(object):
	def __init__(self,lanes_read_vector,lanes_write_vector,NLANES):
		FIFO_LENGHT = 0
		NLANES = 1
		self.channel = [[0]*FIFO_LENGHT for y in range(NLANES)]
		self.trash = [np.random.randint(0,2,FIFO_LENGHT) for y in range(NLANES)]
		self.read_vector = lanes_read_vector
		self.write_vector = lanes_write_vector
		"""
		for i in range(0,len(self.channel)):
			self.channel[i][:] = self.trash[i][:] #hago esto para no usar numpyArrays
		"""
	def get_bit(self,phy_lane_id):
		read_pointer = self.read_vector[phy_lane_id] #obtengo el puntero de lectura
		bit = self.channel[phy_lane_id][read_pointer] 
		self.channel[phy_lane_id].pop() # elimino el bit mas viejo
		return bit
	def add_bit(self,phy_lane_id,bit):
		write_pointer = self.write_vector[phy_lane_id]
		self.channel[phy_lane_id].insert(write_pointer,bit)
