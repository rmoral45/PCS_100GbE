

import copy
import random
import clock_comp_tx as cctx
from pdb import set_trace as bp

NCLOCK    = 100
NLANES    = 20
AM_PERIOD = 16383
EXTRA_TIME = 32
CLOCK_VECT = [NLANES*AM_PERIOD*3, NLANES*2, NLANES*2, ((NLANES*2)+EXTRA_TIME), NLANES*3]

'''


        Agregar algun caso donde se pueda probar el correcto reset 



'''
TEST_CASE = 5
NCLOCK = CLOCK_VECT[TEST_CASE-1]
NCLOCK += EXTRA_TIME

def main():
        ccomp       = cctx.ClockCompTx(NLANES, AM_PERIOD)
        i_vect      = generate_input_vector()
        i_data      = 0
        o_data_vect = []
        o_tag_vect  = []
        o_data      = 0
        o_tag       = 0
        bp()
        for clock in range(NCLOCK) :
                print(clock)
                i_data          = i_vect[clock]
                (o_data, o_tag) = ccomp.run(i_data)
                o_data_vect.append(o_data)
                o_tag_vect.append(o_tag)

        do_test(o_data_vect,o_tag_vect)
        print ('#' * 75)
        print ('')
        print ('#'*30, " TEST_PASSED ", '#'*30)
        print ('')
        print ('#' * 75)

def do_test(dvect, tvect):
        idle_block = 0x1e000000000000000
        if TEST_CASE == 1 :
                print ("Caso 1 no implementado")

        elif TEST_CASE == 2 :
                for i in range(NLANES):
                        if dvect[i] != idle_block or tvect[i] != 1 :
                                print("Cantidad de idles o tags iniciales insuficintes")
                                bp()
                for i in range (NLANES,NLANES*2):
                        if dvect == idle_block or tvect == 1 :
                                print("Se insertaron idles o tags de mas")
                                bp()
        elif TEST_CASE == 3 :
                for i in range(NLANES):
                        if dvect[i] != idle_block or tvect[i] != 1 :
                                print("Cantidad de idles o tags iniciales insuficintes")
                                bp()
                for i in range(NLANES, len(dvect)):
                        if dvect == idle_block or tvect == 1 :
                                print("Se insertaron idles o tags de mas")
                                bp()
        elif TEST_CASE == 4 :
                for i in range(NLANES):
                        if dvect[i] != idle_block or tvect[i] != 1 :
                                print("Cantidad de idles o tags iniciales insuficintes")
                                bp()
                for i in range(NLANES, EXTRA_TIME):
                        if dvect[i] != idle_block:
                                print("Se eliminaron idles  de mas")
                                bp()
        elif TEST_CASE == 5 :
                for i in range(NLANES):
                        if dvect[i] != idle_block or tvect[i] != 1 :
                                print("Cantidad de idles o tags iniciales insuficintes")
                                bp()
                for i in range(NLANES, len(dvect)):
                        if dvect[i] == idle_block or tvect[i] == 1:
                                print("Se insertaron idlesde mas")
                                bp()

def generate_input_vector():

        idle_block = 0x1e000000000000000
        if TEST_CASE == 1:
                vect = [] #aca generar algun flujo aleatorio como el de la cgmii

        elif TEST_CASE == 2:
                if NLANES <= 2 :
                        raise ValueError('no es posible realizar este test para una cantidad de lineas menor a 2')
                n_idle = random.randint(1,NLANES-1)
                vect =  [random.randint(0,28674382) for y in range(NLANES)]
                vect += [copy.copy(idle_block)      for y in range(n_idle)]
                vect +=  [random.randint(0,28674382) for y in range(CLOCK_VECT[TEST_CASE-1] + EXTRA_TIME)]

        elif TEST_CASE == 3:
                vect =  [copy.copy(idle_block)      for y in range(NLANES)]
                vect += [random.randint(0,28347349) for y in range(NCLOCK - NLANES)]

        elif TEST_CASE == 4:
                vect =  [copy.copy(idle_block)      for y in range(NLANES+EXTRA_TIME)]
                vect += [random.randint(0,23435346) for y in range(EXTRA_TIME*2)]

        elif TEST_CASE == 5:

                if NLANES <= 2 :
                        raise ValueError('no es posible realizar este test para una cantidad de lineas menor a 3')
                n_idle = random.randint(1,NLANES-1)
                vect =  [copy.copy(idle_block)      for y in range(n_idle)]
                vect += [random.randint(0,23423523) for y in range(NCLOCK - n_idle)]

        return  vect


if __name__ == '__main__' :
        main()
