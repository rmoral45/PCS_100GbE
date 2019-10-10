from pdb import set_trace as bp

def main():
        n_verilog_idles = 0
        n_python_idles  = 0
        py_blocks   = []
        with open('./verilog.txt') as fd:
                veri_blocks = []
                contents = ''
                contents = fd.read()
                contents = contents.split('\n')
                for data in contents:
                        veri_blocks.append(data[:-1])
                veri_blocks = list(map(lambda x : int(x,2), veri_blocks))
                n_verilog_idles =len(list(filter(lambda x : x == 0x2e000000000000000, veri_blocks)))
                veri_blocks = list(filter(lambda x : x != 0x2e000000000000000, veri_blocks))
                veri_blocks = veri_blocks[2:]
                for i in range(len(veri_blocks)):
                        if veri_blocks[i] != i:
                                print("Error at index %i" %(i))

        with open('./tx_output_data_case_1.txt') as fd:
                py_blocks = []
                contents = ''
                contents = fd.read()
                contents = contents.split('\n')
                for data in contents:
                        py_blocks.append(''.join((data.split())))
                py_blocks = list(map(lambda x : int(x,2), py_blocks[:-1]))
                n_python_idles =len(list(filter(lambda x : x == 0x2e000000000000000, py_blocks)))
        bp()

if __name__ == '__main__':
        main()
