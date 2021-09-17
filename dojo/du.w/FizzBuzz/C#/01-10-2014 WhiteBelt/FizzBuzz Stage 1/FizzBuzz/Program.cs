using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FizzBuzz
{
    class Program
    {
        static void Main(string[] args)
        {
            int maxLimit = 100;     // How long should we check for FizzBuzz
            int Fizz = 3;
            int Buzz = 5;
            string toBePrinted;

            
            for (int i = 1; i < maxLimit; i++)
            {
                toBePrinted = "";  // Clear the printer

                if (i % Fizz == 0 || i % Buzz == 0 )   // if modulo of 3 or 5
                {
                    if (i % Fizz == 0 ) toBePrinted += "Fizz ";   // add Fizz

                    if (i % Buzz == 0 ) toBePrinted += "Buzz";    // add Buzz
                }
                else // no Fizz or Buzz, print the number
                {
                    toBePrinted += i.ToString();
                }


                Console.WriteLine(toBePrinted);
            }
            Console.ReadLine();

        }
    }
}
