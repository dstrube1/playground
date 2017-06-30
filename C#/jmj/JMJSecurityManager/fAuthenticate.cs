using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data;

namespace JMJSecurityManager
{
	/// <summary>
	/// Summary description for fAuthenticate.
	/// </summary>
	public class fAuthenticate : System.Windows.Forms.Form
	{
		#region class variables
		private System.Windows.Forms.Button bCancel;
		private System.Windows.Forms.Button bOK;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox tUser;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox tPass;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Button bRegister;
		private EproLibBase.ExecuteSql ExecuteSql;
		private string customerID;
		private System.Windows.Forms.Timer timer1;
		private System.Windows.Forms.PictureBox pictureBox1;
		private System.Windows.Forms.Button bForgotPassword;
		private System.Windows.Forms.Label label3;
		private System.ComponentModel.IContainer components;
		private DateTime lastAction = DateTime.Now;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.ListBox listBox1;
		private bool userSet;
		private int time_limit;
		#endregion //class variables

		#region properties
		public string User
		{
			get
			{
				return tUser.Text;
			}
			set
			{
				if(value!=null && value != "")
				{
					tUser.Text = value;
					userSet = true;
				}
				else
				{
					tUser.Text = string.Empty;
				}
			}
		}
		public string Pass
		{
			get
			{
				return tPass.Text;
			}
			set {tPass.Text = "";}
		}
		public bool FirstTime
		{
			set
			{
				if (value==true)
					tUser.ReadOnly = false;
				else
					tUser.ReadOnly = true;
			}
		}

		public string Instructions
		{
			get
			{
				return label4.Text;
			}
			set
			{
				if (value!=null)
				{
					if (value.IndexOf("Register")!=-1){
						bRegister.Visible = true;
					}
					else bRegister.Visible = false;
					label4.Text = value;
				}
				else
					label4.Text = "";
			}
		}
		public string CustomerID
		{
			set
			{
				if(value!=null)
					customerID = value;
				else
				{
					customerID = string.Empty;
					bRegister.Hide();
				}
			}
		}
		public ArrayList lastLoggedInList{
			set
			{
				listBox1.DataSource = value;
				if (!userSet) tUser.Text = "";
			}
		}
		public string focus{
			set {
				if (value =="pass")
					tPass.Select();
			}
		}
		public bool ShowPastUsers{
			set{
				if (value ==false)
					listBox1.Hide();
				//else listBox1.Show();
			}
		}
		#endregion //properties
		
