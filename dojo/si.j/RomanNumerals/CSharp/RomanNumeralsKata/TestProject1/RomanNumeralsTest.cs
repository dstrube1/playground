using RomanNumeralsKata;
using NUnit.Framework;
using System;

namespace TestProject1
{
    
    
    /// <summary>
    ///This is a test class for RomanNumeralsTest and is intended
    ///to contain all RomanNumeralsTest Unit Tests
    ///</summary>
    [TestFixture()]
    public class RomanNumeralsTest {
        /// <summary>
        ///A test for DecimalToRomNumerals
        ///</summary>
        [Test()]
        public void should_return_I_for_1() {
            RomanNumerals target = new RomanNumerals(); 
            int n = 1; 
            string expected = "I"; 
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_II_for_2() {
            RomanNumerals target = new RomanNumerals();
            int n = 2;
            string expected = "II";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_IV_for_4() {
            RomanNumerals target = new RomanNumerals();
            int n = 4;
            string expected = "IV";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_V_for_5() {
            RomanNumerals target = new RomanNumerals();
            int n = 5;
            string expected = "V";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_VI_for_6() {
            RomanNumerals target = new RomanNumerals();
            int n = 6;
            string expected = "VI";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_IX_for_9() {
            RomanNumerals target = new RomanNumerals();
            int n = 9;
            string expected = "IX";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_X_for_10() {
            RomanNumerals target = new RomanNumerals();
            int n = 10;
            string expected = "X";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_XI_for_11() {
            RomanNumerals target = new RomanNumerals();
            int n = 11;
            string expected = "XI";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_XIV_for_14() {
            RomanNumerals target = new RomanNumerals();
            int n = 14;
            string expected = "XIV";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_XVI_for_16() {
            RomanNumerals target = new RomanNumerals();
            int n = 16;
            string expected = "XVI";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_XIX_for_19() {
            RomanNumerals target = new RomanNumerals();
            int n = 19;
            string expected = "XIX";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_XX_for_20() {
            RomanNumerals target = new RomanNumerals();
            int n = 20;
            string expected = "XX";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_XXI_for_21() {
            RomanNumerals target = new RomanNumerals();
            int n = 21;
            string expected = "XXI";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_XCIX_for_99() {
            RomanNumerals target = new RomanNumerals();
            int n = 99;
            string expected = "XCIX";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_C_for_100() {
            RomanNumerals target = new RomanNumerals();
            int n = 100;
            string expected = "C";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_CI_for_101() {
            RomanNumerals target = new RomanNumerals();
            int n = 101;
            string expected = "CI";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_CXCIV_for_194() {
            RomanNumerals target = new RomanNumerals();
            int n = 194;
            string expected = "CXCIV";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_CMXCIX_for_999() {
            RomanNumerals target = new RomanNumerals();
            int n = 999;
            string expected = "CMXCIX";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_M_for_1000() {
            RomanNumerals target = new RomanNumerals();
            int n = 1000;
            string expected = "M";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_MDCXCVI_for_1696() {
            RomanNumerals target = new RomanNumerals();
            int n = 1696;
            string expected = "MDCXCVI";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
        [Test()]
        public void should_return_MCMXLIV_for_1944() {
            RomanNumerals target = new RomanNumerals();
            int n = 1944;
            string expected = "MCMXLIV";
            string actual;
            actual = target.DecimalToRomNumerals(n);
            Assert.AreEqual(expected, actual);
        }
    }
}
