#testStrings.py
#Author: David Strube
#Date: 2015-12-30
#What is: testing python string stuffs

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
#stringF0()

#function doing string stuffs, pt 1
def stringF1(s):
	print "testing : '" + s +"'"
	print "s == s[:] = " + str(s == s[:])					#True
	print "s == s + s[0:-1+1] = " + str(s == s + s[0:-1+1]) #True
	print "s == s[0:] = " + str(s == s[0:])					#True
	print "s == s[:-1] ('" + s[:-1] + "')= " + str(s == s[:-1])				#False
	print "s == s[:3] + s[3:] = " + str(s == s[:3] + s[3:]) #True
	print "s.find(s) = " + str(s.find(s))					#0
	print "'s'.find('s') = " + str('s'.find('s'))			#0
	print "s.find('') = " + str(s.find(''))					#0
	print "s.find(s+'!!!')+1 = " + str(s.find(s+'!!!') + 1) #0
	#there is also .find(string x,int pos)
	print
	return
#stringF1("hey")
#stringF1("")
#stringF1("1234")
	
#function doing string stuffs, pt 2
def stringF2(s, t, i):
	print "testing : s = '" + s + "', t = '" + t + "', i = '" + str(i) + "'"
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
	print
	return
#stringF2("hey","h",0)
#stringF2("","",0)
#stringF2("1234","4",2)

def stringF3():
	atag = '<a href="'
	print "atag = " + atag + ", length = " + str(len(atag))
	#Given string page with html text, what is the location of the first <a> tag?
	#start_link = page.find(atag)

	#What is the url in the first <a> tag?
	end_atag='"'
	#end_link = page.find(end_atag, start_link + len(atag))
	#url = page[start_link + len(atag) : end_link]
	return
stringF3()