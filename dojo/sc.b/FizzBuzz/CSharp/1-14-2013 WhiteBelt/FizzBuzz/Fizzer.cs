namespace FizzBuzz
{
    public class Fizzer : IFizz
    {
        public bool IsFizz(int number)
        {
            return number%3 == 0;
        }
    }
    public class FizzerEnhanced : IFizz
    {
        public IFizz Original { get; set; }

        public FizzerEnhanced(IFizz original)
        {
            Original = original;
        }

        public bool IsFizz(int number)
        {
            return Original.IsFizz(number) || number.ToString().Contains("3");
        }
    }
}