using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NUnit.Framework;
using RomanCalculatorKata.Abstract;
using RomanCalculatorKata.Concrete;
using Assert = NUnit.Framework.Assert;

namespace UnitTests.Concrete
{
    [TestFixture]
    public class RomanCalculatorTest
    {
        protected ICalculator Calculator;
        protected RomanCalculator RomanCalculator;
        protected PrivateObject PrivateRomanCalculator;

        public RomanCalculatorTest()
        {
            Calculator = new RomanCalculator();
            RomanCalculator = new RomanCalculator();
            PrivateRomanCalculator = new PrivateObject(RomanCalculator);
        }

        [Test]
        public void CreateSubtractionMap()
        {
            var map = new Dictionary<string, string>
            {
                {"IV", "IIII"},
                {"IX", "VIIII"},
                {"XL", "XXXX"},
                {"XC", "LXXXX"},
                {"CD", "CCCC"},
                {"CM", "DCCCC"}
            };

            Assert.AreEqual(map, PrivateRomanCalculator.Invoke("CreateSubtractionMap", "IVXLCDM"));
        }

        [TestCase("XX", "II", "XXII")]
        [TestCase("D", "D", "M")]
        [TestCase("MCMLIV", "XCII", "MMXLVI")]
        [TestCase("XLVII", "XCIV", "CXLI")]
        [TestCase("MMVIII", "CDIX", "MMCDXVII")]
        [TestCase("XL", "IV", "XLIV")]
        public void Add(string string1, string string2, string output)
        {
            Assert.AreEqual(output, Calculator.Add(string1, string2));
        }

        [TestCase("IV", "IIII")]
        [TestCase("IX", "VIIII")]
        [TestCase("XL", "XXXX")]
        [TestCase("XC", "LXXXX")]
        [TestCase("CD", "CCCC")]
        [TestCase("CM", "DCCCC")]
        [TestCase("CMIX", "DCCCCVIIII")]
        [TestCase("CMXI", "DCCCCXI")]
        public void ToAdditiveNotiation(string input, string output)
        {
            Assert.AreEqual(output, PrivateRomanCalculator.Invoke("ToAdditiveNotation", input));
        }

        [TestCase("IIII", "IV")]
        [TestCase("VIIII", "IX")]
        [TestCase("XXXX", "XL")]
        [TestCase("LXXXX", "XC")]
        [TestCase("CCCC", "CD")]
        [TestCase("DCCCC", "CM")]
        [TestCase("DCCCCVIIII", "CMIX")]
        [TestCase("DCCCCXI", "CMXI")]
        public void ToSubtractiveNotation(string input, string output)
        {
            Assert.AreEqual(output, PrivateRomanCalculator.Invoke("ToSubtractiveNotation", input));
        }

        [TestCase("VII", 7)]
        [TestCase("XIIII", 14)]
        [TestCase("MDCCCCLIIII", 1954)]
        [TestCase("MDCCCCLXXXX", 1990)]
        public void ExpandToI(string input, int iCount)
        {
            Assert.AreEqual(new string('I', iCount), PrivateRomanCalculator.Invoke("ExpandToI", input));
        }

        [TestCase(7, "VII")]
        [TestCase(14, "XIIII")]
        [TestCase(1954, "MDCCCCLIIII")]
        [TestCase(1990, "MDCCCCLXXXX")]
        public void CondenseToM(int iCount, string output)
        {
            Assert.AreEqual(output, PrivateRomanCalculator.Invoke("CondenseToM", new string('I', iCount)));
        }
    }
}
