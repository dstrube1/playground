using System;
//using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.IO;

namespace mmpma
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		#region class variables
		private System.Windows.Forms.Button bGo;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.ListView listView1;
		private System.Windows.Forms.ColumnHeader columnHeader1;
		private System.Windows.Forms.ColumnHeader columnHeader2;
		private System.Windows.Forms.ColumnHeader columnHeader3;
		private System.Windows.Forms.ColumnHeader columnHeader4;
		private System.Windows.Forms.ColumnHeader columnHeader5;
		private System.Windows.Forms.ColumnHeader columnHeader6;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.ListView listView2;
		private System.Windows.Forms.ColumnHeader columnHeader7;
		private System.Windows.Forms.ColumnHeader columnHeader8;
		private System.Windows.Forms.ColumnHeader columnHeader9;
		private System.Windows.Forms.ColumnHeader columnHeader10;
		private System.Windows.Forms.ColumnHeader columnHeader11;
		private System.Windows.Forms.ColumnHeader columnHeader12;
		private System.Windows.Forms.TextBox tGoodCount;
		private System.Windows.Forms.TextBox tFixedCount;
		private System.Windows.Forms.TextBox tBadCount;
		private string[] fields;
		private string[] dbInfoArgs;
		private int goodCount;
		private int fixedCount;
		private int badCount;
		#endregion //class variables
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public Form1(string[] args)
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			fields = new string[6]
				{
						"attachment_id","cpr_id","merged_from_cpr_id","filename",
					"should_be_here","might_be_here"};
			goodCount = 0;
			fixedCount = 0;
			badCount = 0;
			dbInfoArgs = args;
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
			this.bGo = new System.Windows.Forms.Button();
			this.label1 = new System.Windows.Forms.Label();
			this.listView1 = new System.Windows.Forms.ListView();
			this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader3 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader4 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader5 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader6 = new System.Windows.Forms.ColumnHeader();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.label4 = new System.Windows.Forms.Label();
			this.listView2 = new System.Windows.Forms.ListView();
			this.columnHeader7 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader8 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader9 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader10 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader11 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader12 = new System.Windows.Forms.ColumnHeader();
			this.tGoodCount = new System.Windows.Forms.TextBox();
			this.tFixedCount = new System.Windows.Forms.TextBox();
			this.tBadCount = new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			// 
			// bGo
			// 
			this.bGo.Location = new System.Drawing.Point(0, 0);
			this.bGo.Name = "bGo";
			this.bGo.TabIndex = 0;
			this.bGo.Text = "&Go";
			this.bGo.Click += new System.EventHandler(this.bGo_Click);
			// 
			// label1
			// 
			this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label1.Location = new System.Drawing.Point(0, 32);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(240, 16);
			this.label1.TabIndex = 1;
			this.label1.Text = "Attachments with possible missing files";
			// 
			// listView1
			// 
			this.listView1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.listView1.BackColor = System.Drawing.Color.LightGray;
			this.listView1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.listView1.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
																						this.columnHeader1,
																						this.columnHeader2,
																						this.columnHeader3,
																						this.columnHeader4,
																						this.columnHeader5,
																						this.columnHeader6});
			this.listView1.GridLines = true;
			this.listView1.Location = new System.Drawing.Point(8, 56);
			this.listView1.Name = "listView1";
			this.listView1.Size = new System.Drawing.Size(432, 97);
			this.listView1.TabIndex = 2;
			this.listView1.View = System.Windows.Forms.View.Details;
			// 
			// columnHeader1
			// 
			this.columnHeader1.Text = "attachment_id";
			this.columnHeader1.Width = 83;
			// 
			// columnHeader2
			// 
			this.columnHeader2.Text = "cpr_id";
			this.columnHeader2.Width = 49;
			// 
			// columnHeader3
			// 
			this.columnHeader3.Text = "merged_from_cpr_id";
			this.columnHeader3.Width = 82;
			// 
			// columnHeader4
			// 
			this.columnHeader4.Text = "filename";
			// 
			// columnHeader5
			// 
			this.columnHeader5.Text = "should_be_here";
			this.columnHeader5.Width = 75;
			// 
			// columnHeader6
			// 
			this.columnHeader6.Text = "might_be_here";
			this.columnHeader6.Width = 75;
			// 
			// label2
			// 
			this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label2.Location = new System.Drawing.Point(8, 168);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(232, 23);
			this.label2.TabIndex = 3;
			this.label2.Text = "Attachment files already in the right place";
			// 
			// label3
			// 
			this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label3.Location = new System.Drawing.Point(8, 200);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(232, 23);
			this.label3.TabIndex = 4;
			this.label3.Text = "Attachment files moved to the right place";
			// 
			// label4
			// 
			this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label4.Location = new System.Drawing.Point(8, 232);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(200, 23);
			this.label4.TabIndex = 5;
			this.label4.Text = "Attachment files still missing";
			// 
			// listView2
			// 
			this.listView2.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.listView2.BackColor = System.Drawing.Color.LightGray;
			this.listView2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.listView2.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
																						this.columnHeader7,
																						this.columnHeader8,
																						this.columnHeader9,
																						this.columnHeader10,
																						this.columnHeader11,
																						this.columnHeader12});
			this.listView2.Location = new System.Drawing.Point(8, 264);
			this.listView2.Name = "listView2";
			this.listView2.Size = new System.Drawing.Size(432, 152);
			this.listView2.TabIndex = 6;
			this.listView2.View = System.Windows.Forms.View.Details;
			// 
			// columnHeader7
			// 
			this.columnHeader7.Text = "attachment_id";
			this.columnHeader7.Width = 83;
			// 
			// columnHeader8
			// 
			this.columnHeader8.Text = "cpr_id";
			this.columnHeader8.Width = 47;
			// 
			// columnHeader9
			// 
			this.columnHeader9.Text = "merged_from_cpr_id";
			this.columnHeader9.Width = 82;
			// 
			// columnHeader10
			// 
			this.columnHeader10.Text = "filename";
			// 
			// columnHeader11
			// 
			this.columnHeader11.Text = "should_be_here";
			this.columnHeader11.Width = 77;
			// 
			// columnHeader12
			// 
			this.columnHeader12.Text = "might_be_here";
			this.columnHeader12.Width = 74;
			// 
			// tGoodCount
			// 
			this.tGoodCount.BackColor = System.Drawing.Color.LightGray;
			this.tGoodCount.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.tGoodCount.Enabled = false;
			this.tGoodCount.Location = new System.Drawing.Point(248, 168);
			this.tGoodCount.Name = "tGoodCount";
			this.tGoodCount.TabIndex = 7;
			this.tGoodCount.Text = "";
			// 
			// tFixedCount
			// 
			this.tFixedCount.BackColor = System.Drawing.Color.LightGray;
			this.tFixedCount.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.tFixedCount.Enabled = false;
			this.tFixedCount.Location = new System.Drawing.Point(248, 200);
			this.tFixedCount.Name = "tFixedCount";
			this.tFixedCount.TabIndex = 8;
			this.tFixedCount.Text = "";
			// 
			// tBadCount
			// 
			this.tBadCount.BackColor = System.Drawing.Color.LightGray;
			this.tBadCount.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.tBadCount.Enabled = false;
			this.tBadCount.Location = new System.Drawing.Point(248, 232);
			this.tBadCount.Name = "tBadCount";
			this.tBadCount.TabIndex = 9;
			this.tBadCount.Text = "";
			// 
			// Form1
			// 
			this.AcceptButton = this.bGo;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(448, 429);
			this.Controls.Add(this.tBadCount);
			this.Controls.Add(this.tFixedCount);
			this.Controls.Add(this.tGoodCount);
			this.Controls.Add(this.listView2);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.listView1);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.bGo);
			this.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.Name = "Form1";
			this.Text = "Migrated Merged Patients Missing Attachments";
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string [] args) 
		{
			Application.Run(new Form1(args));
		}

		private void bGo_Click(object sender, System.EventArgs e)
		{
			#region clear the stage
			tGoodCount.Text = goodCount.ToString();
			tFixedCount.Text = fixedCount.ToString();
			tBadCount.Text = badCount.ToString();
			#endregion //clear the stage

			#region get variables 
			//string path = "C:\\Program Files\\JMJ\\EncounterPRO";
			//string[] args = new string[2] 
			//	{path,"[Markdev]"};
			dbInfo.Class1 dbi = new dbInfo.Class1();
			string server_db = dbi.getInfo(dbInfoArgs);
			if (server_db ==null) {
				MessageBox.Show("server_db is null");
				return;
			}
			#endregion //get variables  

			#region get dbconnection
			string connection_text = server_db+
				"Integrated Security=SSPI"+
				";Connect Timeout=60";
			SqlConnection connection1 = new SqlConnection(connection_text);
			try
			{
				connection1.Open();
				//MessageBox.Show("args0= "+dbInfoArgs[0]+
				//	"; args[1]="+dbInfoArgs[1]);
				//MessageBox.Show("db_server = "+server_db);
				//return;
			}
			catch (Exception db_exception)
			{
				MessageBox.Show("Error connecting to the database:"
					+ db_exception.ToString());
				return;
			}
			#endregion //get dbconnection
		
			SqlCommand command = new SqlCommand(getQuery(), connection1);

			try
			{
				SqlDataReader reader = command.ExecuteReader();
				while (reader.Read())
				{
					//first put the reuslt in the All list
					ArrayList row = new ArrayList();
					for (int i = 0; i < fields.Length; i++)
					{
						//MessageBox.Show("Adding " + i + ": " + fields[i]);
						row.Add(reader[fields[i]].ToString());
					}
					row.TrimToSize();
					ListViewItem li = new ListViewItem(
						(string[])row.ToArray(typeof(string))); //
					listView1.Items.Add(li);

					//now determine whether this result is good, fixable, or bad
					determine(row);
				}
				reader.Close();
				command.Dispose();
				connection1.Close();
			}
			catch (Exception command_exception)
			{
				MessageBox.Show("Error running the command:"
					+ command_exception.ToString() + "\nconnect string = "
					+ connection_text + "\nargs[0] = "
					+ dbInfoArgs[0] + "\nargs[1] = " + dbInfoArgs[1]);
			}
			finally { bGo.Enabled = false; }
		}

		private string getQuery(){
			return @"DECLARE @candidates TABLE (
					attachment_id int NOT NULL,
					cpr_id varchar(12),
					merged_from_cpr_id varchar(12),
					filename varchar(128),
					should_be_here varchar(255),
					might_be_here varchar(255))


				INSERT INTO @candidates (
					attachment_id,
					cpr_id,
					filename,
					merged_from_cpr_id,
					should_be_here)
				SELECT a.attachment_id,
					a.cpr_id,
					a.attachment_file + '.' + a.extension,
					merged_from_cpr_id = LEFT(a.attachment_file, CHARINDEX('_', a.attachment_file) - 1),
					should_be_here = '\\' + l.attachment_server + '\' + l.attachment_share + '\' + p.attachment_path
				FROM p_Attachment a
					INNER JOIN p_Patient p
					ON a.cpr_id = p.cpr_id
					INNER JOIN c_Attachment_Location l
					ON p.attachment_location_id = l.attachment_location_id
				WHERE a.cpr_id IS NOT NULL
				AND a.attachment_file NOT LIKE a.cpr_id + '%'

				UPDATE x
				SET might_be_here = '\\' + l.attachment_server + '\' + l.attachment_share + '\' + p.attachment_path
				FROM @candidates x
					INNER JOIN p_Patient p
					ON x.merged_from_cpr_id = p.cpr_id
					INNER JOIN c_Attachment_Location l
					ON p.attachment_location_id = p.attachment_location_id
				WHERE p.patient_status = 'MERGED'

				SELECT attachment_id ,
					cpr_id ,
					merged_from_cpr_id ,
					filename ,
					should_be_here ,
					might_be_here
				FROM @candidates";
		}

		private void determine(ArrayList row)
		{
			string filename = row[3].ToString();
			string should_be_here = row[4].ToString();
			if (!should_be_here.EndsWith("\\"))
				should_be_here += "\\";
			string might_be_here = row[5].ToString();
			if (!might_be_here.EndsWith("\\"))
				might_be_here += "\\";
            
			if (File.Exists(should_be_here + filename))
			{
				addToGood();
			}
			else if (File.Exists(might_be_here + filename))
			{
				//File.Move(might_be_here + filename, should_be_here + filename);
				addToFixed();
			}
			else addToBad(row);
		}

		private void addToBad(ArrayList row)
		{
			badCount++;
			tBadCount.Text = badCount.ToString();
			ListViewItem li = new ListViewItem(
				(string[])row.ToArray(typeof(string))); //
			listView2.Items.Add(li);
		}

		private void addToFixed()
		{
			fixedCount++;
			tFixedCount.Text = fixedCount.ToString();
		}

		private void addToGood()
		{
			goodCount++;
			tGoodCount.Text = goodCount.ToString();
		}
	}
}