		public fAuthenticate(EproLibBase.ExecuteSql ExecuteSql)
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			this.bForgotPassword.Click += new System.EventHandler(this.UserInteractionEvent);
			this.bRegister.Click += new System.EventHandler(this.UserInteractionEvent);
			this.listBox1.Click += new System.EventHandler(this.UserInteractionEvent);
			this.listBox1.SelectedIndexChanged += new System.EventHandler(this.UserInteractionEvent);
			this.tUser.Enter += new System.EventHandler(this.UserInteractionEvent);
			this.tUser.Click += new System.EventHandler(this.UserInteractionEvent);
			this.tUser.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.UserInteractionEvent);
			this.tUser.TextChanged += new System.EventHandler(this.UserInteractionEvent);
			this.tPass.Enter += new System.EventHandler(this.UserInteractionEvent);
			this.tPass.Click += new System.EventHandler(this.UserInteractionEvent);
			this.tPass.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.UserInteractionEvent);
			this.tPass.TextChanged += new System.EventHandler(this.UserInteractionEvent);

			this.Move += new System.EventHandler(this.UserInteractionEvent);

			time_limit = 30;
			timer1.Tick += new EventHandler(timer1_Tick);
			//timer1.Interval = time_limit * 1000;
			timer1.Start();

			this.ExecuteSql = ExecuteSql;

			Color c = Color.FromArgb(JMJSecurityManager.color);
			this.FindForm().BackColor = Color.FromArgb(255,c.B, c.G, c.R);
			label3.Text = JMJSecurityManager.version;
			userSet=false;
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
			this.components = new System.ComponentModel.Container();
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(fAuthenticate));
			this.bCancel = new System.Windows.Forms.Button();
			this.bOK = new System.Windows.Forms.Button();
			this.label1 = new System.Windows.Forms.Label();
			this.tUser = new System.Windows.Forms.TextBox();
			this.label2 = new System.Windows.Forms.Label();
			this.tPass = new System.Windows.Forms.TextBox();
			this.label4 = new System.Windows.Forms.Label();
			this.bRegister = new System.Windows.Forms.Button();
			this.timer1 = new System.Windows.Forms.Timer(this.components);
			this.pictureBox1 = new System.Windows.Forms.PictureBox();
			this.bForgotPassword = new System.Windows.Forms.Button();
			this.label3 = new System.Windows.Forms.Label();
			this.label5 = new System.Windows.Forms.Label();
			this.listBox1 = new System.Windows.Forms.ListBox();
			this.SuspendLayout();
			// 
			// bCancel
			// 
			this.bCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.bCancel.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.bCancel.Location = new System.Drawing.Point(432, 440);
			this.bCancel.Name = "bCancel";
			this.bCancel.Size = new System.Drawing.Size(96, 32);
			this.bCancel.TabIndex = 3;
			this.bCancel.Text = "&Cancel";
			this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
			// 
			// bOK
			// 
			this.bOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bOK.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.bOK.Location = new System.Drawing.Point(536, 440);
			this.bOK.Name = "bOK";
			this.bOK.Size = new System.Drawing.Size(96, 32);
			this.bOK.TabIndex = 2;
			this.bOK.Text = "&OK";
			this.bOK.Click += new System.EventHandler(this.bOK_Click);
			// 
			// label1
			// 
			this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label1.Location = new System.Drawing.Point(8, 96);
			this.label1.Name = "label1";
			this.label1.TabIndex = 2;
			this.label1.Text = "Username";
			// 
			// tUser
			// 
			this.tUser.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.tUser.Location = new System.Drawing.Point(120, 96);
			this.tUser.MaxLength = 40;
			this.tUser.Name = "tUser";
			this.tUser.Size = new System.Drawing.Size(200, 20);
			this.tUser.TabIndex = 0;
			this.tUser.Text = "";
			// 
			// label2
			// 
			this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label2.Location = new System.Drawing.Point(8, 120);
			this.label2.Name = "label2";
			this.label2.TabIndex = 4;
			this.label2.Text = "Password";
			// 
			// tPass
			// 
			this.tPass.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.tPass.ImeMode = System.Windows.Forms.ImeMode.NoControl;
			this.tPass.Location = new System.Drawing.Point(120, 120);
			this.tPass.Name = "tPass";
			this.tPass.PasswordChar = '*';
			this.tPass.Size = new System.Drawing.Size(200, 20);
			this.tPass.TabIndex = 1;
			this.tPass.Text = "";
			// 
			// label4
			// 
			this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label4.Location = new System.Drawing.Point(8, 16);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(608, 72);
			this.label4.TabIndex = 7;
			// 
			// bRegister
			// 
			this.bRegister.Anchor = System.Windows.Forms.AnchorStyles.Right;
			this.bRegister.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.bRegister.Location = new System.Drawing.Point(512, 80);
			this.bRegister.Name = "bRegister";
			this.bRegister.Size = new System.Drawing.Size(96, 32);
			this.bRegister.TabIndex = 4;
			this.bRegister.Text = "&Register";
			this.bRegister.Visible = false;
			this.bRegister.Click += new System.EventHandler(this.bRegister_Click);
			// 
			// timer1
			// 
			this.timer1.Enabled = true;
			this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
			// 
			// pictureBox1
			// 
			this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
			this.pictureBox1.Location = new System.Drawing.Point(112, 216);
			this.pictureBox1.Name = "pictureBox1";
			this.pictureBox1.Size = new System.Drawing.Size(384, 104);
			this.pictureBox1.TabIndex = 8;
			this.pictureBox1.TabStop = false;
			// 
			// bForgotPassword
			// 
			this.bForgotPassword.Location = new System.Drawing.Point(120, 160);
			this.bForgotPassword.Name = "bForgotPassword";
			this.bForgotPassword.Size = new System.Drawing.Size(128, 23);
			this.bForgotPassword.TabIndex = 11;
			this.bForgotPassword.Text = "I forgot my password";
			this.bForgotPassword.Click += new System.EventHandler(this.bForgotPassword_Click);
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(8, 448);
			this.label3.Name = "label3";
			this.label3.TabIndex = 12;
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(288, 368);
			this.label5.Name = "label5";
			this.label5.TabIndex = 13;
			// 
			// listBox1
			// 
			this.listBox1.Location = new System.Drawing.Point(344, 96);
			this.listBox1.Name = "listBox1";
			this.listBox1.Size = new System.Drawing.Size(120, 108);
			this.listBox1.TabIndex = 14;
			//this.listBox1.SelectedIndexChanged += new System.EventHandler(this.listBox1_SelectedIndexChanged);
			this.listBox1.Click += new System.EventHandler(this.listBox1_SelectedIndexChanged);
			// 
			// fAuthenticate
			// 
			this.AcceptButton = this.bOK;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.BackColor = System.Drawing.Color.FromArgb(((System.Byte)(239)), ((System.Byte)(230)), ((System.Byte)(222)));
			this.CancelButton = this.bCancel;
			this.ClientSize = new System.Drawing.Size(640, 480);
			this.Controls.Add(this.listBox1);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.bForgotPassword);
			this.Controls.Add(this.pictureBox1);
			this.Controls.Add(this.bRegister);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.tPass);
			this.Controls.Add(this.tUser);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.bOK);
			this.Controls.Add(this.bCancel);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
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
			if (tUser.Text == null || tUser.Text == "")
			{
				MessageBox.Show("Username cannot be blank.");
				if (tUser.Enabled) return;
				else this.DialogResult = DialogResult.Cancel;
			}
			else if (tPass == null || tPass.Text == "")
			{
				MessageBox.Show("Password cannot be blank.");
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

		private void bRegister_Click(object sender, System.EventArgs e)
		{
//			string sqlText = "SELECT * FROM c_user";
//			SqlParameter[] sqlParams = null;
//			try 
//			{
//				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
//				MessageBox.Show("To verify that you can call ExecuteSQL from Authenticate:"+
//					ds.Tables[0].Rows[0][0].ToString());
//			}
//			catch(Exception exec)
//			{
//				throw new Exception ("Error in bRegister", exec);
//			}
			fPINRegister regForm = new fPINRegister(new EproLibBase.ExecuteSql(this.ExecuteSql));
			regForm.CustomerID = customerID;
			if(regForm.ShowDialog() == DialogResult.OK)
			{
				tUser.Text = regForm.User;
			}
		}

		
		private void bForgotPassword_Click(object sender, System.EventArgs e)
		{
		string target = "https://www.jmjtech.com/mgmt/PasswordRecovery.aspx";
			System.Diagnostics.Process.Start(target);
		}

//		private void tUser_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
//		{
//			MessageBox.Show("Keypressed in user");
//		}
//		private void tUser_Enter(object sender, System.EventArgs e)
//		{
//			MessageBox.Show("Entered in user");
//		}

		private void UserInteractionEvent(object sender, KeyPressEventArgs e)
		{
			UserInteractionEvent(sender, (object)e);
		}
		private void UserInteractionEvent(object sender, EventArgs e)
		{
			UserInteractionEvent(sender, (object)e);
		}
		private void UserInteractionEvent(object sender, object e)
		{
			lastAction = DateTime.Now;
			//label5.Text = lastAction;
		}

		private void timer1_Tick(object sender, System.EventArgs e)
		{
			if(0 < DateTime.Compare(
				DateTime.Now, lastAction.AddSeconds((double)time_limit)) )
			{
				//MessageBox.Show(lastAction+" + "+time_limit+ " < "+DateTime.Now);
				bCancel_Click(null, null);
			}
		}

		private void listBox1_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			tUser.Text = listBox1.SelectedItem.ToString();
			if (tUser.Text != "")
			{
				tPass.Select();
			}
			else
				tUser.Select();
			}

		
	}
}
