using System.Globalization;

namespace FizzBuzz
{
    using System;

    namespace FizzBuzz
    {
        class Program
        {
            static void Main(string[] args)
            {
                foreach (var line in new LinesPrinter(new LinePrinter()).GetLines(100))
                {
                    Console.WriteLine(line);
                }
                Console.ReadKey();
            }
        }

        public interface ILinePrinter
        {
            string Print(int num);
        }

        public class LinePrinter : ILinePrinter
        {
            private static bool DivisibleByOrContains(int num, int divisor)
            {
                return num%divisor == 0 || num.ToString(CultureInfo.InvariantCulture).Contains(divisor.ToString(CultureInfo.InvariantCulture));
            }

            public string Print(int num)
            {
                if (DivisibleByOrContains(num, 3) && DivisibleByOrContains(num, 5)) return "fizzbuzz";
                if (DivisibleByOrContains(num, 3)) return "fizz";
                if (DivisibleByOrContains(num, 5)) return "buzz";

                return num.ToString();
            }
        }
        public class LinesPrinter
        {
            private ILinePrinter _linePrinter;

            public LinesPrinter(ILinePrinter linePrinter)
            {
                _linePrinter = linePrinter;
            }

            public string[] GetLines(int numLines)
            {
                var outputLines = new string[numLines];

                for (int i = 0; i < numLines; i++)
                {
                    outputLines[i] = _linePrinter.Print(i + 1);
                }

                return outputLines;
            }
        }
    }

}
