using System;

namespace Bowling
{
    public class RollConverter
    {
        public int ToScore(string stringRolls)
        {
            int[] rolls = ConvertStringToIntArray(stringRolls);
            
            var score = 0;
            var frame = 1;
            var frameroll = 0;
            
            for (var i = 0; i < rolls.Length; i++)
            {
                int previous = i != 0 ? rolls[i - 1] : 0;
                int current = rolls[i];
                int next1 = GetNextRoll(i, 1, rolls);
                int next2 = GetNextRoll(i, 2, rolls);

                score += current;
                frameroll++;

                //if we are not on last frame, look ahead for scoring strikes and spares
                if (frame <= 9)
                {
                    //if a spare
                    if (frameroll == 2 && (current + previous == 10))
                    {
                        score += next1;
                    }
                    //if strike, add next two rolls
                    //note that current could be 10 in a spare if first roll was a gutter ball
                    //this is why we check for a spare before checking for a strike
                    else if (current == 10)
                    {
                        score += next1 + next2;
                    }
                }

                //if we striked/spared or have rolled twice, create new frame
                if (current == 10 || frameroll == 2)
                {
                    frame++;
                    frameroll = 0;
                }
            }

            return score;
        }

        //returns 0 if out of bounds
        private int GetNextRoll(int currentIndex, int count, int[] rolls)
        {
            return (currentIndex + count) < rolls.Length ? rolls[currentIndex + count] : 0;
        }

        //converts a roll string to its numeric representation
        public int[] ConvertStringToIntArray(string rolls)
        {
            int[] intRolls = new int[rolls.Length];

            for (var i = 0; i < rolls.Length; i++)
            {
                switch (rolls[i])
                {
                    case 'X':
                        intRolls[i] = 10;
                        break;
                    case '-':
                        intRolls[i] = 0;
                        break;
                    case '/':
                        intRolls[i] = 10 - intRolls[i - 1];
                        break;
                    default:
                        intRolls[i] = (int)Char.GetNumericValue(rolls[i]);
                        break;
                }
            }

            return intRolls;
        }
    }
}
