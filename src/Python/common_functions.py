from pdb import set_trace as bp
def list_to_hex(hex_list):
	"""Genera un numero a partir de una lista.
	
	Args:
		hex_list: lista de enteros de 8 bits
	Comentarios:
		Concatena los elementos de una lista de octetos para formar un unico numero equivalente,
		el numero resutante tiene al octeto de la posicion 0 de la lista
		como sus bits mas significativos
	"""
	result = 0x000000000
	counter = ( len(hex_list)-1 )
	for value in hex_list:
		result |= (value << (counter*8))
		counter-=1
	#return hex(result).rstrip('L')
	return result

def block_to_hex(block,block_format = 'list'):
	"""Genera un numero a partir de los valores en un diccionario.
	
	Args:
		block : bloque de datos
		block_format: indica de que forma esta representado el bloque de datos
			'list' : es una lista de octetos [D0,D1......D7], se concatenan todos los bytes de la lista 
			'encoder' : es un diccionario como el que utilizamos como salida del encoder{
				en este caso NO se concatena el sh																		'sh' (2bits)          : value
																						'block_type'(8 bits)  : value
																						'payload'(56 bits)    : value	 
																			   			}
			'scrambled' : es un diccionario como el de salida del scrambler :			{
				en este caso SI se cooncatena el sh																		 'sh' (2 bits)        : value
																						 'payload'(64 bits)	  : value
	
																						}																			   			
	Concatena los elementos de un bloque para formar un unico numero equivalente,
	con la forma {sh, block_type, payload}.
	"""
	if block_format == 'list' :
		hexnum = list_to_hex(block)

	elif block_format == 'encoder' :	
		hex_list = []
		hex_list.append(block['block_type'])
		hex_list+= block['payload']
		hexnum = list_to_hex(hex_list)
		
	elif block_format == 'scrambled' :
		hexnum = 0x000000000
		hexnum |= ( block['sh'] << 64)
		hexnum |= block['payload']
	
	return hexnum

	
def reverse_num(num,nbits):
	"""Invierte el orden de los bits de un numero
	
	Ejemplo:
		param: num = 225 = 0xE1 = 0b11100001 ; return: 135 = 0x87 = 0b10000111
	Comentario:
		esta funcion en necesaria por la manera en que el estandar define la  transmision de datos		
	"""
	num1 = num | (1<<nbits) #agrego bit para que no recorte ceros
	#sino cuando num=0x0f por ej da mal el resultado
	binary = bin(num1)
	reverse = binary[-1:1:-1]
	num2=int(reverse,2) & (0b111111110)#elimino bit agregado
	num2 = (num2 >> 1)
	return num2
def num_to_hex_list(block):
	PAYLOAD_NBYTES = 8
	byte_list = []
	for i in reversed(range(0,PAYLOAD_NBYTES)):
		byte = ( block['payload'] & (0xff << (8*i) ) ) >> (8*i)
		byte_list.append(byte)
	return byte_list 

def block_to_bit_stream(block):
	bit_stream = []
	sh_bit_0 = ( block['sh'] & (1<<1) ) >> 1
	sh_bit_1 = ( block['sh'] & 1 )
	bit_stream.insert(0,sh_bit_0)
	bit_stream.insert(0,sh_bit_1)

	payload = num_to_hex_list(block)
	for iter_byte in range(0,len(payload)):
		for iter_bit in range(0,8):
			byte = payload[iter_byte]
			bit = (byte & (1 << iter_bit)) >> iter_bit
			bit_stream.insert(0,bit)
	bit_stream = map(int,bit_stream)
	return bit_stream













