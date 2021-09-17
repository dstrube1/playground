namespace RomanNumerals
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.NumeralLabel = new System.Windows.Forms.Label();
            this.InputTextBox = new System.Windows.Forms.TextBox();
            this.ResultLabel = new System.Windows.Forms.Label();
            this.ConverterComboBox = new System.Windows.Forms.ComboBox();
            this.ConverterLabel = new System.Windows.Forms.Label();
            this.ResultTextBox = new System.Windows.Forms.TextBox();
            this.NumeralRadioButton = new System.Windows.Forms.RadioButton();
            this.NumericRadioButton = new System.Windows.Forms.RadioButton();
            this.SuspendLayout();
            // 
            // NumeralLabel
            // 
            this.NumeralLabel.AutoSize = true;
            this.NumeralLabel.Location = new System.Drawing.Point(9, 73);
            this.NumeralLabel.Name = "NumeralLabel";
            this.NumeralLabel.Size = new System.Drawing.Size(31, 13);
            this.NumeralLabel.TabIndex = 0;
            this.NumeralLabel.Text = "Input";
            // 
            // InputTextBox
            // 
            this.InputTextBox.Location = new System.Drawing.Point(12, 98);
            this.InputTextBox.Name = "InputTextBox";
            this.InputTextBox.Size = new System.Drawing.Size(121, 20);
            this.InputTextBox.TabIndex = 3;
            // 
            // ResultLabel
            // 
            this.ResultLabel.AutoSize = true;
            this.ResultLabel.Location = new System.Drawing.Point(153, 73);
            this.ResultLabel.Name = "ResultLabel";
            this.ResultLabel.Size = new System.Drawing.Size(37, 13);
            this.ResultLabel.TabIndex = 5;
            this.ResultLabel.Text = "Result";
            // 
            // ConverterComboBox
            // 
            this.ConverterComboBox.FormattingEnabled = true;
            this.ConverterComboBox.Location = new System.Drawing.Point(12, 40);
            this.ConverterComboBox.Name = "ConverterComboBox";
            this.ConverterComboBox.Size = new System.Drawing.Size(121, 21);
            this.ConverterComboBox.TabIndex = 8;
            this.ConverterComboBox.SelectedIndexChanged += new System.EventHandler(this.ConverterComboBox_SelectedIndexChanged);
            // 
            // ConverterLabel
            // 
            this.ConverterLabel.AutoSize = true;
            this.ConverterLabel.Location = new System.Drawing.Point(9, 15);
            this.ConverterLabel.Name = "ConverterLabel";
            this.ConverterLabel.Size = new System.Drawing.Size(95, 13);
            this.ConverterLabel.TabIndex = 9;
            this.ConverterLabel.Text = "Numeral Converter";
            // 
            // ResultTextBox
            // 
            this.ResultTextBox.Location = new System.Drawing.Point(156, 98);
            this.ResultTextBox.Name = "ResultTextBox";
            this.ResultTextBox.ReadOnly = true;
            this.ResultTextBox.Size = new System.Drawing.Size(80, 20);
            this.ResultTextBox.TabIndex = 10;
            // 
            // NumeralRadioButton
            // 
            this.NumeralRadioButton.AutoSize = true;
            this.NumeralRadioButton.Location = new System.Drawing.Point(156, 10);
            this.NumeralRadioButton.Name = "NumeralRadioButton";
            this.NumeralRadioButton.Size = new System.Drawing.Size(80, 17);
            this.NumeralRadioButton.TabIndex = 11;
            this.NumeralRadioButton.Text = "To Numeral";
            this.NumeralRadioButton.UseVisualStyleBackColor = true;
            // 
            // NumericRadioButton
            // 
            this.NumericRadioButton.AutoSize = true;
            this.NumericRadioButton.Location = new System.Drawing.Point(156, 40);
            this.NumericRadioButton.Name = "NumericRadioButton";
            this.NumericRadioButton.Size = new System.Drawing.Size(80, 17);
            this.NumericRadioButton.TabIndex = 12;
            this.NumericRadioButton.Text = "To Numeric";
            this.NumericRadioButton.UseVisualStyleBackColor = true;
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(245, 127);
            this.Controls.Add(this.NumericRadioButton);
            this.Controls.Add(this.NumeralRadioButton);
            this.Controls.Add(this.ResultTextBox);
            this.Controls.Add(this.ConverterLabel);
            this.Controls.Add(this.ConverterComboBox);
            this.Controls.Add(this.ResultLabel);
            this.Controls.Add(this.InputTextBox);
            this.Controls.Add(this.NumeralLabel);
            this.Name = "MainForm";
            this.Text = "Numeral Converter";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label NumeralLabel;
        private System.Windows.Forms.TextBox InputTextBox;
        private System.Windows.Forms.Label ResultLabel;
        private System.Windows.Forms.ComboBox ConverterComboBox;
        private System.Windows.Forms.Label ConverterLabel;
        private System.Windows.Forms.TextBox ResultTextBox;
        private System.Windows.Forms.RadioButton NumeralRadioButton;
        private System.Windows.Forms.RadioButton NumericRadioButton;
    }
}