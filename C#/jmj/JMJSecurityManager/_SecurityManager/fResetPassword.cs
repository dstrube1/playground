using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace SecurityManager
{
	/// <summary>
	/// Summary description for fResetPassword.
	/// </summary>
	public class fResetPassword : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.TextBox tAdminUser;
		private System.Windows.Forms.TextBox tAdminPass;
		private string resetUser;
		private System.Windows.Forms.Button bCancel;
		private System.Windows.Forms.Button bOK;
		private System.Windows.Forms.Label label4;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public string AdminUser{
			set
			{
				if(value!=null)
					tAdminUser.Text = value;
				else
					tAdminUser.Text = string.Empty;
			}
		}
		public string AdminPass{
			get
			{
				if(tAdminPass.Text!=null)
					return tAdminPass.Text;
				else
					return string.Empty;
			}
		}
		public string ResetUser{
			set
			{
				if(value!=null)
				{
					resetUser = value;
					label1.Text = "Resetting password for user "+value;
					label4.Text = "The new password will be emailed to "+value;
				}
				else
				{
					resetUser = string.Empty;
				}
			}
		}
		

		public fResetPassword()
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
			this.tAdminUser = new System.Windows.Forms.TextBox();
			this.tAdminPass = new System.Windows.Forms.TextBox();
			this.bCancel = new System.Windows.Forms.Button();
			this.bOK = new System.Windows.Forms.Button();
			this.label4 = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(8, 8);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(256, 23);
			this.label1.TabIndex = 0;
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 40);
			this.label2.Name = "label2";
			this.label2.TabIndex = 1;
			this.label2.Text = "Admin username";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(8, 64);
			this.label3.Name = "label3";
			this.label3.TabIndex = 2;
			this.label3.Text = "Admin password";
			// 
			// tAdminUser
			// 
			this.tAdminUser.Location = new System.Drawing.Point(112, 40);
			this.tAdminUser.Name = "tAdminUser";
			this.tAdminUser.ReadOnly = true;
			this.tAdminUser.Size = new System.Drawing.Size(152, 20);
			this.tAdminUser.TabIndex = 4;
			this.tAdminUser.Text = "";
			// 
			// tAdminPass
			// 
			this.tAdminPass.Location = new System.Drawing.Point(112, 64);
			this.tAdminPass.Name = "tAdminPass";
			this.tAdminPass.PasswordChar = '*';
			this.tAdminPass.Size = new System.Drawing.Size(152, 20);
			this.tAdminPass.TabIndex = 5;
			this.tAdminPass.Text = "";
			// 
			// bCancel
			// 
			this.bCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.bCancel.Location = new System.Drawing.Point(132, 136);
			this.bCancel.Name = "bCancel";
			this.bCancel.TabIndex = 7;
			this.bCancel.Text = "&Cancel";
			this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
			// 
			// bOK
			// 
			this.bOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bOK.Location = new System.Drawing.Point(212, 136);
			this.bOK.Name = "bOK";
			this.bOK.TabIndex = 8;
			this.bOK.Text = "&OK";
			this.bOK.Click += new System.EventHandler(this.bOK_Click);
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(8, 96);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(224, 32);
			this.label4.TabIndex = 9;
			this.label4.Text = "The new password will be emailed to the address for the user being reset";
			// 
			// fResetPassword
			// 
			this.AcceptButton = this.bOK;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.bCancel;
			this.ClientSize = new System.Drawing.Size(296, 167);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.bOK);
			this.Controls.Add(this.bCancel);
			this.Controls.Add(this.tAdminPass);
			this.Controls.Add(this.tAdminUser);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.MaximizeBox = false;
			this.Name = "fResetPassword";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Reset Password";
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
			if (tAdminUser.Text == null || tAdminUser.Text == "")
			{
				MessageBox.Show("Admin sername cannot be blank");
				return;
			}
			else if (tAdminPass.Text == null || tAdminPass.Text == "")
			{
				MessageBox.Show("Admin password cannot be blank");
				return;
			}
			else if (resetUser == null || resetUser == "")
			{
				MessageBox.Show("User to be reset cannot be blank");
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
