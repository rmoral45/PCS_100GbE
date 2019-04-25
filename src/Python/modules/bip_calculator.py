from pdb import set_trace as bp
LEN_CODED_BLOCK = 66

class bipCalculator(object):

	def __init__(self, ):
		self.bip = [1]*8
		self.bip3 = [1]*8
		self.bip7 = [0]*8

	def calculateParity(self, data):
			

		for i in range(0, int(((LEN_CODED_BLOCK-2)/8))-1):		#le resto 2 LEN_CODED_BLOCK pq no contamos los sh
		
			self.bip[0] = self.bip[0] ^ data[2 + 8*i]
			self.bip[1] = self.bip[1] ^ data[3 + 8*i]
			self.bip[2] = self.bip[2] ^ data[4 + 8*i]
			self.bip[3] = self.bip[3] ^ data[5 + 8*i]
			self.bip[4] = self.bip[4] ^ data[6 + 8*i]
			self.bip[5] = self.bip[5] ^ data[7 + 8*i]
			self.bip[6] = self.bip[6] ^ data[8 + 8*i]
			self.bip[7] = self.bip[7] ^ data[9 + 8*i]



		self.bip[3] = self.bip[3] ^ data[0]
		self.bip[4] = self.bip[4] ^ data[1]


		self.bip3 = self.bip

		for j in range(0, len(self.bip3)):
			self.bip7[j] = int(not(self.bip3[j]))

		return (self.bip3, self.bip7)


	def reset(self):
		self.bip = [1]*8
		self.bip3 = [1]*8
		self.bip7 = [0]*8