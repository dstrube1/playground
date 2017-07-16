require 'json'

#using this:
# http://www.ruby-doc.org/stdlib-2.0/libdoc/json/rdoc/JSON.html
my_hash = JSON.parse('{"hello": "goodbye"}')
puts my_hash["hello"] #=> "goodbye"

my_hash = {:yo => "sup"}
puts JSON.generate(my_hash) #=> "{"yo":"sup"}"

#fails:
#puts {:red => "green"}.to_json # "{"red":"green"}"

puts 1.to_json #=> "1", without quotes, but still a string

