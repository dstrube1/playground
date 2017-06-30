using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace SecurityManager
{
	/// <summary>
	/// Summary description for fChangePassword.
	/// </summary>
	public class fChangePassword : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.TextBox tUser;
		private System.Windows.Forms.TextBox tOldPass;
		private System.Windows.Forms.TextBox tNewPass1;
		private System.Windows.Forms.TextBox tNewPass2;
		private System.Windows.Forms.Button bCancel;
		private System.Windows.Forms.Button bOK;
		private System.Windows.Forms.Label label5;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public string User
		{
			set
			{
				if(value!=null)
					tUser.Text = value;
				else
					tUser.Text = string.Empty;
			}
		}
		public string OldPass
		{
			get{
				if(tOldPass.Text!=null)
					return tOldPass.Text;
				else
					return string.Empty;
			}
		}
		public string NewPass
		{
			get
			{
				if(tNewPass1.Text!=null && tNewPass2.Text == tNewPass1.Text)
					return tNewPass1.Text;
				else
					return string.Empty;
			}
		}

		public fChangePassword()
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
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.label4 = new System.Windows.Forms.Label();
			this.tUser = new System.Windows.Forms.TextBox();
			this.tOldPass = new System.Windows.Forms.TextBox();
			this.tNewPass1 = new System.Windows.Forms.TextBox();
			this.tNewPass2 = new System.Windows.Forms.TextBox();
			this.bCancel = new System.Windows.Forms.Button();
			this.bOK = new System.Windows.Forms.Button();
			this.label5 = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(8, 32);
			this.label1.Name = "label1";
			this.label1.TabIndex = 0;
			this.label1.Text = "Username";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 56);
			this.label2.Name = "label2";
			this.label2.TabIndex = 1;
			this.label2.Text = "Old password";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(8, 80);
			this.label3.Name = "label3";
			this.label3.TabIndex = 2;
			this.label3.Text = "New password";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(8, 104);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(128, 23);
			this.label4.TabIndex = 3;
			this.label4.Text = "Confirm new password";
			// 
			// tUser
			// 
			this.tUser.Location = new System.Drawing.Point(128, 32);
			this.tUser.Name = "tUser";
			this.tUser.ReadOnly = true;
			this.tUser.Size = new System.Drawing.Size(136, 20);
			this.tUser.TabIndex = 4;
			this.tUser.Text = "";
			// 
			// tOldPass
			// 
			this.tOldPass.Location = new System.Drawing.Point(128, 56);
			this.tOldPass.Name = "tOldPass";
			this.tOldPass.PasswordChar = '*';
			this.tOldPass.Size = new System.Drawing.Size(136, 20);
			this.tOldPass.TabIndex = 5;
			this.tOldPass.Text = "";
			// 
			// tNewPass1
			// 
			this.tNewPass1.Location = new System.Drawing.Point(128, 80);
			this.tNewPass1.Name = "tNewPass1";
			this.tNewPass1.PasswordChar = '*';
			this.tNewPass1.Size = new System.Drawing.Size(136, 20);
			this.tNewPass1.TabIndex = 6;
			this.tNewPass1.Text = "";
			// 
			// tNewPass2
			// 
			this.tNewPass2.Location = new System.Drawing.Point(128, 104);
			this.tNewPass2.Name = "tNewPass2";
			this.tNewPass2.PasswordChar = '*';
			this.tNewPass2.Size = new System.Drawing.Size(136, 20);
			this.tNewPass2.TabIndex = 7;
			this.tNewPass2.Text = "";
			// 
			// bCancel
			// 
			this.bCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.bCancel.Location = new System.Drawing.Point(112, 136);
			this.bCancel.Name = "bCancel";
			this.bCancel.TabIndex = 8;
			this.bCancel.Text = "&Cancel";
			this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
			// 
			// bOK
			// 
			this.bOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bOK.Location = new System.Drawing.Point(192, 136);
			this.bOK.Name = "bOK";
			this.bOK.TabIndex = 9;
			this.bOK.Text = "&OK";
			this.bOK.Click += new System.EventHandler(this.bOK_Click);
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(8, 0);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(240, 23);
			this.label5.TabIndex = 10;
			// 
			// fChangePassword
			// 
			this.AcceptButton = this.bOK;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.bCancel;
			this.ClientSize = new System.Drawing.Size(270, 167);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.bOK);
			this.Controls.Add(this.bCancel);
			this.Controls.Add(this.tNewPass2);
			this.Controls.Add(this.tNewPass1);
			this.Controls.Add(this.tOldPass);
			this.Controls.Add(this.tUser);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.MaximizeBox = false;
			this.Name = "fChangePassword";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Change Password";
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
			if (tUser.Text == null || tUser.Text == "")
			{
				MessageBox.Show("Username cannot be blank");
				return;
			}
			else if (tOldPass.Text == null || tOldPass.Text == "")
			{
				MessageBox.Show("Old password cannot be blank");
				return;
			}
			else if (tNewPass1.Text == null || tNewPass1.Text == "")
			{
				MessageBox.Show("New password cannot be blank");
				return;
			}
			else if (tNewPass1.Text != tNewPass2.Text)
			{
				MessageBox.Show("New passwords do not match. Please try again.");
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
