using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Markup;

namespace RomanNumeralCalc
{
    public class Program
    {

        static void Main(string[] args)
        {
            var combined = "";
            var newCalc = new RomanNumCalc();
            Console.WriteLine("Please enter the first Roman Numeral:");
            var input1 = Console.ReadLine();

            Console.WriteLine("Please enter the second Roman Numeral:");
            var input2 = Console.ReadLine();

            var firstIsValid = newCalc.ValidateInput(input1);
            var secondIsValid = newCalc.ValidateInput(input2);
            
            if (firstIsValid && secondIsValid)
            {
                combined = newCalc.Combine(input1, input2);
            }
        else
            {
                Console.WriteLine("Invalid Input");
            }
            Console.WriteLine(combined);
            Console.ReadKey();
        }

        


    }
}
