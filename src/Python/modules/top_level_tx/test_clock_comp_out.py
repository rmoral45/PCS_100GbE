
from pdb import set_trace as bp

period = 8000*6
def main():
        #lectura de salida del encoder
        with open('/media/data/PPS/src/Verilog/Simulation Sources/tb_toplevel_tx/encoder_output.txt') as fd :
                enco_data = fd.read()
                enco_data = enco_data.split('\n')
                #bp()
                enco_idle = list(filter(lambda x : x ==  bin(0x21e00000000000000)[2:].zfill(66), enco_data[:period] ))
                enco_data = list(filter(lambda x : x !=  bin(0x21e00000000000000)[2:].zfill(66), enco_data ))
                #print(enco_data[441])
                #for i in range(len(enco_data)):
                #        print(i)
                #        hex(int(enco_data[i],2))
                        
                enco_data = list(map(lambda x : hex(int(x,2)), enco_data))
       #lectura salida de clock comp
        with open('/media/data/PPS/src/Verilog/Simulation Sources/tb_toplevel_tx/clockComp_output.txt') as fd :
                ccomp_data = fd.read()
                ccomp_data = ccomp_data.split('\n')
                #bp()
                ccomp_idle = list(filter(lambda x : x == bin(0x21e00000000000000)[2:].zfill(66), ccomp_data[:period] ))
                ccomp_data = list(filter(lambda x : x != bin(0x21e00000000000000)[2:].zfill(66), ccomp_data ))
                ccomp_data = list(map(lambda x : hex(int(x,2)), ccomp_data))

        

        for i in range(len(enco_data)-3):
        #for i in range(2*10):
                #print(" %s    %s" %(ccomp_data[i],enco_data[i]))
                if(ccomp_data[i] != enco_data[i]):
                        print (i)
                        print ("ccomp    ", ccomp_data[i])
                        print ("enco     ", enco_data[i])
                        bp()
        
        print ("idle enco ", len(enco_idle))
        print ("idle ccomp", len(ccomp_idle))


if __name__ == '__main__':
        main()
