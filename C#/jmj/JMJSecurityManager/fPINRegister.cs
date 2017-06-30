using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
//for methods from JMJSecurityManager:
using System.Data.SqlClient;
using System.Data;
using System.Security.Cryptography;
using System.Text;

namespace JMJSecurityManager
{
	/// <summary>
	/// Summary description for fPINRegister.
	/// </summary>
	public class fPINRegister : System.Windows.Forms.Form
	{
		#region class variables
		private System.Windows.Forms.Button b1;
		private System.Windows.Forms.Button b2;
		private System.Windows.Forms.Button b3;
		private System.Windows.Forms.Button b4;
		private System.Windows.Forms.Button b5;
		private System.Windows.Forms.Button b6;
		private System.Windows.Forms.Button b7;
		private System.Windows.Forms.Button b8;
		private System.Windows.Forms.Button b9;
		private System.Windows.Forms.Button bClear;
		private System.Windows.Forms.Button bCancel;
		private System.Windows.Forms.Button b0;
		private System.Windows.Forms.Label label1;
		private int AccessIDLength;
		private string accessID;
		private string userID;
		private string username;
		private EproLibBase.ExecuteSql ExecuteSql;
		private EPAuthority.Service svc;
		private string customerID;
		#endregion //class variables
		
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public string User
		{
			get
			{
				return username;
			}
			set
			{
				if(value!=null)
					username = value;
				else
					username = string.Empty;
			}
		}
		public string CustomerID{
			set{
				if(value!=null)
					customerID = value;
				else
					customerID = string.Empty;
			}
		}
		public fPINRegister(EproLibBase.ExecuteSql ExecuteSql)
		{
			InitializeComponent();
			accessID = "";
			userID="";
			username = "";
			svc = new EPAuthority.Service();
			
			this.ExecuteSql = ExecuteSql;
			setAccessIDLength();

			Color c = Color.FromArgb(JMJSecurityManager.color);
			this.FindForm().BackColor = Color.FromArgb(255,c.B, c.G, c.R);
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
			this.b1 = new System.Windows.Forms.Button();
			this.b2 = new System.Windows.Forms.Button();
			this.b3 = new System.Windows.Forms.Button();
			this.b4 = new System.Windows.Forms.Button();
			this.b5 = new System.Windows.Forms.Button();
			this.b6 = new System.Windows.Forms.Button();
			this.b7 = new System.Windows.Forms.Button();
			this.b8 = new System.Windows.Forms.Button();
			this.b9 = new System.Windows.Forms.Button();
			this.bClear = new System.Windows.Forms.Button();
			this.bCancel = new System.Windows.Forms.Button();
			this.b0 = new System.Windows.Forms.Button();
			this.label1 = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// b1
			// 
			this.b1.Location = new System.Drawing.Point(8, 40);
			this.b1.Name = "b1";
			this.b1.Size = new System.Drawing.Size(48, 48);
			this.b1.TabIndex = 0;
			this.b1.Text = "&1";
			this.b1.Click += new System.EventHandler(this.b1_Click);
			// 
			// b2
			// 
			this.b2.Location = new System.Drawing.Point(64, 40);
			this.b2.Name = "b2";
			this.b2.Size = new System.Drawing.Size(48, 48);
			this.b2.TabIndex = 1;
			this.b2.Text = "&2";
			this.b2.Click += new System.EventHandler(this.b2_Click);
			// 
			// b3
			// 
			this.b3.Location = new System.Drawing.Point(120, 40);
			this.b3.Name = "b3";
			this.b3.Size = new System.Drawing.Size(48, 48);
			this.b3.TabIndex = 2;
			this.b3.Text = "&3";
			this.b3.Click += new System.EventHandler(this.b3_Click);
			// 
			// b4
			// 
			this.b4.Location = new System.Drawing.Point(8, 96);
			this.b4.Name = "b4";
			this.b4.Size = new System.Drawing.Size(48, 48);
			this.b4.TabIndex = 3;
			this.b4.Text = "&4";
			this.b4.Click += new System.EventHandler(this.b4_Click);
			// 
			// b5
			// 
			this.b5.Location = new System.Drawing.Point(64, 96);
			this.b5.Name = "b5";
			this.b5.Size = new System.Drawing.Size(48, 48);
			this.b5.TabIndex = 4;
			this.b5.Text = "&5";
			this.b5.Click += new System.EventHandler(this.b5_Click);
			// 
			// b6
			// 
			this.b6.Location = new System.Drawing.Point(120, 96);
			this.b6.Name = "b6";
			this.b6.Size = new System.Drawing.Size(48, 48);
			this.b6.TabIndex = 5;
			this.b6.Text = "&6";
			this.b6.Click += new System.EventHandler(this.b6_Click);
			// 
			// b7
			// 
			this.b7.Location = new System.Drawing.Point(8, 152);
			this.b7.Name = "b7";
			this.b7.Size = new System.Drawing.Size(48, 48);
			this.b7.TabIndex = 6;
			this.b7.Text = "&7";
			this.b7.Click += new System.EventHandler(this.b7_Click);
			// 
			// b8
			// 
			this.b8.Location = new System.Drawing.Point(64, 152);
			this.b8.Name = "b8";
			this.b8.Size = new System.Drawing.Size(48, 48);
			this.b8.TabIndex = 7;
			this.b8.Text = "&8";
			this.b8.Click += new System.EventHandler(this.b8_Click);
			// 
			// b9
			// 
			this.b9.Location = new System.Drawing.Point(120, 152);
			this.b9.Name = "b9";
			this.b9.Size = new System.Drawing.Size(48, 48);
			this.b9.TabIndex = 8;
			this.b9.Text = "&9";
			this.b9.Click += new System.EventHandler(this.b9_Click);
			// 
			// bClear
			// 
			this.bClear.Location = new System.Drawing.Point(64, 208);
			this.bClear.Name = "bClear";
			this.bClear.Size = new System.Drawing.Size(48, 48);
			this.bClear.TabIndex = 9;
			this.bClear.Text = "C&lear";
			this.bClear.Click += new System.EventHandler(this.bClear_Click);
			// 
			// bCancel
			// 
			this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.bCancel.Location = new System.Drawing.Point(8, 208);
			this.bCancel.Name = "bCancel";
			this.bCancel.Size = new System.Drawing.Size(48, 48);
			this.bCancel.TabIndex = 10;
			this.bCancel.Text = "&Cancel";
			this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
			// 
			// b0
			// 
			this.b0.Location = new System.Drawing.Point(120, 208);
			this.b0.Name = "b0";
			this.b0.Size = new System.Drawing.Size(48, 48);
			this.b0.TabIndex = 11;
			this.b0.Text = "&0";
			this.b0.Click += new System.EventHandler(this.b0_Click);
			// 
			// label1
			// 
			this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label1.Location = new System.Drawing.Point(24, 8);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(128, 23);
			this.label1.TabIndex = 12;
			this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
			// 
			// fPINRegister
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.BackColor = System.Drawing.Color.FromArgb(((System.Byte)(239)), ((System.Byte)(230)), ((System.Byte)(222)));
			this.CancelButton = this.bCancel;
			this.ClientSize = new System.Drawing.Size(176, 261);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.b0);
			this.Controls.Add(this.bCancel);
			this.Controls.Add(this.bClear);
			this.Controls.Add(this.b9);
			this.Controls.Add(this.b8);
			this.Controls.Add(this.b7);
			this.Controls.Add(this.b6);
			this.Controls.Add(this.b5);
			this.Controls.Add(this.b4);
			this.Controls.Add(this.b3);
			this.Controls.Add(this.b2);
			this.Controls.Add(this.b1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "fPINRegister";
			this.Text = "PIN Registration";
			this.ResumeLayout(false);

		}
		#endregion
	
