using System;
using NUnit.Framework;

namespace FizzBuzz.Tests {
    // ReSharper disable InconsistentNaming
    [TestFixture]
    public class LinePrinterTests {
        [Test]
        [ExpectedException(typeof(ArgumentException))]
        public void must_throw_ArgumentException_if_line_number_is_0() {
            var sut = new LinePrinter();
            sut.PrintLine(0);
        }

        [Test]
        public void must_print_fizz_for_numbers_divisible_only_by_3() {
            var sut = new LinePrinter();
            var line = sut.PrintLine(3);
            Assert.AreEqual("fizz", line);
        }

        [Test]
        public void must_print_fizz_for_numbers_containing_3()
        {
            var sut = new LinePrinter();
            var line = sut.PrintLine(13);
            Assert.AreEqual("fizz", line);
        }

        [Test]
        public void must_print_buzz_for_numbers_divisible_only_by_5()
        {
            var sut = new LinePrinter();
            var line = sut.PrintLine(5);
            Assert.AreEqual("buzz", line);
        }

        [Test]
        public void must_print_buzz_for_numbers_containing_5() {
            var sut = new LinePrinter();
            var line = sut.PrintLine(52);
            Assert.AreEqual("buzz", line);
        }

        [Test]
        public void must_print_fizzbuzz_for_numbers_divisible_by_3_and_5() {
            var sut = new LinePrinter();
            var line = sut.PrintLine(15);
            Assert.AreEqual("fizzbuzz", line);
        }

        [Test]
        public void must_print_fizzbuzz_for_numbers_containing_3_and_5()
        {
            var sut = new LinePrinter();
            var line = sut.PrintLine(53);
            Assert.AreEqual("fizzbuzz", line);
        }

        [Test]
        public void must_print_fizzbuzz_for_numbers_containing_3_and_divisible_by_5()
        {
            var sut = new LinePrinter();
            var line = sut.PrintLine(30);
            Assert.AreEqual("fizzbuzz", line);
        }

        [Test]
        public void must_print_fizzbuzz_for_numbers_divisible_by_3_and_containing_5()
        {
            var sut = new LinePrinter();
            var line = sut.PrintLine(51);
            Assert.AreEqual("fizzbuzz", line);
        }

        [Test]
        public void must_print_number_for_numbers_divisible_by_or_containing_neither_3_nor_5() {
            var sut = new LinePrinter();
            var line = sut.PrintLine(1);
            Assert.AreEqual("1", line);
        }
    }
    // ReSharper restore InconsistentNaming
}
