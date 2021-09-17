using NSpec;

namespace RomanCalculator
{
// ReSharper disable InconsistentNaming
    public class describe_roman_numeral_caclulater : nspec
    {
        public RomanNumeralCalculator sut;

        void should_add_roman_numerals_correctly()
        {
            before = () => sut = new RomanNumeralCalculator();
            it["I + I should equal II"] = () => sut.Add("I","I").should_be("II");
            it["I + II should equal III"] = () => sut.Add("I", "II").should_be("III");
            it["II + II should equal IV"] = () => sut.Add("II", "II").should_be("IV");
            it["II + III should equal V"] = () => sut.Add("II", "III").should_be("V");
            it["IV + I should equal V"] = () => sut.Add("IV", "I").should_be("V");
            it["CCCLXIX plus DCCCXLV should equal MCCXIV"] = () => sut.Add("CCCLXIX", "DCCCXLV").should_be("MCCXIV");
        }

        void should_substitute_for_subtractions()
        {
            before = () => sut = new RomanNumeralCalculator();
            it["CCCLXIX should be subtracted to CCCLXVIIII"] =
                () => sut.SubstituteSubtractions("CCCLXIX").should_be("CCCLXVIIII");
            it["IX should be subtracted to VIIII"] = () => sut.SubstituteSubtractions("IX").should_be("VIIII");
            it["DCCCXLV should be subtracted to DCCCXXXV"] =
                () => sut.SubstituteSubtractions("DCCCXLV").should_be("DCCCXXXXV");
        }

        void should_sort_numerals()
        {
            before = () => sut = new RomanNumeralCalculator();
            it["CCCLXVIIIIDCCCXXXXV should be sorted to DCCCCCCLXXXXXVVIIII"] = () => sut.Sort("CCCLXVIIIIDCCCXXXXV").should_be("DCCCCCCLXXXXXVVIIII");
            it["VXXI should be sorted to XXVI"] = () => sut.Sort("VXXI").should_be("XXVI");
        }
        
        void should_combine_numeral_groupings()
        {
            before = () => sut = new RomanNumeralCalculator();
            it["DCCCCCCLXXXXXXIIII should be combined to MCCXIIII"] =
                () => sut.CombineGroups("DCCCCCCLXXXXXXIIII").should_be("MCCXIIII");
        }

        void should_replace_subtractions()
        {
            before = () => sut = new RomanNumeralCalculator();
            it["MCCXIIII should be replaced to MCCXIV"] = () => sut.ReplaceSubtractions("MCCXIIII").should_be("MCCXIV");
        }
    }
}
// ReSharper restore InconsistentNaming
