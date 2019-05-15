module FizzBuzz
	class Generate
		def initialize(output)
			@output = output
		end
		def start
			@output.puts 'This is FizzBuzz'
			(1..100).each do |i|
				@output.puts response(i).to_s + "\n"
			end
		end
		def response(input)
			if !input.is_a? Integer
				raise "Must be a positive integer!"
			end

			if input % 15 == 0
				"FizzBuzz"
			elsif input % 3 == 0
				"Fizz"
			elsif input % 5 == 0
				"Buzz"
			else
				input.to_s
			end
		end
	end
end