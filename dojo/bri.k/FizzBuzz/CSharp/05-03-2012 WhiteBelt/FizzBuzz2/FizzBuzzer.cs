using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;

namespace FizzBuzz2
{
    class FizzBuzzer
    {
        public static void Main()
        {
            
        }
        public string GetFizzBuzzedLine(int input)
        {
            if (DivisibleByOrContains(input, 3) && DivisibleByOrContains(input, 5)) return "fizzbuzz";
            if (DivisibleByOrContains(input,5)) return "buzz";
            if (DivisibleByOrContains(input,3)) return "fizz";
// ReSharper disable SpecifyACultureInStringConversionExplicitly
            return input.ToString();
// ReSharper restore SpecifyACultureInStringConversionExplicitly
        }

        private bool DivisibleByOrContains(int input, int divisor)
        {
// ReSharper disable SpecifyACultureInStringConversionExplicitly
            if (input % divisor == 0 || input.ToString().Contains(divisor.ToString()))
// ReSharper restore SpecifyACultureInStringConversionExplicitly
                return true;
            return false;
        }
    }
}
