require_relative "fizz_buzz.rb"
require "test/unit"

#assert_equal( expected, actual, failure_message = nil )

class TestFizzBuzz < Test::TestCase

  def test_param_nil
    result_nil = fizz_buzz(nil)
    assert_equal("Can't do FizzBuzz for #{nil} values", result_nil)
  end

  def test_param_not_int
    result_str = fizz_buzz("")
    result_arr = fizz_buzz([1])
    result_sym = fizz_buzz(:cat)
    assert_equal("This is not a number but a #{"".class}", result_str)
    assert_equal("This is not a number but a #{[1].class}", result_arr)
    assert_equal("This is not a number but a #{[1].class}", result_sym)
  end

  def test_param_negative_number
    num = -1
    result = fizz_buzz(num)
    assert_equal("Negative numbers are not allowed", result)
  end

  def test_divisible_by_3
    result = fizz_buzz(3)
    assert_equal("Fizz", result)
  end

  def test_divisible_by_5
    result = fizz_buzz(10)
    assert_equal("Buzz", result)
  end

  def test_divisible_by_3_and_5
    result = fizz_buzz(15)
    assert_equal("Buzz", result)
  end

  def test_not_divisible_by_3_or_5
    num = 19
    result = fizz_buzz(num)
    assert_equal(num, result)
  end
end
