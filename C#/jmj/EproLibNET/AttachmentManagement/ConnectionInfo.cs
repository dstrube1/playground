using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace AttachmentManagement
{
	/// <summary>
	/// Summary description for ConnectionInfo.
	/// </summary>
	public class ConnectionInfo : System.Windows.Forms.Form
	{
		private System.Windows.Forms.TextBox tServer;
		private System.Windows.Forms.TextBox tDatabase;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Button bCancel;
		private System.Windows.Forms.Button bOK;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public ConnectionInfo()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		public string Server
		{
			get
			{
				return tServer.Text;
			}
			set
			{
				tServer.Text = value;
			}
		}
		public string Database
		{
			get
			{
				return tDatabase.Text;
			}
			set
			{
				tDatabase.Text = value;
			}
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
			this.tServer = new System.Windows.Forms.TextBox();
			this.tDatabase = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.bCancel = new System.Windows.Forms.Button();
			this.bOK = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// tServer
			// 
			this.tServer.Location = new System.Drawing.Point(120, 16);
			this.tServer.Name = "tServer";
			this.tServer.Size = new System.Drawing.Size(208, 20);
			this.tServer.TabIndex = 0;
			this.tServer.Text = "";
			// 
			// tDatabase
			// 
			this.tDatabase.Location = new System.Drawing.Point(120, 56);
			this.tDatabase.Name = "tDatabase";
			this.tDatabase.Size = new System.Drawing.Size(208, 20);
			this.tDatabase.TabIndex = 1;
			this.tDatabase.Text = "";
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(16, 16);
			this.label1.Name = "label1";
			this.label1.TabIndex = 2;
			this.label1.Text = "Server:";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(16, 56);
			this.label2.Name = "label2";
			this.label2.TabIndex = 3;
			this.label2.Text = "Database:";
			// 
			// bCancel
			// 
			this.bCancel.Location = new System.Drawing.Point(152, 96);
			this.bCancel.Name = "bCancel";
			this.bCancel.TabIndex = 4;
			this.bCancel.Text = "&Cancel";
			this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
			// 
			// bOK
			// 
			this.bOK.Location = new System.Drawing.Point(248, 96);
			this.bOK.Name = "bOK";
			this.bOK.TabIndex = 5;
			this.bOK.Text = "&OK";
			this.bOK.Click += new System.EventHandler(this.bOK_Click);
			// 
			// ConnectionInfo
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(344, 134);
			this.Controls.Add(this.bOK);
			this.Controls.Add(this.bCancel);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.tDatabase);
			this.Controls.Add(this.tServer);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Name = "ConnectionInfo";
			this.Text = "ConnectionInfo";
			this.ResumeLayout(false);

		}
		#endregion

		private void bOK_Click(object sender, System.EventArgs e)
		{
			DialogResult = DialogResult.OK;
		}

		private void bCancel_Click(object sender, System.EventArgs e)
		{
			DialogResult = DialogResult.Cancel;
		}
	}
}
