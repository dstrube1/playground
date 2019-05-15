using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace Roman_Calculator_Console
{
    [TestFixture]
    class CalculatorTest
    {
        [Test]
        public void TwoNumberAdditionTest()
        {
            Calculator c = new Calculator();

            Assert.AreEqual("II", c.Calculate("I + I"));
            Assert.AreEqual("IV", c.Calculate("II + II"));
            Assert.AreEqual("M", c.Calculate("D+D"));
            Assert.AreEqual("IX", c.Calculate("V + IV"));
            Assert.AreEqual("XVIII", c.Calculate("IX+IX"));
            Assert.AreEqual("MCMXCV", c.Calculate("MD+CDXCV"));
            Assert.AreEqual("MM", c.Calculate("CD+MDC"));
        }

        [Test]
        public void MultiNumberAditionTest()
        {
            Calculator c = new Calculator();

            Assert.AreEqual("IV", c.Calculate("I+I+I+I"));
            Assert.AreEqual("CM", c.Calculate("D + C + C + C + C"));
            Assert.AreEqual("XVI", c.Calculate("IV + IV + VIII"));
            Assert.AreEqual("X", c.Calculate("V+I+I+I+I+I"));
            Assert.AreEqual("MCD", c.Calculate("CM+L+L+L+L + L + L+L+L +L +L"));
            Assert.AreEqual("MCM", c.Calculate("D +D + D + CD"));
        }

        [Test]
        public void MultiVersusTwoTest()
        {
            Calculator c = new Calculator();

            Assert.AreEqual(c.Calculate("X+V+C+D"), c.Calculate(c.Calculate("X+V") + " + " + c.Calculate("C+D")));
            Assert.AreEqual(c.Calculate("XL+LX+MD+XVI"), c.Calculate(c.Calculate("XL+LX") + " + " + c.Calculate("MD+XVI")));
            Assert.AreEqual(c.Calculate("CD+VII+XII+XL"), c.Calculate(c.Calculate("CD+VII") + " + " + c.Calculate("XII+XL")));
        }
    }
}
