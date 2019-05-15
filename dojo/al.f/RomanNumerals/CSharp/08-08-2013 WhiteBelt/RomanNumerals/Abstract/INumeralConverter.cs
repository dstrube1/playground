namespace RomanNumerals.Abstract
{
    public interface INumeralConverter
    {
        string ToNumerals(int amount);
        int ToInt(string numerals);
    }
}