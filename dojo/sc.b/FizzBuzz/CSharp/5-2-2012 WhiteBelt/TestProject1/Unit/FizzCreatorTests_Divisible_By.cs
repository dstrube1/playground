using FizzBuzz;
using NUnit.Framework;

namespace TestProject1.Unit
{
    [TestFixture]
    public class FizzCreatorTests_Divisible_By
    {
        [Test]
        public void should_return_fizz_for_three()
        {
            var sut = new FizzCreator();
            var result = sut.GetLine(3);

            Assert.AreEqual("fizz", result.Value);
        }
        [Test]
        public void should_return_buzz_for_five()
        {
            var sut = new FizzCreator();
            var result = sut.GetLine(5);

            Assert.AreEqual("buzz", result.Value);
        }
        [Test]
        public void should_return_fizz_buzz_for_fifteen()
        {
            var sut = new FizzCreator();
            var result = sut.GetLine(15);

            Assert.AreEqual("fizzbuzz", result.Value);
        }
        [Test]
        public void should_return_7_for_seven()
        {
            var sut = new FizzCreator();
            var result = sut.GetLine(7);

            Assert.AreEqual(7.ToString(), result.Value);
        }

    }
}