=begin
Roman Calculator Kata
Thorne Melcher
01/12/2014

Ruby isn't one of my stronger languages, and I'm mostly doing this as practice. This isn't targeted towards any
dojo belt in particular and is just me doing extra kata over the weekend.
=end
class Calculator
  DIGITS = "IVXLCDM"
  SUB_PAIRS = {"IV"=>"IIII", "IX"=>"VIIII", "XL"=>"XXXX", "XC"=>"LXXXX", "CD"=>"CCCC", "CM"=>"DCCCC"}
  EXTRA_FIXES = {"IIIII"=>"V", "VV"=>"X", "XXXXX"=>"L", "LL"=>"C", "CCCCC"=>"D", "DD"=>"M"}

  def sum(num_i, num_ii)
    num_i = expand_sub(num_i)
    num_ii = expand_sub(num_ii)

    num = num_i + num_ii
    num = sort_digits(num)
    num = fix_extras(num)
    fix_sub(num)
  end

  def expand_sub(num)
    SUB_PAIRS.each do |key,val|
      num = num.gsub(key,val)
    end
    num
  end

  def sort_digits(num)
    num = num.chars.sort{|a,b| DIGITS.index(a.to_s) <=> DIGITS.index(b.to_s)}.join.reverse
  end

  def fix_extras(num)
    EXTRA_FIXES.each do |key,val|
      num = num.gsub(key,val)
    end
    num
  end

  def fix_sub(num)
    SUB_PAIRS.reverse_each do |key,val|
      num = num.gsub(val,key)
    end
    num
  end
end

calc = Calculator.new

while true
  puts "Input first number to sum:"
  num_i = gets.chomp
  puts "Input second number:"
  num_ii = gets.chomp

  sum = calc.sum(num_i, num_ii)

  puts "The sum is: " + sum.to_s
end