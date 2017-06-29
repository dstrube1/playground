using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FizzBuzz_Console
{
    class Program
    {
        static void Main(string[] args)
        {
            for (int i = 1; i <= 100; i++)
            {
                string output = "";
                if (i%3 == 0) output += "Fizz";
                if (i%5 == 0) output += "Buzz";
                if (output == "") output += i;

                Console.WriteLine(output);
            }

            // Easy way to prevent the console window from closing after output
            Console.ReadLine();
        }
    }
}
