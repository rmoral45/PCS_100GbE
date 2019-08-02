import common_variables as cv
import common_functions as cf
import copy
from pdb import set_trace as bp

class programmableFifo(object):
    def __init__(self, nlanes, wr_enable, rd_enable):
        self._nlanes = nlanes
        self.fifos = [Fifo(wr_enable, rd_enable) for x in range(nlanes)]

class Fifo(object):
    def __init__(self, wr_enable, rd_enable):
        self.wr_enable = wr_enable
        self.rd_enable = rd_enable
        self.memory = [[0 for word_len in range(cv.NB_DATA)] for depth in range(120)] #la profundidad esta hardcode asi queda igual que las matrices del main

    def write_fifo(self, data, write_addr):
        if(self.wr_enable):
            self.memory[write_addr] = data
            return
        else:
            return

    def read_fifo(self, read_addr):
        if(self.rd_enable):
            return self.memory[read_addr]
        else:
            return
            