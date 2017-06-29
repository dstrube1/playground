using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RomanNumeralsKata {
    public class RomanNumerals {
        public String DecimalToRomNumerals(int n) {
            String dec = n.ToString();
            StringBuilder buffer = new StringBuilder("");
            //iteratively compute roman numerals from left to right
            //using c as a counter and r as a place digit
            int c, r;
            int len = dec.Length;
            while (len > 0) {
                r = System.Convert.ToInt32(dec.Substring(dec.Length - len, 1));
                switch (len) {
                    case 4: //thousands place
                        for (c = 0; c < r; c++) {
                            buffer.Append("M");
                        }
                        len--;
                        break;
                    case 3: //hundreds place
                        //construct is a bit weird, since it forces me to add 1 less to 'c' when adding numerals to the buffer
                        //same for case 2 and 1
                        for (c = 0; c < r; c++) { 
                            if (10 % r == 1 && r != 3) {
                                buffer.Append("CM");
                                c = c + 8;
                            }
                            else if (5 % r == 1 && r != 2) {
                                buffer.Append("CD");
                                c = c + 3;
                            }
                            else if (r >= 5 && c < 5) {
                                buffer.Append("D");
                                c = c + 4;
                            }
                            else {
                                buffer.Append("C");
                            }
                        }
                        len--;
                        break;
                    case 2: //tens place
                        for (c = 0; c < r; c++) {
                            if (10 % r == 1 && r != 3) {
                                buffer.Append("XC");
                                c = c + 8;
                            }
                            else if (5 % r == 1 && r != 2) {
                                buffer.Append("XL");
                                c = c + 3;
                            }
                            else if (r >= 5 && c < 5) {
                                buffer.Append("L");
                                c = c + 4;
                            }
                            else {
                                buffer.Append("X");
                            }
                        }
                        len--;
                        break;
                    case 1: //ones place
                        for (c = 0; c < r; c++) {
                            if (10 % r == 1 && r != 3) {
                                buffer.Append("IX");
                                c = c + 8;
                            }
                            else if (5 % r == 1 && r != 2) {
                                buffer.Append("IV");
                                c = c + 3;
                            }
                            else if (r >= 5 && c < 5) {
                                buffer.Append("V");
                                c = c + 4;
                            }
                            else {
                                buffer.Append("I");
                            }
                        }
                        len--;
                        break;
                    default: break;
                }
            }
            return buffer.ToString();
        }
    }
}
