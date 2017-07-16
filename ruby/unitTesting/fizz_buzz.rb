
def fizz_buzz(num)
  unless /^[0-9]*$/ === num
    puts "This is not a positive number. Can't do fizz_buzz with #{num}"
    return false
  end
  int = num.to_i
  0.upto(int) do |n|
    if n == 0
      puts n
    elsif n % 3 == 0 && n % 5 == 0
      puts "FizzBuzz"
    elsif n % 3 == 0
      puts "Fizz"
    elsif n % 5 == 0
      puts "Buzz"
    else
      puts n
    end
  end
end

num = ARGV
fizz_buzz(ARGV[0])
