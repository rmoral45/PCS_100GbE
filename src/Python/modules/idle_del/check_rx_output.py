from pdb import set_trace as bp

DUMP_DIR = './rx_test_dump/'
def main():
        n_verilog_idles = 0
        n_verilog_start = 0
        n_verilog_term  = 0
        n_python_idles  = 0
        n_python_start  = 0
        n_python_term   = 0
        with open(DUMP_DIR + 'verilog_output_data.txt') as fd:
                veri_blocks = []
                contents = ''
                contents = fd.read()
                contents = contents.split('\n')
                for data in contents:
                        veri_blocks.append(data)
                veri_blocks = list(map(lambda x : int(x,2), veri_blocks[:-1]))
                n_verilog_idles = len(list(filter(lambda x : x == 0x2e000000000000000, veri_blocks)))
                n_verilog_start = len(list(filter(lambda x : x == 0x27800000000000000, veri_blocks)))
                n_verilog_term  = len(list(filter(lambda x : x == 0x28700000000000000, veri_blocks)))

        with open(DUMP_DIR + 'rx_output_data.txt') as fd:
                py_blocks = []
                contents = ''
                contents = fd.read()
                contents = contents.split('\n')
                for data in contents:
                        py_blocks.append(''.join((data.split())))
                py_blocks = list(map(lambda x : int(x,2), py_blocks[:-1]))
                n_python_idles = len(list(filter(lambda x : x == 0x2e000000000000000, py_blocks)))
                n_python_start = len(list(filter(lambda x : x == 0x27800000000000000, py_blocks)))
                n_python_term  = len(list(filter(lambda x : x == 0x28700000000000000, py_blocks)))

        print("verilog idle  block : %d" %(n_verilog_idles))
        print("verilog start block : %d" %(n_verilog_start))
        print("verilog term  block : %d" %(n_verilog_term))
        print
        print("python  idle  block : %d" %(n_python_idles))
        print("python  start block : %d" %(n_python_start))
        print("python  term  block : %d" %(n_python_term))
        bp()

if __name__ == '__main__':
        main()
