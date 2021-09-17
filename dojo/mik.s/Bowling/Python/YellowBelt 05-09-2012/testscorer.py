import sys
import scorer
import unittest

class TestScorer(unittest.TestCase):
    """Runs unit tests on Scorer."""
    
    def setUp(self):
        self.tested = scorer.Scorer()
        
    def test_must_return_correct_score_for_miss(self):
        score = self.tested.calculate_score('-')
        self.assertEqual(score, 0)
        
    def test_must_return_correct_score_for_simple_roll(self):
        score = self.tested.calculate_score('5')
        self.assertEqual(score, 5)
        
    def test_must_return_correct_score_for_spare(self):
        score = self.tested.calculate_score('5/7')
        self.assertEqual(score, 24)
        
    def test_must_return_correct_score_for_strike(self):
        score = self.tested.calculate_score('X71')
        self.assertEqual(score, 26)
    
    def test_must_return_correct_score_for_game_with_no_marks_or_misses(self):
        score = self.tested.calculate_score('52361481334226514126')
        self.assertEqual(score, 69)
        
    def test_must_return_correct_score_for_game_with_misses_but_no_marks(self):
        score = self.tested.calculate_score('5-36148133-22651-126')
        self.assertEqual(score, 59)
        
    def test_must_return_correct_score_for_game_with_spares_only(self):
        score = self.tested.calculate_score('523/148/3342265/4126')
        self.assertEqual(score, 83)
        
    def test_must_return_correct_score_for_game_with_strikes_only(self):
        score = self.tested.calculate_score('5236X81X422651X26')
        self.assertEqual(score, 106)
        
    def test_must_return_correct_score_for_game_with_strikes_and_spares(self):
        score = self.tested.calculate_score('5/36X81X4/265/X26')
        self.assertEqual(score, 139)
        
    def test_must_raise_InvalidGameException_for_game_with_spare_on_1st_roll(self):
        with self.assertRaises(scorer.InvalidGameException):
            self.tested.calculate_score('/36X81X4/265/X5/')

        
suite = unittest.TestLoader().loadTestsFromTestCase(TestScorer)
unittest.TextTestRunner(verbosity=2).run(suite)