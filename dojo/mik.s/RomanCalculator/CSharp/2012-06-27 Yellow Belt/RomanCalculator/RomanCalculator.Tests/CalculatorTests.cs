using NUnit.Framework;

namespace RomanCalculator.Tests 
{
    // ReSharper disable InconsistentNaming
    [TestFixture]
    public class CalculatorTests
    {
        // This relies on Calculator being stateless - if it is changed to maintain state
        // this should be instantiated per-test
        private readonly Calculator _sut = new Calculator();

        [Test]
        public void add_via_simple_concatenation_must_return_correct_result()
        {
            var result = _sut.Add("V", "II");
            Assert.AreEqual("VII", result);
        }

        [Test]
        public void add_to_higher_level_must_return_correct_result()
        {
            var result = _sut.Add("III", "III");
            Assert.AreEqual("VI", result);
        }

        [Test]
        public void add_with_subtracted_first_operand_must_return_correct_result() 
        {
            var result = _sut.Add("IV", "III");
            Assert.AreEqual("VII", result);
        }

        [Test]
        public void add_with_subtracted_second_operand_must_return_correct_result()
        {
            var result = _sut.Add("III", "IV");
            Assert.AreEqual("VII", result);
        }

        [Test]
        public void add_returning_result_with_four_Is_must_return_subtracted_result()
        {
            var result = _sut.Add("II", "II");
            Assert.AreEqual("IV", result);
        }

        [Test]
        public void add_returning_result_with_four_Xs_must_return_subtracted_result()
        {
            var result = _sut.Add("XX", "XX");
            Assert.AreEqual("XL", result);
        }

        [Test]
        public void add_returning_result_with_four_Cs_must_return_subtracted_result()
        {
            var result = _sut.Add("CC", "CC");
            Assert.AreEqual("CD", result);
        }

        [Test]
        public void add_must_substitute_X_for_two_Vs()
        {
            var result = _sut.Add("V", "V");
            Assert.AreEqual("X", result);
        }

        [Test]
        public void add_must_substitute_C_for_two_Ls()
        {
            var result = _sut.Add("L", "L");
            Assert.AreEqual("C", result);
        }

        [Test]
        public void add_must_substitute_M_for_two_Ds()
        {
            var result = _sut.Add("D", "D");
            Assert.AreEqual("M", result);
        }

        [Test]
        public void add_must_concatenate_multiple_Ms_if_needed()
        {
            var result = _sut.Add("MD", "MD");
            Assert.AreEqual("MMM", result);
        }
    }
    // ReSharper restore InconsistentNaming
}
