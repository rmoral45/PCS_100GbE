


class ClockCompRx(object):

        def __init__(self, nlanes, am_period):
                self.period_counter = 0
                self.idle_counter   = 0
                self.fifo           = [0]*(nlanes + 1)
                self.wr_ptr         = 0
                self.rd_ptr         = 0
                #self.PCS_IDLE       = 0x1e000000000000000
                self.PCS_IDLE       = 0
                self.N_LANES        = nlanes
                self.PERIOD         = nlanes * am_period


        def reset(self) :
                self.period_counter = 0
                self.idle_counter   = 0
                self.wr_ptr         = 0
                self.rd_ptr         = 0

        def run (self, i_data, i_sol, fsm_ctrl) :
                o_data = 'xxxxxxxxxxxxxxxx'
                o_tag  = 'x'
                self.fifo_write(i_data,i_sol)
                (o_data, o_tag) = self.fifo_read(fsm_ctrl)
                self.update_period()
                return (o_data,o_tag)

        def fifo_write(self, i_data, sol) :
                
                if sol :
                        self.idle_counter += 1
                else :
                        self.fifo[self.wr_ptr] = i_data
                        self.wr_ptr += 1
                        if self.wr_ptr >= len(self.fifo) :
                                self.wr_ptr = 0


        def fifo_read(self,  fsm_ctrl) :

                o_data = 'xxxxxxxxxxxxxxxx'
                o_tag  = 'xx'
                if (self.idle_counter < self.N_LANES) and fsm_ctrl :
                        o_data = self.PCS_IDLE
                        o_tag  = 1
                        return (o_data, o_tag)
                else :
                        o_data       = self.fifo[self.rd_ptr]
                        o_tag        = 0
                        self.rd_ptr += 1
                        if self.rd_ptr >= len(self.fifo) :
                                self.rd_ptr = 0
                        return (o_data, o_tag)

        def update_period(self):
                self.period_counter += 1
                if self.period_counter >= self.PERIOD :
                        self.period_counter = 0
                        self.idle_counter = 0


