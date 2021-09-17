using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FizzBuzz
{
    class Program
    {
        static void Main(string[] args)
        {


            //code attempt 1 

            String str = "";
            Console.Out.WriteLine("Code 1 -- Stage 1");
            for (int i = 1; i < 101; i ++)
            {
                if (i % 3 == 0) str = "Fizz";
                
                if (i%5 == 0) str += "Buzz";
                
                if (str.Length == 0) str = i.ToString();

                Console.Out.WriteLine( str);
                str = "";
            }

            Console.Out.WriteLine("\n\n\nCode 1 -- Stage 2");
            for (int i = 1; i < 101; i++)
            {
                if (i % 3 == 0 || i %10 == 3) str = "Fizz";

                if (i % 5 == 0) str += "Buzz";

                if (str.Length == 0) str = i.ToString();

                Console.Out.WriteLine(str);
                str = "";
            }

            //code rewrite 
            int number = 0;
            int[] fizzbuzz = {0, 0, 1, 0, 2, 1, 0, 0, 1, 2, 0, 1, 0, 0, 3};


            Console.Out.WriteLine("\n\n\nCode 2 -- Stage 1");
            while (true)
            {
                for (int i = 1; i < 16; i ++)
                {
                    if (fizzbuzz[i - 1] == 1) Console.Out.Write("Fizz");
                    else if (fizzbuzz[i - 1] == 2) Console.Out.Write("Buzz");
                    else if (fizzbuzz[i - 1] == 3) Console.Out.Write("FizzBuzz");
                    else Console.Out.Write(i + number);
                    Console.Out.Write("\n");
                    if (i + number == 100) goto stage_2;
                }
                number += 15;
            }

        stage_2:
            number = 0;

            Console.Out.WriteLine("\n\n\nCode 2 -- Stage 2");
            while (true)
            {
                for (int i = 1; i < 16; i++)
                {
                    if (fizzbuzz[i - 1] == 1) Console.Out.Write("Fizz");
                    else if (fizzbuzz[i - 1] == 2) Console.Out.Write("Buzz");
                    else if (fizzbuzz[i - 1] == 3) Console.Out.Write("FizzBuzz");
                    else if ((i + number) % 10 == 3) Console.Out.Write("Fizz");
                    else Console.Out.Write(i + number);
                    Console.Out.Write("\n");
                    if (i + number == 100) goto finished;
                }
                number += 15;
            }


        finished:
            Console.Read();
            return;

        }
    }
}
