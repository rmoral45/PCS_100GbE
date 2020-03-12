############## NUMBER OF BITS FOR PARAM ###############
NB_DATA	  = 20
NB_ADDR   = 5
#MEM_DEPTH = 2**NB_ADDR*10
MEM_DEPTH = 1000


############## CGMII CHARACTERS########################
 
D0 = 0x00 # 'p'
D1 = 0x01 # 'h'
D2 = 0x02 # 'y'
D3 = 0x03 # 's'
D4 = 0x04 # 'i'
D5 = 0x05 # 'c'
D6 = 0x06 # 'a'
D7 = 0x07 # 'l'

S = 0xFB
T = 0xFD
I_CGMII = 0x07
Q = 0x9C
Fsig = 0x5C
Z = 0x00
E_CGMII = 0xFE
############## 100GBE CHARACTERS ######################

I_100G = 0x00
E_100G = 0x1E

#######################################################


############ RAW_BLOCKS ################################

DATA_BLOCK = [0x00, D0, D1, D2, D3, D4, D5, D6, D7] 

START_BLOCK = [0x80, S, D1, D2, D3, D4, D5, D6, D7]

Q_ORD_BLOCK = [0x80, Q, D1, D2, D3, Z, Z, Z, Z]
 
Fsig_ORD_BLOCK = [0x80, Fsig, D1, D2, D3, Z, Z, Z, Z]
 
IDLE_BLOCK = [0xFF, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]
 
T0_BLOCK = [0xFF, T, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]

T1_BLOCK = [0xFF, D0, T, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]

T2_BLOCK = [0xFF, D0, D1, T, I_CGMII, I_CGMII, I_CGMII, I_CGMII, I_CGMII]

T3_BLOCK = [0xFF, D0, D1, D2, T, I_CGMII, I_CGMII, I_CGMII, I_CGMII]

T4_BLOCK = [0xFF, D0, D1, D2, D3,T, I_CGMII, I_CGMII, I_CGMII]

T5_BLOCK = [0xFF, D0, D1, D2, D3, D4, T, I_CGMII, I_CGMII]

T6_BLOCK = [0xFF, D0, D1, D2, D3, D4, D5, T, I_CGMII]

T7_BLOCK = [0xFF, D0, D1, D2, D3, D4, D5, D6, T]

##################### CODED BLOCKS ############################

# cuidado!! esta codificacion es lo mas parecida posible a la que debemos implementar pero
# no es exactamente igual 

CODED_DATA_BLOCK = [0x01, D0, D1, D2, D3, D4, D5, D6, D7] 

CODED_START_BLOCK = [0x02,0x78, D1, D2, D3, D4, D5, D6, D7]

CODED_Q_ORD_BLOCK = [0x02,0x4B, D1, D2, D3, Z, Z, Z, Z]
 
CODED_Fsig_ORD_BLOCK = [0x02,0x4B, D1, D2, D3, 0XF0, Z, Z, Z]
 
CODED_IDLE_BLOCK = [0x02,0x1E, I_100G, I_100G, I_100G, I_100G, I_100G, I_100G, I_100G] 

CODED_ERROR_BLOCK = [0x02,0x1E, E_100G, E_100G, E_100G, E_100G, E_100G, E_100G, E_100G]
 
CODED_T0_BLOCK   = [0x02,0x87, I_100G, I_100G, I_100G, I_100G, I_100G, I_100G, I_100G]

CODED_T1_BLOCK   = [0x02,0x99, D0, I_100G, I_100G, I_100G, I_100G, I_100G, I_100G]

CODED_T2_BLOCK   = [0x02,0xAA, D0, D1, I_100G, I_100G, I_100G, I_100G, I_100G]

CODED_T3_BLOCK   = [0x02,0xB4, D0, D1, D2, I_100G, I_100G, I_100G, I_100G]

CODED_T4_BLOCK   = [0x02,0xCC, D0, D1, D2, D3, I_100G, I_100G, I_100G]

CODED_T5_BLOCK   = [0x02,0xD2, D0, D1, D2, D3, D4, I_100G, I_100G]

CODED_T6_BLOCK   = [0x02,0xE1, D0, D1, D2, D3, D4, D5, I_100G]

CODED_T7_BLOCK   = [0x02,0xFF, D0, D1, D2, D3, D4, D5, D6]

###############################################################


###################### ALIGNER MARKERS ########################



#AM_BLOCK_GAP = 16383 #cantidad de bloques entre un AM y otro
AM_BLOCK_GAP = 10

