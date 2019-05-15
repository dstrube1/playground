using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FizzBuzz.Abstract;

namespace FizzBuzz.Concrete
{
    public class FizzBuzzNumberConverter : INumberConverter
    {
        public string IntToString(int number)
        {
            bool multipleOf3 = number % 3 == 0 ? true : false;
            bool multipleOf5 = number % 5 == 0 ? true : false;

            if ((MultipleOf(number, 3) || Contains(number, 3)) && (MultipleOf(number, 5) || Contains(number, 5)))
            {
                return "FizzBuzz";
            }
            else if (MultipleOf(number, 3) || Contains(number, 3))
            {
                return "Fizz";
            }
            else if (MultipleOf(number, 5) || Contains(number, 5))
            {
                return "Buzz";
            }
            else
            {
                return number.ToString();
            }
        }

        private bool Contains(int number, int needle)
        {
            string numbers = number.ToString();
            return numbers.Contains(needle.ToString());
        }

        private bool MultipleOf(int number, int of)
        {
            return number % of == 0;
        }
    }
}
