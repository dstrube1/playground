#testMaths.py
#Author: David Strube
#Date: 2019-03-08
#What is: testing python maths stuffs 

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
	print "light travels this many centimeters in the time it takes for a 2.6 GHz processor to complete one cycle: "
	#2.6 GHz processor = 2.6 billon cycles / second
	cycles_per_second = 2600000000
	print light_meters_per_second * centimeters_per_meter * billionth / (cycles_per_second * billionth)

	print 
	#print "what happens here?"
	#minutes = minutes + 1
	#seconds = minutes * 60
	#print seconds
	#error, because we can't assign a new variable with itself

	age = 40
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
#mathF0()

def round(i):
	if i%1 > 0.5:
		j = (i - i%1) + 1
	else:
		j = (i - i%1)
	print "i, " + str(i) + " rounded = " + str(j)
	return
#round(3.14)
#round(27.63)

def square0(n):
	return "Square of " + str(n) + ": " + str(n**2)
print square0(4)

def square1(n):
	return "Square of " + str(n) + ": " + str(n*n)
print square1(5)

