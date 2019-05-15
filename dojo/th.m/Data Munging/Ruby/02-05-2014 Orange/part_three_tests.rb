require_relative "part_three_munger"
require "test/unit"

class MungerTest < Test::Unit::TestCase
  def test_key_returns
    munger = PartThreeMunger.new

    assert_equal("14", munger.munge("weather.dat", "1  88", "mo", 0, 1, 2)["key"] )
    assert_equal("Aston_Villa", munger.munge("football.dat", "1.", "--", 1, 6, 8, true)["key"] )

  end

  def test_spread_returns
    munger = PartThreeMunger.new

    assert_equal(2, munger.munge("weather.dat", "1  88", "mo", 0, 1, 2)["spread"] )
    assert_equal(1, munger.munge("football.dat", "1.", "--", 1, 6, 8, true)["spread"] )
  end

end