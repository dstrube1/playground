using System.Collections.Generic;
using System.Linq;

namespace RomanCalculator
{
    public class RomanNumeralCalculator
    {
        private const string NumeralList = "IVXLCDM";
        private readonly Dictionary<string, string> _subtractionSubs = new Dictionary<string, string> { { "IV", "IIII" }, { "IX", "VIIII" }, { "XL", "XXXX" }, { "XC", "LXXXX" }, { "CD", "CCCC" }, { "CM", "DCCCC" }, };
        private readonly Dictionary<string, string> _combinations = new Dictionary<string, string> { { "V", "IIIII" }, { "X", "VV" }, { "L", "XXXXX" }, { "C", "LL" }, { "D", "CCCCC" }, { "M", "DD" }, }; 

        public string Add(string first, string second)
        {
            var firstSubbed = SubstituteSubtractions(first);
            var secondSubbed = SubstituteSubtractions(second);
            var concatenatedNumeral = firstSubbed + secondSubbed;
            var sortedNumeral = Sort(concatenatedNumeral);
            var combinedNumeral = CombineGroups(sortedNumeral);
            var replacedSubs = ReplaceSubtractions(combinedNumeral);
            return replacedSubs;
        }

        public string SubstituteSubtractions(string numeral)
        {
            return _subtractionSubs.Aggregate(numeral, (current, subtractionSub) => current.Replace(subtractionSub.Key, subtractionSub.Value));
        }

        public string Sort(string numeral)
        {
            var test = (numeral.OrderByDescending(x => x, new NumeralCharComparer()));
            return new string(test.ToArray());
        }

        class NumeralCharComparer : IComparer<char>
        {
            public int Compare(char x, char y)
            {
                if (NumeralList.IndexOf(x) < NumeralList.IndexOf(y))
                    return -1;
                return NumeralList.IndexOf(x) == NumeralList.IndexOf(y) ? 0 : 1;
            }
        }

        public string CombineGroups(string numeral)
        {
            return _combinations.Aggregate(numeral, (s, pair) => s.Replace(pair.Value, pair.Key));
        }

        public string ReplaceSubtractions(string numeral)
        {
            return _subtractionSubs.Aggregate(numeral, (s, pair) => s.Replace(pair.Value, pair.Key));
        }
    }
}