align_marker_list = [ 0x2C16821003E97DEff ,
					  0x29D718E00628E71ff ,
					  0x2594BE800A6B417ff ,
					  0x24D957B00B26A84ff ,
					  0x2F50709000AF8F6ff ,
					  0x2DD14C20022EB3Dff ,
					  0x29A4A260065B5D9ff ,
					  0x27B45660084BA99ff ,
					  0x2A02476005FDB89ff ,
					  0x268C9FB00973604ff ,
					  0x2FD6C9900029366ff ,
					  0x2B9915500466EAAff ,
					  0x25CB9B200A3464Dff ,
					  0x21AF8BD00E50742ff ,
					  0x283C7CA007C3835ff ,
					  0x23536CD00CAC932ff ,
					  0x2C4314C003BCEB3ff ,
					  0x2ADD6B700522948ff ,
					  0x25F662A00A099D5ff ,
					  0x2C0F0E5003F0F1Aff
					]

align_marker_dict = {
					  	0 : { 
					  			'block_name' : 'Aligner Marker 0',
				   				'sh'		 : 0x2,
				   				'payload'    : 0xC16821003E97DEff	
				  		  	} ,

					  	1 : { 
					  			'block_name' : 'Aligner Marker 1',
				   				'sh'		 : 0x2,
				   				'payload'    : 0x9D718E00628E71ff	
				  		  	} ,

					  	2 : { 
					  			'block_name' : 'Aligner Marker 2',
				   				'sh'		 : 0x2,
				   				'payload'    : 0x594BE800A6B417ff	
				  		  	} ,
					  	3 : { 
					  			'block_name' : 'Aligner Marker 3',
				   				'sh'		 : 0x2,
				   				'payload'    : 0x4D957B00B26A84ff
				  		 	 } ,

				  		4 : { 
					  			'block_name' : 'Aligner Marker 4',
				   				'sh'		 : 0x2,
				   				'payload'    : 0xF50709000AF8F6ff	
				  		  	} ,
				  		5 : { 
					  			'block_name' : 'Aligner Marker 5',
				   				'sh'		 : 0x2,
				   				'payload'    : 0xDD14C20022EB3Dff	
				  		  	} ,
				  		6 : { 
					  			'block_name' : 'Aligner Marker 6',
				   				'sh'		 : 0x2,
				   				'payload'    : 0x9A4A260065B5D9ff	
				  		  	} ,
				  		7 : { 
					  			'block_name' : 'Aligner Marker 7',
				   				'sh'		 : 0x2,
				   				'payload'    : 0x7B45660084BA99ff	
				  		  	} ,
				  		8 : { 
					  			'block_name' : 'Aligner Marker 8',
				   				'sh'		 : 0x2,
				   				'payload'    : 0xA02476005FDB89ff	
				  		  	} ,
				  		9 : { 
					  			'block_name' : 'Aligner Marker 9',
				   				'sh'		 : 0x2,
				   				'payload'    : 0x68C9FB00973604ff	
				  		  	} ,
				  		10 : { 
					  			'block_name' : 'Aligner Marker 10',
				   				'sh'		 : 0x2,
				   				'payload'    : 0xFD6C9900029366ff	
				  		  	} ,
				  		11 : { 
					  			'block_name' : 'Aligner Marker 11',
				   				'sh'		 : 0x2,
				   				'payload'    : 0xB9915500466EAAff	
				  		  	} ,
				  		12 : { 
					  			'block_name' : 'Aligner Marker 12',
				   				'sh'		 : 0x2,
				   				'payload'    : 0x5CB9B200A3464Dff	
				  		  	} ,
				  		13 : { 
					  			'block_name' : 'Aligner Marker 13',
				   				'sh'		 : 0x2,
				   				'payload'    : 0x1AF8BD00E50742ff	
				  		  	} ,
				  		14 : { 
					  			'block_name' : 'Aligner Marker 14',
				   				'sh'		 : 0x2,
				   				'payload'    : 0x83C7CA007C3835ff	
				  		  	} ,
				  		15 :{ 
					  			'block_name' : 'Aligner Marker 15',
				   				'sh'		 : 0x2,
				   				'payload'    : 0x3536CD00CAC932ff	
				  		  	} ,
				  		16 : { 
					  			'block_name' : 'Aligner Marker 16',
				   				'sh'		 : 0x2,
				   				'payload'    : 0xC4314C003BCEB3ff	
				  		  	} ,
				  		17 : { 
					  			'block_name' : 'Aligner Marker 17',
				   				'sh'		 : 0x2,
				   				'payload'    : 0xADD6B700522948ff	
				  		  	} ,
				  		18 : { 
					  			'block_name' : 'Aligner Marker 18',
				   				'sh'		 : 0x2,
				   				'payload'    : 0x5F662A00A099D5ff	
				  		  	} ,
				  		19 : { 
					  			'block_name' : 'Aligner Marker 19',
				   				'sh'		 : 0x2,
				   				'payload'    : 0xC0F0E5003F0F1Aff	
				  		  	} ,  	  	  	  	  	  	  	  	  	  	

					}					

################################################################

####################### BIP CALCULATOR #########################

data_dict = {
				'data': [1, 0] + [0]*64,
				'alignment_flag': 0,
			}