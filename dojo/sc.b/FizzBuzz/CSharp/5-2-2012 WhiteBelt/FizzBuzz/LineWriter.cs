namespace FizzBuzz
{
    public class FizzCreator : IFizzCreator
    {
        public LineResult GetLine(int i)
        {
            if ((i % 3 == 0 || i.ToString().Contains("3")) && (i % 5 == 0 || i.ToString().Contains("5")))
                return new LineResult {Index = i, Value = "fizzbuzz"};
            if (i%3 == 0 || i.ToString().Contains("3"))
                return new LineResult {Index = i, Value = "fizz"};
            if (i%5 == 0 || i.ToString().Contains("5"))
                return new LineResult {Index = i, Value = "buzz"};
            return new LineResult {Index = i, Value =i.ToString()};
        }
    }
    public class NullWriter : IOutput
    {
        public void Write(LineResult value)
        {
            
        }
    }
}