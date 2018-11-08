
import numpy
import random

def num_to_bin(number, nbits):
	binary = bin(number)
	binary = binary[2:].zfill(nbits)
	return binary

def cgmii_block_to_bin(block):

	DATA_NBYTES = 8
	DATA_BITS = 8
	CTRL_BITS = 8
	tx_ctrl = block['TXC']
	tx_data = block['TXD']
	ctrl_bin = (bin(tx_ctrl)[2:].zfill(CTRL_BITS))
	data_bin = ''
	for num in tx_data:
		data_bin += (bin(num)[2:].zfill(DATA_BITS))
	
	return data_bin, ctrl_bin

def encoder_block_to_bin(block):
	"""
	 los caracteres pcs los definimos de 8 bits xq sino era un bardo,hay que ver la forma de arreglarlo aca
	"""
	CODED_BLOCK_NBITS = 66
	tx_coded = []
	coded_bin  = ( bin(block['sh'])[2:].zfill(2) )
	coded_bin += ( bin(block['block_type'])[2:].zfill(8) )
	coded_bin += ( TB_ENCODER[block['block_name']] )['payload']
	return coded_bin

def random_comparator_IO():
	random_block_name = random.sample(TB_CGMII_TRANSMIT.keys(),1) #selecciono bloque random dentro de el dict

	tx_block = TB_CGMII_TRANSMIT[random_block_name] #saco el bloque del dict
	(data_bin,ctrl_bin) = cgmii_block_to_bin(tx_block) # obtengo el bin de TXD y TXC

	coded_block_name = 'CODED_' + random_block_name 

	coded_block = TB_ENCODER[coded_block_name] # busco el bloque codificado correspondiente al enviadp

	coded_bin = encoder_block_to_bin(coded_block)

	return (data_bin, ctrl_bin , coded_bin)




D0 = '00000000'
D1 = '00000001'
D2 = '00000010'
D3 = '00000011'
D4 = '00000100'
D5 = '00000101'
D6 = '00000110'
D7 = '00000111'
#pcs char

I_100G = '0000111'
E_100G = '0011110'
Z = '00'

# cgmi char

S       = '11111011' # 0xfb
T       = '11111101' # 0xfd
Q       = '10011100' # 0x9c
Fsig    = '01011100' # 0x5c
I_CGMII = '00000111' # 0x07
E_CGMII = '11111110' # 0xfe


TB_ENCODER = {

			'CODED_DATA_BLOCK' : {'block_name'   : 'CODED_DATA_BLOCK',
							'sh' 		   : 0x1  ,
							'block_type'   : D0   ,
							'payload' 	   : D1+D2+D3+D4+D5+D6+D7 
							} ,
			
			'CODED_START_BLOCK' : {'block_name'  : 'CODED_START_BLOCK',
							 'sh' 		   : 0x2  ,
							 'block_type'  : 0x78 ,
							 'payload' 	   : D1+D2+D3+D4+D5+D6+D7
							} ,

			'CODED_Q_ORD_BLOCK' : {'block_name'  : 'CODED_Q_ORD_BLOCK',
							 'sh' 		   : 0x2  ,
							 'block_type'  : 0x4B ,
							 'payload' 	   : D1+D2+D3+(16*Z)
							} ,

		 'CODED_Fsig_ORD_BLOCK' : {'block_name'  : 'CODED_Fsig_ORD_BLOCK',
	   						 'sh' 		   : 0x2  ,
							 'block_type'  : 0x4B ,
							 'payload' 	   : D1+D2+D3+'1111'+(14*Z)
							} ,

			'CODED_IDLE_BLOCK' : {'block_name'   : 'CODED_IDLE_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x1E ,
							'payload' 	   : (8*I_100G)
							} ,

			'CODED_ERROR_BLOCK' : {'block_name'  : 'CODED_ERROR_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x1E ,
							'payload' 	   : (8*E_100G)
							} ,

			'CODED_T0_BLOCK' 	  : {'block_name'  : 'CODED_T0_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x87 ,
							'payload' 	   : (7*'0')+(7*I_100G)
							} ,

			'CODED_T1_BLOCK' 	  : {'block_name'  : 'CODED_T1_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0x87 ,
							'payload' 	   : D0+(6*'0')+(6*I_100G)
							} ,

			'CODED_T2_BLOCK' 	  : {'block_name'  : 'CODED_T2_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xAA ,
							'payload' 	   : D0+D1+(5*'0')+(5*I_100G)
							} ,

			'CODED_T3_BLOCK' 	  : {'block_name'  : 'CODED_T3_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xB4 ,
							'payload' 	   : D0+D1+D2+(4*'0')+(4*I_100G)
							} ,

			'CODED_T4_BLOCK' 	  : {'block_name'  : 'CODED_T4_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xCC ,
							'payload' 	   : D0+D1+D2+D3+(3*'0')+(3*I_100G)
							} ,

			'CODED_T5_BLOCK' 	  : {'block_name'  : 'CODED_T5_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xD2 ,
							'payload' 	   : D0+D1+D2+D3+D4+(2*'0')+(2*I_100G)
							} ,

			'CODED_T6_BLOCK' 	  : {'block_name'  : 'CODED_T6_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xE1 ,
							'payload' 	   : D0+D1+D2+D3+D4+D5+'0'+I_100G
							} ,
							
			'CODED_T7_BLOCK' 	  : {'block_name'  : 'CODED_T7_BLOCK',
							'sh' 		   : 0x2  ,
							'block_type'   : 0xFF ,
							'payload' 	   : D0+D1+D2+D3+D4+D5+D6
							} 
		 }


