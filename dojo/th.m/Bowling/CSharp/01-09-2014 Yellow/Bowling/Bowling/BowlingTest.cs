using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace Bowling
{
    [TestFixture]
    class BowlingTest
    {
        [Test]
        public void TestScoring()
        {
            Assert.AreEqual(300, Program.CalculateScore("XXXXXXXXXXXX"));
            Assert.AreEqual(90, Program.CalculateScore("9-9-9-9-9-9-9-9-9-9-"));
            Assert.AreEqual(150, Program.CalculateScore("5/5/5/5/5/5/5/5/5/5/5"));
            Assert.AreEqual(110, Program.CalculateScore("1/1/1/1/1/1/1/1/1/1/1"));
            Assert.AreEqual(60, Program.CalculateScore("2/2/2/2/2/2"));
        }
    }
}
