import random
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
def main():
        deco_fsm = DecoderFsm()
        state_vect = []
        i_data = []
        i_tag = []
        (i_data,i_tag) = sim_data_stream()
        for clock in range(len(i_data)):
                state_vect.append(deco_fsm.state)
                deco_fsm.run(i_data[clock])

        bp()


def sim_data_stream():
        # Block encoding
        CTRL_BLOCK  = 0
        START_BLOCK = 1
        DATA_BLOCK  = 2
        TERM_BLOCK  = 3
        ERR_BLOCK   = 4
        #Sim parameters
        N_PACKETS = 10
        MIN_CTRL = 0 #es como  si llegara la secuencia {START DATA ... DATA TERM START DATA ... DATA}
        MAX_CTRL = 30
        MIN_DATA = 20
        MAX_DATA = 60

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
        '''   
        N_INSERTS = int(len(type_vect)/AM_PERIOD)
        for i in range(1,N_INSERTS+1):
                for j in range(N_LANES):
                        pos = (AM_PERIOD*i) + j
                        type_vect.insert(pos, CTRL_BLOCK)
                        sol_vect.insert(pos, 1)
        '''
        return (type_vect, sol_vect)

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