TB_CGMII_TRANSMIT = { 
			
			'ERROR_BLOCK'		:{		'block_name'		: 'ERROR_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: E_CGMII+E_CGMII+E_CGMII+E_CGMII+E_CGMII+E_CGMII+E_CGMII+E_CGMII		
		    					},

		    'START_BLOCK':{ 			'block_name'		: 'START_BLOCK',
		    							'TXC'				: 0x80,
		    							'TXD'				: S+D1+D2+D3+D4+D5+D6+D7	
		    					},

		    'DATA_BLOCK':{ 				'block_name'		: 'DATA_BLOCK',
		    							'TXC'				: 0x00,
		    							'TXD'				: D0+D1+D2+D3+D4+D5+D6+D7	
		    					},

		    'Q_ORD_BLOCK':{ 			'block_name'		: 'Q_ORD_BLOCK',
		    							'TXC'				: 0x80,
		    							'TXD'				: Q+D1+D2+D3+Z+Z+Z+Z		
		    					},


		    'Fsig_ORD_BLOCK':{ 			'block_name'		: 'Fsig_ORD_BLOCK',
		    							'TXC'				: 0x80,
		    							'TXD'				: Fsig+D1+D2+D3+Z+Z+Z+Z 	
									},

			'IDLE_BLOCK':{ 				'block_name'		: 'IDLE_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: I_CGMII+I_CGMII+I_CGMII+I_CGMII+I_CGMII+I_CGMII+I_CGMII+I_CGMII		
								},					    

			'T0_BLOCK':{				'block_name'		: 'T0_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: T+I_CGMII+I_CGMII+I_CGMII+I_CGMII+I_CGMII+I_CGMII+I_CGMII		
							},

			'T1_BLOCK':{				'block_name'		: 'T1_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: D0+T+I_CGMII+I_CGMII+I_CGMII+I_CGMII+I_CGMII+I_CGMII		
							},

			'T2_BLOCK':{				'block_name'		: 'T2_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: D0+D1+T+I_CGMII+I_CGMII+I_CGMII+I_CGMII+I_CGMII		
							},

			'T3_BLOCK':{				'block_name'		: 'T3_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: D0+D1+D2+T+I_CGMII+I_CGMII+I_CGMII+I_CGMII		
							},

			'T4_BLOCK':{				'block_name'		: 'T4_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: D0+D1+D2+D3+T+I_CGMII+I_CGMII+I_CGMII		
							},

			'T5_BLOCK':{				'block_name'		: 'T5_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: D0+D1+D2+D3+D4+T+I_CGMII+I_CGMII	
							},

			'T6_BLOCK':{				'block_name'		: 'T6_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: D0+D1+D2+D3+D4+D5+T+I_CGMII		
							},

			'T7_BLOCK':{				'block_name'		: 'T7_BLOCK',
		    							'TXC'				: 0xFF,
		    							'TXD'				: D0+D1+D2+D3+D4+D5+D6+T		
							},
		   
	    	}