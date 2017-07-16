def init_prime_arr(num)
 num_count = []
 sieve_num = sieve(num)
 2.upto(num) do |n|
   if n == 2
     num_count[n] = 2
   end
   next if n.even?
   num_count[n] = n
   n += 2
 end
 init_prime_list = num_count
 return init_prime_list
end

def sieve(num)
 #num = 10
 sieve_prime_list = []
 #sieve_num_count = [nil,nil,2,3,nil,5,nil,7,nil,9,nil]
 sieve_num_count = init_prime_arr(num)
 puts "sieve_num_count = #{sieve_num_count}"
 puts "sieve_num_count[3] = #{sieve_num_count[3]}"
return
 sieve_num_count[3].upto(Math.sqrt(num)) do |i|
   next unless sieve_num_count[i]
   num.times do |j|
     next if sieve_num_count[j].nil? || sieve_num_count[j] == i
     puts "#{sieve_num_count[j]}, i: #{i}"
   #sieve_num_count.each do |j|
   if sieve_num_count[j] % i == 0
     sieve_num_count[j] = nil 
   end
     end
     puts "arr - #{sieve_num_count}"
   sieve_prime_list = sieve_num_count.compact!
   end
 sieve_prime_list
 end
 
#sieve(10)
#sieve(init_prime_arr(10))

def find_primes(num)
  candidate = 2
  while candidate <= num
      divisor = 2
    isPrime = true
    while divisor < candidate
      if candidate % divisor == 0
        isPrime = false
        break
      end
      divisor += 1
    end
      puts "#{candidate}" if isPrime == true
      candidate += 1
  end
end

find_primes(10)