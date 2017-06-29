using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace Roman_Calculator_2
{
    [TestFixture]
    class CalculatorTest
    {
        private readonly Calculator _calculator;

        public CalculatorTest()
        {
            _calculator = new Calculator();
        }

        [Test]
        public void TestCalculate()
        {
            Assert.AreEqual("IV", _calculator.Calculate("I+I+I+I"));
            Assert.AreEqual("CM", _calculator.Calculate("D + C + C + C + C"));
            Assert.AreEqual("XVII", _calculator.Calculate("IV + IV + IX"));
            Assert.AreEqual("X", _calculator.Calculate("V+I+I+I+I+I"));
            Assert.AreEqual("MCD", _calculator.Calculate("CM+L+L+L+L + L + L+L+L +L +L"));
            Assert.AreEqual("MCMIV", _calculator.Calculate("D +DII + D + CDII"));
        }

        [Test]
        public void TestCombineExtras()
        {
            Assert.AreEqual("XII", _calculator.CombineExtras("VVII"));
            Assert.AreEqual("CDC" , _calculator.CombineExtras("CDLL"));
            Assert.AreEqual("XI", _calculator.CombineExtras("IIIIIIIIIII"));
        }

        [Test]
        public void TestExpandSubtractive()
        {
            Assert.AreEqual("XIIII", _calculator.ExpandSubtractive("XIV"));
            Assert.AreEqual("CCCCLXXXX", _calculator.ExpandSubtractive("CDXC"));
        }

        [Test]
        public void TestCollapseToSubtractive()
        {
            Assert.AreEqual("XIV", _calculator.CollapseToSubtractive("XIIII"));
            Assert.AreEqual("CDXCIII", _calculator.CollapseToSubtractive("CCCCLXXXXIII"));
        }

        [Test]
        public void TestSort()
        {
            Assert.AreEqual("XXXVVVIII", _calculator.Sort("XIVIXVVIX"));
            Assert.AreEqual("MMMCCC", _calculator.Sort("MMCMCC"));
            Assert.AreEqual("MDCLXVI", _calculator.Sort("IVXCLDM"));
        }

        [Test]
        public void TestSum()
        {
            Assert.AreEqual("XXII", _calculator.Sum("XX", "II"));
            Assert.AreEqual("D", _calculator.Sum("CD", "C"));
            Assert.AreEqual("IX", _calculator.Sum("V", "IV"));
        }
    }
}
