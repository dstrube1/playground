#test.py
#Author: David Strube
#Date: 2015-12-30
#What is: testing python stuffs

dictionary = {
        'a': 1,
        'b': 2,
    }
def caseF(x):
    return dictionary.get(x, 9)    # 9 is default if x not found
    #also, don't declare the dictionary in the function, so as to not have to rebuild it everytime the function is called
#print caseF('a') #should return 1
#print caseF('c') #not found, should return default 9

def multiReturn():
	return 1,2

a=0
b=1
#print "a = ",a,"; b=",b #print initial values
a,b = multiReturn()
#print "a = ",a,"; b=",b #confirm behaves as expected
a=0
b=1
#print "a = ",a,"; b=",b #print resetted values
a = multiReturn() #if only one variable is the recipient of multiple values, that variables gets all the values
#print "a = ",a,"; b=",b

def noValueReturned(a,b):
	a = a+b
	
#print noValueReturned(1,2) #prints "None"
#make sure this didn't affect a&b above:
#print "a = ",a,"; b=",b 

def ifelseF():
	a = 1
	if a == 1:
		print 'a is 1'
	elif a == 2: #else if => elif
		print 'a is 2'
	else:
	#pass does nothing; used when a statement is required syntactically but the program requires no action.
		pass
#ifelseF()

def paramF(a,b=1,c='c'):
	print "a = ",a,"; b = ",b,"; c = ",c
#paramF() must be called with at least one param
paramF(1) #1st param can be int
paramF('x') #1st param can be string
paramF(1,c=2,b='d') #params can be out of order if named; data types can change