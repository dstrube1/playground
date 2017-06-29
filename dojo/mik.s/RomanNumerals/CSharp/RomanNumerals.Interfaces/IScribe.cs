namespace RomanNumerals.Interfaces
{
    public interface IScribe {
        string ToRoman(uint number);
        uint ToArabic(string numerals);
    }
}
