using FizzBuzz.Concrete;
using FizzBuzz.Abstract;
using System;
namespace FizzBuzz
{
    class EntryPoint
    {
        static void Main(string[] args)
        {
            INumberConverter converter = new FizzBuzzNumberConverter();

            for (var i = 1; i <= 100; i++)
            {
                Console.WriteLine(converter.IntToString(i));
            }

            Console.ReadKey();
        }
    }
}
