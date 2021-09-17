using Xunit;
using Xunit.Extensions;

namespace RomanNumerals
{
    public class Test
    {
        [Theory,
         InlineData(1, "I"),
         InlineData(5, "V"),
         InlineData(10, "X"),
         InlineData(50, "L"),
         InlineData(100, "C"),
         InlineData(500, "D"),
         InlineData(1000, "M")]
        public void MustReturnTheBasicNumbers(int arabic, string roman)
        {
            string result = arabic.ToRoman();
            Assert.Equal(roman, result);
        }
        [Theory,
         InlineData(2, "II"),
         InlineData(3, "III"),
         InlineData(20, "XX"),
         InlineData(30, "XXX"),
         InlineData(200, "CC"),
         InlineData(300, "CCC")]
        public void MustReturnForMultipleRoman(int arabic, string roman)
        {
            string result = arabic.ToRoman();
            Assert.Equal(roman, result);
        }
        [Theory,
         InlineData(6, "VI"),
         InlineData(7, "VII"),
         InlineData(11, "XI"),
         InlineData(16, "XVI")]
        public void MustReturnForMultipleAbovePreviousRoman(int arabic, string roman)
        {
            string result = arabic.ToRoman();
            Assert.Equal(roman, result);
        }
        [Theory,
         InlineData(4, "IV"),
         InlineData(9, "IX"),
         InlineData(40, "XL"),
         InlineData(90, "XC"),
         InlineData(400, "CD"),
         InlineData(900, "CM")]
        public void MustReturnForOneFewerRoman(int arabic, string roman)
        {
            string result = arabic.ToRoman();
            Assert.Equal(roman, result);
        }
        [Theory,
         InlineData(1800, "MDCCC"),
         InlineData(890, "DCCCXC"),
         InlineData(707, "DCCVII"),
         InlineData(89, "LXXXIX"),
         InlineData(1084, "MLXXXIV"),
         InlineData(1484, "MCDLXXXIV")]
        public void MustReturnComplexExamples(int arabic, string roman)
        {
            string result = arabic.ToRoman();
            Assert.Equal(roman, result);
        }

    }
}