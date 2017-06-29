require 'test/unit'
require_relative 'bowling_game'

class BowlingGameTest < Test::Unit::TestCase
  @@perfect_game = BowlingGame.new("XXXXXXXXXXXX")
  @@nine_and_miss = BowlingGame.new("9-9-9-9-9-9-9-9-9-9-")
  @@threes_and_fours = BowlingGame.new("34343434343434343434")
  @@five_to_spare = BowlingGame.new("5/5/5/5/5/5/5/5/5/5/5")

  def test_frame_string_save
    assert_equal(@@perfect_game.score_string, "XXXXXXXXXXXX")
    assert_equal(@@nine_and_miss.score_string, "9-9-9-9-9-9-9-9-9-9-")
    assert_equal(@@threes_and_fours.score_string, "34343434343434343434")
    assert_equal(@@five_to_spare.score_string, "5/5/5/5/5/5/5/5/5/5/5")
  end

  def test_bonus_frame_calculation
    assert_equal(@@perfect_game.bonus_frames, 2)
    assert_equal(@@nine_and_miss.bonus_frames, 0)
    assert_equal(@@threes_and_fours.bonus_frames, 0)
    assert_equal(@@five_to_spare.bonus_frames, 1)
  end

  def test_score_calculation
    assert_equal(@@perfect_game.total_score, 300)
    assert_equal(@@nine_and_miss.total_score, 90)
    assert_equal(@@threes_and_fours.total_score, 70)
    assert_equal(@@five_to_spare.total_score, 150)
  end
end