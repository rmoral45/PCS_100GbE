import os
import getpass
import pwd
import grp
import datetime
'''
	Todas estas funciones deberian ser parte de u objeto helper.
'''

def create_dump_dir(filename, remove_if_exist=False):

	cwd = os.getcwd()
	current_date 	 = datetime.date.today().strftime("%d/%m/%Y").replace('/', '_')
	dir_name = cwd + '/tmp-' + filename + '-' + current_date 

	if os.path.exists(dir_name) :

		if remove_if_exist : 
			os.remove(dir_name)
			os.makedirs(dir_name, mode=0o777, exist_ok=False)
		else :
			now = datetime.datetime.now()
			dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
			time = dt_string.split(' ')[1]
			dir_name += '-' + time
			os.makedirs(dir_name, mode=0o777, exist_ok=False)
	else :
		os.makedirs(dir_name, mode=0o777, exist_ok=False)

	return dir_name

def create_dump_files(dir_name, fname_list) :
	for  fname in fname_list :
		path = dir_name + '/' + fname + '.txt'
		open(path, "w")

def write_dump_files(data):
	'''
	data deberi ser una tupla (nobre_archivo,  dato a escribir)
	'''


def main():
	print ('HOLA')
	dir_name = create_dump_dir('AAAAAAA', remove_if_exist=False)
	create_dump_files(dir_name, ['hoola1','hola2'])



if __name__ == "__main__" :
	main()
