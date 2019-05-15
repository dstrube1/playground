using System;
using NUnit.Framework;
using RomanNumerals.Abstract;
using RomanNumerals.Concrete;

namespace UnitTests.Concrete
{
    [TestFixture]
    public class RomanNumeralConverterTest
    {
        protected INumeralConverter Converter;

        public RomanNumeralConverterTest()
        {
            Converter = new RomanNumeralConverter();
        }

        [TestCase(1954, "MCMLIV")]
        [TestCase(1990, "MCMXC")]
        [TestCase(2008, "MMVIII")]
        [TestCase(47, "XLVII")]
        public void IntToNumeral(int input, string result)
        {
            Assert.AreEqual(result, Converter.ToNumerals(input));
        }

        [TestCase("MCMLIV", 1954)]
        [TestCase("MCMXC", 1990)]
        [TestCase("MMVIII", 2008)]
        [TestCase("XLVII", 47)]
        public void IntToNumeral(string input, int result)
        {
            Assert.AreEqual(result, Converter.ToInt(input));
        }

        [Test]
        public void BadFormat()
        {
            Assert.Throws<Exception>(() => Converter.ToInt("4"));
        }
    }
}
