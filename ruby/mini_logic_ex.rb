#code ex in the book

#write a function for a string and reverse the string...

#thought process
# p e o p l e
# 0 1 2 3 4 5
#
# e e o p l p
# 0 1 2 3 4 5

##s_odd = 'sam'
##s_even = 'same'

##def rev(str)
##  n = str.length/2
##  n.times do |i|
##    str[i], str[(str.length - 1) - i] = str[(str.length - 1) - i], str[i]
##  end
##  return str
##end

#fibonacci
#0,1,1,2,3,5...
#0,1,2,3,4,5...
# f(n)=f(n-1)+f(n-2)
# f(0) = 0
# f(1) = 1
#write a fx, n = 10, gives the 10th num of fib seq and n = 100, gives teh 100th num
#of fib seq

#10

# f(10) = f(10 - 1) + f(10 - 2)

# f(10) = f(9) + f(8) = 34 + 21 = 55
# f(9) = f(8) + f(7) = 21 + 13 = 34
# f(8) = f(7) + f(6) = 13 + 8 = 21
# f(7) = f(6) + f(5) = 8 + 5 = 13
# f(6) = f(5) + f(4) = 5 + 3 = 8
# f(5) = f(4) + f(3) = 3 + 2 = 5
# f(4) = f(3) + f(2) = 2 + 1 = 3
# f(3) = f(2) + f(1) = 1 + 1 = 2
# f(2) = f(1) + f(0) = 1 + 0
# f(1) = 1
# f(0) = 0

##n = 10
##def f(n)
##  if n == 0
##    return 0
##  elsif n == 1
##    return 1
##  else #n = 3
##    f(n-1) + f(n-2)
##  end
##end

#TODO: improve efficiency. No point working on f(n-2)

#Create a fx that: prints out * n number of times in asc and desc order like this:

#this is asc order.
# 1 = *
# 2 = **
# 3 = ***
# 4 = ****

##n = 10
##def stars_desc(n)
##  i= 0
##  if n != 0
##  until i == n
##    (n-i).times do
##      print '*'
##      end
##      print "\n"
##    i += 1
##    end
##  end
##end


##n = 10
##def stars_asc(n)
##  i= n
##  if n != 0
##  until i == 0
##    ((n-i)+1).times do
##      print '*'
##      end
##      print "\n"
##    i -= 1
##    end
##  end
##end

#Permutation
#determine if a string is a permutation of another.

##s = 'cats'
##s2 = 'astc'

#nice and clean.
##def permutation(s1,s2)
##  if s1.length == s2.length
##    snew = s1 + s2
##    snew.each_char do |c|
##      if (snew.count c) % 2 != 0
##        false ###???
##        puts 'nope'
##      end
##    end
##  else
##    puts 'nope'
##  end
##end

#longer but clearer perhaps?
##def permutation(s1,s2)
##  if s1.length == s2.length
##    n = s1.length
##    perm = true
##    n.times do |i|
##      if s1.chars.sort[i] != s2.chars.sort[i]
##        perm = false
##      end
##      break if !perm ###???
##      print false
##    end
##    if perm == true
##      perm
##    end
##  else
##    print 'nope'
  ###missing end here
##  end
##end

# isSubstring
# 1.8 Assume you have a method isSubstring which checks if one word is a
# substring of another. Given two strings, si and s2, write code to check if s2 is
# a rotation of s1 using only one call to isSubstring (e.g.,"waterbottle"is a rotation
# of "erbottlewat").
#

s1 = 'waterbottle'
s2 = 'erbottlewat'

s3 = 'waterway'
s4 = 'waywater'
#
# waterbottle
# 0123456789n
#
# erbottle wat
# 3456789n 012

#check s2 against s1.

#use sort method...
  # s1 and s2 same length
  # s1 and s2 have same characters

# find the 0 index letter s2

  def isSubstring?(s1,s2)
    rotation_check = ''
    if s1.chars.sort == s2.chars.sort
        s2.each_char do |j|
            if s1[0] == j
            puts "j is " + j + s2.index(j).to_s + " s1[0] is " + s1[0].to_s
              rotation_check += s2[s2.index(j)...s2.length]
              puts "rotation_check is " + rotation_check
              rotation_check += s2[0...s2.index(j)]
              puts "rotation_check is " + rotation_check
              if rotation_check == s1
                true
              else
                false
                rotation_check.clear
              end
            end
            break if rotation_check == s1
        end
    else
       false
    end
  end


# You have 10 pebbles (numbered 1-10). They are by default black. You must alter
# them by painting them white if they are black or painting them black if they
# are white. There are 10 rounds. Every round, you must alter the pebbles that are
# multiples of the current round. The pebbles are by default black.
#
# 1st round, you alter every pebble (paint them all white).
# 2nd round, you alter every other pebble(you paint pebbles #2,4,6,8,10 black).
# 3rd round, you alter pebbles #3,6,9.
# 4th round you alter pebbles #4,8.
# ...
# 10th round, you alter pebble #10.
# After the 10th round, which pebbles are painted black and which are painted white?

@color = [:b,:w]
limit = 10
def pebble_color_hash(n)
  pebble_arr = (1..n).to_a
  pebble_color = {}
  pebble_arr.each do |i|
    pebble_color[pebble_arr[i-1]] = @color[0]
  end
  pebble_count(n,pebble_color)
  pebble_color
end


def pebble_count(n,pebble_hash)
  t = 1
  n.times do
    pebble_hash.each_key do |k|
      if pebble_hash.keys[k-1] % t == 0
        if pebble_hash[k] ==  @color[0]
          pebble_hash[k] =  @color[1]
        else
          pebble_hash[k] =  @color[0]
        end
      end
      puts pebble_hash.to_s + t.to_s
    end
    t += 1
  end
  puts pebble_hash.to_s
end
  pebble_color_hash(limit)

# Sum of multiples
# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

n=1000
def sum_3_5(n)
sum = 0
num = 0
  while num < n do
    if num % 3 == 0 || num % 5 == 0
      sum += num
    end
    num += 1
  end
  sum
end
