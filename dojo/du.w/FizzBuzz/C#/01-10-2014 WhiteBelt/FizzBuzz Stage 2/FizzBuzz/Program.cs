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

                if (i % Fizz == 0 || i.ToString().IndexOf(Fizz.ToString()) != -1 || i % Buzz == 0 || i.ToString().IndexOf(Buzz.ToString()) != -1)   // if modulo of 3 or 5 || if 3 or 5 in the num
                {
                    if (i % Fizz == 0 || i.ToString().IndexOf(Fizz.ToString()) != -1) toBePrinted += "Fizz ";   // add Fizz

                    if (i % Buzz == 0 || i.ToString().IndexOf(Buzz.ToString()) != -1) toBePrinted += "Buzz";    // add Buzz
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
