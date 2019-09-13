import common_variables as cv
import common_functions as cf
import copy
from pdb import set_trace as bp

class programmableFifo(object):
    def __init__(self, nlanes, wr_enable, rd_enable, delay_vector):
        self._nlanes = nlanes
        self.fifos = [Fifo(wr_enable, rd_enable, delay_vector[x]) for x in range(nlanes)]

class Fifo(object):
    def __init__(self, wr_enable, rd_enable, lane_deskew):
        self.wr_enable      = wr_enable
        self.rd_enable      = rd_enable
        self.wr_ptr         = 0
        self.rd_ptr         = 0 
        self._fifo_length   = 20
        self.memory         = [0] * (self._fifo_length)
        

    def write_fifo(self, data):
        if(self.wr_enable):

            self.memory[self.wr_ptr] = data

            self.wr_ptr += 1

            if(self.wr_ptr >= (self._fifo_length)):
                self.wr_ptr = 0

        else:
            return

    def read_fifo(self):
        
        if(self.rd_enable):

            #bp()
            aux = 0
            aux = self.memory[self.rd_ptr]

            self.rd_ptr += 1

            if(self.rd_ptr >= (self._fifo_length)):
                self.rd_ptr = 0 
            
            return aux
                
        else:
            return
            
    def set_fifo_delay(self, delay):
        self.rd_ptr = delay
        return