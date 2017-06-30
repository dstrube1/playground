using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace test_Interface
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		private System.Windows.Forms.TextBox textBox1;
		private System.Windows.Forms.RadioButton radioButton1;
		private System.Windows.Forms.RadioButton radioButton2;
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.ComboBox comboBox1;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public Form1()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.textBox1 = new System.Windows.Forms.TextBox();
			this.radioButton1 = new System.Windows.Forms.RadioButton();
			this.radioButton2 = new System.Windows.Forms.RadioButton();
			this.button1 = new System.Windows.Forms.Button();
			this.comboBox1 = new System.Windows.Forms.ComboBox();
			this.SuspendLayout();
			// 
			// textBox1
			// 
			this.textBox1.Location = new System.Drawing.Point(8, 32);
			this.textBox1.Name = "textBox1";
			this.textBox1.TabIndex = 0;
			this.textBox1.Text = "";
			// 
			// radioButton1
			// 
			this.radioButton1.Location = new System.Drawing.Point(16, 112);
			this.radioButton1.Name = "radioButton1";
			this.radioButton1.TabIndex = 1;
			this.radioButton1.Text = "radioButton1";
			// 
			// radioButton2
			// 
			this.radioButton2.Location = new System.Drawing.Point(16, 144);
			this.radioButton2.Name = "radioButton2";
			this.radioButton2.TabIndex = 2;
			this.radioButton2.Text = "radioButton2";
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(24, 184);
			this.button1.Name = "button1";
			this.button1.TabIndex = 3;
			this.button1.Text = "button1";
			this.button1.Click += new System.EventHandler(this.button1_Click);
			// 
			// comboBox1
			// 
			this.comboBox1.Location = new System.Drawing.Point(128, 120);
			this.comboBox1.Name = "comboBox1";
			this.comboBox1.Size = new System.Drawing.Size(121, 21);
			this.comboBox1.TabIndex = 4;
			this.comboBox1.Text = "comboBox1";
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(292, 273);
			this.Controls.Add(this.comboBox1);
			this.Controls.Add(this.button1);
			this.Controls.Add(this.radioButton2);
			this.Controls.Add(this.radioButton1);
			this.Controls.Add(this.textBox1);
			this.Name = "Form1";
			this.Text = "Form1";
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
		}

		private void button1_Click(object sender, System.EventArgs e)
		{
			try
			{
				string text = textBox1.Text;
				int count=0;
				int percent=0;
				if (text.EndsWith("%")){
					percent = Int32.Parse(text.Substring(0,text.IndexOf("%")));
					if (percent < 0 || percent > 100){
						MessageBox.Show("Invalid percentage", "Error");
						return;
					}
					MessageBox.Show("deletePercentPatients(percent="+percent+")","Info");
				}
				else {
					count = Int32.Parse(text);
					if (count < 0)
					{
						MessageBox.Show("Invalid patient count", "Error");
						return;
					}
					MessageBox.Show("deleteCountPatients(count="+count+")","Info");
				}
				if (radioButton1.Checked){
					MessageBox.Show("radio1","Info");
				}
				else if (radioButton2.Checked){
					MessageBox.Show("radio2","Info");
				}
				else{
					MessageBox.Show("neither radio","Info");
				}
			}
			catch (Exception exec){
				MessageBox.Show(exec.ToString(),"Error");
			}
		}
	}
}
