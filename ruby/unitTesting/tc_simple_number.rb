#from https://en.wikibooks.org/wiki/Ruby_Programming/Unit_testing

require_relative "simple_number"
require "minitest/autorun"
#require "test/unit"
 
class TestSimpleNumber < Minitest::Test
 
  def test_simple
    assert_equal(4, SimpleNumber.new(2).add(2) )
    assert_equal(6, SimpleNumber.new(2).multiply(3) )
  end
 
end