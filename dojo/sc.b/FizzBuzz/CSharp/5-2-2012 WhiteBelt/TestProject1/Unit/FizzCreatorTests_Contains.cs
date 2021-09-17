using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FizzBuzz;
using NUnit.Framework;
using TestProject1.Specs;

namespace TestProject1.Unit
{
    [TestFixture]
    public class FizzCreatorTests_Contains
    {
        [Test]
        public void should_return_fizz_for_13()
        {
            var sut = new FizzCreator();
            var result = sut.GetLine(13);

            Assert.AreEqual("fizz", result.Value);
        }
        [Test]
        public void should_return_buzz_for_52()
        {
            var sut = new FizzCreator();
            var result = sut.GetLine(52);

            Assert.AreEqual("buzz", result.Value);
        }

        [Test]
        public void should_return_fizzbuzz_for_53_because_it_contains_both_5_and_3()
        {
            var sut = new FizzCreator();
            var result = sut.GetLine(53);

            Assert.AreEqual("fizzbuzz", result.Value);
        }

        [Test]
        public void should_return_fizzbuzz_for_35_because_it_contains_5_and_is_divisible_by_3()
        {
            var sut = new FizzCreator();
            var result = sut.GetLine(35);

            Assert.AreEqual("fizzbuzz", result.Value);
        }
    }
}
