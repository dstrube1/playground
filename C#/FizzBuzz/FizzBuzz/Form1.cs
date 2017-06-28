using System;
using System.Windows.Forms;

namespace FizzBuzz
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            SetText();
        }

        private void SetText()
        {
            richTextBox1.Text = "";

            for (int i=1; i <= 100; i++){
		
			bool isFizz = isFizzF(i);
			bool isBuzz = isBuzzF(i);
			
			if (isFizz && isBuzz)
                richTextBox1.Text += "FizzBuzz\n";
			else if (isFizz)
                richTextBox1.Text += "Fizz\n";
			else if (isBuzz)
                richTextBox1.Text += "Buzz\n";
			else //(!isFizz && !isBuzz)
                richTextBox1.Text += i + "\n";

    		}
        }

        private bool isFizzF(int i)
        {
            String s = i.ToString();

            if (i % 3 == 0 || (checkBox1.Checked && s.Contains("3")))
                return true;
            return false;
        }

        private bool isBuzzF(int i)
        {
            String s = i.ToString();

            if (i % 5 == 0 || (checkBox1.Checked && s.Contains("5")))
                return true;
            return false;
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            SetText();
        }

    }
}
