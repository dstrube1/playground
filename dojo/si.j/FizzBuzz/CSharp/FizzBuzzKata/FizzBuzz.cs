using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FizzBuzzKata
{
    public class FizzBuzz
    {
        public String FizzOrBuzz(int n) {
            StringBuilder sb = new System.Text.StringBuilder("");

            if (n % 3 == 0) { 
                sb.Append("Fizz"); 
            }
            if (n % 5 == 0) { 
                sb.Append("Buzz"); 
            }
            if (!(n % 3 == 0) && !(n % 5 == 0)) {
                sb.Append(n.ToString());
            }
            return sb.ToString();
        }

        public String FizzOrBuzz2(int n) {
            StringBuilder sb = new System.Text.StringBuilder("");
            String num = n.ToString();
            bool fizzFlag = false;
            bool buzzFlag = false;

            if (n % 3 == 0 || num.Contains("3")) {
                fizzFlag = true;
                sb.Append("Fizz");
            }
            if (n % 5 == 0 || num.Contains("5")) {
                buzzFlag = true;
                sb.Append("Buzz");
            }
            if (!fizzFlag && !buzzFlag) {
                sb.Append(n.ToString());
            }
            return sb.ToString();
        }
    }
}
