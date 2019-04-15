#mprocessingTest.py
#Author: David Strube
#Date: 2019-03-27
#What is: Tests multiprocessing

#from
#https://medium.com/@nbosco/multithreading-vs-multiprocessing-in-python-c7dc88b50b5b

import sys
import multiprocessing

def calc_square(number):
    print('Square:' , number * number)
    result = number * number
    print(result)
def calc_quad(number):
    print('Quad:' , number * number * number * number)
def count_up(number):
	i = 0
	while i < 100:
		i += 1
		if i % 10 == 0:
			sys.stderr.write(str(number))
    
if __name__ == "__main__":
    number = 7
    #result = None

#p1 = multiprocessing.Process(target=calc_square, args=(number,))
#p2 = multiprocessing.Process(target=calc_quad, args=(number,))
#p1.start()
#p2.start()
#p1.join()
#p2.join()
    
# Wont print because processes run using their own memory location                     
#print(result)

processArray = []
for i in range(9):
	p = multiprocessing.Process(target=count_up, args=(i,))
	p.start()
	processArray.append(p)
	#p.join()
	#print "for i in range(3): ", i

for j in range(9):
	processArray[j].join()
	
print "\nmultiprocessing.cpu_count(): "
print multiprocessing.cpu_count()

import os
print "\nos.cpu_count(): "
print multiprocessing.cpu_count()