		private void setAccessIDLength()
		{
			AccessIDLength = 4;
			string sqlText = "SELECT preference_value FROM o_preferences "+
				"WHERE preference_type = 'Preferences' AND preference_level = "+
				"'Global' AND preference_key = 'Global' AND preference_id = "+
				"'password_length'";
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
				if(ds.Tables.Count>0 && ds.Tables[0].Rows.Count>0)
				{
					//MessageBox.Show(ds.Tables[0].Rows[0][0].ToString());
					AccessIDLength = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
				}
			}
			catch(Exception exec)
			{
				throw new Exception ("Error setting AccessID length", exec);
			}
		}

		private void updateTitle(){
			label1.Text = "";
			for (int i=0; i<accessID.Length; i++){
				label1.Text += "*";
			}
		}
	
		private void testAccessID(){
			if (accessID.Length < AccessIDLength)
				return;
			if (accessID.Length > AccessIDLength){
				accessID = "";
				return;
			}
			string sqlText = "SELECT user_id FROM c_user "+
				"WHERE status = 'OK' AND actor_class = 'User' AND access_id = '" + accessID+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
				if(ds.Tables.Count>0 && ds.Tables[0].Rows.Count>0)
				{
					userID = ds.Tables[0].Rows[0][0].ToString();
					
					User = JMJSecurityManager.establishCredentials2(userID);
					try
					{
						this.DialogResult = DialogResult.OK;
					}
					catch(Exception exec)
					{
						throw exec;
					}
				}
				else{
					accessID = "";
				}
			}
			catch(Exception exec)
			{
				throw new Exception ("Error testing access ID", exec);
			}
		}


		#region buttons
		private void b1_Click(object sender, System.EventArgs e)
		{
			accessID +="1";
			testAccessID();
			updateTitle();
		}
		
		private void b2_Click(object sender, System.EventArgs e)
		{
			accessID +="2";
			testAccessID();
			updateTitle();
		}

		private void b3_Click(object sender, System.EventArgs e)
		{
			accessID +="3";
			testAccessID();
			updateTitle();
		}

		private void b4_Click(object sender, System.EventArgs e)
		{
			accessID +="4";
			testAccessID();
			updateTitle();
		}

		private void b5_Click(object sender, System.EventArgs e)
		{
			accessID +="5";
			testAccessID();
			updateTitle();
		}

		private void b6_Click(object sender, System.EventArgs e)
		{
			accessID +="6";
			testAccessID();
			updateTitle();
		}

		private void b7_Click(object sender, System.EventArgs e)
		{
			accessID +="7";
			testAccessID();
			updateTitle();
		}

		private void b8_Click(object sender, System.EventArgs e)
		{
			accessID +="8";
			testAccessID();
			updateTitle();
		}

		private void b9_Click(object sender, System.EventArgs e)
		{
			accessID +="9";
			testAccessID();
			updateTitle();
		}

		private void b0_Click(object sender, System.EventArgs e)
		{
			accessID +="0";
			testAccessID();
			updateTitle();
		}
		private void bClear_Click(object sender, System.EventArgs e)
		{
			accessID ="";
			updateTitle();
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

		#endregion //buttons
	}
}
