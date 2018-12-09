
import tx_modules as tx
from pdb import set_trace as bp
import copy


'''
el block coounter pasarselo desde afuera xq sino se arma bardo
'''

class IdleDeletionModule(object):
	def __init__(self,NBLOCKS,NLANES):
		self.N_BLOCKS      = NBLOCKS
		self.N_LANES       = NLANES
		self.BLOCK_MOD     = NLANES*NBLOCKS #
		self.idle_counter  = 0
		self.block_counter = 0
		self.output_block  = 0
		self.fifo		   = []


	def add_block(self,block):

		if(self.block_counter == (self.N_LANES * self.N_BLOCKS) ):
			self.block_counter = 0

		if(block['block_name'] == 'IDLE_BLOCK' and self.idle_counter < self.N_LANES): #delete idle
			self.idle_counter = self.idle_counter + 1
			return
		else:
			self.fifo.insert(0,block)
			return

	def get_block(self):
		if(self.block_counter < self.N_LANES): #insert idle
			block = copy.deepcopy(tx.CGMII_TRANSMIT['IDLE_BLOCK'])
			block['block_name'] = 'INSERTED'
			self.block_counter = self.block_counter + 1
			return block
		else:
			self.block_counter = self.block_counter + 1
			return self.fifo.pop()
