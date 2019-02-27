import os
import getpass
import pwd
import grp
import os

def create_dump_dir(fname):
	#filename = os.path.basename(__file__)
	#filename = filename.split('.')[0]
	filename = fname.split('.')[0]
	dir_name = 'tmp-' + filename
	path = './' + dir_name # './' + dir_name + '/' ???
	os.mkdir(path, 777)
	uid = pwd.getpwnam("dj").pw_uid
	gid = grp.getgrnam("dj").gr_gid
	os.chown(path, uid, gid)
	os.chmod(path, 777)
	return path



