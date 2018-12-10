import time
import serial

ser=serial.serial_for_url('loop://', timeout=1)
ser.isOpen()
ser.timeout=5
ser.flushInput()
ser.flushOutput()
print(ser.timeout)

leds = [0,1,2,3]
colors = ['R', 'G', 'B']

while True :
    print 'Ingrese un comando, indicando W/R para leer/escribir y exit para salir \n'	#si leemos, el 8vo bit de device va en 1, de lo contrario en 0
    frame = []
    chrframe = []
    which_leds = []
    data_size = 0
    action = raw_input(">> ")
    if action == 'exit':
        ser.close()
        print 'Comunicacion finalizada por el usuario.'
        exit()
    elif:
        #-----------envio--------------------------------
        #bits fijos de trama
        frame.append(0xA0)
        #Siempre enviaremos y recibiremos tramas cortas.
        frame[0] |= 0x10
        #Indicamos el tamanio de la trama
        data_size =(len(input) & 0x0F)
        frame[0] |= data_size
        #agrego L.HIGH y L.LOW
        frame.append(0x00)			#L.Size(High)			
        frame.append(0x00)			#L.Size(High)
        frame.append(0x00)			#device	
        frame.append(0x00)			#data

        if(action == 'W'):
   	    	print 'Desea prender o apagar los leds? (P/A)'			
        	onoff = raw_input(">> ")
        		if(onoff == 'P'):
        			frame[4] |= (0x80)								#Si prendo, en el 8vo bit de data va un 1
        			print 'Que LEDs desea prender? (0, 1, 2 o 3, 4 para salir)'
        			on = raw_input(">>")
        			if( on not in leds || on == '4'):
        				break
        			elsQe:
        				frame[3] |= (1 << int(on))
        		elif(onoff == 'A'):									#Si apago, en el 8vo bit de data va un 0
        			print 'Que LEDs desea apagar? (0, 1, 2 o 3, 4 para salir)'
        			off = raw_input(">> ")
        			if( off not in leds || off == '4'):
	        			break
    	    		else:
        				frame[3] |= (0 << int(off))
        		else:
        			break

	        print 'De que color desea prender los LEDS? (R-G-B)'	#En los 3 primeros bits menos significativos de data va la info del color. Bit0=R, Bit1=G, Bit2=B
    	    color = raw_input(">> ")
        	if (color not in colors):
        		print 'Color ingresado invalido, por defecto se prenderan en Rojo'
        		frame[4] |= 0x01
			elif (color == 'R'):
				frame[4] |= 0x01
			elif (color == 'G'):
				frame[4] |= 0x02
			else (color == 'B'):
				frame[4] |= 0x03


		else:
   	    	print 'Se leera el estado de todos los switchs'
   	    	frame[3] = 0x87
   	    	
        #agrego fin de trama    
        frame.append(0x40)
        frame[-1] |= (frame[0] & 0x1F )
        #Transformo a chr
        for element in range(len(frame)):
        	chrframe = chr(frame[element])
		
		#Escribo el puerto para transmision
        ser.write(chrframe)
                    
    #-----------------recepcion-------------------------
        #leo los primeros 4 bytes(cabecera)
        header = ser.read(4) 
        header = map(ord,header)
        print "cabecera",header
        data_size = (header[0] & 0x0F)
        #leo datos
        recv = ser.read(data_size)
        if len(recv) != data_size:
            print "se recibieron menos datos"
        frame_end = ord(ser.read(1))
        if (frame_end & 0x1F) != (header[0] & 0x1F):
            print 'Error de recepcion \n'
        if recv == 'calculadora' :
            print "ejecuto calculadora"
            calc()
        elif recv == 'graficar':
            print "ejecuto graficar"   

    else:
        print 'Comando invalido, intente nuevamente \n'