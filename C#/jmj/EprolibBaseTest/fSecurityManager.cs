using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

//copied xml samples from here
//$/EncounterPRO/XML Schemas/Sample XML

//copied epolibbase.dll from here
//\\Techserv\devel\Common\EproLibBase

//put recompiled securitymanager.dll here
//C:\WINDOWS\assembly

//using db=CCHIT_Demo; server=techserv; user_id=PEDStest, username=test
//in CredentialAttribute.XML:
//		<Attribute name="approle" >CPRSystem</Attribute>
//		<Attribute name="approlepwd" >applesauce28</Attribute>


namespace EproLibBaseTest
{
	/// <summary>
	/// Summary description for fSecurityManager.
	/// </summary>
	public class fSecurityManager : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TabControl tabControl1;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		#region globals
		private System.Type connectedType = null;
		private System.Windows.Forms.OpenFileDialog openFileDialog1;
		private System.Windows.Forms.TabPage tabPage2;
		private System.Windows.Forms.TabPage tabPage3;
		private System.Windows.Forms.TabPage tabPage4;
		private System.Windows.Forms.TabPage tabPage5;
		private System.Windows.Forms.TabPage tabPage6;
		private System.Windows.Forms.TabPage tabPage7;
		private System.Windows.Forms.Button bChallenge;
		private System.Windows.Forms.RichTextBox rtbChallenge;
		private System.Windows.Forms.RichTextBox rtbChallengeResult;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Button bAuthenticate;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.RichTextBox rtbAuthenticateResult;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.RichTextBox rtbReAuthenticate;
		private System.Windows.Forms.RichTextBox rtbReAuthenticateResult;
		private System.Windows.Forms.Button bReAuthenticate;
		private System.Windows.Forms.Label label7;
		private System.Windows.Forms.Label label8;
		private System.Windows.Forms.RichTextBox rtbchangePassword;
		private System.Windows.Forms.RichTextBox rtbchangePasswordResult;
		private System.Windows.Forms.Button bchangePassword;
		private System.Windows.Forms.Label label9;
		private System.Windows.Forms.Label label10;
		private System.Windows.Forms.RichTextBox rtbAdminUserName;
		private System.Windows.Forms.RichTextBox rtbResetPasswordResult;
		private System.Windows.Forms.Button bResetPassword;
		private System.Windows.Forms.Label label11;
		private System.Windows.Forms.RichTextBox rtbResetUserName;
		private System.Windows.Forms.Label label12;
		private System.Windows.Forms.Label label13;
		private System.Windows.Forms.Button bEstablishCredentials;
		private System.Windows.Forms.RichTextBox rtbEstablishCredentials;
		private System.Windows.Forms.RichTextBox rtbEstablishCredentialsResult;
		private object connectedClass = null;
		#endregion //globals

		public System.Type ConnectedType
		{
			get
			{
				return connectedType;
			}
			set
			{
				connectedType = value;
			}
		}

