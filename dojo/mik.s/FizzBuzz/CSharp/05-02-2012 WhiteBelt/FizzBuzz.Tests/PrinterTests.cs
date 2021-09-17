using System;
using System.Linq;
using Moq;
using NUnit.Framework;

namespace FizzBuzz.Tests
{
    // ReSharper disable InconsistentNaming
    [TestFixture]
    public class PrinterTests {
        class TestPackage {
            public Printer Tested { get; set; }
            public Mock<ILinePrinter> MockLinePrinter { get; set; }

            public TestPackage() {
                MockLinePrinter = new Mock<ILinePrinter>();
                Tested = new Printer(MockLinePrinter.Object);
            }
        }

        [Test]
        [ExpectedException(typeof(ArgumentNullException))]
        public void constructor_must_throw_ArgumentNullException_if_line_printer_is_null() {
            new Printer(null);
        }

        [Test]
        [ExpectedException(typeof(ArgumentException))]
        public void must_throw_ArgumentException_if_number_of_lines_is_0() {
            var pkg = new TestPackage();
            pkg.Tested.PrintLines(0).Count();
        }

        [Test]
        public void must_call_line_printer_specified_number_of_times() {
            // Arrange
            var pkg = new TestPackage();
            uint times = 100;
            var count = 0;

            pkg.MockLinePrinter
                .Setup(lp => lp.PrintLine(It.IsAny<uint>()))
                .Callback((uint LinePrinter) => count++);

            // Act
            pkg.Tested.PrintLines(times).Count();

            // Assert
            Assert.AreEqual(times, count);
        }

        [Test]
        public void must_print_specified_number_of_lines() {
            // Arrange
            var pkg = new TestPackage();
            uint lines = 100;

            // Act
            var count = pkg.Tested.PrintLines(lines).Count();

            // Assert
            Assert.AreEqual(lines, count);
        }
    }
    // ReSharper restore InconsistentNaming
}
