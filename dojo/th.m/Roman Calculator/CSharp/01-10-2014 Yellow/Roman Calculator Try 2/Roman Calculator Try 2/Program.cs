using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Roman_Calculator_2
{
    class Program
    {
        static void Main(string[] args)
        {
            Calculator c = new Calculator();
            Regex validRegex = new Regex(@"^([IVXLCDM,\+, ]*)$");

            while (true)
            {
                Console.WriteLine("Enter in a Roman numerals addition expression:");
                string input = Console.ReadLine();

                if (validRegex.IsMatch(input))
                {
                    Console.WriteLine("Sum: " + c.Calculate(input));
                }
                else
                {
                    Console.WriteLine("That is an invalid expression. Must only use Roman digits, spaces, and the plus sign.");
                }
            }
        }
    }
}
