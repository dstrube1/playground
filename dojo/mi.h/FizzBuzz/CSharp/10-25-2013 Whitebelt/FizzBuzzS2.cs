using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/* Write a program that prints the numbers from 1 to 100. But for multiples of three print "Fizz"
 * instead of the number and for the multiples of five print "Buzz". For numbers which are multiples
 * of both three and five print "FizzBuzz?". 
 
 Stage 2 - new requirements
1 A number is fizz if it is divisible by 3 or if it has a 3 in it

2 A number is buzz if it is divisible by 5 or if it has a 5 in it
3 Both 1 & 2 then fizzbuzz */

namespace FizzBuzzS2
{
    class Program
    {
        static void Main(string[] args)
        {
            int number = 1;

        Start:

            string tempString = number.ToString();

        if (((number % 3 == 0) || (tempString.Contains("3"))) && ((number % 5 == 0) || (tempString.Contains("5"))))
                goto Both;

            if ((number % 3 == 0) || (tempString.Contains("3")))
                goto Three;

            if ((number % 5 == 0) || (tempString.Contains("5")))
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
