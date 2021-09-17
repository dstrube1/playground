class FizzBuzz
  def print(numbers = 1..15)
    numbers.map do |num, fizz, buzz|
      case [isFizz(num),isBuzz(num)]
        when [true,true];"FizzBuzz"
        when [true,false];"Fizz"
        when [false,true];"Buzz"
        else num
      end
    end
  end
  def isFizz(num)
    num % 3 == 0
  end
  def isBuzz(num)
    num % 5 == 0
  end
end