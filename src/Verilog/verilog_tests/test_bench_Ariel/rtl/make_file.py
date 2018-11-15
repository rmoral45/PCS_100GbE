

file0 = open('./vectors/reset.out','w')
file1 = open('./vectors/switch.out','w')

reset = 0;
switch = [0,0,0,0]

for ptr in range(100000):
    if(ptr==100):
        reset = 1
        switch = [1,0,0,0]
    if(ptr==20000):
        reset = 1
        switch = [1,1,0,0]
    if(ptr==30000):
        reset = 1
        switch = [1,0,1,0]
    if(ptr==40000):
        reset = 1
        switch = [1,1,1,0]
    if(ptr==50000):
        reset = 1
        switch = [1,1,1,1]
    if(ptr==60000):
        reset = 1
        switch = [0,1,1,1]
    if(ptr==70000):
        reset = 0
        switch = [0,1,1,1]

    file0.write('%d\n'%reset)
    file1.write('%d\t%d\t%d\t%d\n'%(switch[0],switch[1],switch[2],switch[3]))


file0.close()
file1.close()

