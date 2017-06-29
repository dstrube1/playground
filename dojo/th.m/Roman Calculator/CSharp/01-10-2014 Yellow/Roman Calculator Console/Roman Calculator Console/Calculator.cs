using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Roman_Calculator_Console
{
    class Calculator
    {
        private ArrayList digits;

        public Calculator()
        {
            digits = new ArrayList();
            digits.Add(new RomanDigit("M", 1000));
            digits.Add(new RomanDigit("CM", 900));
            digits.Add(new RomanDigit("D", 500));
            digits.Add(new RomanDigit("CD", 400));
            digits.Add(new RomanDigit("C", 100));
            digits.Add(new RomanDigit("XC", 90));
            digits.Add(new RomanDigit("L", 50));
            digits.Add(new RomanDigit("XL", 40));
            digits.Add(new RomanDigit("X", 10));
            digits.Add(new RomanDigit("IX", 9));
            digits.Add(new RomanDigit("V", 5));
            digits.Add(new RomanDigit("IV", 4));
            digits.Add(new RomanDigit("I", 1));
        }

        public string Calculate(string input)
        {
            int totalValue = 0;
            string[] numbers = input.Split('+');

            foreach (string number in numbers)
            {
                totalValue += ConvertRomanToArabic(number.Trim());
            }

            return ConvertArabicToRoman(totalValue);
        }

        public int ConvertRomanToArabic(string value)
        {
            int totalValue = 0;
            string remaining = value;

            for (int i=digits.Count-1; i>=0; i--)
            {
                RomanDigit digit = (RomanDigit) digits[i];

                if (digit.IsMultiUse())
                {
                    while (remaining.Length > 0 && remaining.Substring(remaining.Length - 1, 1) == digit.Text)
                    {
                        remaining = remaining.Substring(0, remaining.Length - 1);
                        totalValue += digit.Value;
                    }
                }
                else
                {
                    if (remaining.Length >= digit.Text.Length && remaining.Substring(remaining.Length - digit.Text.Length, digit.Text.Length) == digit.Text)
                    {
                        remaining = remaining.Substring(0, remaining.Length - digit.Text.Length);
                        totalValue += digit.Value;
                    }
                }
                
            }

            return totalValue;
        }

        public string ConvertArabicToRoman(int value)
        {
            string output = "";
            int remainingValue = value;

            foreach (RomanDigit digit in digits)
            {
                if (digit.IsMultiUse())
                {
                    while (remainingValue >= digit.Value)
                    {
                        output += digit.Text;
                        remainingValue -= digit.Value;
                    }

                }
                else
                {
                    if (remainingValue >= digit.Value)
                    {
                        output += digit.Text;
                        remainingValue -= digit.Value;
                    }
                }
            }

            return output;
        }
    }
}
