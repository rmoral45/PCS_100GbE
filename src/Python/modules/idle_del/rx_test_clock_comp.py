import random
import copy
import clock_comp_rx as ccrx
from collections import namedtuple
from pdb import set_trace as bp
AM_PERIOD = 100
N_LANES   = 20

'''
        Cada packete simulado es la secuencia de bloques
       { N-Control , N-datos, Terminate}
'''
#State encoding
RX_INIT = (1 << 0)
RX_C    = (1 << 1)
RX_D    = (1 << 2)
RX_T    = (1 << 3)
RX_E    = (1 << 4)
# Block encoding
CTRL_BLOCK  = 0
START_BLOCK = 1
DATA_BLOCK  = 2
TERM_BLOCK  = 3
ERR_BLOCK   = 4
DATA_NAME = ['IDLE', 'START', 'DATA', 'TERM', 'ERR']

DUMP_DIR = './rx_test_dump/'
def main():
        decode_type(2)
        deco_fsm   = DecoderFsm()
        ccomp      = ccrx.ClockCompRx(N_LANES, AM_PERIOD)
        state_vect = []
        i_data     = []
        i_tag      = []
        o_data     = 99
        o_tag      = 99
        o_dv       = []
        o_tv       = []
        o_fsm_vect = []
        fsm_ctrl   = 0
        (i_data,i_tag) = sim_data_stream()
        
        ##########  Sim Starts ###########
        for clock in range(len(i_data)):
                fsm_ctrl = (deco_fsm.state == RX_C)
                (o_data, o_tag) = ccomp.run(i_data[clock], i_tag[clock], fsm_ctrl)
                o_dv.append(o_data)
                o_tv.append(o_tag)
                o_fsm_vect.append(fsm_ctrl);
                print(DATA_NAME[i_data[clock]],'  ',i_tag[clock],'  ', DATA_NAME[o_data], '  ', o_tag)
                deco_fsm.run(o_data)

        ##########  Testing   ############
        sim_test(i_data,o_dv)

        ##########  Logging   ############
        with open(DUMP_DIR + "rx_input_data.txt", "w") as fd:
                for block_type in i_data :
                        fd.write((' '.join(decode_type(block_type))) + '\n')
        with open(DUMP_DIR + "rx_input_tag.txt", "w") as fd:
                for tag in i_tag :
                        fd.write(bin(tag)[2:] + '\n')
        with open(DUMP_DIR + "rx_input_fsmctrl.txt", "w") as fd:
                for tag in o_fsm_vect :
                        fd.write(bin(tag)[2:] + '\n')

        with open(DUMP_DIR + "rx_output_data.txt", "w") as fd:
                for block_type in o_dv :
                        fd.write((' '.join(decode_type(block_type))) + '\n')
        

class IdleBlocksMismatch(Exception):
        pass

def decode_type(btype):
                
        Blocks = namedtuple('PCS_BLOCKS', ['idle', 'start','rand_data','terminate', 'error'])
        payload = Blocks(0x2e000000000000000,\
                         0x27800000000000000,\
                         0x19988776655443322,\
                         0x28700000000000000,\
                         0x21e1e1e1e1e1e1e1e)

        block_types = {
                  0 : payload.idle,
                  1 : payload.start,
                  2 : payload.rand_data,
                  3 : payload.terminate,
                  4 : payload.error
                }

        dec = block_types[btype]
        dec = bin(dec)[2:].zfill(66)
        return dec

def sim_test(i_data, o_data):
        if o_data.count(CTRL_BLOCK) != i_data.count(CTRL_BLOCK):
                raise IdleBlockMismatch("Comparacion entre entrada y salida del comp")
        else :
                print('#'*40)
                print("Testing pass succefully")
                print('#'*40)
        
def sim_data_stream():
        #Sim parameters
        N_PACKETS = 1200
        MIN_CTRL  = 5 
        MAX_CTRL  = 30
        MIN_DATA  = 20
        MAX_DATA  = 60

        #parametrizacion de bloques por paquete
        ctrl_vect = [random.randint(MIN_CTRL, MAX_CTRL) for y in range(N_PACKETS)] # parametrizacion para cada paquete a generar
        data_vect = [random.randint(MIN_DATA, MAX_DATA) for y in range(N_PACKETS)] # idem
                
        #Vars
        type_vect = []
        sol_vect  = []

        #Genero un stream de paquetes como saldrian del encoder
        for i in range(N_PACKETS):
                type_vect += [CTRL_BLOCK for y in range(ctrl_vect[i])]
                type_vect += [START_BLOCK]
                type_vect += [DATA_BLOCK for y in range(data_vect[i])]
                type_vect += [TERM_BLOCK]
        sol_vect += [0]*len(type_vect)

        #Simulo la insercion de alineadores, que luego en RX fueron pisados con idles y a los cuales se les appendeo sol_tag
        N_INSERTS = int(len(type_vect)/AM_PERIOD)
        for i in range(1,N_INSERTS+1):
                pos = (AM_PERIOD*N_LANES*i)-N_LANES -1
                for j in range(N_LANES):
                        type_vect.insert(pos, CTRL_BLOCK)
                        sol_vect.insert(pos, 1)

        return (type_vect[0:12000], sol_vect)

class DecoderFsm(object):
        def __init__(self):
                self.state     = RX_INIT
                self.state_seq = []
        def reset(self):
                self.state     = RX_INIT
                self.state_seq = []
        def run(self, RTYPE):

                if self.state == RX_INIT :
                        if RTYPE == CTRL_BLOCK:
                                self.state = RX_C
                        elif RTYPE == START_BLOCK :
                                self.state = RX_D
                        else :
                                self.state = RX_E

                elif self.state == RX_C :
                        if RTYPE == CTRL_BLOCK:
                                self.state = RX_C
                        elif RTYPE == START_BLOCK:
                                self.state = RX_D
                        else :
                                self.state = RX_E

                elif self.state == RX_D :
                        if RTYPE == DATA_BLOCK :
                                self.state = RX_D
                        elif RTYPE == TERM_BLOCK:
                                self.state = RX_T
                        else :
                                self.state = RX_E
                elif self.state == RX_T :
                        if RTYPE == CTRL_BLOCK:
                                self.state = RX_C
                        elif RTYPE == START_BLOCK:
                                self.state = RX_D
                        else :
                                self.state = RX_E
                elif self.state == RX_E :
                        if RTYPE == CTRL_BLOCK :
                                self.state = RX_C
                        elif RTYPE == DATA_BLOCK :
                                self.state = RX_D
        

if __name__ == '__main__' :
        main()
