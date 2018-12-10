import time
import serial


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

print 'Ingrese un comando:[1,2,3]\r\n'

while 1 :
    input = raw_input("<< ")
    if input == 'exit':
        ser.close()
        exit()
    elif(input == '3'):
        print "Wait Input Data"
        ser.write(input)
        time.sleep(2)
        out = ord(ser.read(1))
        print(ser.inWaiting())
        if out != '':
            print ">>" + str(out)
    else:
        ser.write(input)
        time.sleep(1)
