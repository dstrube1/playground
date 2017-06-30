using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace testForm
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		private System.Windows.Forms.TextBox t1;
		private System.Windows.Forms.TextBox t2;
		private System.Windows.Forms.Button b1;
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
			this.t1 = new System.Windows.Forms.TextBox();
			this.t2 = new System.Windows.Forms.TextBox();
			this.b1 = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// t1
			// 
			this.t1.Location = new System.Drawing.Point(8, 8);
			this.t1.Name = "t1";
			this.t1.TabIndex = 0;
			this.t1.Text = "";
			// 
			// t2
			// 
			this.t2.Location = new System.Drawing.Point(8, 32);
			this.t2.Name = "t2";
			this.t2.TabIndex = 1;
			this.t2.Text = "";
			// 
			// b1
			// 
			this.b1.Location = new System.Drawing.Point(8, 56);
			this.b1.Name = "b1";
			this.b1.Size = new System.Drawing.Size(112, 23);
			this.b1.TabIndex = 2;
			this.b1.Text = "&Change focus";
			this.b1.Click += new System.EventHandler(this.b1_Click);
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(136, 85);
			this.Controls.Add(this.b1);
			this.Controls.Add(this.t2);
			this.Controls.Add(this.t1);
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

		private void b1_Click(object sender, System.EventArgs e)
		{
			t2.Select();
		}
	}
}
