#!/usr/bin/python3

with open('reg_addr_decl.v') as f:
    init_addr = 1;
    raw_file = f.readlines()
    register_always = []
    #print(raw_file.replace('\n'))
    for index, token in enumerate(raw_file) :
        block = raw_file[index].replace('\n',  ' ')
        block = block[0:-7] + '=' + block[-7:-1] 
        register_always.append(block)
        
    for i in register_always :
        print(i)

