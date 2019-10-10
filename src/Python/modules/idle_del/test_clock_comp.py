

import copy
import random
import clock_comp_tx as cctx
from pdb import set_trace as bp
NB_DATA    = 66
NCLOCK     = 100
NLANES     = 20
AM_PERIOD  = 60
EXTRA_TIME = 32
CLOCK_VECT = [NLANES*AM_PERIOD*3, NLANES*2, NLANES*2, ((NLANES*2)+EXTRA_TIME), NLANES*3]

'''
        Agregar algun caso donde se pueda probar el correcto reset 

'''
'''
Programa para hacer el testing del modulo de insecion/eliminacion de idles
	Casos  de prueba:
		1)flujo 'normal' de datos de cgmii
			pass : cada NLANES*NBLOCKS debe haber 20 idles iniciales
					la cant de idles generada por la cgmii debe ser igual 
					a la cant que sale del modulo de idle_delete (no se insertaron de mas ni sacaron de menos)
		2)no se recibe ningun idle desde cgmii hasta al menos clock > NLANES
			pass : debe haber 20 idles inicales y ninguno al menos hasta NLANES*2 bloques
		3)se reciben todos idle mientras 0 < clock < NLANES y ninguno clock >= NLANE
			pass : la entrada al encoder debe contene SOLO 20 idles iniciales consecutivos
		4)se reciben todos idle mientras 0 < clock < NLANES + M
			pass : la entrada al encoder debe tener NLANES + M idles
		5) se reciben M ( < NLANES ) idles mientras clock < 20
			pass : la entrada al encoder debe tener solo NLANES idles
'''
TEST_CASE = 1
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
        for clock in range(NCLOCK) :
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
        print ('')
        print('#'*25, 'writing log files...' , '#'*25)
        test_case = 'case_' + str(TEST_CASE) + '.txt'
        with open('tx_input_data_' + test_case, 'w') as fd:
                for block in i_vect:
                        dtw = bin(block)[2:].zfill(NB_DATA)
                        dtw = " ".join(dtw)
                        dtw = dtw + '\n'
                        fd.write(dtw)         
        with open('tx_output_data_' + test_case, 'w') as fd:
                for block in o_data_vect:
                        dtw = bin(block)[2:].zfill(NB_DATA)
                        dtw = " ".join(dtw)
                        dtw = dtw + '\n'
                        fd.write(dtw)         
        with open('tx_output_tag_' + test_case, 'w') as fd:
                for tag in o_tag_vect:
                        fd.write(bin(tag)[2:] + '\n')         

class TestFailed(Exception):
        pass

def do_test(dvect, tvect):
        idle_block = 0x1e000000000000000
        if TEST_CASE == 1 :
                print ("Caso 1 no implementado")

        elif TEST_CASE == 2 :
                for i in range(NLANES):
                        if dvect[i] != idle_block or tvect[i] != 1 :
                                raise TestFailed("Cant de idlesso tags iniciales insuficientes")

                for i in range (NLANES,NLANES*2):
                        if dvect == idle_block or tvect == 1 :
                                raise TestFailed("se insertaron idles o tags de mas")

        elif TEST_CASE == 3 :
                for i in range(NLANES):
                        if dvect[i] != idle_block or tvect[i] != 1 :
                                raise TestFailed("Cant de idles o tags iniciales insuficientes")
                for i in range(NLANES, len(dvect)):
                        if dvect == idle_block or tvect == 1 :
                                raise TestFailed("se insertaron idles o tags de mas")

        elif TEST_CASE == 4 :
                for i in range(NLANES):
                        if dvect[i] != idle_block or tvect[i] != 1 :
                                raise TestFailed("Cant de idlesso tags iniciales insuficientes")
                for i in range(NLANES, EXTRA_TIME):
                        if dvect[i] != idle_block:
                                raise TestFailed("se eliminaton idles de mas")
        elif TEST_CASE == 5 :
                for i in range(NLANES):
                        if dvect[i] != idle_block or tvect[i] != 1 :
                                raise TestFailed("Canti de idles o tags insuficientes")
                for i in range(NLANES, len(dvect)):
                        if dvect[i] == idle_block or tvect[i] == 1:
                                raise TestFailed("se insertaron idles de mas")

def generate_input_vector():

        idle_block = 0x2e000000000000000
        err_block  = 0x2eeeeeeeeeeeeeeee
        if TEST_CASE == 1:
                vect = [] #aca generar algun flujo aleatorio como el de la cgmii
                vect += [err_block]
                vect += [copy.copy(idle_block) for y in range(45)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(100))
                vect += [copy.copy(idle_block) for y in range(27)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(100,178))
                vect += [copy.copy(idle_block) for y in range(72)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(178,325))
                vect += [copy.copy(idle_block) for y in range(15)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(325,732))
                vect += [copy.copy(idle_block) for y in range(10)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(732,810))
                vect += [copy.copy(idle_block) for y in range(42)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(810,875))
                vect += [copy.copy(idle_block) for y in range(9)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(875,920))
                vect += [copy.copy(idle_block) for y in range(55)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(920,980))
                vect += [copy.copy(idle_block) for y in range(20)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(980,1025))
                vect += [copy.copy(idle_block) for y in range(23)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(1025,1325))
                vect += [copy.copy(idle_block) for y in range(65)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(1325,1400))
                vect += [copy.copy(idle_block) for y in range(33)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(1400,1460))
                vect += [copy.copy(idle_block) for y in range(78)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(1460,2025))
                vect += [copy.copy(idle_block) for y in range(27)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(2025,2055))
                vect += [copy.copy(idle_block) for y in range(15)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(2055,2200))
                vect += [copy.copy(idle_block) for y in range(65)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(2200,2300))
                vect += [copy.copy(idle_block) for y in range(65)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(2300,2350))
                vect += [copy.copy(idle_block) for y in range(21)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(2350,2450))
                vect += [copy.copy(idle_block) for y in range(450)] #[FIX] hacer esto parametrizando n_idle
                vect += list(range(2450,2850))
                

        elif TEST_CASE == 2:
                if NLANES <= 2 :
                        raise ValueError('no es posible realizar este test para una cantidad de lineas menor a 2')
                n_idle = random.randint(1,NLANES-1)
                #vect =  [random.randint(0,28674382) for y in range(NLANES)]
                vect =  list(range(NLANES))
                vect += [copy.copy(idle_block)      for y in range(25)] #[FIX] hacer esto parametrizando n_idle
                #vect +=  [random.randint(0,28674382) for y in range(CLOCK_VECT[TEST_CASE-1] + EXTRA_TIME)]
                vect +=  list(range(NLANES,CLOCK_VECT[TEST_CASE-1] + EXTRA_TIME))

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
