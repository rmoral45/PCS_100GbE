import random
import numpy as np
from pdb import set_trace as bp
import tx_modules as tx 
#import rx_modules as rx
import paralell_converter as pc
import parallel_to_serial as p2s
import serial_to_parallel as s2p
import channel_model as ch
import block_sync as bs
NCLOCK = 10000
NIDLE = 5
NDATA = 16
NLANES = 1
CODED_BLOCK_LEN = 66





def main():
	#------------------------init--------------------#
	tx_fifo = []
	lanes = [[] for y in range(NLANES)]

	cgmii_module = tx.CgmiiFSM()
	tx_scrambler_module = tx.Scrambler()
	rx_scrambler_module = tx.Scrambler()
	paralell_converter = pc.ParallelConverterModule(NLANES)
	Paralell_To_Serial = p2s.ParallelToSerialModule(0)
	Serial_To_Paralell = s2p.SerialToParallelModule(0)
	Channel = ch.ChannelModel([0],[0],NLANES)
	Block_Sync = bs.BlockSyncModule(0)

	##################debug vars ################
	bcount = 0
	tx_cgm = []
	bsync_vect = []
	#############################################

	##################reset##############
	Block_Sync.reset()

	#####################################

	for clock in range (0,NCLOCK): # MAIN LOOP
		
		#######################    TX    ###########################


		tx_raw = cgmii_module.tx_raw #bloque recibido desde cgmii
		tx_cgm.append(tx_raw)
		#codificacion
		if tx_raw['block_name'] in tx.ENCODER : 
			tx_coded = tx.ENCODER[ tx_raw['block_name'] ]
		else :
			tx_coded = tx.ENCODER['ERROR_BLOCK']
		
		
		cgmii_module.change_state(0)
		
		tx_scrm = tx_scrambler_module.tx_scrambling(tx_coded)
		paralell_converter.add_block(tx_scrm)
		
		if paralell_converter.pc_ready():
				blockX = paralell_converter.get_block()
				Paralell_To_Serial.block_to_bit_stream(blockX)

		############################################################


		#######################    CANAL  ##########################	

		for i in range(CODED_BLOCK_LEN):
			Channel.add_bit( Paralell_To_Serial.lane_id() , Paralell_To_Serial.get_bit() )
			Serial_To_Paralell.acumulate_bit(Channel)

		############################################################


		#######################    RX    ###########################
		if Serial_To_Paralell.block_ready() :
			rx_block = Serial_To_Paralell.get_66_bit()

		rx_block['block_name'] = 'block_' + str(bcount)
		bcount += 1
		bsync_vect.append(rx_block)
		Block_Sync.receive_block(rx_block)
		for y in range(10):
			Block_Sync.FSM_change_state()
		if clock == 14 :
			Block_Sync.debug_state_seq()
			print ' sh count :    ' , Block_Sync.sh_cnt
			bp()

		


		#recv_block = rx_scrambler_module.rx_scrambling(rx_block)
		






	

if __name__ == '__main__':
    main()
