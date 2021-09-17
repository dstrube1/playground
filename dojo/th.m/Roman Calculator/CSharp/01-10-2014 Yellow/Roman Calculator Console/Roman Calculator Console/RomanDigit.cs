using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Roman_Calculator_Console
{
    class RomanDigit
    {
        public int Value { get; set; }
        public string Text { get; set; }

        public RomanDigit(string text, int value)
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
