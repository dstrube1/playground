using NUnit.Framework;

namespace FizzBuzz.Unit
{
    [TestFixture]
    internal class Fizz_Tests
    {
        [Test]
        public void _3_should_Fizz()
        {
            var sut = new Fizzer();
            var result = sut.IsFizz(3);
            Assert.That(result, Is.True);
        }

        [Test]
        public void _5_should_not_Fizz()
        {
            var sut = new Fizzer();
            var result = sut.IsFizz(5);
            Assert.That(result, Is.False);
        }
        [Test]
        public void _1_should_not_Fizz()
        {
            var sut = new Fizzer();
            var result = sut.IsFizz(1);
            Assert.That(result, Is.False);
        }
        [Test]
        public void _6_should_Fizz()
        {
            var sut = new Fizzer();
            var result = sut.IsFizz(6);
            Assert.That(result, Is.True);
        }
        [Test]
        public void _15_should_Fizz()
        {
            var sut = new Fizzer();
            var result = sut.IsFizz(15);
            Assert.That(result, Is.True);
        }
    }
}