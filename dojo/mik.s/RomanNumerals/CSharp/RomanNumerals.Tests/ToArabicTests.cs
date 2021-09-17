using System;
using NUnit.Framework;

namespace RomanNumerals.Tests {
    // ReSharper disable InconsistentNaming
    [TestFixture]
    public class ToArabicTests {
        [Test]
        [ExpectedException(typeof(ArgumentException))]
        public void must_throw_ArgumentException_for_null_string() {
            TestNumber(null, 0);
        }

        [Test]
        [ExpectedException(typeof(ArgumentException))]
        public void must_throw_ArgumentException_for_empty_string()
        {
            TestNumber(string.Empty, 0);
        }

        [Test]
        public void must_convert_I_to_1() {
            TestNumber("I", 1);
        }

        [Test]
        public void must_convert_II_to_2() {
            TestNumber("II", 2);
        }

        [Test]
        public void must_convert_III_to_3()
        {
            TestNumber("III", 3);
        }

        [Test]
        public void must_convert_V_to_5() {
            TestNumber("V", 5);
        }

        [Test]
        public void must_convert_VII_to_7()
        {
            TestNumber("VII", 7);
        }

        [Test]
        public void must_convert_IX_to_9()
        {
            TestNumber("IX", 9);
        }

        [Test]
        public void must_convert_X_to_10() {
            TestNumber("X", 10);
        }

        [Test]
        public void must_convert_L_to_50() {
            TestNumber("L", 50);
        }

        public void must_convert_XCIV_to_94() {
            TestNumber("XCIV", 94);
        }

        [Test]
        public void must_convert_C_to_100() {
            TestNumber("C", 100);
        }

        [Test]
        public void must_convert_D_to_500() {
            TestNumber("D", 500);
        }

        [Test]
        public void must_convert_M_to_1000() {
            TestNumber("M", 1000);
        }

        [Test]
        public void must_convert_MIII_to_1003() {
            TestNumber("MIII", 1003);
        }

        [Test]
        public void must_convert_MMMIX_to_3009() {
            TestNumber("MMMIX", 3009);
        }

        private void TestNumber(string romanNumerals, uint expectedResult) {
            var scribe = new Scribe();
            var result = scribe.ToArabic(romanNumerals);
            Assert.AreEqual(expectedResult, result);
        }
    }
    // ReSharper restore InconsistentNaming
}
