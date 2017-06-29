using System;
using System.Windows.Forms;
using RomanNumerals.Abstract;
using RomanNumerals.Concrete;

namespace RomanNumerals
{
    public partial class MainForm : Form
    {
        protected INumeralConverter Converter;

        public MainForm()
        {
            InitializeComponent();
            Converter = new RomanNumeralConverter();
            ConverterComboBox.Text = "Roman";
            ConverterComboBox.Items.Add("Roman");
            NumeralRadioButton.Checked = true;
            InputTextBox.KeyPress += InputTextBox_KeyPress;
        }

        protected void ConverterComboBox_SelectedIndexChanged(object sender, EventArgs args)
        {
            //not supported until more converters added.
        }

        private void InputTextBox_KeyPress(object sender, KeyPressEventArgs args)
        {
            //didnt press enter
            if (args.KeyChar != (char) 13) return;
            
            try
            {
                if (NumeralRadioButton.Checked)
                {
                    ResultTextBox.Text = Converter.ToNumerals(Convert.ToInt32(InputTextBox.Text));
                }
                else if (NumericRadioButton.Checked)
                {
                    ResultTextBox.Text = Converter.ToInt(InputTextBox.Text).ToString();
                }
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
        }
    }
}
