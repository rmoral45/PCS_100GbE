import copy

'''
    condicion de error: que llegue un start of lane en una posicion que ya existe 
        error = lambda x : filter(sol_vect, sol_vect[i] > 1 )
'''

class deskewCalculator(object):
    def __init__(self, nlanes, max_deskew):
        self.nlanes = nlanes
        self.counters = [ss_counter for x in range(nlanes)]
        self.common_counter = 0
        self.start_flag = 0
        self.stop_signals = [0]*nlanes
        self.resync_flag = 0
        self.fsm = deskewCalculatorFSM(nlanes)


    def update_counters(self, sol_signals, resync_signals, am_lock_signal):
        self.start_flag = any(sol_signals)      #<reduction or> of start_of_lane of all lanes
        self.resync_flag = any(resync_signals)  #<reduction or> of resync_signal of all lanes

        if ~am_lock_signal:
            for x in range(self.nlanes):
                counters[x].reset()

        elif am_lock_signal:
            for x in range(self.nlanes):
                counters[x].update_count(self.start_flag, sol_signals[x], self.resync_flag)

'''
Start/Stop Counter: 
    Habra un contador de este tipo por cada linea, el comportamiento es el siguiente:
    - si start signal es 1 y stop signal tambien, guardamos la cuenta y seteamos el flag de finalizacion en 1 (es la linea mas rapida).
    - si start signal es 1 y no hay stop signal, seteamos el flag de inicio de cuenta en 1.
    - si start signal es 1 y no esta seteado el flag de finalizacion, incrementamos la cuenta en 1.

    ACA HAY QUE REVISAR EL MAX_DESKEW?????? Lo podria hacer en el Modulo principal. (13/06/19) ----> lo hacemos en la FSM
'''
class ss_counter(object):

    #def __init__(self, MAX_SKEW):
    def __init__(self):
        #self._max_skew  = 0
        self._start     = 0
        self._stop      = 0
        self._count     = 0
        self._finish    = 0
        self._final_count = 0 

    def reset(self):
        #self._max_skew  = 0
        self._start     = 0
        self._stop      = 0
        self._count     = 0
        self.finish     = 0
        self._final_count = 0 

    def update_count(self, start_signal, stop_signal, resync_signal):
        if(resync_signal):
            self.reset()
        elif stop_signal and start_signal: 
            self._final_count = self._count
            self._finish = 1
        elif start_signal and not stop_signal:
            self._start = 1
        elif start_signal and not self._finish
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
        self._start_counters = 0
        self._stop_lane_counter = [0]*nlanes
        self._stop_common_counter = 0
        self._skew_done = 0
        self._invalid_skew = 0

    def change_state(self, sol_signals, resync_signals, common_counter, max_skew):

        if self._state = "INIT":
            self._start_counters = 0
            self._stop_lane_counter = [0]*self._nlanes
            self._stop_common_counter = 0 
            self._skew_done = 0
            self._invalid_skew = 0 
        
            if(any(resync_signals)):            #<reduction or> of start_of_lane of all lanes
                self._state = "INIT"
            
            if(any(sol_signals)):               #<reduction or> of resync_signal of all lanes
                self._state = "COUNT"
                self._start_counters = 1
                self._stop_lane_counter = copy.copy(sol_signals)
            
        
        elif self._state = "COUNT":

            self._stop_lane_counter = [sum(x) for x in zip(self._stop_lane_counter,sol_signals)]        #xoring list element wise
            self._stop_common_counter = sum(self._stop_lane_counter) == self.nlanes                     #si todas las lineas pararon de contar, paro el contador comun

            if(common_counter >= max_skew):
                self._invalid_skew = 1
                self._state = 'INIT'

            else:
                if(any(resync_signals)):
                    self._state = "INIT"
                elif self._stop_common_counter
                    self._state = "DONE"

        elif self._state = "DONE":
            self._skew_done = 1







    