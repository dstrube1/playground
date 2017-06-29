using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/* Write a program that prints the numbers from 1 to 100. But for multiples of three print "Fizz"
 * instead of the number and for the multiples of five print "Buzz". For numbers which are multiples
 * of both three and five print "FizzBuzz?". */

namespace FizzBuzzS1
{
    class Program
    {
        static void Main(string[] args)
        {
            int number = 1;
            
            Start:

            if ((number % 3 == 0) && (number % 5 == 0))
                goto Both;

            if (number % 3 == 0)
                goto Three;

            if (number % 5 == 0)
                goto Five;

            else goto None;

            Both:
            System.Console.WriteLine("FizzBuzz?");
            goto End;

            Three:
            System.Console.WriteLine("Fizz");
            goto End;

            Five:
            System.Console.WriteLine("Buzz");
            goto End;

            None:
            System.Console.WriteLine(number);
            goto End;

            End:

            number++;

            if (number < 101)
                goto Start;

            Console.ReadLine();
        }
    }
}
