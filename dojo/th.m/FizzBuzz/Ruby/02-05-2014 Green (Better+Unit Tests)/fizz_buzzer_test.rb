require 'test/unit'
require_relative 'fizz_buzzer'

class FizzBuzzerTest < Test::Unit::TestCase
  def test_numeric_returns
    assert_equal("Fizz", 3.fizzbuzz)
    assert_equal("Fizz", 9.fizzbuzz)
    assert_equal("Fizz", 33.fizzbuzz)

    assert_equal("Buzz", 5.fizzbuzz)
    assert_equal("Buzz", 35.fizzbuzz)
    assert_equal("Buzz", 55.fizzbuzz)

    assert_equal("FizzBuzz", 15.fizzbuzz)
    assert_equal("FizzBuzz", 45.fizzbuzz)
    assert_equal("FizzBuzz", 90.fizzbuzz)

    assert_equal(98, 98.fizzbuzz)
    assert_equal(22, 22.fizzbuzz)
    assert_equal(137, 137.fizzbuzz)
  end
end