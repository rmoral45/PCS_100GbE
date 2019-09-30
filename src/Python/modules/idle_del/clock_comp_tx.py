



class ClockCompTx(object):

        def __init__(self, nlanes, am_period):
                self.period_counter = 0
                self.idle_counter   = 0
                self.fifo           = [0]*(nlanes + 1)
                self.wr_ptr         = 0
                self.rd_ptr         = 0
                self.PCS_IDLE       = 0x1e000000000000000
                self.N_LANES        = nlanes
                self.PERIOD         = nlanes * am_period

        def reset(self) :
                self.period_counter = 0
                self.idle_counter   = 0
                self.wr_ptr         = 0
                self.rd_ptr         = 0

        def run(self, i_data):
                o_data = 'xxxxxxxxxxxxxxx'
                o_tag  = 'x'

                self.fifo_write(i_data)
                (o_data,o_tag) = self.fifo_read()
                self.update_period()
                return (o_data, o_tag)

        def fifo_write(self, i_data):

                if i_data == self.PCS_IDLE and \
                    self.idle_counter < self.N_LANES :
                        self.idle_counter += 1
                else :
                        self.fifo[self.wr_ptr] = i_data
                        self.wr_ptr+= 1
                        if (self.wr_ptr >= len(self.fifo)):
                                self.wr_ptr = 0
                        
        
        def fifo_read(self) :
                o_data = 0
                o_tag  = 0
                if self.period_counter < self.N_LANES: #Insercion de Idle
                        o_data = self.PCS_IDLE
                        o_tag  = 1
                        return (o_data, o_tag) 
                else :
                        o_data = self.fifo[self.rd_ptr]
                        o_tag  = 0
                        self.rd_ptr += 1
                        if (self.rd_ptr >= len(self.fifo)) :
                                self.rd_ptr = 0
                        return (o_data, o_tag)

        def update_period(self) :
                self.period_counter += 1
                if self.period_counter >= self.PERIOD :
                        self.period_counter = 0
                        self.idle_counter   = 0

        def pvar(self) :
                padding = 11
                print ("IDLE COUNTER   : ", self.idle_counter)
                print ("PERIOD COUNTER : " , self.period_counter)
                for i in self.fifo :
                        #f"{value:#0{padding}x}"
                        print ("{i:#0{padding}x}")
                        #print ("{0:#0{1}x}".format(i,11))

