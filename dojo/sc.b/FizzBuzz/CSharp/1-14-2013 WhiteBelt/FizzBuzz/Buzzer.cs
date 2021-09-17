namespace FizzBuzz
{
    public class Buzzer : IBuzz
    {
        public bool IsBuzz(int number)
        {
            return number%5 == 0;
        }
    }
    public class BuzzerEnhanced: IBuzz
    {
        public IBuzz Original { get; set; }

        public BuzzerEnhanced(IBuzz original)
        {
            Original = original;
        }

        public bool IsBuzz(int number)
        {
            return Original.IsBuzz(number) || number.ToString().Contains("5");
        }
    }
}