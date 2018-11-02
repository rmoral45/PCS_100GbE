
import random
import numpy as np
from pdb import set_trace as bp
from common_variables import *
from common_functions import *





class ParallelScrambler(object):

	def __init__(self):
		self.BLOCK_CODED_LEN = 64
		self.SCRAMBLER_LEN = 58
		self.polynom_1 = 38
		self.polynom_2 = 57
		self.shift_reg = map(int,np.zeros(self.SCRAMBLER_LEN))
		self.xor = 0

	def par_scrambling(self,in_block):
		output = { 'block_name' : in_block['block_name'],
				   'sh'			: in_block['sh'],
				   'payload'    : 0x00000000 	
				  }

		payload = block_to_hex(in_block,block_format = 'encoder')
		output_1 =map(int,np.zeros(39))
		output_2 =map(int,np.zeros(19))
		output_3 =map(int,np.zeros(6))
		for i in range(0,39):
			in_bit = ((payload & (1 <<(63 - i))) >> (63-i))
			output_1[i] = (in_bit ^ self.shift_reg[57-i] ^ self.shift_reg[38-i])

		for j in range(0,19) :
			in_bit = ((payload & (1 <<(24 - j))) >> (24-j))
			output_2[j] = (in_bit ^ self.shift_reg[18-j] ^ output_1[j])

		ext_out =map(int,np.zeros(self.SCRAMBLER_LEN))
		ext_out[19:len(ext_out)] = reversed(output_1)
		ext_out[0:19] = reversed(output_2)
		for k in range(0,6):
			in_bit = ((payload & (1 <<(5 - k)) ) >> (5-k))
			output_3[k] =(in_bit ^ output_1[k] ^ output_1[19+k])
		output_final = map(int,np.zeros(64))
		output_final[0:39] = output_1
		output_final[39:58] = output_2
		output_final[58:len(output_final)] = output_3
		'''
		FALTA ACTUALIZAR EL VALOR DEL SHIFT_REG !!!!!!!!!
		'''
		
		return output_final
		 
