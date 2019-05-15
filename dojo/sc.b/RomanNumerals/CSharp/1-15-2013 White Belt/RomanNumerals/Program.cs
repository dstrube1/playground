using System;
using System.Collections.Generic;
using System.Linq;

namespace RomanNumerals
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter Arabic Numbers:");
            while (true)
            {
                var input = Console.ReadLine();
                if (string.IsNullOrEmpty(input))
                    break;
                int arabic;
                Console.WriteLine(int.TryParse(input, out arabic) ? arabic.ToRoman() : "Can't parse to integer");
            }
        }
    }
    public static class ConvertExtension
    {
        public static string ToRoman(this int arabic)
        {
            var hash = new Dictionary<int, string>()
                {
                    {1, "I"},
                    {5, "V"},
                    {10, "X"},
                    {50, "L"},
                    {100, "C"},
                    {500, "D"},
                    {1000, "M"}
                };

            var result = hash.Keys.OrderByDescending(x => x).Aggregate("", (seed, key) =>
                {
                    while (arabic > 0 && arabic >= key)
                    {
                        arabic -= key;
                        seed += hash[key];
                    }
                    return seed;
                });
            result = result.Replace("DCCCC", "CM");
            result = result.Replace("CCCC", "CD");
            result = result.Replace("LXXXX", "XC");
            result = result.Replace("XXXX", "XL");
            result = result.Replace("VIIII", "IX");
            result = result.Replace("IIII", "IV");
            return result;
        }
    }
}
