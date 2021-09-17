using System;
using System.Linq;
using System.Drawing;
using System.Windows.Forms;
using RomanNumerals.Abstract;
using RomanNumerals.Concrete;

namespace RomanNumerals
{
    class Program
    {
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.Run(new MainForm());
        }
    }
}
