#test.py
#Author: David Strube
#Date: 2015-12-30
#What is: testing python stuffs

#function doing math stuffs, pt 0
def mathF0():
	print 'number of minutes in seven weeks: '
	print 7 * 7 * 24 * 60

	print #new line
	light_meters_per_second = 299792458
	billionth = 1 / 1000000000.0 #adding .0 turns this from int to float calculation
	centimeters_per_meter = 100
	#print 'light travels this many meters per second: ' + light_meters_per_second.to_s
	print "light travels this many centimeters in a nanosecond: "
	print light_meters_per_second * centimeters_per_meter * billionth 

	print
	print "light travels this many centimeters in the time it takes for my processor to complete one cycle: "
	#2.6 GHz processor = 2.6 billon cycles / second
	cycles_per_second = 2600000000
	print light_meters_per_second * centimeters_per_meter * billionth / (cycles_per_second * billionth)

	print 
	#print "what happens here?"
	#minutes = minutes + 1
	#seconds = minutes * 60
	#print seconds
	#error, because we can't assign a new variable with itself

	age = 36
	days_per_year = 365.25
	print "I've been alive about this many days: "
	print age * 365.25

	print 
	a = 1
	x = 2
	print "a = " + str(a) + ", x = " + str(x)
	a,x = x,a
	print "a = " + str(a) + ", x = " + str(x)
	a,x = x,a
	print "a = " + str(a) + ", x = " + str(x)
	return

def mathF0(i):
	if i%1 > 0.5:
		j = (i - i%1) + 1
	else:
		j = (i - i%1)
	print "i, " + str(i) + " rounded = " + str(j)
	return
#mathF0(3.14)
#mathF0(27.63)

#function doing string stuffs, pt 0
def stringF0():
	print
	string = "string"
	print "string = " + string
	print "string[0] = " + string[0] #s
	print "string[-1] = " + string[-1] #g
	print "string[-2] = " + string[-2] #n
	print "string[-6] = " + string[-6] #s
	#print "string[-7] = " + string[-7] #index out of range error
	print "string[1:1] = " + string[1:1] #nothing
	print "string[1:4] = " + string[1:4] #tri
	print "string[1:] = " + string[1:] #tring
	print "string[4:] = " + string[:4] #stri
	return

#function doing string stuffs, pt 1
def stringF1(s):
	print "testing : " + s 
	print "s == s[:] = " + str(s == s[:])					#True
	print "s == s + s[0:-1+1] = " + str(s == s + s[0:-1+1]) #True
	print "s == s[0:] = " + str(s == s[0:])					#True
	print "s == s[:-1] = " + str(s == s[:-1])				#False
	print "s == s[:3] + s[3:] = " + str(s == s[:3] + s[3:]) #True
	print "s.find(s) = " + str(s.find(s))					#0
	print "'s'.find('s') = " + str('s'.find('s'))			#0
	print "s.find('') = " + str(s.find(''))					#0
	print "s.find(s+'!!!')+1 = " + str(s.find(s+'!!!') + 1) #0
	#there is also .find(string x,int pos)
	return

#stringF1("hey")
#stringF1("")
#stringF1("1234")
	
#function doing string stuffs, pt 2
def stringF2(s, t, i):
	print "testing : " + s + ", " + t + ", " + str(i)
	#which of these is equivalent to s.find(t,i):
	#s[i:].find(t)										#yes? no

	#the slash at the end of this next line does line continuation, but must be the last character on the line; even a space (' ') will mess it up
	print "s.find(t,i) (" +str(s.find(t,i))+ ") == s[i:].find(t) (" \
+ str(s[i:].find(t))+ ") = " + str(s.find(t,i) == s[i:].find(t))		
		#also, there must be no comment between first half and second half of line continuation.
		#indentation doesn't matter on line continuation
				
	#s.find(t)[:i] 		#no
	#s[i:].find(t) + i	#no
	#s[i:].find(t[i:])									#no? no
	print "s.find(t,i) (" +str(s.find(t,i))+ ") == s[i:].find(t[i:]) (" +str(s[i:].find(t[i:]))+ ") = " + str(s.find(t,i) == s[i:].find(t[i:]))		
	return
	
#stringF2("hey","h",0)
#stringF2("","",0)
#stringF2("1234","4",2)

def stringF3():
	atag = '<a href="'
	print "atag = " + atag + ", length = " + str(len(atag))
	#Given string page with html text, what is the location of the first <a> tag?
	start_link = page.find(atag)

	#What is the url in the first <a> tag?
	end_atag='"'
	end_link = page.find(end_atag, start_link + len(atag))
	url = page[start_link + len(atag) : end_link]
	return

def loops():
	for letter in 'abc':
		print "for letter in 'abc': " + letter
	for i in range(3):
		print "for i in range(3): ", i
	for i in range(5,8): #we can reusing variables
		print "for i in range(5,8): ", i
	print "can we reuse a variable outside its loop? yes: ",i 
	count = 0
	while (count < 4):
		print 'while (count<4): ', count # oh hey, another way to concatenate a string and int
		count = count + 1
	return
#loops()
	
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

def square0(n):
	return n**2
def square1(n):
	return n*n
#print square1(5)

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