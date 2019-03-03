#maximums.py
#Author: David Strube
#Date: 2019-03-02
#What is: looking for maximums & minimums

import sys

#float minimum is about 9.88131291682e-324
x = 1.0
y = 0.0
print x
while x > y:
	if x % 10000000000000000000.0 == 0.0:
		#newline: print "."
		#https://stackoverflow.com/questions/493386/how-to-print-without-newline-or-space
		#doesn't work: print('.', end='')
		#doesn't work: print('.', end='', flush=True)
		#works:
		sys.stdout.write('.')
	x = x / 10.0
	print x