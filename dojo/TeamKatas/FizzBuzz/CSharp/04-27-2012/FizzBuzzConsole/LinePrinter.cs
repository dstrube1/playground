using System;
using System.Collections.Generic;
using FizzBuzzConsole;

namespace Tests
{
    public class FizzBuzzer : IFizzBuzzer
    {
        public IPrinter Printer { get; set; }

        public FizzBuzzer(IPrinter printer)
        {
            Printer = printer;
        }

        public IEnumerable<string> CreateLines(int upperLimit)
        {
            for(int i=1;i<=upperLimit;i++)
            {
                yield return CreateLine(i);
            }
            
        }

        public void PrintLines(int upperLimit)
        {
            foreach (string line in CreateLines(upperLimit))
                Printer.Write(line);
        }

        public string CreateLine(int num)
        {
            bool for3 = DivisibleByOrContains(num, 3);
            bool for5 = DivisibleByOrContains(num, 5);
            if ( for3 && for5) return "fizzbuzz";
            if (for3) return "fizz";
            if (for5) return "buzz";
            return num.ToString();
        }

        public bool DivisibleByOrContains(int num, int divisor)
        {
            return num%divisor == 0 || num.ToString().Contains(divisor.ToString());
        }

    }

    public interface IPrinter
    {
        void Write(string line);
    }
}