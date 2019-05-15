using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using RomanNumeral;

namespace RomanNumeral
{
    public class Convert
    {

        // convert the number to the roman numeral
        public static string ConvertToRom(int num)
        {
            string output = "";
            string lastUsed = "";
            while (num > 0)
            {

                lastUsed = Model.romanNumbers.FirstOrDefault(x => x.Value <= num).Key;
                output += lastUsed;
                num -= Model.romanNumbers.FirstOrDefault(x => x.Key == lastUsed).Value;
            }

            return output;
        }

        // convert the roman numeral to the number
        public static int ConvertToNum(string roman)
        {
            char[] input = roman.ToArray();
          
            int sum = 0;

            

            for(int i = 0; i < roman.Length; ++i)
            {
                string currentRomanNum = input[i].ToString();

                currentRomanNum.Reverse();

                int lastNum = 0 ;
                int currentNum = Model.romanNumbers.FirstOrDefault(x => x.Key == currentRomanNum).Value;


               

                // if the current value is greater than the next value
                if (currentNum <= lastNum)
                {
                   sum -= currentNum;
                  // Console.WriteLine(currentNum);
                }
                else
                {
                    sum += currentNum;
                   // Console.WriteLine(currentNum);
                }
                
                
                lastNum = currentNum;
                

              
            }


            return sum;
        }

        public static int ConvertToNum(string[] roman)
        {
            int sum = 0;

            for (int j = 0; j < roman.Length; j++)
            {
                char[] input = roman[j].ToArray();

                for (int i = 0; i < roman.Length; ++i)
                {
                    string currentRomanNum = input[i].ToString();

                    currentRomanNum.Reverse();

                    int lastNum = 0;
                    int currentNum = Model.romanNumbers.FirstOrDefault(x => x.Key == currentRomanNum).Value;




                    // if the current value is greater than the next value
                    if (currentNum <= lastNum)
                    {
                        sum -= currentNum;
                        // Console.WriteLine(currentNum);
                    }
                    else
                    {
                        sum += currentNum;
                        // Console.WriteLine(currentNum);
                    }


                    lastNum = currentNum;



                }
            }
                return sum;
            
         }

        // check to see if the input is a number
         public static bool ParseNum(string num)
        {
            int myNum;

            bool isNum = int.TryParse(num, out myNum);
            
           
            return isNum;
        }

         public static bool ParseNum(string[] num)
         {
             bool isNum = true; 
             int myNum;

             for(int i =0; i > num.Length; i++)
             {
                 if (!int.TryParse(num[i], out myNum))
                 {
                     isNum = false;
                 }
             }

             return isNum;
         }


        // check to see if the input is a roman numeral
          public static bool ParseRom(string rom)
        {
            // isRom stays true until we find something other than what we are looking for

            bool isRom = true;
              // check the characters within the string
            foreach (char c in rom)
            {
                if (!Model.romanNumbers.Keys.Contains(c.ToString()))
                {
                    isRom = false;
                }
                
            }
            return isRom;
        }

          public static bool ParseRom(string[] rom)
          {
              // isRom stays true until we find something other than what we are looking for

              bool isRom = true;

              // check each substring
              for (int i = 0; i > rom.Length; i++)
              {
                  // check the characters within the substring
                  foreach (char c in rom[i])
                  {
                      if (!Model.romanNumbers.Keys.Contains(c.ToString()))
                      {
                          isRom = false;
                          Console.WriteLine(c);
                      }
                      
                  }
              }

              return isRom;
          }
    }
}
