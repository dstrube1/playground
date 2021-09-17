def fizzbuzz(from,to)
  for x in from..to
    output = ""
    output += "Fizz" if x%3 == 0
    output += "Buzz" if x%5 == 0
    output = x.to_s if output == ""
    puts output
  end
end

fizzbuzz(1,100)