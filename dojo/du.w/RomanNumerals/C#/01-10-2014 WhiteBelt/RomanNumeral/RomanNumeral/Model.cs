using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RomanNumeral
{
    public class Model
    {
        public static Dictionary<string, int> romanNumbers = new Dictionary<string, int>()
        {
            {"M" , 1000},
            {"CM" , 900},
            {"D" , 500},
            {"CD" , 400},
            {"C" , 100},
            {"LC" , 90},
            {"L" , 50},
            {"XL" , 40},
            {"X" , 10},
            {"IX" , 9},
            {"V" , 5},
            {"IV" , 4},
            {"I" , 1},
           

        };
    }
}
