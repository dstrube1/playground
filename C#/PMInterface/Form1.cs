using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace PMInterface
{
	/// <summary>
	/// This assumes that at this practice:
	/// 1- bat and reg files are in the same folder
	/// 2- bat and reg files are on the same drive as where the incoming and outgoing files will be
	/// 3- Elligence directory path is like this:
	///		d:\\Program files\\dsi\\elligence Application Server\\website\\bin\\global\\hl7\\#DATABASENAME#\\jmj
	///	4- Elligence directory path in the reg files is like this:
	///		d:\\Program files\\elligence Application Server\\website\\bin\\global\\hl7\\#DATABASENAME#\\jmj
	///	5- The Release folder is immediately under the HL7Mapping folder
	///	6- Services will be installed
	///	7- All work done in Epro->Config->PM will be done there, before or after work done here
	///	8- ComputerID in o_server_component is correct
	///	9- Rows in o_server_component are otherwise the same as they are in the Master db
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		private System.Windows.Forms.RadioButton radioButton1;
		private System.Windows.Forms.RadioButton radioButton2;
		private System.Windows.Forms.RadioButton radioButton3;
		private System.Windows.Forms.RadioButton radioButton4;
		private System.Windows.Forms.RadioButton radioButton5;
		private System.Windows.Forms.TextBox textBox1;
		private System.Windows.Forms.TextBox textBox2;
		private System.Windows.Forms.TextBox textBox3;
		private System.Windows.Forms.TextBox textBox4;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.TextBox textBox5;
		private System.Windows.Forms.ComboBox comboBox1;
		private System.Windows.Forms.ComboBox comboBox2;
		private System.Windows.Forms.Label label6;
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
			this.radioButton1 = new System.Windows.Forms.RadioButton();
			this.radioButton2 = new System.Windows.Forms.RadioButton();
			this.radioButton3 = new System.Windows.Forms.RadioButton();
			this.radioButton4 = new System.Windows.Forms.RadioButton();
			this.radioButton5 = new System.Windows.Forms.RadioButton();
			this.textBox1 = new System.Windows.Forms.TextBox();
			this.textBox2 = new System.Windows.Forms.TextBox();
			this.textBox3 = new System.Windows.Forms.TextBox();
			this.textBox4 = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.label4 = new System.Windows.Forms.Label();
			this.label5 = new System.Windows.Forms.Label();
			this.textBox5 = new System.Windows.Forms.TextBox();
			this.comboBox1 = new System.Windows.Forms.ComboBox();
			this.comboBox2 = new System.Windows.Forms.ComboBox();
			this.label6 = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// radioButton1
			// 
			this.radioButton1.Location = new System.Drawing.Point(24, 16);
			this.radioButton1.Name = "radioButton1";
			this.radioButton1.TabIndex = 0;
			this.radioButton1.Text = "HL7";
			// 
			// radioButton2
			// 
			this.radioButton2.Location = new System.Drawing.Point(24, 144);
			this.radioButton2.Name = "radioButton2";
			this.radioButton2.TabIndex = 1;
			this.radioButton2.Text = "non-HL7";
			// 
			// radioButton3
			// 
			this.radioButton3.Location = new System.Drawing.Point(88, 48);
			this.radioButton3.Name = "radioButton3";
			this.radioButton3.TabIndex = 2;
			this.radioButton3.Text = "Elligence";
			// 
			// radioButton4
			// 
			this.radioButton4.Location = new System.Drawing.Point(88, 80);
			this.radioButton4.Name = "radioButton4";
			this.radioButton4.TabIndex = 3;
			this.radioButton4.Text = "Centricity";
			// 
			// radioButton5
			// 
			this.radioButton5.Location = new System.Drawing.Point(88, 112);
			this.radioButton5.Name = "radioButton5";
			this.radioButton5.TabIndex = 4;
			this.radioButton5.Text = "Other";
			// 
			// textBox1
			// 
			this.textBox1.Location = new System.Drawing.Point(416, 48);
			this.textBox1.Name = "textBox1";
			this.textBox1.TabIndex = 5;
			this.textBox1.Text = "";
			// 
			// textBox2
			// 
			this.textBox2.Location = new System.Drawing.Point(416, 80);
			this.textBox2.Name = "textBox2";
			this.textBox2.TabIndex = 6;
			this.textBox2.Text = "";
			// 
			// textBox3
			// 
			this.textBox3.Location = new System.Drawing.Point(416, 112);
			this.textBox3.Name = "textBox3";
			this.textBox3.TabIndex = 7;
			this.textBox3.Text = "";
			// 
			// textBox4
			// 
			this.textBox4.Location = new System.Drawing.Point(416, 240);
			this.textBox4.Name = "textBox4";
			this.textBox4.Size = new System.Drawing.Size(32, 20);
			this.textBox4.TabIndex = 8;
			this.textBox4.Text = "";
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(248, 48);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(112, 23);
			this.label1.TabIndex = 9;
			this.label1.Text = "Directory Server";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(248, 80);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(120, 23);
			this.label2.TabIndex = 10;
			this.label2.Text = "Client Workstation";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(248, 112);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(128, 23);
			this.label3.TabIndex = 11;
			this.label3.Text = "Elligence Database";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(248, 144);
			this.label4.Name = "label4";
			this.label4.TabIndex = 12;
			this.label4.Text = "Drive letter";
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(248, 176);
			this.label5.Name = "label5";
			this.label5.TabIndex = 13;
			this.label5.Text = "Windows / Winnt?";
			// 
			// textBox5
			// 
			this.textBox5.Location = new System.Drawing.Point(416, 208);
			this.textBox5.Name = "textBox5";
			this.textBox5.Size = new System.Drawing.Size(256, 20);
			this.textBox5.TabIndex = 14;
			this.textBox5.Text = "";
			// 
			// comboBox1
			// 
			this.comboBox1.Location = new System.Drawing.Point(416, 176);
			this.comboBox1.Name = "comboBox1";
			this.comboBox1.Size = new System.Drawing.Size(121, 21);
			this.comboBox1.TabIndex = 15;
			// 
			// comboBox2
			// 
			this.comboBox2.Location = new System.Drawing.Point(416, 144);
			this.comboBox2.Name = "comboBox2";
			this.comboBox2.Size = new System.Drawing.Size(40, 21);
			this.comboBox2.TabIndex = 16;
			// 
			// label6
			// 
			this.label6.Location = new System.Drawing.Point(248, 208);
			this.label6.Name = "label6";
			this.label6.Size = new System.Drawing.Size(144, 23);
			this.label6.TabIndex = 17;
			this.label6.Text = "Path to bat and reg files";
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(800, 285);
			this.Controls.Add(this.label6);
			this.Controls.Add(this.comboBox2);
			this.Controls.Add(this.comboBox1);
			this.Controls.Add(this.textBox5);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.textBox4);
			this.Controls.Add(this.textBox3);
			this.Controls.Add(this.textBox2);
			this.Controls.Add(this.textBox1);
			this.Controls.Add(this.radioButton5);
			this.Controls.Add(this.radioButton4);
			this.Controls.Add(this.radioButton3);
			this.Controls.Add(this.radioButton2);
			this.Controls.Add(this.radioButton1);
			this.Name = "Form1";
			this.Text = "Practice management system integration setup interface";
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
	}
}
