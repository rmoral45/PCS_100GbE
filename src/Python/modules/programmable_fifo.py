import common_variables as cv
import common_functions as cf
import copy
from pdb import set_trace as bp

class programmableFifo(object):
    def __init__(self, nlanes):
        self._nlanes = nlanes
        self.fifos = [Fifo() for x in range(nlanes)]



class Fifo(object):
    def __init__(self, enable):
        self._enable = enable
        self.memory = [[0]*cv.NB_ADDR]*cv.MEM_DEPTH
        if(enable):
            self._write_enable = 1
            self._read_enable = 1
        elif(not(enable)):
            self._write_enable = 0
            self._read_enable = 0

    def write_fifo(data, write_addr):

    
    def read_fifo(read_addr):
