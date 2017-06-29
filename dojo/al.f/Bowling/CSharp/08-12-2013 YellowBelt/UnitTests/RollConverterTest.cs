using Bowling;
using NUnit.Framework;

namespace UnitTests
{
    [TestFixture]
    public class RollConverterTest
    {
        protected RollConverter Converter = new RollConverter();

        [TestCase("XXXXXXXXXXXX", 300)]
        [TestCase("9-9-9-9-9-9-9-9-9-9-", 90)]
        [TestCase("-9-9-9-9-9-9-9-9-9-9", 90)]
        [TestCase("5/5/5/5/5/5/5/5/5/5/5", 150)]
        [TestCase("9-3/613/815/-/8-7/8/8", 131)]
        [TestCase("9-3561368153258-7181", 82)]
        [TestCase("X3/61XXX2/9-7/XXX", 193)]
        public void ToScore(string input, int output)
        {
            Assert.AreEqual(output, Converter.ToScore(input));
        }

        [TestCase("XXXXXXXXXXXX", new int[] { 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 })]
        [TestCase("9-9-9-9-9-9-9-9-9-9-", new int[] { 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0 })]
        [TestCase("-9-9-9-9-9-9-9-9-9-9", new int[] { 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9 })]
        [TestCase("5/5/5/5/5/5/5/5/5/5/5", new int[] { 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 })]
        [TestCase("9-3/613/815/-/8-7/8/8", new int[] { 9, 0, 3, 7, 6, 1, 3, 7, 8, 1, 5, 5, 0, 10, 8, 0, 7, 3, 8, 2, 8 })]
        [TestCase("9-3561368153258-7181", new int[] { 9, 0, 3, 5, 6, 1, 3, 6, 8, 1, 5, 3, 2, 5, 8, 0, 7, 1, 8, 1})]
        [TestCase("X3/61XXX2/9-7/XXX", new int[] {10, 3, 7, 6, 1, 10, 10, 10, 2, 8, 9, 0, 7, 3, 10, 10, 10 })]
        public void ToIntRolls(string input, int[] output)
        {
            Assert.AreEqual(output, Converter.ConvertStringToIntArray(input));
        }
    }
}
