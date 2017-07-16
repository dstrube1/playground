def starPrint
	x = [1,2,3,4,5]
	x.each do |i| #outer loop
	  (1..i).to_a.each do|| #inner loop
	   print "*"
	  end
	  puts ""
	end
end

def revStr1(str)
	rev_str=[]
	idx = str.length - 1
	str.each_char do |c|
		rev_str[idx] = c
		idx -= 1
	end
	return rev_str.join
end

def revStr2(str)
	rev_str = Array.new(str.length)
	dec = str.length - 1
	inc = 0
	((str.length + 1)/2).times do
		rev_str[inc] = str[dec]
		rev_str[dec] = str[inc]
		dec -= 1
		inc += 1
	end
	return rev_str.join
end

#starPrint
#puts revStr1("Abc")
puts revStr2("Abc")