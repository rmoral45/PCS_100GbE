import random
import numpy as np
from pdb import set_trace as bp
from common_variables import *
from common_functions import *

import copy

class ScrmGen(object) :
	def __init__(self):
		self.BLOCK_CODED_LEN = 64
		self.SCRAMBLER_LEN = 58
		self.polynom_1 = 38
		self.polynom_2 = 57
		self.shift_reg = []
		self.xor = 0	
	def scrm_func(self,in_block):
		output = []
		'''
			OJO !!!! DEBERIA INVERTIR EL ORDEN DE LOS OCTETOS
		''' 
		for i in range(0,self.SCRAMBLER_LEN):
			self.shift_reg.append ("SEED" + str(i))		
		for i in reversed(range(0,self.BLOCK_CODED_LEN)):
		
			self.xor = '(' + 'Bit'+ str(i) + 'xor' + self.shift_reg[38] + 'xor'  + self.shift_reg[57] + ')'
			self.shift_reg.pop()
			output.append(self.xor) 
			self.shift_reg.insert(0,self.xor) 
			
		return output