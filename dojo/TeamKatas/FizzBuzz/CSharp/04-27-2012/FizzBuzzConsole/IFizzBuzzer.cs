using System.Collections.Generic;

namespace FizzBuzzConsole
{
    public interface IFizzBuzzer
    {
        IEnumerable<string> CreateLines(int upperLimit);
    }
}