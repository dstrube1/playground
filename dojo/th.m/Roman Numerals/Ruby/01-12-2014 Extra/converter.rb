=begin
Roman Converter Kata
01/12/2014
Thorne Melcher

Ruby isn't one of my stronger languages, and I'm mostly doing this as practice. This isn't targeted towards any
dojo belt in particular and is just me doing extra kata over the weekend.
=end

class Calculator
  CHAR_VALS = {"M"=>1000, "D"=>500, "C"=>100, "L"=>50, "X"=>10, "V"=>5, "I"=>1}
  EXTRA_FIXES = {"IIIII"=>"V", "VV"=>"X", "XXXXX"=>"L","LL"=>"C","CCCCC"=>"D","DD"=>"M"}
  SUB_FIXES = {"DCCCC"=>"CM", "CCCC"=>"CD", "LXXXX"=>"XC", "XXXX"=>"XL", "VIIII"=>"IX", "IIII"=>"IV"}

  def convert(num)
    num = raw_digits(num) # convert number to its raw roman numeral digits
    num = fix_extras(num) # collapse down extra digits into bigger forms
    num = fix_subtractive(num) # add in subtractive digits
  end

  def raw_digits(num)
    digits = ""
    CHAR_VALS.each do |key,val|
      while num > val do
        digits += key
        num -= val
      end
    end

    digits
  end

  def fix_subtractive(num)
    SUB_FIXES.each do |key,val|
      num = num.gsub(key,val)
    end

    num
  end

  def fix_extras(num)
    EXTRA_FIXES.each do |key,val|
      num = num.gsub(key, val)
    end

    num
  end
end

calc = Calculator.new

while true
  puts "Enter a number to convert to Roman numerals."
  num = gets.chomp

  num = calc.convert(num.to_i)
  puts "In Roman numerals: #{num}"
end