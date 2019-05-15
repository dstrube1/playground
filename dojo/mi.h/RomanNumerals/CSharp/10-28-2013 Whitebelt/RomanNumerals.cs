using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RomanNumerals
{
    class Program
    {

        static string convertToRoman(int x)
        {
            string tempString = "";

while (x >= 1000)
{
tempString += "M";
x-= 1000;
}

while (x >= 900)
{
tempString += "CM";
x -= 900;
}

while (x >= 500)
{
tempString += "D";
x-= 500;
}

while (x >= 400)
{
    tempString += "CD";
    x -= 400;
}

while (x >= 100)
{
tempString += "C";
x-= 100;
}

while (x >= 90)
{
    tempString += "XC";
    x -= 90;
}

while (x >= 50)
{
tempString += "L";
x-= 50;
}

while (x >= 40)
{
    tempString += "XL";
    x -= 40;
}

while (x >= 10)
{
tempString += "X";
x-= 10;
}

while (x >= 9)
{
    tempString += "IX";
    x -= 9;
}

while (x >= 5)
{
tempString += "V";
x-= 5;
}

while (x >= 4)
{
    tempString += "IV";
    x -= 4;
}

while (x >= 1)
{
    tempString += "I";
x-= 1;
}

            return tempString;
        }

        static void Main(string[] args)
        {

            Console.WriteLine("Type a number to convert to Roman Numerals.");

            string numberAsString;
            numberAsString = Console.ReadLine();

            int number;
            number = Convert.ToInt32(numberAsString);

            string result;

            result = convertToRoman(number);

            Console.WriteLine("Result: ");
            Console.WriteLine(result);

            Console.WriteLine("Press enter to exit.");
            Console.ReadLine();
        }
    }
}
