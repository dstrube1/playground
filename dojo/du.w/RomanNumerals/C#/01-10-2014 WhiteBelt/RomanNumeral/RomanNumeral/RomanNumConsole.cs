using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using RomanNumeral;

namespace RomanNumeral
{
    class RomanNumConsole
    {
        /// <summary>
        /// laid out as MVC
        /// RomanNumConsole is set up as the View
        /// Convert is the Control
        /// Model is the Model
        /// </summary>
        /// <param name="args"></param>
      
        static void Main(string[] args)
        {
            string output = "";

            Console.WriteLine("Enter a number to be converted to Roman Numeral.");

            while (true)
            {                
                string line = Console.ReadLine();

                line.Replace(" ", string.Empty);

                bool add = line.IndexOf("+", StringComparison.CurrentCultureIgnoreCase) > -1;
                bool subtract = line.IndexOf("-", StringComparison.CurrentCultureIgnoreCase) > -1;

                // dividing the equation at the operator.
                string[] substrings;

                if(add)
                {
                    substrings = line.Split('+');

                    if (Convert.ParseRom(substrings)) // if roman numeral
                    {
                        Convert.ConvertToNum(substrings);
                        Console.WriteLine("we have to add Roman Numerals!!!!!");
                    }
                    else 
                    if (Convert.ParseNum(substrings)) // if numbers
                    {
                        Console.WriteLine("we have to add numbers");
                    }
                    
                }
                else if (subtract)
                {

                }


                #region ConvertNumbers
                if (Convert.ParseNum(line)) // if the line is a number
                {
                    output = "";
                    int convertedInt;
                    int.TryParse(line, out convertedInt); // convert the input number from string to int
                    output +=  Convert.ConvertToRom(convertedInt);

                   
                }
                else if (Convert.ParseRom(line)) // if the line is a Roman Numeral
                {
                    output = "";

                    output += Convert.ConvertToNum(line).ToString();
                }
                else
                {
                    //output = "Not a number! Not a Roman Numeral!";
                }
                #endregion


                Console.WriteLine(output);
            }

        }

    
    }
}
