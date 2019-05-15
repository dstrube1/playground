using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FizzBuzz.Abstract
{
    public interface INumberConverter
    {
        string IntToString(int number);
    }
}
