def find_primes(topCandidate)
 candidate = 2
 while candidate <= topCandidate
   prime = true
   divisor = 2
   while divisor * divisor <= candidate
     if candidate % divisor == 0
       prime = false
       break
     end
     divisor += 1
     #puts "divisor : #{divisor}, candidate : #{candidate}, topCandidate is #{topCandidate}"
   end
     #puts "divisor : #{divisor}, candidate : #{candidate}, topCandidate is #{topCandidate}"
     puts "#{candidate}" if prime
     candidate += 1
 end
 #  puts "divisor : #{divisor}, candidate : #{candidate}, topCandidate is #{topCandidate}"
end

def find_primes_0(num)
 prime_count = 2
 prime_arr = []
 while prime_count <= num
   prime = 1
   if prime_count == 2
     prime_arr << prime_count
     break if num == prime_arr.first
     prime_count += 1
   end
   prime_arr.each do |i|

     while i * i <= prime_count    #9 > 5
       if prime_count % i == 0    
         prime = 0
         break
       end
       break
             puts "i: #{i}, prime_count: #{prime_count}"
     #  prime_arr << prime_count
 #    puts "stuff"
     end
   end
   prime_arr << prime_count if prime == 1
   prime_count += 1
   prime_arr
 #puts "end of outer while results: prime_arr is #{prime_arr}, prime_count is #{prime_count}"
 end
puts "end of function results: prime_arr is #{prime_arr}, prime_count is #{prime_count}"
end

find_primes(100)