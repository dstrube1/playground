# Largest palindrome product
# Problem 4
# A palindromic number reads the same both ways. The largest palindrome made from the product 
#of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.
#
# 999 * 999
# 999 * 998
# 999 * 997
# ...
# 999 * 100
#
# 998 * 998
# 998 * 997
# 998 * 996
# ...
# 998 * 100
#
# 997 * 997
# 997 * 996
# 997 * 995
# ...
# 997 * 100


def palindrome_product
  product = 0
  arr = []
  num1 = 999
  num2 = 999
  numInnerLoops = 0
  numOuterLoops = 0
  until num1 == 99
    numOuterLoops +=1
    until num2 == 99
      numInnerLoops += 1
      product = num1 * num2
      if product.to_s == product.to_s.reverse
        arr << product
        break
      end
      num2 -= 1
    end
    break unless arr[1].nil?
    num1 -= 1
    num2 = num1
  end
#  puts "numOuterLoops = #{numOuterLoops}; numInnerLoops = #{numInnerLoops}"
  return arr.sort.last
end

puts palindrome_product