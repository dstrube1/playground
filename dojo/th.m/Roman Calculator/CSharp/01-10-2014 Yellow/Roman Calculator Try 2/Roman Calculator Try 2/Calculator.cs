using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Roman_Calculator_2
{
    class Calculator
    {
        private Dictionary<string, string> subPairs;
        private string digits = "IVXLCDM";

        public Calculator()
        {
            subPairs = new Dictionary<string, string>();
            subPairs.Add("IV", "IIII");
            subPairs.Add("IX", "VIIII");
            subPairs.Add("XL", "XXXX");
            subPairs.Add("XC", "LXXXX");
            subPairs.Add("CD", "CCCC");
            subPairs.Add("CM", "DCCCC");
        }

        public string Calculate(string expression)
        {
            string[] parts = expression.Split('+');
            string totalValue = "";

            foreach (string part in parts)
            {
                if (totalValue == "") totalValue = part;
                else totalValue = Sum(totalValue, part);
            }

            return totalValue;
        }

        public string Sum(string numI, string numII)
        {
            numI = ExpandSubtractive(numI);
            numII = ExpandSubtractive(numII);

            string num = Sort(numI + numII);

            num = CombineExtras(num);

            num = CollapseToSubtractive(num);

            return num;
        }

        // Re-adds in any needed subtractive digits
        public string CollapseToSubtractive(string num)
        {
            foreach (KeyValuePair<string, string> pair in subPairs.Reverse())
            {
                num = num.Replace(pair.Value, pair.Key);
            }

            return num;
        }

        // Combines any extra numerals into bigger variants
        public String CombineExtras(string num)
        {
            for (int i = 0; i < digits.Length-1; i++)
            {
                var limit = 2;
                if (i%2 == 0) limit = 5;

                string find = "";
                for (int j = 0; j < limit; j++) find += digits[i];

                string replace = "" + digits[i + 1];

                num = num.Replace(find, replace);
            }

            return num;
        }

        // Sorts a random collection of Roman numerals that don't have any subtractive
        // digits into proper order
        public String Sort(string num)
        {
            string sorted = "";

            foreach (char digit in digits.Reverse())
            {
                int count = num.Count(c => c == digit);

                for (int i = 0; i < count; i++) sorted += digit;
            }

            return sorted;
        }

        // Converts any subtractive digits in the Roman numeral to an improper expanded form
        public string ExpandSubtractive(string num)
        {
            foreach (KeyValuePair<string, string> pair in subPairs)
            {
                num = num.Replace(pair.Key, pair.Value);
            }

            return num;
        }
    }
}
