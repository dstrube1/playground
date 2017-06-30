using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace SecurityManager
{
	/// <summary>
	/// Summary description for fAuthenticate.
	/// </summary>
	public class fAuthenticate : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Button bCancel;
		private System.Windows.Forms.Button bOK;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox tUser;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox tPass;
		private System.Windows.Forms.Label label4;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;


		public string User
		{
			get
			{
				return tUser.Text;
			}
			set
			{
				if(value!=null)
					tUser.Text = value;
				else
					tUser.Text = string.Empty;
			}
		}
		public string Pass
		{
			get
			{
				return tPass.Text;
			}
		}
		public bool FirstTime
		{
			set{
				if (value==true)
					tUser.ReadOnly = false;
				else
					tUser.ReadOnly = true;
			}
		}

		public string Instructions
		{
			set
			{
				if (value!=null)
					label4.Text = value;
				else
					label4.Text = "";
			}
		}
		public fAuthenticate()
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
				if(components != null)
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
			this.bCancel = new System.Windows.Forms.Button();
			this.bOK = new System.Windows.Forms.Button();
			this.label1 = new System.Windows.Forms.Label();
			this.tUser = new System.Windows.Forms.TextBox();
			this.label2 = new System.Windows.Forms.Label();
			this.tPass = new System.Windows.Forms.TextBox();
			this.label4 = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// bCancel
			// 
			this.bCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.bCancel.Location = new System.Drawing.Point(136, 150);
			this.bCancel.Name = "bCancel";
			this.bCancel.TabIndex = 0;
			this.bCancel.Text = "&Cancel";
			this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
			// 
			// bOK
			// 
			this.bOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bOK.Location = new System.Drawing.Point(216, 150);
			this.bOK.Name = "bOK";
			this.bOK.TabIndex = 1;
			this.bOK.Text = "&OK";
			this.bOK.Click += new System.EventHandler(this.bOK_Click);
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(8, 96);
			this.label1.Name = "label1";
			this.label1.TabIndex = 2;
			this.label1.Text = "Username";
			// 
			// tUser
			// 
			this.tUser.Location = new System.Drawing.Point(120, 96);
			this.tUser.Name = "tUser";
			this.tUser.Size = new System.Drawing.Size(136, 20);
			this.tUser.TabIndex = 3;
			this.tUser.Text = "";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 120);
			this.label2.Name = "label2";
			this.label2.TabIndex = 4;
			this.label2.Text = "Password";
			// 
			// tPass
			// 
			this.tPass.Location = new System.Drawing.Point(120, 120);
			this.tPass.Name = "tPass";
			this.tPass.PasswordChar = '*';
			this.tPass.Size = new System.Drawing.Size(136, 20);
			this.tPass.TabIndex = 5;
			this.tPass.Text = "";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(8, 16);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(272, 72);
			this.label4.TabIndex = 7;
			// 
			// fAuthenticate
			// 
			this.AcceptButton = this.bOK;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.bCancel;
			this.ClientSize = new System.Drawing.Size(292, 175);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.tPass);
			this.Controls.Add(this.tUser);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.bOK);
			this.Controls.Add(this.bCancel);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.MaximizeBox = false;
			this.Name = "fAuthenticate";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "EncounterPRO Authentication";
			this.ResumeLayout(false);

		}
		#endregion

		private void bCancel_Click(object sender, System.EventArgs e)
		{
			try
			{
				this.DialogResult = DialogResult.Cancel;
			}
			catch(Exception exec)
			{
				throw exec;
			}
		}

		private void bOK_Click(object sender, System.EventArgs e)
		{
			if (tUser.Text == null || tUser.Text == ""){
				MessageBox.Show("Username cannot be blank");
				return;
			}
			else if (tPass == null || tPass.Text == ""){
				MessageBox.Show("Password cannot be blank");
				return;
			}
			else
			{
				try
				{
					this.DialogResult = DialogResult.OK;
				}
				catch(Exception exec)
				{
					throw exec;
				}
			}
		}
	}
}
