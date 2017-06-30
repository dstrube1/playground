using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.Data.SqlClient;

namespace AttachmentManagement
{
	/// <summary>
	/// Summary description for fMain.
	/// </summary>
	public class fMain : System.Windows.Forms.Form
	{
		private string Server = null;
		private string Database = null;
		private string AppRolePwd = null;

		private System.Windows.Forms.ListView lbInFiles;
		private System.Windows.Forms.ListView lbInDatabase;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.Button bMoveLeft;
		private System.Windows.Forms.Button bMoveRight;
		SqlConnection con = null;


		public fMain()
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
			this.lbInFiles = new System.Windows.Forms.ListView();
			this.lbInDatabase = new System.Windows.Forms.ListView();
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.button1 = new System.Windows.Forms.Button();
			this.bMoveLeft = new System.Windows.Forms.Button();
			this.bMoveRight = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// lbInFiles
			// 
			this.lbInFiles.AllowDrop = true;
			this.lbInFiles.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None;
			this.lbInFiles.Location = new System.Drawing.Point(16, 96);
			this.lbInFiles.Name = "lbInFiles";
			this.lbInFiles.Size = new System.Drawing.Size(256, 277);
			this.lbInFiles.TabIndex = 0;
			this.lbInFiles.View = System.Windows.Forms.View.Details;
			// 
			// lbInDatabase
			// 
			this.lbInDatabase.AllowDrop = true;
			this.lbInDatabase.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None;
			this.lbInDatabase.Location = new System.Drawing.Point(312, 96);
			this.lbInDatabase.Name = "lbInDatabase";
			this.lbInDatabase.Size = new System.Drawing.Size(256, 277);
			this.lbInDatabase.TabIndex = 1;
			this.lbInDatabase.View = System.Windows.Forms.View.Details;
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(16, 72);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(144, 23);
			this.label1.TabIndex = 2;
			this.label1.Text = "Attachments are in Files:";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(312, 72);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(200, 23);
			this.label2.TabIndex = 3;
			this.label2.Text = "Attachments are in Database:";
			// 
			// button1
			// 
			this.button1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.button1.Location = new System.Drawing.Point(16, 16);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(264, 40);
			this.button1.TabIndex = 5;
			this.button1.Text = "Modify Default Attachment Locations";
			this.button1.Click += new System.EventHandler(this.button1_Click_1);
			// 
			// bMoveLeft
			// 
			this.bMoveLeft.Location = new System.Drawing.Point(272, 120);
			this.bMoveLeft.Name = "bMoveLeft";
			this.bMoveLeft.Size = new System.Drawing.Size(40, 23);
			this.bMoveLeft.TabIndex = 6;
			this.bMoveLeft.Text = ">>";
			this.bMoveLeft.Click += new System.EventHandler(this.bMoveLeft_Click);
			// 
			// bMoveRight
			// 
			this.bMoveRight.Location = new System.Drawing.Point(272, 160);
			this.bMoveRight.Name = "bMoveRight";
			this.bMoveRight.Size = new System.Drawing.Size(40, 23);
			this.bMoveRight.TabIndex = 7;
			this.bMoveRight.Text = "<<";
			this.bMoveRight.Click += new System.EventHandler(this.bMoveRight_Click);
			// 
			// fMain
			// 
			this.AllowDrop = true;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(584, 390);
			this.Controls.Add(this.bMoveRight);
			this.Controls.Add(this.bMoveLeft);
			this.Controls.Add(this.button1);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.lbInDatabase);
			this.Controls.Add(this.lbInFiles);
			this.Name = "fMain";
			this.Text = "EP Attachment Manager";
			this.Load += new System.EventHandler(this.fMain_Load);
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new fMain());
		}

		private void button1_Click(object sender, System.EventArgs e)
		{
			System.Collections.ArrayList patientList = new ArrayList();
			SqlConnection con = GetNewConnection("techserv","cpr_405_testing","applesauce28");
			SqlCommand cmd = new SqlCommand();
			cmd.Connection = con;
			cmd.CommandText = "SELECT DISTINCT cpr_id FROM p_Patient";
			SqlDataReader r = cmd.ExecuteReader();
			while(r.Read())
			{
				patientList.Add(r[0].ToString());
			}
			EproLibNET.Utilities util = new EproLibNET.Utilities();
			util.EPAttchToFile((string[])patientList.ToArray(Type.GetType("System.String")),"techserv","cpr_405_testing","applesauce28",null);
		}

		public SqlConnection GetNewConnection(string Server, string Database, string AppRolePwd)
		{
			SqlConnection con = new SqlConnection("Server="+Server+";Database="+Database+";Integrated Security=SSPI;Pooling=FALSE");
			con.Open();
			SqlCommand cmd = new SqlCommand("exec sp_SetAppRole 'cprsystem', '"+AppRolePwd+"'",con);
			cmd.ExecuteNonQuery();
			return con;
		}

		private void button2_Click(object sender, System.EventArgs e)
		{
			MessageBox.Show(this, "This feature is not yet implemented.");
		}

		private void LoadLists()
		{
			SqlCommand cmd = con.CreateCommand();
			SqlDataReader r = null;

			// Populate left list (patients with attachments in files)
			lbInFiles.Items.Clear();
			lbInFiles.Columns.Clear();
			lbInFiles.Columns.Add("col1",lbInFiles.Width-25,HorizontalAlignment.Left);
			try
			{
				cmd.CommandText = "SELECT DISTINCT pp.cpr_id, pp.first_name, pp.last_name FROM p_Patient pp "+
					"INNER JOIN p_Attachment pa ON pp.cpr_id = pa.cpr_id "+
					"WHERE pa.storage_flag = 'F' ORDER BY pp.last_name, pp.first_name, pp.cpr_id";
				r = cmd.ExecuteReader();
				while(r.Read())
				{
					string dispString = null, cprID = null;
					if( r.IsDBNull(r.GetOrdinal("cpr_id")) || null == r["cpr_id"] || r["cpr_id"].ToString() == "")
						continue;
					cprID = r["cpr_id"].ToString();

					if( !r.IsDBNull(r.GetOrdinal("last_name")) && null!=r["last_name"] )
						dispString = r["last_name"].ToString();
					else
						dispString = "[NO LAST NAME]";

					dispString += ", ";

					if( !r.IsDBNull(r.GetOrdinal("first_name")) && null!=r["first_name"] )
						dispString += r["first_name"].ToString();
					else
						dispString += "[NO FIRST NAME]";

					dispString += " - " + cprID;
				
					ListViewItem liNewItem = new ListViewItem(dispString);
					liNewItem.Tag = cprID;
					lbInFiles.Items.Add(liNewItem);
				}
			}
			catch(Exception exc)
			{
				MessageBox.Show(this, exc.ToString(), "Error populating left list");
			}
			finally
			{
				try
				{
					r.Close();
				}
				catch{}
			}

			// Populate right list (patients with attachments in database)
			lbInDatabase.Items.Clear();
			lbInDatabase.Columns.Clear();
			lbInDatabase.Columns.Add("col1",lbInDatabase.Width-25,HorizontalAlignment.Left);
			try
			{
				cmd.CommandText = "SELECT DISTINCT pp.cpr_id, pp.first_name, pp.last_name FROM p_Patient pp "+
					"INNER JOIN p_Attachment pa ON pp.cpr_id = pa.cpr_id "+
					"WHERE pa.storage_flag = 'D' ORDER BY pp.last_name, pp.first_name, pp.cpr_id";
				r = cmd.ExecuteReader();
				while(r.Read())
				{
					string dispString = null, cprID = null;
					if( r.IsDBNull(r.GetOrdinal("cpr_id")) || null == r["cpr_id"] || r["cpr_id"].ToString() == "")
						continue;
					cprID = r["cpr_id"].ToString();

					if( !r.IsDBNull(r.GetOrdinal("last_name")) && null!=r["last_name"] )
						dispString = r["last_name"].ToString();
					else
						dispString = "[NO LAST NAME]";

					dispString += ", ";

					if( !r.IsDBNull(r.GetOrdinal("first_name")) && null!=r["first_name"] )
						dispString += r["first_name"].ToString();
					else
						dispString += "[NO FIRST NAME]";

					dispString += " - " + cprID;
				
					ListViewItem liNewItem = new ListViewItem(dispString);
					liNewItem.Tag = cprID;
					lbInDatabase.Items.Add(liNewItem);
				}
			}
			catch(Exception exc)
			{
				MessageBox.Show(this, exc.ToString(), "Error populating right list");
			}
			finally
			{
				try
				{
					r.Close();
				}
				catch{}
			}
		}

		private void fMain_Load(object sender, System.EventArgs e)
		{
			AppRolePwd = "a";
			AppRolePwd += "p";
			AppRolePwd += "p";
			AppRolePwd += "l";
			AppRolePwd += "e";
			AppRolePwd += "s";
			AppRolePwd += "a";
			AppRolePwd += "u";
			AppRolePwd += "c";
			AppRolePwd += "e";
			AppRolePwd += "2";
			AppRolePwd += "8";

			ConnectionInfo conInfo = new ConnectionInfo();

			while(con == null)
			{
				if(conInfo.ShowDialog(this)==DialogResult.Cancel)
				{
					Close();
					return;
				}
				try
				{
					con = GetNewConnection(conInfo.Server,conInfo.Database,AppRolePwd);
				}
				catch(Exception exc)
				{
					MessageBox.Show(this, exc.ToString(), "Error Creating Connection");
					con = null;
				}
			}
			Server = conInfo.Server;
			Database = conInfo.Database;

			// Connection established or program has exited by this point.

			LoadLists();
		}

		private void button1_Click_1(object sender, System.EventArgs e)
		{
			MessageBox.Show(this, "Not implemented.  Edit manually in c_Attachment_Extention."+Environment.NewLine+
				"Set default_storage_flag = 'D' for Database or 'F' for Files by file type", "Not Implemented.");
		}



		private void ProgressUpdate (int Progress, string Status)
		{
			ProgressBars.fSingleProgressBar.SetProgress(Progress);
			ProgressBars.fSingleProgressBar.SetStatus(Status);
		}

		private void bMoveRight_Click(object sender, System.EventArgs e)
		{
			try
			{
				ListView lv = lbInDatabase;

				System.Collections.ArrayList cprIDList = new ArrayList();
			
				foreach(ListViewItem lvi in lv.SelectedItems)
				{
					cprIDList.Add(lvi.Tag.ToString());
				}

				string[] cprID = (string[]) cprIDList.ToArray(Type.GetType("System.String"));

				if(cprID.Length==0)
					return;

				if(MessageBox.Show(this, "Do you want to move attachments for the selected patients from the database to a file structure?","Move To Files?",MessageBoxButtons.YesNo,MessageBoxIcon.Question)==DialogResult.No)
					return;

				EproLibNET.Utilities util = new EproLibNET.Utilities();
				ProgressBars.fSingleProgressBar.ShowProgressScreen();
				ProgressBars.fSingleProgressBar.ProgressForm.Description = "Moving Attachments to File Structure";
				util.EPAttchToFile(cprID,Server,Database,AppRolePwd, new EproLibNET.ProgressUpdate(ProgressUpdate));
				ProgressBars.fSingleProgressBar.CloseForm();
				MessageBox.Show(this, "Finished moving attachments to file structure.");	
			}
			catch(Exception exc)
			{
				ProgressBars.fSingleProgressBar.CloseForm();
				MessageBox.Show(this,exc.ToString(),"Error");
			}
			LoadLists();
		}

		private void bMoveLeft_Click(object sender, System.EventArgs e)
		{
			try
			{
				ListView lv = lbInFiles;

				System.Collections.ArrayList cprIDList = new ArrayList();
			
				foreach(ListViewItem lvi in lv.SelectedItems)
				{
					cprIDList.Add(lvi.Tag.ToString());
				}

				string[] cprID = (string[]) cprIDList.ToArray(Type.GetType("System.String"));

				if(cprID.Length==0)
					return;

				if(MessageBox.Show(this, "Do you want to move attachments for the selected patients from a file structure to the database?","Move To Database?",MessageBoxButtons.YesNo,MessageBoxIcon.Question)==DialogResult.No)
					return;

				EproLibNET.Utilities util = new EproLibNET.Utilities();
				ProgressBars.fSingleProgressBar.ShowProgressScreen();
				ProgressBars.fSingleProgressBar.ProgressForm.Description = "Moving Attachments to Database";
				util.EPAttchToDB(cprID,Server,Database,AppRolePwd, new EproLibNET.ProgressUpdate(ProgressUpdate));
				ProgressBars.fSingleProgressBar.CloseForm();
				MessageBox.Show(this, "Finished moving attachments to database.");		
			}
			catch(Exception exc)
			{
				ProgressBars.fSingleProgressBar.CloseForm();
				MessageBox.Show(this,exc.ToString(),"Error");
			}
			LoadLists();
		}
	}
}
