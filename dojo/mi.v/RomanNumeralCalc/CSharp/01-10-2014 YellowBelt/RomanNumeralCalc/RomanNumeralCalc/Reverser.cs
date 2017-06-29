using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RomanNumeralCalc
{
    public class Reverser : IComparer
    {
        public int Compare(object x, object y)
        {
            return ((new CaseInsensitiveComparer()).Compare(y, x));
        }
    }
}
