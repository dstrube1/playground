using System;

using Xamarin.Forms;
/*
From XAM-130
https://university.xamarin.com/classes#xam130-xaml-in-xamarinforms
*/
namespace Calculator
{
    public partial class MainPage : ContentPage
    {
        //Label resultText;
        int currentState = 1;
        string mathOperator;
        double firstNumber, secondNumber;

        public MainPage()
        {
            InitializeComponent();
            OnClear(this,null);
        }

        void OnSelectNumber(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            string pressed = button.Text;

            if (this.resultText.Text == "0" || currentState < 0)
            {
                this.resultText.Text = "";
                if (currentState < 0)
                {
                    currentState *= -1;
                }
            }

            this.resultText.Text += pressed;

            if (double.TryParse(this.resultText.Text, out double number))
            {
                this.resultText.Text = number.ToString();
                if (currentState == 1)
                {
                    firstNumber = number;
                }
                else
                {
                    secondNumber = number;
                }
            }
        }

        void OnSelectOperator(object sender, EventArgs e)
        {
            currentState = -2;
            Button button = (Button)sender;
            mathOperator = button.Text;
        }

        void OnClear(object sender, EventArgs e)
        {
            firstNumber = 0;
            secondNumber = 0;
            currentState = 1;
            this.resultText.Text = "0";
        }

        void OnCalculate(object sender, EventArgs e)
        {
            if (currentState == 2)
            {
                var result = SimpleCalculator.Calculate(firstNumber, secondNumber, mathOperator);

                this.resultText.Text = result.ToString();
                firstNumber = result;
                currentState = -1;
            }
        }
    }
}
