import copy
from pdb import set_trace as bp

class deskewCalculator(object):
    def __init__(self, nlanes):
        self.nlanes = nlanes
        self.counters = [ss_counter() for x in range(nlanes)]
        self.common_counter = ss_counter()
        self.start_flag = 0
        self.stop_signals = [0]*nlanes
        self.resync_flag = 0
        self.fsm = deskewCalculatorFSM(nlanes)
    
'''
Start/Stop Counter: 
    Habra un contador de este tipo por cada linea, el comportamiento es el siguiente:
    - si start signal es 1 y stop signal tambien, guardamos la cuenta y seteamos el flag de finalizacion en 1 (es la linea mas rapida).
    - si start signal es 1 y no hay stop signal, seteamos el flag de inicio de cuenta en 1.
    - si start signal es 1 y no esta seteado el flag de finalizacion, incrementamos la cuenta en 1.

    ACA HAY QUE REVISAR EL MAX_DESKEW?????? Lo podria hacer en el Modulo principal. (13/06/19) ----> lo hacemos en la FSM
'''
class ss_counter(object):

    def __init__(self):
        self._start     = 0
        self._stop      = 0
        self._count     = 0
        self._finish    = 0
        self._final_count = 0 

    def reset(self):
        self._start     = 0
        self._stop      = 0
        self._count     = 0
        self.finish     = 0
        self._final_count = 0 

    def update_count(self, start_signal, stop_signal, resync_signal):
        #un resync en cualquier linea resetea a todos los contadores.
        if(resync_signal):              
            self.reset()
        elif stop_signal : 
            self._final_count = self._count
        elif start_signal:
            self._count += 1

'''
Maquina de estados de la Calculadora de Skew:
    ESTADOS: 
            -INIT:  inicializa las seniales de start, stop y de control de skew en 0
                    chequea si llego algun resync y se resetea en caso de que asi sea
                    chequea si llego algun start of lane y manda a contar a todos los contadores en caso de que asi sea
            -COUNT: Detiene la cuenta cada vez que llega un start of lane.
                    Si todas las cuentas estan detenidas, detiene la cuenta del contador comun.
                    Si llega un resync en alguna linea, voy al estado de inicializacion.
            -DONE:  
'''
class deskewCalculatorFSM(object):

    def __init__(self, nlanes):
        self._nlanes = nlanes
        self._state = "INIT"
        self.start_counters = 0
        self.stop_lane_counter = [0]*nlanes
        self.stop_common_counter = 0
        self.skew_done = 0
        self.invalid_skew = 0
        self.wr_enb_prog_fifo = 0
        self.rd_enb_prog_fifo = 0
        self.set_fifo_delay   = 0

    def change_state(self, sol_signals, resync_signals, common_counter, max_skew):

        if self._state == "INIT":
            self.start_counters = 0
            self.stop_lane_counter = [0]*self._nlanes
            self.stop_common_counter = 0 
            self.skew_done = 0
            #self.invalid_skew = 0 
        
            if(any(resync_signals)):            #<reduction or> of resync_signal of all lanes, mas prioritario que el sol? 
                self._state = "INIT"
            
            elif(any(sol_signals)):               #<reduction or> of start_of_lane of all lanes
                self._state = "COUNT"
                self.start_counters = 1
                self.stop_lane_counter = [sum(x) for x in zip(self.stop_lane_counter,sol_signals)]            

        
        elif self._state == "COUNT":
            self.stop_lane_counter = [sum(x) for x in zip(self.stop_lane_counter,sol_signals)]        #oring list element wise
            self.stop_common_counter = sum(self.stop_lane_counter) == self._nlanes                     #si todas las lineas pararon de contar, paro el contador comun
            self.wr_enb_prog_fifo = 1


            if(common_counter._count >= max_skew):
                self.invalid_skew = 1
                self._state = 'INIT'

            else:
                if(any(resync_signals)):
                    self._state = "INIT"
                elif self.stop_common_counter:
                    self._state = "DONE"
                    self.set_fifo_delay = 1


        elif self._state == "DONE":
            self.skew_done = 1
            self.rd_enb_prog_fifo = 1
            self.set_fifo_delay = 0






    