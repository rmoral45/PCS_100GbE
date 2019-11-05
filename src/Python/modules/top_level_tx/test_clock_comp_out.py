


def main():
        #lectura de salida del encoder
        with open('') as fd :
                enco_data = fd.read()
                enco_data = enco_data.split('\n')
                enco_data = list(filter(lambda x : x !=  bin(0x21e00000000000000)[2:].zfill(66), enco_data ))
                enco_data = list(map(lambda x : x = hex(int(x,2)), enco_data))
       #lectura salida de clock comp
        with open('') as fd :
                ccomp_data = fd.read()
                ccomp_data = ccomp_data.split('\n')
                ccomp_data = list(filter(lambda x : x != bin(0x21e00000000000000)[2:].zfill(66), ccomp_data ))
                ccomp_data = list(map(lambda x : x = hex(int(x,2)), ccomp_data))

        for i in range(200):
                print(" %s    %s" %(ccomp_data[i],enco_data[i]))
if __name__ == '__main__':
        main()
