#!/usr/bin/env ruby

#RomanNumerals in Ruby
#DS 2014-02-24

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
	def to_arabic_old 
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

	def to_arabic(str = self, result = 0) 
	  return result if str.empty?
	  roman_mapping.values.each do |roman|
		if str.upcase.start_with?(roman) #must upcase here to make the function accept upper or lower case
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

	def initialize()
	end
	
	def testArabicToRoman
		arabicArray = [
		1,2,3,4,5,6,7,8,9,10,
		#11,12,13,14,15,16,17,
		#18,19,20,21,22,23,24,
		#25,26,27,28,29,30,35,
		#40,50,60,90,91,99,100,
		#101,200,399,400,401,499,
		#500,899,900,901,999,
		1000,3109,4999
		]
		for i in arabicArray
			puts i.to_s + " in Roman : "  + i.to_roman 
		end
	end
	
	def testRomanToArabic

		romanArray = [
		#"i","ii","iii","iv","v","vi","vii","viii","ix","x",
		#"xi","xii","xiii","xiv","xv","xvi","xvii",
		#"xviii","xix","xx","xxi","xxii","xxiii",
		#"xxiv","xxv","xxvi","xxvii","xxviii",
		#"xxix","xxx","xxxv","xl","l","lx","xc",
		#"xci","xcix","c","ci","cc","cccxcix",
		#"cd","cdi","cdxcix","d","dcccxcix",
		"cm","cmi","cmxcix","m","mmmcix","mmmmcmxcix",
		"I","II","III","IV","V","VI","VII","VIII","IX","X",
		#"XI","XII","XIII","XIV","XV","XVI","XVII","XVIII",
		#"XIX","XX","XXI","XXII","XXIII","XXIV","XXV",
		#"XXVI","XXVII","XXVIII","XXIX","XXX","XXXV","XL",
		#"L","LX","XC","XCI","XCIX","C","CI","CC","CCCXCIX",
		#"CD","CDI","CDXCIX","D","DCCCXCIX","CM","CMI",
		#"CMXCIX","M","MMMCIX","MMMMCMXCIX"
		]

		for i in romanArray
			puts i + " in Arabic : " + i.to_arabic.to_s 
		end
	end
	
end


numerals = RomanNumerals.new()
numerals.testArabicToRoman
numerals.testRomanToArabic

#invalid:
#puts numerals.instance_methods
#valid
#puts RomanNumerals.instance_methods

