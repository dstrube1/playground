using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Roman_Calculator_Console
{
    class Program
    {
        private static Regex validRegex;
        private static Calculator calculator;

        static void Main(string[] args)
        {
            validRegex = new Regex(@"^([MDCLXVI\+ ]*)$");
            calculator = new Calculator();

            while (true)
            {
                Console.WriteLine("Enter in Roman Numerals-based addition expression.");

                string input = Console.ReadLine();

                if (validRegex.IsMatch(input))
                {
                    Console.WriteLine("The sum is: " + calculator.Calculate(input));
                }
                else
                {
                    Console.WriteLine("ERROR: Invalid input. Must only include spaces, plus signs, and characters in MDCLXVI.");
                }
            }
        }

        
    }
}
