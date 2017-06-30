using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace SecurityManager
{
	/// <summary>
	/// Summary description for fEstablish.
	/// </summary>
	public class fEstablish : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Button bCancel;
		private System.Windows.Forms.Button bOK;
		private System.Windows.Forms.TextBox tUser;
		private System.Windows.Forms.TextBox tPass;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.TextBox tAnswer;
		private System.Windows.Forms.ComboBox cbQuestion;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.TextBox tEmail;
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
		public string Heading
		{
			set
			{
				if (value!=null)
					label1.Text = value;
				else
					label1.Text = "";
			}
		}

		public string Question
		{
			get
			{
				if (cbQuestion.SelectedIndex != -1)
					return cbQuestion.SelectedItem.ToString();
				else
					return string.Empty;
			}
		}
		public string Answer
		{
			get
			{
				if (tAnswer.Text!=null)
					return tAnswer.Text;
				else
					return string.Empty;
			}
		}
		public string Email
		 {
			 get
			 {
				 if (tEmail.Text!=null)
					 return tEmail.Text;
				 else
					 return string.Empty;
			 }
		 }
		public fEstablish()
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
			this.tUser = new System.Windows.Forms.TextBox();
			this.tPass = new System.Windows.Forms.TextBox();
			this.bCancel = new System.Windows.Forms.Button();
			this.bOK = new System.Windows.Forms.Button();
			this.label4 = new System.Windows.Forms.Label();
			this.cbQuestion = new System.Windows.Forms.ComboBox();
			this.label5 = new System.Windows.Forms.Label();
			this.tAnswer = new System.Windows.Forms.TextBox();
			this.label6 = new System.Windows.Forms.Label();
			this.tEmail = new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(0, 0);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(280, 23);
			this.label1.TabIndex = 0;
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 32);
			this.label2.Name = "label2";
			this.label2.TabIndex = 1;
			this.label2.Text = "Username";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(8, 80);
			this.label3.Name = "label3";
			this.label3.TabIndex = 2;
			this.label3.Text = "Password";
			// 
			// tUser
			// 
			this.tUser.Location = new System.Drawing.Point(8, 56);
			this.tUser.Name = "tUser";
			this.tUser.Size = new System.Drawing.Size(216, 20);
			this.tUser.TabIndex = 3;
			this.tUser.Text = "";
			// 
			// tPass
			// 
			this.tPass.Location = new System.Drawing.Point(8, 104);
			this.tPass.Name = "tPass";
			this.tPass.PasswordChar = '*';
			this.tPass.Size = new System.Drawing.Size(216, 20);
			this.tPass.TabIndex = 4;
			this.tPass.Text = "";
			// 
			// bCancel
			// 
			this.bCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.bCancel.Location = new System.Drawing.Point(72, 274);
			this.bCancel.Name = "bCancel";
			this.bCancel.TabIndex = 5;
			this.bCancel.Text = "&Cancel";
			this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
			// 
			// bOK
			// 
			this.bOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bOK.Location = new System.Drawing.Point(152, 274);
			this.bOK.Name = "bOK";
			this.bOK.TabIndex = 6;
			this.bOK.Text = "&OK";
			this.bOK.Click += new System.EventHandler(this.bOK_Click);
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(8, 128);
			this.label4.Name = "label4";
			this.label4.TabIndex = 7;
			this.label4.Text = "Select a question";
			// 
			// cbQuestion
			// 
			this.cbQuestion.Items.AddRange(new object[] {
															"What is your pet\'s name?",
															"What is your mother\'s maiden name?",
															"What is your favorite number?",
															"What is your favorite color?",
															"What is your quest?",
															"Which is your favorite sibling?",
															"Isn\'t it ironic, don\'t you think?",
															"Huh?"});
			this.cbQuestion.Location = new System.Drawing.Point(8, 152);
			this.cbQuestion.Name = "cbQuestion";
			this.cbQuestion.Size = new System.Drawing.Size(216, 21);
			this.cbQuestion.TabIndex = 8;
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(8, 176);
			this.label5.Name = "label5";
			this.label5.TabIndex = 9;
			this.label5.Text = "Answer";
			// 
			// tAnswer
			// 
			this.tAnswer.Location = new System.Drawing.Point(8, 200);
			this.tAnswer.Name = "tAnswer";
			this.tAnswer.Size = new System.Drawing.Size(216, 20);
			this.tAnswer.TabIndex = 10;
			this.tAnswer.Text = "";
			// 
			// label6
			// 
			this.label6.Location = new System.Drawing.Point(8, 224);
			this.label6.Name = "label6";
			this.label6.TabIndex = 11;
			this.label6.Text = "Email address";
			// 
			// tEmail
			// 
			this.tEmail.Location = new System.Drawing.Point(8, 248);
			this.tEmail.Name = "tEmail";
			this.tEmail.Size = new System.Drawing.Size(216, 20);
			this.tEmail.TabIndex = 12;
			this.tEmail.Text = "";
			// 
			// fEstablish
			// 
			this.AcceptButton = this.bOK;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.bCancel;
			this.ClientSize = new System.Drawing.Size(232, 303);
			this.Controls.Add(this.tEmail);
			this.Controls.Add(this.tAnswer);
			this.Controls.Add(this.tPass);
			this.Controls.Add(this.tUser);
			this.Controls.Add(this.label6);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.cbQuestion);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.bOK);
			this.Controls.Add(this.bCancel);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.MaximizeBox = false;
			this.Name = "fEstablish";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Establishing Crendtials";
			this.ResumeLayout(false);

		}
		#endregion

		private void bOK_Click(object sender, System.EventArgs e)
		{
			#region testing
			/*
			try
			{
			MessageBox.Show("cbQuestion.SelectedIndex = "+cbQuestion.SelectedIndex.ToString());
			MessageBox.Show("cbQuestion.SelectedItem = "+cbQuestion.SelectedItem.ToString());
			MessageBox.Show("cbQuestion.SelectedText:"+cbQuestion.SelectedText);
			MessageBox.Show("cbQuestion.SelectedValue:"+cbQuestion.SelectedValue.ToString());
			MessageBox.Show("cbQuestion.SelectionLength = "+cbQuestion.SelectionLength);
			MessageBox.Show("cbQuestion.SelectionStart = "+cbQuestion.SelectionStart);
				return;
			}
			catch(Exception exec)
			{
				MessageBox.Show("FromEC: "+exec.ToString());
				return;
			}
			*/
			#endregion //testing
			if (tUser.Text == null || tUser.Text == "")
			{
				MessageBox.Show("Username cannot be blank");
				return;
			}
			else if (tPass == null || tPass.Text == "")
			{
				MessageBox.Show("Password cannot be blank");
				return;
			}
			else if (cbQuestion.SelectedIndex == -1)
			{
				MessageBox.Show("Please select a question");
				return;
			}
			else if (tAnswer.Text==null || tAnswer.Text== "")
			{
				MessageBox.Show("Please enter an answer");
				return;
			}
			else if(tEmail.Text==null || tEmail.Text== ""){
				MessageBox.Show("Please enter an email address");
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
	}
}