		public object ConnectedClass
		{
			get
			{
				return connectedClass;
			}
			set
			{
				connectedClass = value;
			}
		}
		public fSecurityManager()
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
			this.tabControl1 = new System.Windows.Forms.TabControl();
			this.tabPage2 = new System.Windows.Forms.TabPage();
			this.label4 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.rtbChallengeResult = new System.Windows.Forms.RichTextBox();
			this.rtbChallenge = new System.Windows.Forms.RichTextBox();
			this.bChallenge = new System.Windows.Forms.Button();
			this.tabPage4 = new System.Windows.Forms.TabPage();
			this.bReAuthenticate = new System.Windows.Forms.Button();
			this.rtbReAuthenticateResult = new System.Windows.Forms.RichTextBox();
			this.rtbReAuthenticate = new System.Windows.Forms.RichTextBox();
			this.label6 = new System.Windows.Forms.Label();
			this.label5 = new System.Windows.Forms.Label();
			this.tabPage7 = new System.Windows.Forms.TabPage();
			this.rtbEstablishCredentialsResult = new System.Windows.Forms.RichTextBox();
			this.rtbEstablishCredentials = new System.Windows.Forms.RichTextBox();
			this.bEstablishCredentials = new System.Windows.Forms.Button();
			this.label13 = new System.Windows.Forms.Label();
			this.label12 = new System.Windows.Forms.Label();
			this.tabPage3 = new System.Windows.Forms.TabPage();
			this.rtbAuthenticateResult = new System.Windows.Forms.RichTextBox();
			this.label3 = new System.Windows.Forms.Label();
			this.bAuthenticate = new System.Windows.Forms.Button();
			this.tabPage5 = new System.Windows.Forms.TabPage();
			this.bchangePassword = new System.Windows.Forms.Button();
			this.rtbchangePasswordResult = new System.Windows.Forms.RichTextBox();
			this.rtbchangePassword = new System.Windows.Forms.RichTextBox();
			this.label8 = new System.Windows.Forms.Label();
			this.label7 = new System.Windows.Forms.Label();
			this.tabPage6 = new System.Windows.Forms.TabPage();
			this.rtbResetUserName = new System.Windows.Forms.RichTextBox();
			this.label11 = new System.Windows.Forms.Label();
			this.bResetPassword = new System.Windows.Forms.Button();
			this.rtbResetPasswordResult = new System.Windows.Forms.RichTextBox();
			this.rtbAdminUserName = new System.Windows.Forms.RichTextBox();
			this.label10 = new System.Windows.Forms.Label();
			this.label9 = new System.Windows.Forms.Label();
			this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
			this.tabControl1.SuspendLayout();
			this.tabPage2.SuspendLayout();
			this.tabPage4.SuspendLayout();
			this.tabPage7.SuspendLayout();
			this.tabPage3.SuspendLayout();
			this.tabPage5.SuspendLayout();
			this.tabPage6.SuspendLayout();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label1.Location = new System.Drawing.Point(8, 8);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(428, 40);
			this.label1.TabIndex = 0;
			this.label1.Text = "Connected: ";
			// 
			// tabControl1
			// 
			this.tabControl1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tabControl1.Controls.Add(this.tabPage2);
			this.tabControl1.Controls.Add(this.tabPage5);
			this.tabControl1.Controls.Add(this.tabPage7);
			this.tabControl1.Controls.Add(this.tabPage3);
			this.tabControl1.Controls.Add(this.tabPage4);
			this.tabControl1.Controls.Add(this.tabPage6);
			this.tabControl1.Location = new System.Drawing.Point(0, 48);
			this.tabControl1.Name = "tabControl1";
			this.tabControl1.SelectedIndex = 0;
			this.tabControl1.Size = new System.Drawing.Size(444, 356);
			this.tabControl1.TabIndex = 1;
			// 
			// tabPage2
			// 
			this.tabPage2.Controls.Add(this.label4);
			this.tabPage2.Controls.Add(this.label2);
			this.tabPage2.Controls.Add(this.rtbChallengeResult);
			this.tabPage2.Controls.Add(this.rtbChallenge);
			this.tabPage2.Controls.Add(this.bChallenge);
			this.tabPage2.Location = new System.Drawing.Point(4, 22);
			this.tabPage2.Name = "tabPage2";
			this.tabPage2.Size = new System.Drawing.Size(436, 330);
			this.tabPage2.TabIndex = 1;
			this.tabPage2.Text = "challenge";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(224, 88);
			this.label4.Name = "label4";
			this.label4.TabIndex = 4;
			this.label4.Text = "Challenge Result";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 88);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(152, 23);
			this.label2.TabIndex = 3;
			this.label2.Text = "Enter Challenge here";
			// 
			// rtbChallengeResult
			// 
			this.rtbChallengeResult.Location = new System.Drawing.Point(224, 120);
			this.rtbChallengeResult.Name = "rtbChallengeResult";
			this.rtbChallengeResult.Size = new System.Drawing.Size(176, 128);
			this.rtbChallengeResult.TabIndex = 2;
			this.rtbChallengeResult.Text = "";
			// 
			// rtbChallenge
			// 
			this.rtbChallenge.Location = new System.Drawing.Point(8, 120);
			this.rtbChallenge.Name = "rtbChallenge";
			this.rtbChallenge.Size = new System.Drawing.Size(176, 128);
			this.rtbChallenge.TabIndex = 1;
			this.rtbChallenge.Text = "";
			// 
			// bChallenge
			// 
			this.bChallenge.Location = new System.Drawing.Point(24, 280);
			this.bChallenge.Name = "bChallenge";
			this.bChallenge.TabIndex = 0;
			this.bChallenge.Text = "Go";
			this.bChallenge.Click += new System.EventHandler(this.bChallenge_Click);
			// 
			// tabPage4
			// 
			this.tabPage4.Controls.Add(this.bReAuthenticate);
			this.tabPage4.Controls.Add(this.rtbReAuthenticateResult);
			this.tabPage4.Controls.Add(this.rtbReAuthenticate);
			this.tabPage4.Controls.Add(this.label6);
			this.tabPage4.Controls.Add(this.label5);
			this.tabPage4.Location = new System.Drawing.Point(4, 22);
			this.tabPage4.Name = "tabPage4";
			this.tabPage4.Size = new System.Drawing.Size(436, 330);
			this.tabPage4.TabIndex = 3;
			this.tabPage4.Text = "reauthenticate";
			// 
			// bReAuthenticate
			// 
			this.bReAuthenticate.Location = new System.Drawing.Point(16, 288);
			this.bReAuthenticate.Name = "bReAuthenticate";
			this.bReAuthenticate.TabIndex = 4;
			this.bReAuthenticate.Text = "Go";
			this.bReAuthenticate.Click += new System.EventHandler(this.bReAuthenticate_Click);
			// 
			// rtbReAuthenticateResult
			// 
			this.rtbReAuthenticateResult.Location = new System.Drawing.Point(256, 168);
			this.rtbReAuthenticateResult.Name = "rtbReAuthenticateResult";
			this.rtbReAuthenticateResult.TabIndex = 3;
			this.rtbReAuthenticateResult.Text = "";
			// 
			// rtbReAuthenticate
			// 
			this.rtbReAuthenticate.Location = new System.Drawing.Point(24, 168);
			this.rtbReAuthenticate.Name = "rtbReAuthenticate";
			this.rtbReAuthenticate.TabIndex = 2;
			this.rtbReAuthenticate.Text = "";
			// 
			// label6
			// 
			this.label6.Location = new System.Drawing.Point(256, 136);
			this.label6.Name = "label6";
			this.label6.Size = new System.Drawing.Size(120, 23);
			this.label6.TabIndex = 1;
			this.label6.Text = "ReAuthenticate result";
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(24, 136);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(128, 23);
			this.label5.TabIndex = 0;
			this.label5.Text = "ReAuthenticate this";
			// 
			// tabPage7
			// 
			this.tabPage7.Controls.Add(this.rtbEstablishCredentialsResult);
			this.tabPage7.Controls.Add(this.rtbEstablishCredentials);
			this.tabPage7.Controls.Add(this.bEstablishCredentials);
			this.tabPage7.Controls.Add(this.label13);
			this.tabPage7.Controls.Add(this.label12);
			this.tabPage7.Location = new System.Drawing.Point(4, 22);
			this.tabPage7.Name = "tabPage7";
			this.tabPage7.Size = new System.Drawing.Size(436, 330);
			this.tabPage7.TabIndex = 6;
			this.tabPage7.Text = "establishCredentials";
			// 
			// rtbEstablishCredentialsResult
			// 
			this.rtbEstablishCredentialsResult.Location = new System.Drawing.Point(320, 184);
			this.rtbEstablishCredentialsResult.Name = "rtbEstablishCredentialsResult";
			this.rtbEstablishCredentialsResult.TabIndex = 4;
			this.rtbEstablishCredentialsResult.Text = "";
			// 
			// rtbEstablishCredentials
			// 
			this.rtbEstablishCredentials.Location = new System.Drawing.Point(8, 176);
			this.rtbEstablishCredentials.Name = "rtbEstablishCredentials";
			this.rtbEstablishCredentials.TabIndex = 3;
			this.rtbEstablishCredentials.Text = "";
			// 
			// bEstablishCredentials
			// 
			this.bEstablishCredentials.Location = new System.Drawing.Point(16, 288);
			this.bEstablishCredentials.Name = "bEstablishCredentials";
			this.bEstablishCredentials.TabIndex = 2;
			this.bEstablishCredentials.Text = "Go";
			this.bEstablishCredentials.Click += new System.EventHandler(this.bEstablishCredentials_Click);
			// 
			// label13
			// 
			this.label13.Location = new System.Drawing.Point(272, 152);
			this.label13.Name = "label13";
			this.label13.Size = new System.Drawing.Size(144, 23);
			this.label13.TabIndex = 1;
			this.label13.Text = "establishCredentials Result";
			// 
			// label12
			// 
			this.label12.Location = new System.Drawing.Point(8, 144);
			this.label12.Name = "label12";
			this.label12.Size = new System.Drawing.Size(120, 23);
			this.label12.TabIndex = 0;
			this.label12.Text = "UserID";
			// 
			// tabPage3
			// 
			this.tabPage3.Controls.Add(this.rtbAuthenticateResult);
			this.tabPage3.Controls.Add(this.label3);
			this.tabPage3.Controls.Add(this.bAuthenticate);
			this.tabPage3.Location = new System.Drawing.Point(4, 22);
			this.tabPage3.Name = "tabPage3";
			this.tabPage3.Size = new System.Drawing.Size(436, 330);
			this.tabPage3.TabIndex = 2;
			this.tabPage3.Text = "authenticate";
			// 
			// rtbAuthenticateResult
			// 
			this.rtbAuthenticateResult.Location = new System.Drawing.Point(16, 144);
			this.rtbAuthenticateResult.Name = "rtbAuthenticateResult";
			this.rtbAuthenticateResult.TabIndex = 2;
			this.rtbAuthenticateResult.Text = "";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(16, 104);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(136, 23);
			this.label3.TabIndex = 1;
			this.label3.Text = "Authenticate Result";
			// 
			// bAuthenticate
			// 
			this.bAuthenticate.Location = new System.Drawing.Point(8, 288);
			this.bAuthenticate.Name = "bAuthenticate";
			this.bAuthenticate.TabIndex = 0;
			this.bAuthenticate.Text = "Go";
			this.bAuthenticate.Click += new System.EventHandler(this.bAuthenticate_Click);
			// 
			// tabPage5
			// 
			this.tabPage5.Controls.Add(this.bchangePassword);
			this.tabPage5.Controls.Add(this.rtbchangePasswordResult);
			this.tabPage5.Controls.Add(this.rtbchangePassword);
			this.tabPage5.Controls.Add(this.label8);
			this.tabPage5.Controls.Add(this.label7);
			this.tabPage5.Location = new System.Drawing.Point(4, 22);
			this.tabPage5.Name = "tabPage5";
			this.tabPage5.Size = new System.Drawing.Size(436, 330);
			this.tabPage5.TabIndex = 4;
			this.tabPage5.Text = "changePassword";
			// 
			// bchangePassword
			// 
			this.bchangePassword.Location = new System.Drawing.Point(16, 280);
			this.bchangePassword.Name = "bchangePassword";
			this.bchangePassword.TabIndex = 4;
			this.bchangePassword.Text = "Go";
			this.bchangePassword.Click += new System.EventHandler(this.bchangePassword_Click);
			// 
			// rtbchangePasswordResult
			// 
			this.rtbchangePasswordResult.Location = new System.Drawing.Point(288, 152);
			this.rtbchangePasswordResult.Name = "rtbchangePasswordResult";
			this.rtbchangePasswordResult.TabIndex = 3;
			this.rtbchangePasswordResult.Text = "";
			// 
			// rtbchangePassword
			// 
			this.rtbchangePassword.Location = new System.Drawing.Point(16, 152);
			this.rtbchangePassword.Name = "rtbchangePassword";
			this.rtbchangePassword.TabIndex = 2;
			this.rtbchangePassword.Text = "";
			// 
			// label8
			// 
			this.label8.Location = new System.Drawing.Point(248, 128);
			this.label8.Name = "label8";
			this.label8.Size = new System.Drawing.Size(144, 23);
			this.label8.TabIndex = 1;
			this.label8.Text = "ChangePassword Result";
			// 
			// label7
			// 
			this.label7.Location = new System.Drawing.Point(16, 120);
			this.label7.Name = "label7";
			this.label7.TabIndex = 0;
			this.label7.Text = "ChangePass this";
			// 
			// tabPage6
			// 
			this.tabPage6.Controls.Add(this.rtbResetUserName);
			this.tabPage6.Controls.Add(this.label11);
			this.tabPage6.Controls.Add(this.bResetPassword);
			this.tabPage6.Controls.Add(this.rtbResetPasswordResult);
			this.tabPage6.Controls.Add(this.rtbAdminUserName);
			this.tabPage6.Controls.Add(this.label10);
			this.tabPage6.Controls.Add(this.label9);
			this.tabPage6.Location = new System.Drawing.Point(4, 22);
			this.tabPage6.Name = "tabPage6";
			this.tabPage6.Size = new System.Drawing.Size(436, 330);
			this.tabPage6.TabIndex = 5;
			this.tabPage6.Text = "resetPassword";
			// 
			// rtbResetUserName
			// 
			this.rtbResetUserName.Location = new System.Drawing.Point(16, 176);
			this.rtbResetUserName.Name = "rtbResetUserName";
			this.rtbResetUserName.TabIndex = 6;
			this.rtbResetUserName.Text = "";
			// 
			// label11
			// 
			this.label11.Location = new System.Drawing.Point(16, 152);
			this.label11.Name = "label11";
			this.label11.TabIndex = 5;
			this.label11.Text = "ResetUserName";
			// 
			// bResetPassword
			// 
			this.bResetPassword.Location = new System.Drawing.Point(16, 280);
			this.bResetPassword.Name = "bResetPassword";
			this.bResetPassword.TabIndex = 4;
			this.bResetPassword.Text = "Go";
			this.bResetPassword.Click += new System.EventHandler(this.bResetPassword_Click);
			// 
			// rtbResetPasswordResult
			// 
			this.rtbResetPasswordResult.Location = new System.Drawing.Point(312, 176);
			this.rtbResetPasswordResult.Name = "rtbResetPasswordResult";
			this.rtbResetPasswordResult.TabIndex = 3;
			this.rtbResetPasswordResult.Text = "";
			// 
			// rtbAdminUserName
			// 
			this.rtbAdminUserName.Location = new System.Drawing.Point(8, 48);
			this.rtbAdminUserName.Name = "rtbAdminUserName";
			this.rtbAdminUserName.TabIndex = 2;
			this.rtbAdminUserName.Text = "";
			// 
			// label10
			// 
			this.label10.Location = new System.Drawing.Point(288, 152);
			this.label10.Name = "label10";
			this.label10.Size = new System.Drawing.Size(120, 23);
			this.label10.TabIndex = 1;
			this.label10.Text = "resetPassword Result";
			// 
			// label9
			// 
			this.label9.Location = new System.Drawing.Point(8, 16);
			this.label9.Name = "label9";
			this.label9.TabIndex = 0;
			this.label9.Text = "AdminUserName";
			// 
			// fSecurityManager
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(440, 397);
			this.Controls.Add(this.tabControl1);
			this.Controls.Add(this.label1);
			this.Name = "fSecurityManager";
			this.Text = "SecurityManager";
			this.Load += new System.EventHandler(this.fSecurityManager_Load);
			this.tabControl1.ResumeLayout(false);
			this.tabPage2.ResumeLayout(false);
			this.tabPage4.ResumeLayout(false);
			this.tabPage7.ResumeLayout(false);
			this.tabPage3.ResumeLayout(false);
			this.tabPage5.ResumeLayout(false);
			this.tabPage6.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		private void fSecurityManager_Load(object sender, System.EventArgs e)
		{
			if(ConnectedType!=null && ConnectedClass!=null)
			{
				label1.Text += ConnectedType.FullName;
			}
			else
			{
				throw new Exception("ConnectedType and ConnectedClass are not instantiated.");
			}
		}

		private void bChallenge_Click(object sender, System.EventArgs e)
		{
			try
			{
				rtbChallengeResult.Text = ConnectedType.InvokeMember("Challenge", System.Reflection.BindingFlags.InvokeMethod, null, ConnectedClass, new object[]{rtbChallenge.Text}).ToString();
				MessageBox.Show(this, "Challenge() completed successfully.");
			}
			catch(Exception exc)
			{
				MessageBox.Show(this, exc.ToString(), "Error calling Challenge()", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}

		private void bAuthenticate_Click(object sender, System.EventArgs e)
		{
			try
			{
				rtbAuthenticateResult.Text = ConnectedType.InvokeMember("Authenticate", System.Reflection.BindingFlags.InvokeMethod, null, ConnectedClass, new object[]{}).ToString();
				MessageBox.Show(this, "Authenticate() completed successfully.");
			}
			catch(Exception exc)
			{
				MessageBox.Show(this, exc.ToString(), "Error calling Authenticate()", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}

		private void bReAuthenticate_Click(object sender, System.EventArgs e)
		{
			try
			{
				rtbReAuthenticateResult.Text = ConnectedType.InvokeMember("ReAuthenticate", System.Reflection.BindingFlags.InvokeMethod, null, ConnectedClass, new object[]{rtbReAuthenticate.Text}).ToString();
				MessageBox.Show(this, "ReAuthenticate() completed successfully.");
			}
			catch(Exception exc)
			{
				MessageBox.Show(this, exc.ToString(), "Error calling ReAuthenticate()", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}

		private void bchangePassword_Click(object sender, System.EventArgs e)
		{
			try
			{
				rtbchangePasswordResult.Text = ConnectedType.InvokeMember("ChangePassword", System.Reflection.BindingFlags.InvokeMethod, null, ConnectedClass, new object[]{rtbchangePassword.Text}).ToString();
				MessageBox.Show(this, "ChangePassword() completed successfully.");
			}
			catch(Exception exc)
			{
				MessageBox.Show(this, exc.ToString(), "Error calling ChangePassword()", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}

		private void bResetPassword_Click(object sender, System.EventArgs e)
		{	
			try
			{
				rtbResetPasswordResult.Text = ConnectedType.InvokeMember("ResetPassword", System.Reflection.BindingFlags.InvokeMethod, null, ConnectedClass, new object[]{rtbAdminUserName.Text, rtbResetUserName.Text}).ToString();
				MessageBox.Show(this, "ResetPassword() completed successfully.");
			}
			catch(Exception exc)
			{
				MessageBox.Show(this, exc.ToString(), "Error calling ResetPassword()", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}

		private void bEstablishCredentials_Click(object sender, System.EventArgs e)
		{
			try
			{
				rtbEstablishCredentialsResult.Text = ConnectedType.InvokeMember("EstablishCredentials", System.Reflection.BindingFlags.InvokeMethod, null, ConnectedClass, new object[]{rtbEstablishCredentials.Text}).ToString();
				MessageBox.Show(this, "EstablishCredentials() completed successfully.");
			}
			catch(Exception exc)
			{
				MessageBox.Show(this, exc.ToString(), "Error calling EstablishCredentials()", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}


	}
}
