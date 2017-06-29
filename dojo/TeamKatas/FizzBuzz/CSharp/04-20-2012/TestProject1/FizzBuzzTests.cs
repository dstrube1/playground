using FizzBuzz.FizzBuzz;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
// ReSharper disable InconsistentNaming
namespace TestProject1
{
    [TestClass]
    public class FizzBuzzTests
    {
        [TestMethod]
        public void output_should_be_specified_number_of_lines()
        {
            // Arrange
            var linePrinter = new Mock<ILinePrinter>();
            var linesPrinter = new LinesPrinter(linePrinter.Object);

            // Act
            var output = linesPrinter.GetLines(100);

            // Assert
            Assert.AreEqual(100, output.Length);
        }

        [TestMethod]
        public void three_should_print_as_fizz()
        {
            var sut = new LinePrinter();
            var output = sut.Print(3);
            Assert.AreEqual("fizz", output);

        }

        [TestMethod]
        public void _5_should_print_as_buzz()
        {
            var sut = new LinePrinter();
            var output = sut.Print(5);
            Assert.AreEqual("buzz", output);
        }
        [TestMethod]
        public void _51_should_print_as_fizzbuzz()
        {
            var sut = new LinePrinter();
            var output = sut.Print(51);
            Assert.AreEqual("fizzbuzz", output); 
        }

        [TestMethod]
        public void _35_should_print_as_fizzbuzz()
        {
            var sut = new LinePrinter();
            var output = sut.Print(35);
            Assert.AreEqual("fizzbuzz", output);
        }
        [TestMethod]
        public void line_ending_in_3_should_print_fizz()
        {
            var sut = new LinePrinter();
            var output = sut.Print(13);
            Assert.AreEqual("fizz", output);
        }
        [TestMethod]
        public void line_starting_in_3_should_print_fizz()
        {
            var sut = new LinePrinter();
            var output = sut.Print(31);
            Assert.AreEqual("fizz", output);
        }

        [TestMethod]
        public void line_ending_in_5_should_print_buzz()
        {
            var sut = new LinePrinter();
            var output = sut.Print(5);
            Assert.AreEqual("buzz", output);
        }

        [TestMethod]
        public void line_starting_in_5_should_print_buzz()
        {
            var sut = new LinePrinter();
            var output = sut.Print(52);
            Assert.AreEqual("buzz", output);
        }

        [TestMethod]
        public void line_divisible_by_three_and_five_should_print_as_fizzbuzz()
        {
            var sut = new LinePrinter();
            var output = sut.Print(15);
            Assert.AreEqual("fizzbuzz", output);
        }

        [TestMethod]
        public void line_divisible_by_neither_three_nor_five_should_print_as_line_number()
        {
            var sut = new LinePrinter();
            var output = sut.Print(2);
            Assert.AreEqual(output, "2");
        }
    }
}
// ReSharper restore InconsistentNaming