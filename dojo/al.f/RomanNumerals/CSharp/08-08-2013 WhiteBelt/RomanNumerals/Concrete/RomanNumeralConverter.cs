using System;
using System.Collections.Generic;
using RomanNumerals.Abstract;
using System.Linq;

namespace RomanNumerals.Concrete
{
    public class RomanNumeralConverter : INumeralConverter
    {
        protected List<KeyValuePair<string, int>> Numerals;
  
        public RomanNumeralConverter()
        {
            Numerals = new List<KeyValuePair<string, int>>
            {
                new KeyValuePair<string, int>("I",  1),
                new KeyValuePair<string, int>("IV", 4),
                new KeyValuePair<string, int>("V",  5),
                new KeyValuePair<string, int>("IX", 9),
                new KeyValuePair<string, int>("X",  10),
                new KeyValuePair<string, int>("XL", 40),
                new KeyValuePair<string, int>("L",  50),
                new KeyValuePair<string, int>("XC", 90),
                new KeyValuePair<string, int>("C",  100),
                new KeyValuePair<string, int>("CD", 400),
                new KeyValuePair<string, int>("D",  500),
                new KeyValuePair<string, int>("CM", 900),
                new KeyValuePair<string, int>("M",  1000)
            };
        }
        
        public string ToNumerals(int amount)
        {
            int length = Numerals.Count;
            string numerals = "";
            
            for (var i = length - 1; i >= 0; i--)
            {
                int count = amount / Numerals[i].Value;

                //if total was divisible by numeral amount, add numerals to string
                if (count > 0)
                {
                    numerals = AddXNumeralsToString(count, Numerals[i].Key, numerals);
                }

                amount -= (count * Numerals[i].Value);

                //if the amount is zero we are done
                if (amount == 0) break;
            }

            return numerals;
        }

        private string AddXNumeralsToString(int x, string numeral, string s)
        {
            for (var i = 0; i < x; i++)
            {
                s += numeral;
            }

            return s;
        }

        public int ToInt(string numerals)
        {
            int total = 0;
            
            for (var i = 0; i < numerals.Length; i++)
            {
                int current = NToInt(numerals[i].ToString());

                //if current is not last, get next value, otherwise 0
                int next = (i + 1) < numerals.Length ? NToInt(numerals[i + 1].ToString()) : 0;

                //if the current numeral is less than the next, we must subtract it from the next
                //otherwise simply add it
                if (current < next)
                {
                    total += (next - current);

                    //skip looking at next numeral since we just needed it for subtraction
                    i++;
                }
                else
                {
                    total += current;
                }
            }

            return total;
        }

        protected int NToInt(string numeral)
        {
            int i = Numerals.FindIndex(kvp => kvp.Key == numeral);

            if (i == -1)
                throw new Exception("Numeral '" + numeral + "' is not supported by " + GetType().Name + ". Supported numerals are: " 
                    + string.Join(", ", Numerals.Select(kvp => kvp.Key).Where((kvp, index) => index % 2 == 0).ToArray()));

            return Numerals[i].Value;
        }
    }
}
