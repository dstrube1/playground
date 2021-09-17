require './FizzBuzz/fizzbuzz'

class FizzBuzzExtended < FizzBuzz

  def isFizz(num)
    num % 3 == 0 || num.to_s.include?('3')
  end
  def isBuzz(num)
    num % 5 == 0 || num.to_s.include?('5')
  end
end