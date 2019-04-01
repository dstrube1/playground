#testLoops.py
#Author: David Strube
#Date: 2019-03-08
#What is: testing python loop stuffs

def loops():
	for letter in 'abc':
		print "for letter in 'abc': " + letter
	for i in range(3):
		print "for i in range(3): ", i
	for i in range(5,8): #we can reuse variables
		print "for i in range(5,8): ", i
	print "can we reuse a variable outside its loop? yes: ",i 
	count = 0
	while (count < 4):
		print 'while (count<4): ', count # oh hey, another way to concatenate a string and int
		count += 1
	return

loops()
