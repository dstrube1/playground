using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;

namespace Tests
{
    [TestClass]
    public class OutputTests
    {
        class TestPackage
        {
            public Mock<IPrinter> mockPrinter = new Mock<IPrinter>();
            public FizzBuzzer Printer;
            public TestPackage()
            {
                Printer = new FizzBuzzer(mockPrinter.Object);
            }
        }

       [TestMethod] 
// ReSharper disable InconsistentNaming
        public void Output_must_be_100_lines_long()
// ReSharper restore InconsistentNaming
       {
            var pkg = new TestPackage();
            var output = pkg.Printer.CreateLines(100);

            Assert.AreEqual(100, output.Count());
        }
        [TestMethod]
        public void Fizzbuzzer_should_write_to_Printer()
        {
            var pkg = new TestPackage();
            pkg.Printer.PrintLines(1);
            pkg.mockPrinter.Verify(x => x.Write(It.IsAny<string>()));
        }
    
        [TestMethod]
        public void FizzBuzzer_must_print_fizz_for_number_divisible_only_by_3()
        {
            var pkg = new TestPackage();
            Assert.AreEqual("fizz",pkg.Printer.CreateLine(3));
        }

        [TestMethod]
        public void FizzBuzzer_must_print_buzz_for_number_divisible_only_by_5()
        {
            var pkg = new TestPackage();
            Assert.AreEqual("buzz", pkg.Printer.CreateLine(5));
        }

        [TestMethod]
        public void FizzBuzzer_must_print_fizzbuzz_for_number_divisible_by_3_and_5()
        {
            var pkg = new TestPackage();
            Assert.AreEqual("fizzbuzz", pkg.Printer.CreateLine(15));
        }

        [TestMethod]
        public void FizzBuzzer_must_print_11_for_11()
        {
            var pkg = new TestPackage();

            Assert.AreEqual("11", pkg.Printer.CreateLine(11));


        }
        [TestMethod]
        public void FizzBuzzer_must_print_fizz_output_for_13()
        {
            var pkg = new TestPackage();

            Assert.AreEqual("fizz", pkg.Printer.CreateLine(13));
        }

        [TestMethod]
        public void FizzBuzzer_must_print_buzz_output_for_52()
        {
            var pkg = new TestPackage();

            Assert.AreEqual("buzz", pkg.Printer.CreateLine(52));
        }


        [TestMethod]
        public void FizzBuzzer_must_print_fizzbuzz_output_for_35()
        {
            var pkg = new TestPackage();

            Assert.AreEqual("fizzbuzz", pkg.Printer.CreateLine(35));
        }
    }
}
