using System;
using System.Collections.Generic;
using Xamarin.Forms;

namespace Calculator
{
    public partial class CalcButton : ContentView
    {
        public string ButtonText { get; set; }
        public string GridRow { get; set; }
        public string GridColumn { get; set; }

        public CalcButton()
        {
            InitializeComponent();
        }

        //public event SelectNumberEventHandler SelectNumber;

        void OnSelectNumber(object sender, EventArgs e) 
        {
            Button button = (Button)sender;
            string pressed = button.Text;

            //SelectNumber?.Invoke(this, new SelectNumberEventArgs(ButtonText));

            //if (this.resultText.Text == "0" || currentState < 0)
            //{
            //    this.resultText.Text = "";
            //    if (currentState < 0)
            //    {
            //        currentState *= -1;
            //    }
            //}

            //this.resultText.Text += pressed;

            //if (double.TryParse(this.resultText.Text, out double number))
            //{
            //    this.resultText.Text = number.ToString();
            //    if (currentState == 1)
            //    {
            //        firstNumber = number;
            //    }
            //    else
            //    {
            //        secondNumber = number;
            //    }
            //}
        }
    }
}
