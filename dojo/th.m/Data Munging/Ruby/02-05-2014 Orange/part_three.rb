require_relative "part_three_munger"

munger = PartThreeMunger.new

data = munger.munge("weather.dat", "1  88", "mo", 0, 1, 2)
puts "The lowest spread was key: #{data['key']} value: #{data['spread']}"

data = munger.munge("football.dat", "1.", "--", 1, 6, 8, true)
puts "The lowest spread was key: #{data['key']} value: #{data['spread']}"