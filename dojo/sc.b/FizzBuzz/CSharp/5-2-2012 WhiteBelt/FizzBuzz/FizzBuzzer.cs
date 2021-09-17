using System.Collections.Generic;
using System.Linq;

namespace FizzBuzz
{
    public class FizzBuzzer
    {
        public IOutput OutputWriter { get; set; }
        public IFizzCreator Creator { get; set; }

        public FizzBuzzer(IOutput outputWriter, IFizzCreator creator)
        {
            OutputWriter = outputWriter;
            Creator = creator;
        }

        public void WriteNumbers(IEnumerable<int> numbers)
        {
            ForNumbers(numbers).ToList().ForEach(x => OutputWriter.Write(x));
        }
        public IEnumerable<LineResult> ForNumbers(IEnumerable<int> numbers)
        {
            return numbers.Select(number => Creator.GetLine(number));
        }
    }
}