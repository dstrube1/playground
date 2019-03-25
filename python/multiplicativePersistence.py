#multiplicativePersistence.py
#Author: David Strube
#Date: 2019-03-22
#What is: Having a go at multiplicative persistence

import sys

#According to this:
#https://www.youtube.com/watch?v=Wim9WJeDTHQ
#There is a conjecture that 11 is the limit
#Let's see if we can do better

#Dumb brute force
#from 4:10 here:
#https://www.youtube.com/watch?v=E4mrC39sEOQ
def dumbPersistence(n, steps=0, start=0):
	if start == 0:
		start = n
	if len(str(n)) == 1:
		#print "Total steps " + str(steps)
		if steps > 6:
			print "start was " + str(start) + "; steps = " + str(steps)
	#	else:
	#		if start % 1000 == 0:
	#			sys.stdout.write('.')
		return
		
	steps += 1
	digits = [int(i) for i in str(n)]
	result = 1
	for j in digits:
		result *= j
	#print result
	dumbPersistence(result, steps, start)
	
#dumbPersistence(9999)
#dumbPersistence(277777788888899)
#dumbPersistence(5555)
#dumbPersistence(355)
#dumbPersistence(868)
#dumbPersistence(976)

def testDumb():
	limit = 100000 #greater than this (and with steps limit > 7) and it starts to take a while
	pos = 0
	while pos < limit: 
		#print "testing " + str(pos)
		dumbPersistence(pos)
		pos += 1
	print "Done"
#testDumb()

#A little smarter
#from 10:47 here:
#https://www.youtube.com/watch?v=Wim9WJeDTHQ
#1- Leave out anything with a 5
#2- keep track of what's been tested; compare what is being tested to what has been tested; if digits (regardless of order) match, skip it
tested = []
def smartPersistence(n, steps=0, start=0):
	if start == 0:
		start = n
	if "5" in str(start):
		#print "contains 5: " + str(n)
		sys.stderr.write('5')
		return
	if hasBeenTested(start):
		#print "already tested similar combination of digits: " + str(n)
		sys.stderr.write('X')
		return
	if len(str(n)) == 1:
		#print "Total steps " + str(steps)
		if steps > 8:
			print "start was " + str(start) + "; steps = " + str(steps)
		else:
			if start % 1000 == 0:
				sys.stderr.write('.')
		return
		
	steps += 1
	digits = [int(i) for i in str(n)]
	result = 1
	for j in digits:
		result *= j
	#print result
	smartPersistence(result, steps, start)

def hasBeenTested(n):
#	if n in tested:
#		return True
#	lengthFound = False
#	for i in tested:
#		if len(str(n)) == len(str(i)):
#			lengthFound = True
#	if not lengthFound:
#		return False
	for j in tested:
		if hasSameDigits(j,n):
			return True
	return False

def hasSameDigits(j,n):
	if sorted(str(j)) == sorted(str(n)):
		return True
	return False

#smartPersistence(277777788888899)

def testSmart():
	#limit = 10000000
	pos = 277777788936677
	while True:#pos < limit:
		smartPersistence(pos)
		tested.append(pos)
		pos += 1
	print "Done"
testSmart()

































