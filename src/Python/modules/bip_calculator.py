from pdb import set_trace as bp
LEN_CODED_BLOCK = 66

class bipCalculator(object):

	def __init__(self, ):
		self.bip = [1]*8
		self.bip3 = [1]*8
		self.bip7 = [0]*8

	def calculateParity(self, data):

		'''
		for i in range(0, ((LEN_CODED_BLOCK-2)/8)):		#le resto 2 LEN_CODED_BLOCK pq no contamos los sh

			self.bip[0] = self.bip[0] ^ data[2 + 8*i]
			self.bip[1] = self.bip[1] ^ data[3 + 8*i]
			self.bip[2] = self.bip[2] ^ data[4 + 8*i]
			self.bip[3] = self.bip[3] ^ data[5 + 8*i]
			self.bip[4] = self.bip[4] ^ data[6 + 8*i]
			self.bip[5] = self.bip[5] ^ data[7 + 8*i]
			self.bip[6] = self.bip[6] ^ data[8 + 8*i]
			self.bip[7] = self.bip[7] ^ data[9 + 8*i]
		
		self.bip[0] = self.bip3[0] ^ data[2] ^ data[10] ^ data[18] ^ data[26] ^ data[34] ^ data[42] ^ data[50] ^ data[58]
		self.bip[1] = self.bip3[1] ^ data[3] ^ data[11] ^ data[19] ^ data[27] ^ data[35] ^ data[43] ^ data[51] ^ data[59] 
		self.bip[2] = self.bip3[2] ^ data[4] ^ data[12] ^ data[20] ^ data[28] ^ data[36] ^ data[44] ^ data[52] ^ data[60]
		self.bip[3] = self.bip3[3] ^ data[5] ^ data[13] ^ data[21] ^ data[29] ^ data[37] ^ data[45] ^ data[53] ^ data[61]
		self.bip[4] = self.bip3[4] ^ data[6] ^ data[14] ^ data[22] ^ data[30] ^ data[38] ^ data[46] ^ data[54] ^ data[62]
		self.bip[5] = self.bip3[5] ^ data[7] ^ data[15] ^ data[23] ^ data[31] ^ data[39] ^ data[47] ^ data[55] ^ data[63]
		self.bip[6] = self.bip3[6] ^ data[8] ^ data[16] ^ data[24] ^ data[32] ^ data[40] ^ data[48] ^ data[56] ^ data[64]
		self.bip[7] = self.bip3[7] ^ data[9] ^ data[17] ^ data[25] ^ data[33] ^ data[41] ^ data[49] ^ data[57] ^ data[65]
		'''

		#paridad invertida
		self.bip[7] = self.bip3[7] ^ data[2] ^ data[10] ^ data[18] ^ data[26] ^ data[34] ^ data[42] ^ data[50] ^ data[58]
		self.bip[6] = self.bip3[6] ^ data[3] ^ data[11] ^ data[19] ^ data[27] ^ data[35] ^ data[43] ^ data[51] ^ data[59] 
		self.bip[5] = self.bip3[5] ^ data[4] ^ data[12] ^ data[20] ^ data[28] ^ data[36] ^ data[44] ^ data[52] ^ data[60]
		self.bip[4] = self.bip3[4] ^ data[5] ^ data[13] ^ data[21] ^ data[29] ^ data[37] ^ data[45] ^ data[53] ^ data[61]
		self.bip[3] = self.bip3[3] ^ data[6] ^ data[14] ^ data[22] ^ data[30] ^ data[38] ^ data[46] ^ data[54] ^ data[62]
		self.bip[2] = self.bip3[2] ^ data[7] ^ data[15] ^ data[23] ^ data[31] ^ data[39] ^ data[47] ^ data[55] ^ data[63]
		self.bip[1] = self.bip3[1] ^ data[8] ^ data[16] ^ data[24] ^ data[32] ^ data[40] ^ data[48] ^ data[56] ^ data[64]
		self.bip[0] = self.bip3[0] ^ data[9] ^ data[17] ^ data[25] ^ data[33] ^ data[41] ^ data[49] ^ data[57] ^ data[65]
		


		#self.bip[3] = self.bip[3] ^ data[0]
		#self.bip[4] = self.bip[4] ^ data[1]

	

		self.bip[4] = self.bip[4] ^ data[0]
		self.bip[3] = self.bip[3] ^ data[1]


		self.bip3 = self.bip

		for j in range(0, len(self.bip3)):
			self.bip7[j] = int(not(self.bip3[j]))

		return (self.bip, self.bip7)


	def reset(self):
		self.bip = [1]*8
		self.bip3 = [1]*8
		self.bip7 = [0]*8