
def main():

	correct = open("verilog-decoded-data-output.txt", "r+")
	asd = open("corregido.txt", "w")

	for line in correct: 
		line.replace('', ' ')

		#print line
		asd.write(line)
	

	correct.close()

if __name__ == '__main__':
    main()
