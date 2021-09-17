using System.Collections.Generic;
using System.Linq;
using RomanCalculatorKata.Abstract;

namespace RomanCalculatorKata.Concrete
{
    public class RomanCalculator : ICalculator
    {
        protected Dictionary<string, string> SubtractionMap;
        protected string Numerals;

        public RomanCalculator()
        {
            //ordering matters - lowest to highest
            Numerals = "IVXLCDM";

            /*The subtraction map should look like the following: 
             *Might consider just making this a literal rather than generating it
             
            SubtractionMap = new Dictionary<string, string>
            {
                {"IV", "IIII
                {"IX", "VIIII"},
                {"XL", "XXXX"},
                {"XC", "LXXXX"},
                {"CD", "CCCC"},
                {"CM", "DCCCC"}
            };
            */
            SubtractionMap = CreateSubtractionMap(Numerals);
        }

        public string Add(string string1, string string2)
        {
            string1 = ExpandToI(ToAdditiveNotation(string1));
            string2 = ExpandToI(ToAdditiveNotation(string2));

            return ToSubtractiveNotation(CondenseToM(string1 + string2));
        }

        //creates the subtraction cases like IV, IX, etc before M. So key would be IV and value would be IIII
        private Dictionary<string, string> CreateSubtractionMap(string numerals)
        {
            var map = new Dictionary<string, string>();

            for (var i = 0; i < numerals.Length - 1; i += 2)
            {
                var current = numerals[i];
                var next = numerals[i + 1];
                var third = numerals[i + 2];
                map.Add("" + current + next, new string(current, 4));
                map.Add("" + current + third, next + new string(current, 4));
            }

            return map;
        }

        private string ToAdditiveNotation(string numerals)
        {
            return SubtractionMap.Aggregate(numerals, (aggregate, kvp) => aggregate.Replace(kvp.Key, kvp.Value));
        }

        private string ToSubtractiveNotation(string numerals)
        {
            return SubtractionMap.Reverse().Aggregate(numerals, (aggregate, kvp) => aggregate.Replace(kvp.Value, kvp.Key));
        }

        //takes all the numerals and converts them to I
        private string ExpandToI(string numerals)
        {
            for (var i = Numerals.Length - 1; i >= 1; i--)
            {
                numerals = numerals.Replace(Numerals[i].ToString(), new string(Numerals[i - 1], i % 2 == 0 ? 2 : 5));
            }

            return numerals;
        }

        //takes all the numerals and converts them to I
        private string CondenseToM(string numerals)
        {
            for (var i = 0; i < Numerals.Length - 1; i++)
            {
                numerals = numerals.Replace(new string(Numerals[i], i % 2 == 0 ? 5 : 2), Numerals[i + 1].ToString());
            }

            return numerals;
        }
    }
}
