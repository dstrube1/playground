using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Bowling
{
    class Program
    {
        private static char FRAME_STRIKE = 'X';
        private static char FRAME_SPARE = '/';


        static void Main(string[] args)
        {
            Regex validator = new Regex(@"^([1-9,\-,\/,X]*)$");

            while (true)
            {
                Console.WriteLine("Enter your frame scores, using the character set [1-9,X,/,-].");
                string input = Console.ReadLine();

                if (!validator.IsMatch(input))
                {
                    Console.WriteLine("ERROR: Your frame scores include invalid characters.");
                }
                else
                {
                    Console.WriteLine("The total score for this game is " + CalculateScore(input));
                }
            }
            
        }

        public static int CalculateScore(string frames)
        {
            int totalScore = 0;
            char oneFrameAgo = '-';
            char twoFramesAgo = '-';
            int framesLeft = frames.Length;
            bool onExtraFrames = false;

            foreach (char c in frames)
            {
                int numericValue = (int) Char.GetNumericValue(c);

                if (numericValue == -1)
                {
                    switch (c)
                    {
                        case '-':
                            numericValue = 0;
                            break;
                        case '/':
                            numericValue = (10-(int)Char.GetNumericValue(oneFrameAgo));
                            break;
                        case 'X':
                            numericValue = 10;
                            break;
                    }
                }

                int bonusFactor = 1;

                // Extra frames only count as a bonus, so we should start with 0, not 1
                if (onExtraFrames) bonusFactor--;

                if ((oneFrameAgo == FRAME_SPARE || oneFrameAgo == FRAME_STRIKE) && !(framesLeft==1 && twoFramesAgo==FRAME_STRIKE)) bonusFactor++;
                if (twoFramesAgo == FRAME_STRIKE) bonusFactor++;

                totalScore += bonusFactor * numericValue;

                twoFramesAgo = oneFrameAgo;
                oneFrameAgo = c;

                framesLeft--;

                if ((c == FRAME_STRIKE && framesLeft == 2) || (c == FRAME_SPARE && framesLeft == 1)) onExtraFrames = true;

            }

            return totalScore;
        }

    }
}
