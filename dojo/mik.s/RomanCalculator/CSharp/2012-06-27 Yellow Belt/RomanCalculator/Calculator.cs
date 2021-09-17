using System.Linq;
using System.Text;
using RomanCalculator.Interfaces;

namespace RomanCalculator
{
    public class Calculator : ICalculator
    {
        public string Add(string n1, string n2)
        {
            n1 = RemoveSubtractions(n1);
            n2 = RemoveSubtractions(n2);

            var sum = n1 + n2;
            sum = SortNumerals(sum);
            sum = CollapseRepeats(sum);
            sum = ApplySubtractions(sum);

            return sum;
        }

        #region Private helpers

        private readonly char[] _numerals = new [] { 'M', 'D', 'C', 'L', 'X', 'V', 'I'};

        private readonly string[][] _subtractions = 
            new [] {
                new [] {"IV", "IIII"},
                new [] {"IX", "VIIII"},
                new [] {"XL", "XXXX"},
                new [] {"XC", "LXXXX"}, 
                new [] {"CD", "CCCC"},
                new [] {"CM", "DCCCC"}
            };

        private readonly string[][] _repeats =
            new [] {
                new[] {"IIIII", "V"},
                new[] {"VV", "X"},
                new[] {"XXXXX", "L"},
                new[] {"LL", "C"},
                new[] {"CCCCC", "D"},
                new[] {"DD", "M"}
            };

        private string RemoveSubtractions(string n)
        {
            return _subtractions.Aggregate(n, (current, pair) => current.Replace(pair[0], pair[1]));
        }

        private string CollapseRepeats(string n)
        {
            return _repeats.Aggregate(n, (current, pair) => current.Replace(pair[0], pair[1]));
        }

        private string ApplySubtractions(string n)
        {
            return _subtractions.Aggregate(n, (current, pair) => current.Replace(pair[1], pair[0]));
        }

        private string SortNumerals(string n)
        {
            // I considered doing this via a custom IComparer, but that would likely have been more code and 
            // would likely not have performed any better on small strings like these.
            var sb = new StringBuilder();

            foreach (var numeral in _numerals)
            {
                foreach (var c in n)
                {
                    if (c == numeral)
                    {
                        sb.Append(c);
                    }
                }
            }

            return sb.ToString();
        }

        #endregion
    }
}
