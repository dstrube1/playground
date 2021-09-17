using NUnit.Framework;

namespace FizzBuzz2
{
    [TestFixture]
    class UnitTest
    {
        [Test]
        public void the_number_1_should_print_1()
        {
            var sut = new FizzBuzzer();

            var result = sut.GetFizzBuzzedLine(1);

            Assert.AreEqual("1", result);
        }

        [Test]
        public void the_number_3_should_print_fizz()
        {
            var sut = new FizzBuzzer();

            var result = sut.GetFizzBuzzedLine(3);

            Assert.AreEqual("fizz", result); 
        }

        [Test]
        public void the_number_5_should_print_buzz()
        {
            var sut = new FizzBuzzer();

            var result = sut.GetFizzBuzzedLine(5);

            Assert.AreEqual("buzz", result);
        }

        [Test]
        public void the_number_15_should_print_fizzbuzz()
        {
            var sut = new FizzBuzzer();

            var result = sut.GetFizzBuzzedLine(15);

            Assert.AreEqual("fizzbuzz", result);
        }

        [Test]
        public void the_number_31_should_print_fizz()
        {
            var sut = new FizzBuzzer();

            var result = sut.GetFizzBuzzedLine(31);

            Assert.AreEqual("fizz", result);
        }

        [Test]
        public void the_number_52_should_print_buzz()
        {
            var sut = new FizzBuzzer();

            var result = sut.GetFizzBuzzedLine(52);

            Assert.AreEqual("buzz", result);
        }

        [Test]
        public void the_number_53_should_print_fizzbuzz()
        {
            var sut = new FizzBuzzer();

            var result = sut.GetFizzBuzzedLine(15);

            Assert.AreEqual("fizzbuzz", result);
        }
    }
}
