
from operator import add

class DeskewCalculator(object):
	def __init__(self, nlanes):
		self.NLANES 	   = nlanes
		self.counters      = [SSCounter() for i in range(nlanes)]
		self.stop_flags    = [0]*nlanes
		self.start_flag    = 0
		self.resync_flag   = 0
		self.state = 'INIT'

	def update_counters(am_lock, sol_vect, resync_vect):
		self.start_flag  = sum(sol_vect)
		self.resync_flag = sum(resync_vect)
		if am_lock == 0:
			for i in range(self.NLANES):
				counters[i].reset()
		else :
			for i in range(self.NLANES):
				counters[i].update(self.start_flag, sol_vect[i], self.resync_flag)
			

class SSCounter(object):
	def __init__(self,MAX_SKEW):
		self.max_skew = MAX_SKEW
		self.count  = 0
		self.start  = 0
		self.stop   = 0
		self.finish = 0
		self.final_count = 0
	def reset(self):
		self.count  = 0
		self.start  = 0
		self.stop   = 0
		self.finish = 0
		self.final_count = 0
	def update(self,start_sig,stop_sig,resync_sig):
		if resync_sig :
			self.reset()
		elif stop_sig and start_sig :
			self.final_count = self.count
			self.finish = 0
		elif start_sig and not stop_sig :
			self.start = 1
		elif self.start and not self.finish :
			self.count += 1


class DeskewFSM(object) :
	'''
		states = INIT, COUNT_START, COUNT_STOP
	'''
	def __init__(self,NLANES):
		self.nlanes = NLANES
		self.start_all_counters  = 0
		self.stop_lane_counters  = [0]*NLANES
		self.stop_common_counter = 0
		self.state = 'INIT'
		self.deskew_done  = 0
		self.invalid_skew = 0
	def change_state(self,sol_vect,resync_vect,am_lock):

		if self.state == 'INIT' :
			#self.restart_counters = 1
			self.start_all_counters  = 0
			self.stop_lane_counters  = [0]*NLANES
			self.stop_common_counter = 0
			self.deskew_done  = 0
			self.invalid_skew = 0

			if sum(resync_vect) :
				self.state = 'INIT'
			elif sum(sol_vect) :
				self.start_all_counters = 1
				self.stop_lane_counters = copy.copy(sol_vect)
				self.state = 'COUNT_START'		

		elif self.state == 'COUNT_START' :

			self.stop_lane_counters = map(add,self.stop_lane_counters,sol_vect)#es lo mismo que hacer una xor
			self.stop_common_counter = ( (sum(stop_lane_counters) == self.nlanes) *1)#igual que reduction &
			if sum(resync_vect) :
				self.state = 'INIT'
			elif self.stop_common_counter :
				self.state = 'DESKEW_DONE'

		elif self.state == 'DESKEW_DONE' :

		'''
			En algun lado hay que revisar que el valor del common cunter
			sea menor  que  MAX_SKEW
		'''
			self.deskew_done = 1

