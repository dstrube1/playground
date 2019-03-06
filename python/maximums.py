#maximums.py
#Author: David Strube
#Date: 2019-03-02
#What is: looking for maximums & minimums

import sys

#float minimum is about 9.88131291682e-324
x = 1.0
y = 0.0
print x
while x > 0:
	y = x
	x = x / 10.0
	#print x
print "Float minimum approximately: " + str(y)
#	https://stackoverflow.com/questions/7604966/maximum-and-minimum-values-for-ints

#can change type
x = 1
y = 0
print x

#Looking for int max this way doesn't work
#count = 0
#while x > y:
#	x = x * 10
#	count = count + 1
#	if count % 100000 == 0:
		#newline: 
#		print count
		#https://stackoverflow.com/questions/493386/how-to-print-without-newline-or-space
		#doesn't work: 
		#print('.', end='')
		#doesn't work: 
		#print('.', end='', flush=True)
		#works:
		#sys.stdout.write('.')

#Better way:
print "Int max: " + str(sys.maxint) + "((2^63) - 1)"
print "Max word size: " + str(sys.maxsize)
#invalid:
#print "sys.maxfloat = " + str(sys.maxfloat)