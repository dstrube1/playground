using NUnit.Framework;
using FizzBuzz.Concrete;
using FizzBuzz.Abstract;

namespace UnitTests.Concrete
{
    [TestFixture]
    public class FizzBuzzNumberConverterTest
    {
        protected INumberConverter Converter = new FizzBuzzNumberConverter();

        [TestCase(3, "Fizz")]
        [TestCase(9, "Fizz")]
        [TestCase(13, "Fizz")]
        [TestCase(23, "Fizz")]
        public void FizzOutput(int input, string output)
        {
            Assert.AreEqual(output, Converter.IntToString(input));
        }

        [TestCase(5, "Buzz")]
        [TestCase(10, "Buzz")]
        public void BuzzOutput(int input, string output)
        {
            Assert.AreEqual(output, Converter.IntToString(input));
        }

        [TestCase(15, "FizzBuzz")]
        [TestCase(30, "FizzBuzz")]
        [TestCase(35, "FizzBuzz")]
        public void FizzBuzzOutput(int input, string output)
        {
            Assert.AreEqual(output, Converter.IntToString(input));
        }
    }
}
