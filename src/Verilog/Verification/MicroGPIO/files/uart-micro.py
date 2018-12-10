import time
import serial
from pdb import set_trace as bp

FRAME_RESP_SIZE = 5

ser = serial.Serial(
    port='/dev/ttyUSB1',	#Configurar con el puerto
    baudrate=115200,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE,
    bytesize=serial.EIGHTBITS
)

ser.isOpen()
ser.timeout=None
print(ser.timeout)

valid_leds = [0,1,2,3]
valid_colors = [0,1,2]
frame = []
resp = []
def main():
    while 1 :
        frame = []
        resp = []
        print 'Ingrese operacion que desea realizar:\n'
        print ' 1 apagar leds\n'
        print ' 2 encender leds\n'
        print ' 3 leer switches\n'
        print ' 4 salir\n'
    
        input = raw_input("<< ")
        input = int(input)
    
        frame.append(0xB0) #por ahora siempre va a ser trama corta
        frame.append(0x00)
        frame.append(0x00)
        frame.append(0x00) #este es device
        if input == 4:
            ser.close()
            exit()
        elif(input == 1):

            while 1:
                print "Ingrese el numero de led que desea apagar 0/1/2/3 o 5"
                selected = raw_input("<< ")
                selected = int(selected)
                if selected not in valid_leds:
                    break
                else :
                    frame[3] |=  (1 << selected)
            frame.append(frame[0]) #agrego fin de trama

        elif(input == 2):
            frame[3] |= (1<<7) #bit que indica encendido
            while 1:
                print "Ingrese el numero de led que desea encender 0/1/2/3 o 5 para salir"
                selected = raw_input("<< ")
                selected = int(selected)
                if selected not in valid_leds:
                    print "no es un led valido"
                    break
                else :
                    frame[3] |= (1<<selected)
                    frame.append(0x00)#agrego un byte de data
                    frame[0] = frame[0] + 0x01 #indico que agrego el byte de datos
                    while 1 :
                        print "Ingrese el color que desea poner en dicho led\n"
                        print "0 : azul \n"
                        print "1 : verde \n"
                        print "2 : rojo\n"
                        print "5 : si no desea agregar mas colores\n"
                        color = raw_input("<< ")
                        color = int(color)
                        if color not in valid_colors:
                            break
                        else:
                            frame[-1] |= (1<<color)    
          #  frame.append(frame[0]) #agrego fin de trama                    
        else :
            #por ahora no hago mas nada si tengo que leer los switch 
           # frame.append(frame[0]) #agrego fin de trama  
           print 'afasfafasf'

        bp()
        frame = map(chr,frame)
        ser.write( frame[0:4] )
        time.sleep(1)    
    '''    
    for i in range(0,FRAME_RESP_SIZE): #revisar cuantos datos envia el prog del micro
        out = ord(ser.read(1))
        resp.append(ord)    #revisar si uso ord o que mierda
        print(ser.inWaiting()) #esto para que?
    if resp[4] != '':
        print ">>" + str(out)
    '''  
if __name__ == '__main__':
        main()       