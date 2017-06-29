using System;
using System.Globalization;

namespace FizzBuzz {
    public class LinePrinter : ILinePrinter {
        public string PrintLine(uint lineNumber) {
            if (lineNumber == 0) {
                throw new ArgumentException();
            }

            var uses3 = (lineNumber % 3 == 0 || lineNumber.ToString(CultureInfo.InvariantCulture).Contains("3"));
            var uses5 = (lineNumber % 5 == 0 || lineNumber.ToString(CultureInfo.InvariantCulture).Contains("5"));

            if (uses3 && uses5) {
                return "fizzbuzz";
            } 
            
            if (uses5) {
                return "buzz";
            }
            
            if (uses3) {
                return "fizz";
            }

            return lineNumber.ToString(CultureInfo.InvariantCulture);
        }
    }
}
