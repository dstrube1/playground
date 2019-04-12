#!/usr/bin/python3

#multiplicativePersistence.py3
#Author: David Strube
#Date: 2019-04-08
#What is: Having a go at multiplicative persistence, using python3
#See also: multiplicativePersistence.py

import sys
import multiprocessing

#According to this:
#https://www.youtube.com/watch?v=Wim9WJeDTHQ
#There is a conjecture that 11 is the limit
#Let's see if we can do better

#from 10:47 here:
#https://www.youtube.com/watch?v=Wim9WJeDTHQ
#1- Leave out anything with a 1, 0, (5 and an even), two 2s, two 3s, (2 and 3), or (2 and 4)
#2- if digits aren't in ascending order skip it
def smartPersistence(n, steps=0, start=0):
	if start == 0:
		start = n
	if "0" in str(start) or "1" in str(start) or contains2Twos(start) or contains2Threes(start):
		return
	if "2" in str(start) and "3" in str(start):
		return
	if "2" in str(start) and "4" in str(start):
		return
	if "5" in str(start) and containsEven(start):
		return
	if not areDigitsAscending(start):
		return
	if len(str(n)) == 1:
		if steps > 11: 
			output = "start was " + str(start) + "; steps = " + str(steps)
			print (output)
			with open('output.txt', 'w') as file:
				file.write(output)
		return
	steps += 1
	digits = [int(i) for i in str(n)]
	result = 1
	for j in digits:
		result *= j
	smartPersistence(result, steps, start)

def containsEven(n):
	if "2" in str(n) or "4" in str(n) or "6" in str(n) or "8" in str(n):
		return True
	return False

def contains2Twos(n):
	count = str(n).count('2') 
	if count >= 2:
		return True
	return False
	
def contains2Threes(n):
	count = str(n).count('3') 
	if count >= 2:
		return True
	return False
	
def areDigitsAscending(n):
	if ''.join(sorted(str(n))) == str(n):
		return True
	return False

#smartPersistence(277777788888899)

intab = "0"
outtab = " "
trantab = str.maketrans(intab, outtab)

#starting at lowest possible 233 digit candidate
def testSmart(pos,threadNum,limit):
	posOrigin = pos
	while limit > 0:
		smartPersistence(pos)
		pos += 1
		limit -= 1
		if limit % 100000 == 0:
			output = '\r' + str(threadNum) + '(' + str(limit).translate(trantab).rstrip() + '); '
			sys.stderr.write(output) ###Python 3's stderr doesn't work as well a Python 2's
	print ("Thread " + str(threadNum) + " is done, checked from " + str(posOrigin) + " to " + str(pos))
#testSmart()

if __name__ == "__main__":
	processArray = []
	startPos = 26666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
	startPosOrigin = startPos
	perThreadLimit = 1000000000
	threadLimit = multiprocessing.cpu_count()
	for i in range(threadLimit):
		startPos += (i * perThreadLimit)
		p = multiprocessing.Process(target=testSmart, args=(startPos,i,perThreadLimit,))
		p.start()
		processArray.append(p)
		startPos = startPosOrigin

	for j in range(threadLimit):
		processArray[j].join()