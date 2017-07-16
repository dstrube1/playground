puts "Words to search through: "
text = gets.downcase.chomp

puts "Word to redact: "
redact= gets.chomp.split(" ")


words=text.split(" ")

words.each do |x|
    redact.each do |y|
  if x == y
      x = " REDACTED "
      break
    end
end
print x + " "
end
puts " "