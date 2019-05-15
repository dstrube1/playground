using System;
using System.Collections.Generic;
using System.Text;

namespace RomanNumerals
{
    class Program
    {
        static void Main(string[] args)
        {

            var numerals = new Dictionary<string, int>
            {
                {"M", 1000},
                {"CM", 900},
                {"D", 500},
                {"CD", 400},
                {"C", 100},
                {"XC", 90},
                {"L", 50},
                {"XL", 40},
                {"X", 10},
                {"IX", 9},
                {"V", 5},
                {"IV", 4},
                {"I", 1}
            };
            while (true)
            {
                var s = new StringBuilder();
                Console.WriteLine("Enter a number between 1 and 3999:");
                var input = Console.ReadLine();
                int number;
                if (!int.TryParse(input, out number))
                {
                    Console.WriteLine("Please enter a number.");
                }
                else if (number < 1 || number > 3999)
                {
                    Console.WriteLine("Number must be between 1 and 3999");
                }
                else
                {
                    foreach (var numeral in numerals)
                    {
                        while (number >= numeral.Value)
                        {
                            s.Append(numeral.Key);
                            number -= numeral.Value;
                        }
                    }
                }
                Console.WriteLine(s);
            }
        }
    }
}
