using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace test_GRITS
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		#region behind the scenes
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox tb_cpr_id;
		private System.Windows.Forms.Button button1;
		private EproLibNET.GRITS grits_object;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.DateTimePicker begin_date;
		private System.Windows.Forms.DateTimePicker end_date;
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
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.tb_cpr_id = new System.Windows.Forms.TextBox();
			this.button1 = new System.Windows.Forms.Button();
			this.label3 = new System.Windows.Forms.Label();
			this.begin_date = new System.Windows.Forms.DateTimePicker();
			this.end_date = new System.Windows.Forms.DateTimePicker();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(16, 16);
			this.label1.Name = "label1";
			this.label1.TabIndex = 0;
			this.label1.Text = "cpr id";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 48);
			this.label2.Name = "label2";
			this.label2.TabIndex = 1;
			this.label2.Text = "begin date";
			// 
			// tb_cpr_id
			// 
			this.tb_cpr_id.Location = new System.Drawing.Point(136, 16);
			this.tb_cpr_id.Name = "tb_cpr_id";
			this.tb_cpr_id.TabIndex = 2;
			this.tb_cpr_id.Text = "test7846";
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(64, 176);
			this.button1.Name = "button1";
			this.button1.TabIndex = 4;
			this.button1.Text = "Go";
			this.button1.Click += new System.EventHandler(this.button1_Click);
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(16, 112);
			this.label3.Name = "label3";
			this.label3.TabIndex = 5;
			this.label3.Text = "end date";
			// 
			// begin_date
			// 
			this.begin_date.CustomFormat = "";
			this.begin_date.Format = System.Windows.Forms.DateTimePickerFormat.Short;
			this.begin_date.Location = new System.Drawing.Point(128, 48);
			this.begin_date.Name = "begin_date";
			this.begin_date.Size = new System.Drawing.Size(104, 20);
			this.begin_date.TabIndex = 7;
			// 
			// end_date
			// 
			this.end_date.Format = System.Windows.Forms.DateTimePickerFormat.Short;
			this.end_date.Location = new System.Drawing.Point(144, 112);
			this.end_date.Name = "end_date";
			this.end_date.Size = new System.Drawing.Size(96, 20);
			this.end_date.TabIndex = 8;
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(292, 273);
			this.Controls.Add(this.end_date);
			this.Controls.Add(this.begin_date);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.button1);
			this.Controls.Add(this.tb_cpr_id);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
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


		#endregion //behind the scenes

		private void button1_Click(object sender, System.EventArgs e)
		{
			grits_object = new EproLibNET.GRITS();
			
			int count = 12;
			//object AdoCon = 1;
			string report_id = "{3758B62C-5B3B-E065-151B-EE36D2CCEBD2}";

			string [] attributes = new string[count];
			string [] values = new string[count];
			
			attributes[0] = "SERVER";//v2=SERVERNAME
			attributes[1] = "DATABASE";
			attributes[2] = "PWD";
			attributes[3] = "REPORTFILENAME";
			attributes[4] = "UID";
			attributes[5] = "OUTPUTDIR";
			attributes[6] = "PROGKEY_ELIG";
			attributes[7] = "SENDINGORG";
			attributes[8] = "STARTDATE";
			attributes[9] = "ENDDATE";
			attributes[10] = "HISTORICAL";
			attributes[11] = "DATA_WHERE"; //v4 cprsystem app role pw
			values[0] = "TECHSERV";
			values[1] = "cpr_405_production";
			values[2] = "";
			values[3] = @"\\developer-ds\CPRFILES\grits.txt"; //doesnt have to be an existing file
			values[4] = "sa";
			values[5] = @"\\developer-ds\cprfiles\grits\";
			values[6] = "GRITS";				// from c_observation, where description=GRITS Eligibility
			values[7] = "1234";					// any # will do
			values[8] = begin_date.Text;
			values[9] = end_date.Text;
			values[10] = "Y";
			values[11] = "applesauce28";

			grits_object.PrintReport(report_id, null, count, attributes, values);
		}
	}
}
