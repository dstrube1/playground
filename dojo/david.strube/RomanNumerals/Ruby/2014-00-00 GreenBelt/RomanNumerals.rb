#!/usr/bin/env ruby

#RomanNumerals in Ruby
#DS 2014-00-00

#If using IronRuby, from command line:
#ir RomanNumerals.rb

#see also:
# http://codequizzes.wordpress.com/2013/10/27/converting-an-integer-to-a-roman-numeral/
# http://codequizzes.wordpress.com/2013/10/27/converting-a-roman-numeral-to-an-integer/
# http://codereview.stackexchange.com/questions/7937/this-correct-ruby-code-is-not-good-ruby-code-roman-numeral-converter
# http://rubyquiz.com/quiz22.html
class Integer
 
 def to_roman_old
    result = ""
    number = self
    roman_mapping.keys.each do |divisor|
      quotient, modulus = number.divmod(divisor)
      result << roman_mapping[divisor] * quotient
      number = modulus
    end
    result
  end
  
  def to_roman(number = self, result = "")
  return result if number == 0
  roman_mapping.keys.each do |divisor|
    quotient, modulus = number.divmod(divisor)
    result << roman_mapping[divisor] * quotient
    return to_roman(modulus, result) if quotient > 0
  end
end
  
  private
 
  def roman_mapping
    {
      1000 => "M",
      900 => "CM",
      500 => "D",
      400 => "CD",
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",
      5 => "V",
      4 => "IV",
      1 => "I"
    }
  end
 
end

class String 
	def to_arabic_old #returns 0
	  result = 0
	  str = self
	  roman_mapping.values.each do |roman|
		while str.start_with?(roman)
		  result += roman_mapping.invert[roman]
		  str = str.slice(roman.length, str.length)
		end
	  end
	  result
	end

	def to_arabic(str = self, result = 0) # returns all array roman_mapping values
	  return result if str.empty?
	  roman_mapping.values.each do |roman|
		if str.start_with?(roman)
		  result += roman_mapping.invert[roman]
		  str = str.slice(roman.length, str.length)
		  return to_arabic(str, result)
		end
	  end
	end

	private
 
  def roman_mapping
    {
      1000 => "M",
      900 => "CM",
      500 => "D",
      400 => "CD",
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",
      5 => "V",
      4 => "IV",
      1 => "I"
    }
  end
end

class RomanNumerals
	
	attr_accessor :number1
	
	def initialize(number0)
		@number1 = number0
	end
	def printThem
		#puts "Hello #{@number1}!"
	end
	
end

arabicArray = [
1,2,3,4,5,6,7,8,9,10,
11,12,13,14,15,16,17,
18,19,20,21,22,23,24,
25,26,27,28,29,30,35,
40,50,60,90,91,99,100,
101,200,399,400,401,499,
500,899,900,901,999,
1000,3109,4999
]
for i in arabicArray
	puts i.to_s + " in Roman : "  + i.to_roman 
end

romanArray = [
"i","ii","iii","iv","v","vi","vii","viii","ix","x",
"xi","xii","xiii","xiv","xv","xvi","xvii",
"xviii","xix","xx","xxi","xxii","xxiii",
"xxiv","xxv","xxvi","xxvii","xxviii",
"xxix","xxx","xxxv","xl","l","lx","xc",
"xci","xcix","c","ci","cc","cccxcix",
"cd","cdi","cdxcix","d","dcccxcix",
"cm","cmi","cmxcix","m","mmmcix","mmmmcmxcix"
]

for i in romanArray
	#puts i + " in Arabic : " + i.to_arabic.to_s 
end

numerals = RomanNumerals.new("3")
numerals.printThem

#puts "152 in Roman: " 
#puts 152.to_roman

#puts "MIV in Arabic: " 
#puts "MIV".to_arabic

#invalid:
#puts numerals.instance_methods
#valid
#puts RomanNumerals.instance_methods
#puts numerals.number1
#^ requires this in the class:
#attr_accessor :number
#numerals.number1=2
#see RomanNumeralsTest for more testing
#numerals.printThem