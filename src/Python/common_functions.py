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

def block_to_hex(block):
	"""Genera un numero a partir de los valores en un diccionario.

	Concatena los elementos de un bloque para formar un unico numero equivalente,
	con la forma {sh, block_type, payload}.
	"""
	hex_list = []
	hex_list.append(block['block_type'])
	hex_list+= block['payload']
	hexnum = list_to_hex(hex_list)
	return hexnum	