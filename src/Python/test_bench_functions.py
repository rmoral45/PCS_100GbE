
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

def num_to_bin(number, nbits):
	binary = bin(number)
	binary = binary[2:].zfill(nbits)
	return binary

def cgmii_block_to_bin(block):

	DATA_NBYTES = 8
	DATA_BITS = 64
	CTRL_BITS = 8
	tx_ctrl = block['TXC']
	tx_data = block['TXD']
	ctrl_bin = (bin(tx_ctrl)[2:0].zfill(CTRL_BITS))
	data_bin = ''
	for num in tx_data:
		data_bin += (bin(num)[2:0].zfill(DATA_BITS))
	
	return data_bin, ctrl_bin

def encoder_block_to_bin(block):
	"""
	 los caracteres pcs los definimos de 8 bits xq sino era un bardo,hay que ver la forma de arreglarlo aca
	"""
	CODED_BLOCK_NBITS = 66
	tx_coded = []
	tx_coded[len(tx_coded):] = block['payload']
	coded_bin  = ( bin(block['sh'])[2:].zfill(2) )
	coded_bin += ( bin(block['block_type'])[2:]zfill(8) )
	for num in tx_coded:
		coded_bin += (bin(num)[2:0].zfill(7))  

	return coded_bin








TB_ENCODER = {

			'CODED_DATA_BLOCK' : {'block_name'   : 'CODED_DATA_BLOCK',
							'sh' 		   : 0x1  ,
							'block_type'   : D0   ,
							'payload' 	   : [D1, D2, D3, D4, D5, D6, D7] 
							} ,
			
			'CODED_START_BLOCK' : {'block_name'  : 'CODED_START_BLOCK',
							 'sh' 		   : 0x2  ,
							 'block_type'  : 0x78 ,
							 'payload' 	   : [D1, D2, D3, D4, D5, D6, D7]
							} ,

			'CODED_Q_ORD_BLOCK' : {'block_name'  : 'CODED_Q_ORD_BLOCK',
							 'sh' 		   : 0x2  ,
							 'block_type'  : 0x4B ,
							 'payload' 	   : [D1, D2, D3, Z, Z, Z, Z]
							} ,

		 'CODED_Fsig_ORD_BLOCK' : {'block_name'  : 'CODED_Fsig_ORD_BLOCK',
	   						 'sh' 		   : 0x2  ,
							 'block_type'  : 0x4B ,
							 'payload' 	   : [D1, D2, D3, 0XF0, Z, Z, Z]
							} ,

			'CODED_IDLE_BLOCK' : {'block_name'   : 'CODED_IDLE_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x1E ,
							'payload' 	   : [I_100G,I_100G,I_100G,I_100G,I_100G,I_100G,I_100G,I_100G]
							} ,

			'CODED_ERROR_BLOCK' : {'block_name'  : 'CODED_ERROR_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x1E ,
							'payload' 	   : [E_100G,E_100G,E_100G,E_100G,E_100G,E_100G,E_100G,E_100G]
							} ,

			'CODED_T0_BLOCK' 	  : {'block_name'  : 'CODED_T0_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x87 ,
							'payload' 	   : [I_100G,I_100G,I_100G,I_100G,I_100G,I_100G,I_100G]
							} ,

			'CODED_T1_BLOCK' 	  : {'block_name'  : 'CODED_T1_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x87 ,
							'payload' 	   : [D0,I_100G,I_100G,I_100G,I_100G,I_100G,I_100G]
							} ,

			'CODED_T2_BLOCK' 	  : {'block_name'  : 'CODED_T2_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xAA ,
							'payload' 	   : [D0,D1,I_100G,I_100G,I_100G,I_100G,I_100G]
							} ,

			'CODED_T3_BLOCK' 	  : {'block_name'  : 'CODED_T3_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xB4 ,
							'payload' 	   : [D0,D1,D2,I_100G,I_100G,I_100G,I_100G]
							} ,

			'CODED_T4_BLOCK' 	  : {'block_name'  : 'CODED_T4_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xCC ,
							'payload' 	   : [D0,D1,D2,D3,I_100G,I_100G,I_100G]
							} ,

			'CODED_T5_BLOCK' 	  : {'block_name'  : 'CODED_T5_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xD2 ,
							'payload' 	   : [D0, D1, D2, D3, D4, I_100G, I_100G]
							} ,

			'CODED_T6_BLOCK' 	  : {'block_name'  : 'CODED_T6_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xE1 ,
							'payload' 	   : [D0, D1, D2, D3, D4, D5, I_100G]
							} ,
							
			'CODED_T7_BLOCK' 	  : {'block_name'  : 'CODED_T7_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xFF ,
							'payload' 	   : [D0, D1, D2, D3, D4, D5, D6]
							} 
		 }