using Moq;
using NUnit.Framework;

namespace FizzBuzz.Unit
{
    [TestFixture]
    class FizzerEnhanced_Tests
    {
        private class TestPackage
        {
            public FizzerEnhanced Sut { get; private set; }
            public Mock<IFizz> FizzerOjMock { get; private set; }

            public TestPackage()
            {
                FizzerOjMock = new Mock<IFizz>();
                Sut = new FizzerEnhanced(FizzerOjMock.Object);

                FizzerOjMock.Setup(x => x.IsFizz(It.IsAny<int>())).Returns(false);
            }
        }
        [Test]
        public void _3_should_Fizz()
        {
            var pkg = new TestPackage();
            var result = pkg.Sut.IsFizz(3);
            Assert.That(result, Is.True);
        }
        [Test]
        public void _13_should_Fizz()
        {
            var pkg = new TestPackage();
            var result = pkg.Sut.IsFizz(13);
            Assert.That(result, Is.True);
        }
        [Test]
        public void _9_should_not_Fizz()
        {
            var pkg = new TestPackage();
            var result = pkg.Sut.IsFizz(9);
            Assert.That(result, Is.False);
        }
        [Test]
        public void _33_should_Fizz()
        {
            var pkg = new TestPackage();
            var result = pkg.Sut.IsFizz(33);
            Assert.That(result, Is.True);
        }
    }
    [TestFixture]
    internal class Buzzer_Tests
    {
        [Test]
        public void _3_should_not_Buzz()
        {
            var sut = new Buzzer();
            var result = sut.IsBuzz(3);
            Assert.That(result, Is.False);
        }

        [Test]
        public void _5_should_Buzz()
        {
            var sut = new Buzzer();
            var result = sut.IsBuzz(5);
            Assert.That(result, Is.True);
        }
        [Test]
        public void _1_should_not_Buzz()
        {
            var sut = new Buzzer();
            var result = sut.IsBuzz(1);
            Assert.That(result, Is.False);
        }
        [Test]
        public void _6_should_not_Buzz()
        {
            var sut = new Buzzer();
            var result = sut.IsBuzz(6);
            Assert.That(result, Is.False);
        }
        [Test]
        public void _15_should_Buzz()
        {
            var sut = new Buzzer();
            var result = sut.IsBuzz(15);
            Assert.That(result, Is.True);
        }
    }
}