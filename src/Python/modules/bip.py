from pdb import set_trace as bp
import copy

NB_BIP = 8
class BipCalculator(object):
	def __init__(self,NB_BLOCK):
		self.bip     = [1]*NB_BIP
		self.bip_out = [1]*NB_BIP
	def reset(self) :
		self.bip     = [1]*NB_BIP
		self.bip_out = [1]*NB_BIP
	def calculate(self,block,am_insert):



