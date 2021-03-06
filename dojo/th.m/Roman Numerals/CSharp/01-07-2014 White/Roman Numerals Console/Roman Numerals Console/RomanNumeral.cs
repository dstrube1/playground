using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Roman_Numerals_Console
{
    class RomanNumeral
    {
        public int Value { get; set; }
        public string Text { get; set; }

        public RomanNumeral(string text, int value)
        {
            this.Value = value;
            this.Text = text;
        }

        public bool IsMultiUse()
        {
            return (this.Value.ToString().Substring(0, 1) == "1");
        }
    }
}
