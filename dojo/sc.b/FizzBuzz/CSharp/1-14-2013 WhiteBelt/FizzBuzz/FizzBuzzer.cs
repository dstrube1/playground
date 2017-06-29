using System.Collections.Generic;
using System.Linq;

namespace FizzBuzz
{
    public class FizzBuzzer
    {
        public IFizz Fizzer { get; set; }
        public IBuzz Buzzer { get; set; }

        public FizzBuzzer(IFizz fizzer, IBuzz buzzer)
        {
            Fizzer = fizzer;
            Buzzer = buzzer;
        }
        public string ConvertAll(List<int> listOfNumbers)
        {
            return string.Join(",", listOfNumbers.Select(ConvertNumber));
        }
        public string ConvertNumber(int number)
        {
            var isFizz = Fizzer.IsFizz(number);
            var isBuzz = Buzzer.IsBuzz(number);
            if (isBuzz && isFizz)
                return "FizzBuzz";
            if (isBuzz)
                return "Buzz";
            if (isFizz)
                return "Fizz";
            
            return number.ToString();
        }

    }
}