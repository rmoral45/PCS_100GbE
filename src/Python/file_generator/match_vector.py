
from pdb import set_trace as bp


def main():

	#verilog_decoded_output = open("./verilog_outputs/verilog-decoded-data-output.txt","r")
	#verilog_cgmii_input = open("./verilog_outputs/para_comparar.txt","r")

	match_counter = 0
	no_match_counter = 0

	with open("./verilog_outputs/verilog-decoded-data-output.txt") as verilog_decoded_output:
		decoded_output = verilog_decoded_output.readlines()

	with open("./verilog_outputs/para_comparar.txt") as verilog_cgmii_input:
		cgmii_input = verilog_cgmii_input.readlines()


	decoded_output = [x.strip() for x in decoded_output] 
	cgmii_input = [x.strip() for x in cgmii_input] 

	bp()


	for i in cgmii_input:
		for j in decoded_output:
			if i == j:
				#print "match"
				match_counter = match_counter + 1
			else:
				#print "no match"
				no_match_counter = no_match_counter + 1

	print "match_counter", match_counter
	print "no_match_counter", no_match_counter

if __name__ == '__main__':
    main()

