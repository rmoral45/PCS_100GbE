import time
import serial

class UartManager(object):
    
    def __init__(self, port, baudrate):
        self.ser = serial.Serial(port=port,
                                 baudrate=baudrate,
                                 parity=serial.PARITY_NONE,
                                 stopbits=serial.STOPBITS_ONE,
                                 bytesize=serial.EIGHTBITS)
        self.ser.isOpen()
        self.ser.timeout=None
    
    def send(self, device, data):
        frame = []
        #header
        frame.append(0xA0)
        data_len = len(data)
        if(data_len>15):
            frame[0] |=   0x10
            frame.append((data_len & 0xFF00)>>8)
            frame.append(data_len & 0x00FF)
        else:   
            frame[0] |= data_len
            frame.append(0)
            frame.append(0)

        frame.append(device) #campo Device

        #data
        for d in data:
            frame.append(ord(d))

        #tail
        frame.append(frame[0])
        for f in frame:
            self.ser.write(chr(f))

    def receive(self):
        header_str = self.ser.read(4)
        header = map(ord, header_str)
        device = header[3]

        if not header[0] & 0x10:
            data_len = header[0] & 0x0F
        else:
            data_len = header[1]<<8 | header[2]
        
        data = self.ser.read(data_len)

        tail = ord(self.ser.read(1))
        if header[0] != tail:
            print "El mensaje contiene errores"
            return

        return device, data

    def close(self):
        self.ser.close()


