using System;
using NUnit.Framework;

namespace RomanNumerals.Tests {
    // ReSharper disable InconsistentNaming
    [TestFixture]
    public class ToRomanTests {
        [Test]
        [ExpectedException(typeof(ArgumentException))]
        public void must_throw_ArgumentException_for_0() {
            TestNumber(0, "");
        }

        [Test]
        public void must_convert_1_to_I() {
            TestNumber(1, "I");
        }

        [Test]
        public void must_convert_2_to_II() {
            TestNumber(2, "II");
        }

        [Test]
        public void must_convert_3_to_III()
        {
            TestNumber(3, "III");
        }

        [Test]
        public void must_convert_5_to_V() {
            TestNumber(5, "V");
        }

        [Test]
        public void must_convert_7_to_VII()
        {
            TestNumber(7, "VII");
        }

        [Test]
        public void must_convert_9_to_IX()
        {
            TestNumber(9, "IX");
        }

        [Test]
        public void must_convert_10_to_X() {
            TestNumber(10, "X");
        }

        [Test]
        public void must_convert_50_to_L() {
            TestNumber(50, "L");
        }

        public void must_convert_94_to_XCIV() {
            TestNumber(94, "XCIV");
        }

        [Test]
        public void must_convert_100_to_C() {
            TestNumber(100, "C");
        }

        [Test]
        public void must_convert_500_to_D() {
            TestNumber(500, "D");
        }

        [Test]
        public void must_convert_1000_to_M() {
            TestNumber(1000, "M");
        }

        [Test]
        public void must_convert_1003_to_MIII() {
            TestNumber(1003, "MIII");
        }

        [Test]
        public void must_convert_3009_to_MMMIX() {
            TestNumber(3009, "MMMIX");
        }

        private void TestNumber(uint number, string expectedResult) {
            var scribe = new Scribe();
            var result = scribe.ToRoman(number);
            Assert.AreEqual(expectedResult, result);
        }
    }
    // ReSharper restore InconsistentNaming
}
