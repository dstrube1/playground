using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Text.RegularExpressions;

namespace Paster
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Go_OnClick(object sender, System.EventArgs e)
        {
            //string tempString = Environment.NewLine;
            string tempString = "";
            tempString += leftTextBox.Text;

            string[] split = tempString.Split(new Char[] {'\n'});

            string tempString2 = "";

            foreach (string s in split)
            {

                    tempString2 += leftText.Text;

                    string sNoBreaks = Regex.Replace(s, @"\r\n?|\n", "");
                    //string sNoBreaksNoQuotes = sNoBreaks.Replace("\"", "\\\"");
                    //tempString2 += sNoBreaksNoQuotes;
                    tempString2 += sNoBreaks;
                    tempString2 += rightText.Text;
                    tempString2 += Environment.NewLine;

            }

            bigTextBox.Text = tempString2;

        }

        private void Go2_OnClick(object sender, System.EventArgs e)
        {
            //string tempString = Environment.NewLine;
            string tempString = "";
            tempString += leftTextBox.Text;

            string[] split = tempString.Split(new Char[] { '\n' });

            string tempString2 = "";

            foreach (string s in split)
            {

                tempString2 += leftText.Text;

                string sNoBreaks = Regex.Replace(s, @"\r\n?|\n", "");
                string sNoBreaksNoQuotes = sNoBreaks.Replace("\"", "\\\"");
                tempString2 += sNoBreaksNoQuotes;
                //tempString2 += sNoBreaks;
                tempString2 += rightText.Text;
                tempString2 += Environment.NewLine;

            }

            bigTextBox.Text = tempString2;

            //System.IO.File.WriteAllText(@"C:\zCSProjBackups\" + "pastedcode.txt", tempString2);

            //System.IO.File.WriteAllText(@"C:\zCSProjBackups\" + "pastedcoderesults.txt", "System.Console.WriteLine(\"Press Enter.\");");
        }

        private void Go3_OnClick(object sender, System.EventArgs e)
        {
            //string tempString = Environment.NewLine;
            string tempString = "";
            tempString += leftTextBox.Text;

            string[] split = tempString.Split(new Char[] { '\n' });

            string tempString2 = "";

            foreach (string s in split)
            {

                tempString2 += leftText.Text;

                string sNoBreaks = Regex.Replace(s, @"\r\n?|\n", "");
                string sNoBreaksNoQuotes = sNoBreaks.Replace("\"", "THISISAQUOTE");
                string sNoBreaksNoQuotesNoSlashes = sNoBreaksNoQuotes.Replace("\\", "THISISASLASH");

                sNoBreaksNoQuotesNoSlashes = sNoBreaksNoQuotesNoSlashes.Replace("THISISAQUOTE", "\\\"");
                sNoBreaksNoQuotesNoSlashes = sNoBreaksNoQuotesNoSlashes.Replace("THISISASLASH", "\\\\");

                tempString2 += sNoBreaksNoQuotesNoSlashes;
                //tempString2 += sNoBreaks;
                tempString2 += rightText.Text;
                tempString2 += Environment.NewLine;

            }

            bigTextBox.Text = tempString2;

            //System.IO.File.WriteAllText(@"C:\zCSProjBackups\" + "pastedcode.txt", tempString2);

            //System.IO.File.WriteAllText(@"C:\zCSProjBackups\" + "pastedcoderesults.txt", "System.Console.WriteLine(\"Press Enter.\");");

         //   Console.WriteLine();

           // Console.WriteLine(@"C:\zCSProjBackups\" + "pastedcoderesults.txt" + "System.Console.WriteLine(\"Press Enter.\");");
        }

        private void Go4_OnClick(object sender, System.EventArgs e)
        {
            //string tempString = Environment.NewLine;
            string tempString = leftTextBox.Text;

            string tempString2 = tempString.Replace(Environment.NewLine, replacedText.Text);

            bigTextBox.Text = tempString2;
        }

        private void Go5_OnClick(object sender, System.EventArgs e)
        {
            //string tempString = Environment.NewLine;
            string tempString = leftTextBox.Text;
            string tempString2 = leftTextBox.Text;

            if (!(replaceText.Text.Equals(String.Empty)))
            tempString2 = tempString.Replace(replaceText.Text, Environment.NewLine);

            bigTextBox.Text = tempString2;
        }

        private void Go6_OnClick(object sender, System.EventArgs e)
        {
            //string tempString = Environment.NewLine;
            string tempString = leftTextBox.Text;
            string tempString2 = leftTextBox.Text;

            if (!(replaceText.Text.Equals(String.Empty)))
            tempString2 = tempString.Replace(replaceText.Text, replacedText.Text);

            bigTextBox.Text = tempString2;
        }

        private void Go7_OnClick(object sender, System.EventArgs e)
        {
leftTextBox.Text = bigTextBox.Text;
        }

        private void Go8_OnClick(object sender, System.EventArgs e)
        {
        }

    }
}
