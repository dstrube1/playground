using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
//must add references to eprolibbase.dll from here
//\\Techserv\devel\Common\EproLibBase
// and securitymanager.dll

namespace test_SecurityManager
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		#region behind the scenes

		private SecurityManager.SecurityManager mgr;
		private System.Windows.Forms.Button bChangepass;
		private System.Windows.Forms.Button bAuthenticate;
		private System.Windows.Forms.Button bReauthenticate;
		private System.Windows.Forms.Button bChallenge;
		private System.Windows.Forms.Button bResetPass;
		private System.Windows.Forms.Button bEstablish;
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
			this.bChangepass = new System.Windows.Forms.Button();
			this.bAuthenticate = new System.Windows.Forms.Button();
			this.bReauthenticate = new System.Windows.Forms.Button();
			this.bChallenge = new System.Windows.Forms.Button();
			this.bResetPass = new System.Windows.Forms.Button();
			this.bEstablish = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// bChangepass
			// 
			this.bChangepass.Location = new System.Drawing.Point(176, 24);
			this.bChangepass.Name = "bChangepass";
			this.bChangepass.Size = new System.Drawing.Size(64, 40);
			this.bChangepass.TabIndex = 0;
			this.bChangepass.Text = "Change Password";
			this.bChangepass.Click += new System.EventHandler(this.bChangepass_Click);
			// 
			// bAuthenticate
			// 
			this.bAuthenticate.Location = new System.Drawing.Point(8, 120);
			this.bAuthenticate.Name = "bAuthenticate";
			this.bAuthenticate.TabIndex = 1;
			this.bAuthenticate.Text = "Authenticate";
			this.bAuthenticate.Click += new System.EventHandler(this.bAuthenticate_Click);
			// 
			// bReauthenticate
			// 
			this.bReauthenticate.Location = new System.Drawing.Point(8, 224);
			this.bReauthenticate.Name = "bReauthenticate";
			this.bReauthenticate.Size = new System.Drawing.Size(96, 23);
			this.bReauthenticate.TabIndex = 2;
			this.bReauthenticate.Text = "Reauthenticate";
			this.bReauthenticate.Click += new System.EventHandler(this.bReauthenticate_Click);
			// 
			// bChallenge
			// 
			this.bChallenge.Location = new System.Drawing.Point(16, 24);
			this.bChallenge.Name = "bChallenge";
			this.bChallenge.TabIndex = 3;
			this.bChallenge.Text = "Challenge";
			this.bChallenge.Click += new System.EventHandler(this.bChallenge_Click);
			// 
			// bResetPass
			// 
			this.bResetPass.Location = new System.Drawing.Point(168, 128);
			this.bResetPass.Name = "bResetPass";
			this.bResetPass.Size = new System.Drawing.Size(75, 32);
			this.bResetPass.TabIndex = 4;
			this.bResetPass.Text = "Reset Password";
			this.bResetPass.Click += new System.EventHandler(this.bResetPass_Click);
			// 
			// bEstablish
			// 
			this.bEstablish.Location = new System.Drawing.Point(168, 208);
			this.bEstablish.Name = "bEstablish";
			this.bEstablish.Size = new System.Drawing.Size(75, 40);
			this.bEstablish.TabIndex = 5;
			this.bEstablish.Text = "Establish Credentials";
			this.bEstablish.Click += new System.EventHandler(this.bEstablish_Click);
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(292, 273);
			this.Controls.Add(this.bEstablish);
			this.Controls.Add(this.bResetPass);
			this.Controls.Add(this.bChallenge);
			this.Controls.Add(this.bReauthenticate);
			this.Controls.Add(this.bAuthenticate);
			this.Controls.Add(this.bChangepass);
			this.Name = "Form1";
			this.Text = "Test Security Manager";
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

		private void bChallenge_Click(object sender, System.EventArgs e)
		{
			mgr = new SecurityManager.SecurityManager();
			MessageBox.Show("mgr.Challenge(test) = "+mgr.Challenge("test"));
		}
		
		private void bAuthenticate_Click(object sender, System.EventArgs e)
		{
			mgr = new SecurityManager.SecurityManager();
			MessageBox.Show("mgr.Authenticate() = "+mgr.Authenticate());
		}

		private void bReauthenticate_Click(object sender, System.EventArgs e)
		{
			mgr = new SecurityManager.SecurityManager();
			MessageBox.Show("mgr.ReAuthenticate(bob) = "+mgr.ReAuthenticate("bob").ToString());
		}

		private void bChangepass_Click(object sender, System.EventArgs e)
		{
			mgr = new SecurityManager.SecurityManager();
			MessageBox.Show("mgr.ChangePassword(bob) = "+mgr.ChangePassword("bob").ToString());
		}
		
		private void bResetPass_Click(object sender, System.EventArgs e)
		{
			mgr = new SecurityManager.SecurityManager();
			MessageBox.Show("mgr.ResetPassword(Rob, bob) = "+mgr.ResetPassword("Rob", "bob").ToString());
		}

		private void bEstablish_Click(object sender, System.EventArgs e)
		{
			mgr = new SecurityManager.SecurityManager();
			try
			{
				MessageBox.Show("mgr.EstablishCredentials(B123) = "+mgr.EstablishCredentials("B123"));
			}
			catch (Exception ex){
				MessageBox.Show(ex.ToString());
			}
		}

	}
}
