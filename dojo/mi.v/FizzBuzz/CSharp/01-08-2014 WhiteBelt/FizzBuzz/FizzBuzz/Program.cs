using System;


namespace FizzBuzz
{
    class Program
    {
        static void Main(string[] args)
        {
            //Phase 2
            for (int i = 1; i <= 100; i++)
            {
                string s = Convert.ToString(i);
                if (((i % 3 == 0) && (i % 5 == 0)) || (s.Contains("5") && s.Contains("3")))
                {
                    Console.WriteLine("FizzBuzz");
                    continue;
                }
                if ((i % 3 == 0) || s.Contains("3"))
                {
                    Console.WriteLine("Fizz");
                    continue;
                }
                if ((i % 5 == 0) || (s.Contains("5")))
                {
                    Console.WriteLine("Buzz");
                    continue;
                }
                Console.WriteLine(i);
            }
            Console.ReadLine();
        }
    }
}
