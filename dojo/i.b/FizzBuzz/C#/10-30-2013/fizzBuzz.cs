using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fizzBuzz.console
{
    class fizzBuzz
    {
        static void Main(string[] args)
        {
            for (var i = 1; i < 101; i++)
            {
                var isFizz = IsFizz(i);
                var isBuzz = IsBuzz(i);

                if (isFizz && isBuzz)
                {
                    Console.WriteLine("FizzBuzz");
                }
                else if(isFizz)
                {
                    Console.WriteLine("Fizz");
                }
                else if (isBuzz)
                {
                    Console.WriteLine("Buzz");
                }
                else
                {
                    Console.WriteLine(i.ToString());
                }
            }
            var x = Console.ReadLine();
        }

        private static bool IsFizz(int value)
        {
            return value % 3 == 0 || value.ToString().Contains("3");
        }

        private static bool IsBuzz(int value)
        {
            return value % 5 == 0 || value.ToString().Contains("5");
        }
    }
}
