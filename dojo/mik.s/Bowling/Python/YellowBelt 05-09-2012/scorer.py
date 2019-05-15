import sys

class InvalidGameException(Exception):
    """Indicates faulty game data."""
    pass

# This is implemented as a class, though I could have gotten away somewhat
# more cleanly using global functions.  I don't especially like how Python
# treats instance methods, with the __ name mangling and 'self' param and all.
class Scorer:
    """Calculates the score for a bowling game."""
    
    def calculate_score(self, rolls):
        # Calculates the score for a bowling game expressed as a string of 
        # rolls, with numbers representing knockdowns of 1-9 pins, dashes repre-
        # senting misses, slashes representing spares, and Xs representing
        # strikes.  
        
        # NOTE: The kata specified not to count frames. Because of that, for a 
        # game with N frames, this class can't tell the difference between a 
        # strike in the N-1th frame followed by a normal frame, and a strike in 
        # the last frame followed by the two bonus rolls. This code treats all
        # rolls as part of valid frames, and counts them accordingly.
        
        score = 0
        
        for i in range(len(rolls)):
            score += self.__score(rolls, i)
            
        return score
        
    def __rawscore(self, rolls, index, offset=0):
        # Calculates the raw score for a given roll (i.e. the score before
        # applying the scores from future rolls, for spares and strikes).
        
        if (index + offset) < 0:
            # print('Game invalid - spare on first roll!')
            raise InvalidGameException()
            
        if index > (len(rolls) - 1):
            return 0
            
        roll = rolls[index + offset]
        
        if roll == 'X':
            return 10
        elif roll == '/':
            # Note we need to look back for spares
            return 10 - self.__rawscore(rolls, index, -1)
        elif roll == '-':
            return 0
        else:
            return int(roll)
                
    def __score(self, rolls, index):
        # Calculates the total score for a given roll, including (for spares
        # and strikes) the scores of future rolls.
        
        roll = rolls[index]
        
        if roll == 'X':
            return (
                10 
                + self.__rawscore(rolls, index, 1) 
                + self.__rawscore(rolls, index, 2)
            )
        elif roll == '/':
            return (
                self.__rawscore(rolls, index) 
                + self.__rawscore(rolls, index, 1)
            )
        else:
            return self.__rawscore(rolls, index)