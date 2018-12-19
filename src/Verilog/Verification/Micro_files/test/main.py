from os import system
from time import sleep
import binascii
from pdb import set_trace as bp
import copy

import matplotlib.pyplot as plt

from uart_manager import UartManager
#from tool._fixedInt import *

def clear(ack):
    system('clear')
    print ack
    print "--------------------------"


def decod_ber(ber):
    bit_error_re = ber[0:8][::-1]
    bit_count_re = ber[8:16][::-1]
    bit_error_im = ber[16:24][::-1]
    bit_count_im = ber[24:32][::-1]
    bit_error_re = int(binascii.hexlify(bit_error_re), 16)
    bit_count_re = int(binascii.hexlify(bit_count_re), 16)
    bit_error_im = int(binascii.hexlify(bit_error_im), 16)
    bit_count_im = int(binascii.hexlify(bit_count_im), 16)
    return bit_error_re, bit_count_re, bit_error_im, bit_count_im

def new_fixed_int(value, intwidth, fracwidth):
    fi = DeFixedInt(intwidth, fracwidth)
    fi.value = value
    return fi

def unsigned_to_signed(unsigned):
    signed = unsigned - 256 if unsigned > 127 else unsigned
    return signed

def decod_log(str_log):
    str_log = str_log[::-1]
    log_list = []
    for i in range(0,len(str_log),4):
        log_list.append(str_log[i:i+4])   
    tx_re = [ord(l[0]) for l in log_list]
    tx_im = [ord(l[1]) for l in log_list]
    rx_re = [ord(l[2]) for l in log_list]
    rx_im = [ord(l[3]) for l in log_list]
    tx_re = map(unsigned_to_signed, tx_re)
    tx_im = map(unsigned_to_signed, tx_im)
    rx_re = map(unsigned_to_signed, rx_re)
    rx_im = map(unsigned_to_signed, rx_im)
    tx_re = [new_fixed_int(v, 8, 7).fValue for v in tx_re]
    tx_im = [new_fixed_int(v, 8, 7).fValue for v in tx_im]
    rx_re = [new_fixed_int(v, 8, 7).fValue for v in rx_re]
    rx_im = [new_fixed_int(v, 8, 7).fValue for v in rx_im]
    return tx_re, tx_im, rx_re, rx_im
        
    
    

def main():
    data_vect    = [[] for y in range(1024)]
    reorder_vect = [[] for y in range(1024)]
    main_menu  =   "reset             - 1 \n"\
                 + "enable/disable    - 2 \n"\
                 + "set phase         - 3 \n"\
                 + "read ber          - 4 \n"\
                 + "read tx/rx log    - 5 \n"\
                 + "Input: "
    enable_disable_menu =  "Enable Tx    - 1\n"\
                         + "Enable Rx    - 2\n"\
                         + "Enable BER   - 3\n"\
                         + "Enable ALL   - 4\n"\
                         + "Disable Tx   - 5\n"\
                         + "Disable Rx   - 6\n"\
                         + "Disable BER  - 7\n"\
                         + "Disable ALL  - 8\n"\
                         + "Input: "
    set_phase_menu = 'Seleccione fase: 0-1-2-3:\n'\
                    +'Input: '

    main_menu_choices = map(str, range(1,6))
    enable_disable_menu_choices = map(str, range(1,9))
    set_phase_menu_choices = map(str,range(4))

    
    uart = UartManager('/dev/ttyUSB1', 115200)
    

    ack = ''
    while(True):
        inp = -1
        while inp not in main_menu_choices:
            clear(ack); ack=''
            inp = raw_input(main_menu)

        #reset
        if inp == '1':
            uart.send(0,'')
            ack = uart.receive()[1]

        #enable/disable menu
        elif inp == '2':
            inp = -1
            while inp not in enable_disable_menu_choices:
                clear(ack); ack=''
                inp = raw_input(enable_disable_menu)
            uart.send(int(inp), '')
            ack = uart.receive()[1]

        #set phase
        elif inp == '3':
            inp = -1
            while inp not in set_phase_menu_choices:
                clear(ack); ack=''
                inp = raw_input(set_phase_menu)
            uart.send(9, chr(int(inp)))
            ack = uart.receive()[1]

        #read ber
        elif inp == '4':
            uart.send(10,'')
            ber = uart.receive()[1]
            bit_error_re, bit_count_re,\
            bit_error_im, bit_count_im = decod_ber(ber)
            clear('')
            print 'ERROR RE: %e'%bit_error_re
            print 'COUNT RE: %e'%bit_count_re
            print 'ERROR IM: %e'%bit_error_im
            print 'COUNT IM: %e'%bit_count_im
            raw_input("Press Enter to continue")

        #read tx/rx log
        elif inp == '5':
            uart.send(11, '')
            for i in range(1023):
                log = uart.receive()[1]
                for j in range(8):
                    data_vect[i].insert( 0, ord(log[j]) )
                reorder_vect[i][:] = copy.deepcopy(data_vect[i][::1])
                reorder_vect[i]    = map(bin,reorder_vect[i])
            #format
            for i in range(1023):
                for j in range(8):
                    reorder_vect[i][j] =reorder_vect[i][j][2:].zfill(8)

            #file write
            enco_output_data_file  = open("micro-output-data.txt" ,"w")

            for i in range(1023):
                bin_micro_data = ''.join(reorder_vect[i])
                enco_output_data_file.write(bin_micro_data + '\n')



            raw_input("Press Enter to continue")
            
            

if __name__ == '__main__':
    main()
