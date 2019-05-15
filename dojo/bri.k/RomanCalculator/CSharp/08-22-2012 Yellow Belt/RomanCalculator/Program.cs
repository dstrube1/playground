namespace RomanCalculator
{
    class Program
    {
        static void Main(string[] args)
        {
            var calc = new RomanNumeralCalculator();
            var sorted = calc.Sort("CCCLXVIIIIDCCCXXXXV");
        }
    }
}
