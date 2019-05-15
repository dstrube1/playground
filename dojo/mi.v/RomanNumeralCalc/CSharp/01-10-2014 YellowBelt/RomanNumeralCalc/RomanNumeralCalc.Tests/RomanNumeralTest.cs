using NUnit.Framework;
using RomanNumeralCalc;

namespace RomanNumeralCalc.Tests
{
    [TestFixture]
    public class RomanNumeralTest
    {
        private readonly RomanNumCalc _calc = new RomanNumCalc();
        [Test]
        public void CorrectlyConvertToSubtractive()
        {
            var calculated = _calc.Combine("II", "II");
            Assert.AreEqual("IV", calculated);
        }

        [Test]
        public void CorrectlyConvertToAdditive()
        {
            var calculated = _calc.Combine("III", "III");
            Assert.AreEqual("VI", calculated);
        }

        [Test]
        public void CorrectAddLargerNumbers()
        {
            var calculated = _calc.Combine("CC", "CCC");
            Assert.AreEqual("D", calculated);
        }

        [Test]
        public void CorrectlyConvertCompoundAddition()
        {
            var calculated = _calc.Combine("CDC", "CDC");
            Assert.AreEqual("M", calculated);
        }

        [Test]
        public void CorrectlyConvertLongStrings()
        {
            var calculated = _calc.Combine("IIIIIIIII", "IIIII");
            Assert.AreEqual("XIV", calculated);
        }

        [Test]
        public void CorrectlyIgnoreCasing()
        {
            var calculated = _calc.Combine("IIiIi", "vvIIIii");
            Assert.AreEqual("XX", calculated);
        }

        [Test]
        public void CorrectlyRemoveExceptions()
        {
            var calculated = _calc.Combine("VIIII", "XXXX");
            Assert.AreEqual("XLIX", calculated);
        }

        [Test]
        public void CorrectlyReAddExceptions()
        {
            var calculated = _calc.Combine("XXXXX", "XXXXX");
            Assert.AreEqual("C", calculated);
        }
    }
}
