using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace RomanNumeralCalc
{
    public class RomanNumCalc
    {
        private static Dictionary<string, string> _dict;
        private static Dictionary<string, string> _adjustments;
        public RomanNumCalc()
        {
            _dict = new Dictionary<string, string>
            {
                {"IV", "IIII"},
                {"IX", "VIIII"},
                {"XL", "XXXX"},
                {"XC", "LXXXX"},
                {"CD", "CCCC"},
                {"CM", "DCCCC"}
            };

            _adjustments = new Dictionary<string, string>
            {
                {"IIIII", "V"},
                {"VV", "X"},
                {"XXXXX", "L"},
                {"LL", "C"},
                {"CCCCC", "D"},
                {"DD", "M"}
            };

        }

        public string Combine(string input1, string input2)
        {
            input1 = input1.ToUpper();
            input2 = input2.ToUpper();

            input1 = RemoveExceptions(input1);
            input2 = RemoveExceptions(input2);

            var combined = input1 + input2;

            combined = Sort(combined);
            combined = Condense(combined);
            combined = AddExceptions(combined);

            return combined;
        }

        public bool ValidateInput(string input)
        {
            return (input != null) && (Regex.IsMatch(input, @"^[a-zA-Z]+$"));
        }

        public string RemoveExceptions(string except)
        {
            return _dict.Keys.Aggregate(except, (current, d) => current.Replace(d, _dict[d]));
        }

        public string AddExceptions(string combined)
        {
            _dict = new Dictionary<string, string>
            {
                {"CM", "DCCCC"},
                {"CD", "CCCC"},
                {"XC", "LXXXX"},
                {"XL", "XXXX"},
                {"IX", "VIIII"},
                {"IV", "IIII"}
                
            };
            return _dict.Keys.Aggregate(combined, (current, d) => current.Replace(_dict[d], d));
        }

        public string Condense(string toBeCondensed)
        {
            return _adjustments.Keys.Aggregate(toBeCondensed, (current, a) => current.Replace(a, _adjustments[a]));
        }

        public string Sort(string sortable)
        {
            char[] numerals = { 'M', 'D', 'C', 'L', 'X', 'V', 'I' };
            var characters = sortable.ToCharArray();
            // this line below was originally two foreach loops, reformatted by Resharper.. sorry for the crazy looking syntax.
            return (from n in numerals from c in characters where c == n select c).Aggregate("", (current, c) => current + c.ToString(CultureInfo.InvariantCulture));
        }
    }
}
