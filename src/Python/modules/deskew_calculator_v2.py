

class deskewCalculator(object):
    
    def __init__(self, nlanes):
        self._nlanes        = nlanes
        self._counters      = for(ss_counter for i in range(nlanes))
        self._stop_signals  = [0]*nlanes
        self._start_signal  = 0
        self._state         = "INIT"

    


class ss_counter(object):

    def __init__(self, MAX_SKEW):
        self._max_skew  = 0
        self._start     = 0
        self._stop      = 0
        self._count     = 0
        self._finish    = 0
        self._final_count = 0 

    def reset(self):
        self._max_skew  = 0
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


    