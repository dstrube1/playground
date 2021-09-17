using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Roman_Numerals_Console;

namespace Roman_Numerals_Console
{
    class Program
    {
        private static ArrayList numerals;

        static void Main(string[] args)
        {
            numerals = new ArrayList();
            numerals.Add(new RomanNumeral("M", 1000));
            numerals.Add(new RomanNumeral("CM", 900));
            numerals.Add(new RomanNumeral("D", 500));
            numerals.Add(new RomanNumeral("CD", 400));
            numerals.Add(new RomanNumeral("C", 100));
            numerals.Add(new RomanNumeral("XC", 90));
            numerals.Add(new RomanNumeral("L", 50));
            numerals.Add(new RomanNumeral("XL", 40));
            numerals.Add(new RomanNumeral("X", 10));
            numerals.Add(new RomanNumeral("IX", 9));
            numerals.Add(new RomanNumeral("V", 5));
            numerals.Add(new RomanNumeral("IV", 4));
            numerals.Add(new RomanNumeral("I", 1));

            while (true)
            {
                Console.WriteLine("Enter an integer from 1-3000:");
                string input = Console.ReadLine();
                int num;

                if (!int.TryParse(input, out num))
                {
                    Console.WriteLine("That's not an integer...");
                }
                else if (num < 1)
                {
                    Console.WriteLine("The number must be greater than 0...");
                }
                else if (num > 3000)
                {
                    Console.WriteLine("The number must not be larger than 3000...");
                }
                else
                {
                    Console.WriteLine("The value in Roman numerals is: " + Convert(num));
                }
            }
        }

        private static string Convert(int value)
        {
            string output = "";
            int remainingValue = value;

            foreach (RomanNumeral numeral in numerals)
            {
                if (numeral.IsMultiUse()) 
                {
                    while (remainingValue >= numeral.Value)
                    {
                        output += numeral.Text;
                        remainingValue -= numeral.Value;
                    }
                    
                }
                else
                {
                    if (remainingValue >= numeral.Value)
                    {
                        output += numeral.Text;
                        remainingValue -= numeral.Value;
                    }
                }
            }

            return output;
        }
    }
}
