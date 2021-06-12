#!/usr/bin/python3

basic_reg_syntax = (' CASENAME :                    \n' + \
                    ' begin                         \n' + \
                    '     rf_o_data_d <= REGNAME    \n' + \
                    ' end                           \n' 
                  )



with open('rf_address.h') as f:
    raw_file = f.readlines()
    register_always = []
    #print(raw_file.replace('\n'))
    for index, token in enumerate(raw_file) :
        if not ('_I_' in token) :
            raw_file[index] = raw_file[index].replace('#define', '')
            raw_file[index] = raw_file[index].replace(' ', '')
            raw_file[index] = raw_file[index].replace('\n', '')
            block = basic_reg_syntax.replace('REGNAME', raw_file[index].lower())
            block = block.replace('CASENAME', raw_file[index])
            register_always.append(block)
        
    for i in register_always :
        print(i)

