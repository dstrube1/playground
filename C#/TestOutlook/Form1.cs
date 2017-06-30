using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.IO;
using Outlook = Microsoft.Office.Interop.Outlook; 
//using System.Diagnostics;

namespace TestOutlook
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		#region behind the scenes
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.ListView listView1;
		private System.Windows.Forms.ColumnHeader columnHeader1;
		private System.Windows.Forms.ColumnHeader columnHeader2;
		private System.Windows.Forms.ColumnHeader columnHeader3;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.Label label2;
		private string EntryID;
		private string StoreID;
		private System.Windows.Forms.Button button3;
		Outlook._Application var = new Outlook.ApplicationClass();
		private System.Windows.Forms.TextBox tb_levels;
		private System.Windows.Forms.RadioButton rb_top;
		private System.Windows.Forms.RadioButton rb_all;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.TextBox tb_top;
		private System.Windows.Forms.TextBox tb_path;
		private System.Windows.Forms.TextBox tb_report;
		private ListViewItem context = null;

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
			var = null;
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
			this.button1 = new System.Windows.Forms.Button();
			this.listView1 = new System.Windows.Forms.ListView();
			this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader3 = new System.Windows.Forms.ColumnHeader();
			this.tb_path = new System.Windows.Forms.TextBox();
			this.tb_levels = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.button2 = new System.Windows.Forms.Button();
			this.label2 = new System.Windows.Forms.Label();
			this.button3 = new System.Windows.Forms.Button();
			this.rb_top = new System.Windows.Forms.RadioButton();
			this.rb_all = new System.Windows.Forms.RadioButton();
			this.label3 = new System.Windows.Forms.Label();
			this.tb_top = new System.Windows.Forms.TextBox();
			this.tb_report = new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			// 
			// button1
			// 
			this.button1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.button1.Location = new System.Drawing.Point(8, 280);
			this.button1.Name = "button1";
			this.button1.TabIndex = 0;
			this.button1.Text = "Go to Root";
			this.button1.Click += new System.EventHandler(this.button1_Click);
			// 
			// listView1
			// 
			this.listView1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.listView1.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
																						this.columnHeader1,
																						this.columnHeader2,
																						this.columnHeader3});
			this.listView1.Location = new System.Drawing.Point(0, 8);
			this.listView1.Name = "listView1";
			this.listView1.Size = new System.Drawing.Size(516, 200);
			this.listView1.TabIndex = 1;
			this.listView1.View = System.Windows.Forms.View.Details;
			this.listView1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.listView1_MouseDown);
			this.listView1.DoubleClick += new System.EventHandler(this.listView1_DoubleClick);
			// 
			// columnHeader1
			// 
			this.columnHeader1.Text = "Folder / Issue";
			this.columnHeader1.Width = 299;
			// 
			// columnHeader2
			// 
			this.columnHeader2.Text = "FolderID / Practice";
			this.columnHeader2.Width = 109;
			// 
			// columnHeader3
			// 
			this.columnHeader3.Text = "StoreID / Owner";
			this.columnHeader3.Width = 97;
			// 
			// tb_path
			// 
			this.tb_path.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tb_path.Location = new System.Drawing.Point(8, 240);
			this.tb_path.Name = "tb_path";
			this.tb_path.ReadOnly = true;
			this.tb_path.Size = new System.Drawing.Size(256, 20);
			this.tb_path.TabIndex = 2;
			this.tb_path.Text = "";
			// 
			// tb_levels
			// 
			this.tb_levels.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.tb_levels.Location = new System.Drawing.Point(312, 280);
			this.tb_levels.Name = "tb_levels";
			this.tb_levels.ReadOnly = true;
			this.tb_levels.Size = new System.Drawing.Size(40, 20);
			this.tb_levels.TabIndex = 3;
			this.tb_levels.Text = "";
			// 
			// label1
			// 
			this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.label1.Location = new System.Drawing.Point(232, 280);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(72, 23);
			this.label1.TabIndex = 4;
			this.label1.Text = "levels deep";
			// 
			// button2
			// 
			this.button2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.button2.Location = new System.Drawing.Point(128, 280);
			this.button2.Name = "button2";
			this.button2.TabIndex = 5;
			this.button2.Text = "..";
			this.button2.Click += new System.EventHandler(this.button2_Click);
			// 
			// label2
			// 
			this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.label2.Location = new System.Drawing.Point(8, 216);
			this.label2.Name = "label2";
			this.label2.TabIndex = 6;
			this.label2.Text = "Current path";
			// 
			// button3
			// 
			this.button3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.button3.Location = new System.Drawing.Point(8, 312);
			this.button3.Name = "button3";
			this.button3.TabIndex = 7;
			this.button3.Text = "Report";
			this.button3.Click += new System.EventHandler(this.button3_Click);
			// 
			// rb_top
			// 
			this.rb_top.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.rb_top.Location = new System.Drawing.Point(360, 232);
			this.rb_top.Name = "rb_top";
			this.rb_top.Size = new System.Drawing.Size(48, 24);
			this.rb_top.TabIndex = 8;
			this.rb_top.Text = "Top";
			// 
			// rb_all
			// 
			this.rb_all.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.rb_all.Location = new System.Drawing.Point(360, 256);
			this.rb_all.Name = "rb_all";
			this.rb_all.Size = new System.Drawing.Size(48, 24);
			this.rb_all.TabIndex = 9;
			this.rb_all.Text = "All";
			// 
			// label3
			// 
			this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.label3.Location = new System.Drawing.Point(312, 232);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(40, 23);
			this.label3.TabIndex = 10;
			this.label3.Text = "View";
			// 
			// tb_top
			// 
			this.tb_top.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.tb_top.Location = new System.Drawing.Point(408, 232);
			this.tb_top.Name = "tb_top";
			this.tb_top.Size = new System.Drawing.Size(32, 20);
			this.tb_top.TabIndex = 11;
			this.tb_top.Text = "";
			// 
			// tb_report
			// 
			this.tb_report.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.tb_report.Location = new System.Drawing.Point(96, 312);
			this.tb_report.Name = "tb_report";
			this.tb_report.Size = new System.Drawing.Size(224, 20);
			this.tb_report.TabIndex = 12;
			this.tb_report.Text = "";
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(528, 349);
			this.Controls.Add(this.tb_report);
			this.Controls.Add(this.tb_top);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.rb_all);
			this.Controls.Add(this.rb_top);
			this.Controls.Add(this.button3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.button2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.tb_levels);
			this.Controls.Add(this.tb_path);
			this.Controls.Add(this.listView1);
			this.Controls.Add(this.button1);
			this.Name = "Form1";
			this.Text = "Outlook issue reporter";
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			//try {
				System.Windows.Forms.Application.Run(new Form1());
			//}
			//catch (System.Exception excep)
			//{
			//	Console.WriteLine(excep.ToString());
			//}
		}

		#endregion //behind the scenes

		//goto root
		private void button1_Click(object sender, System.EventArgs e)
		{
			updatePath("", "", "");
			updateLevels(0);
			//updateList(); cannot call updateList because cannot get EntryID of root
			listView1.Items.Clear();
			foreach (Outlook.MAPIFolder folder in var.Session.Folders)
			{
				ListViewItem li = new ListViewItem(new string[] {folder.FullFolderPath, folder.EntryID, folder.StoreID});
				listView1.Items.Add(li);
			}
		}

			
		//go up one dir
		private void button2_Click(object sender, System.EventArgs e)
		{
			try
			{
				Outlook.MAPIFolder parent = (Outlook.MAPIFolder) var.Session.GetFolderFromID(EntryID, StoreID).Parent;
				updatePath(parent.FullFolderPath, parent.EntryID, parent.StoreID);
				updateLevels(int.Parse(tb_levels.Text)-1);
				updateList();
			}
			catch (System.Exception excep)
			{
				Console.WriteLine(excep.ToString());
			}

		}


		//report
		private void button3_Click(object sender, System.EventArgs e)
		{
			string filename = @"C:\Documents and Settings\All Users\Desktop\1.txt";
			string text = "";

			if (File.Exists(filename)) 
			{
				string message = filename+" already exists. Click Yes if you are ready for it to be overwritten.";
				MessageBoxButtons buttons = MessageBoxButtons.YesNo;
				DialogResult result = MessageBox.Show(message,"Alert", buttons);

				if(result == DialogResult.Yes)
				{
					File.Delete(filename);
				}
				else return;
			}
			
				ArrayList aL = new ArrayList();
				foreach (ListViewItem item in listView1.Items)
				{
					//Console.WriteLine("item.Index = "+item.Index);
					//Console.WriteLine("item.Text = "+item.Text);
					text = item.Text;
					if (text.IndexOf("Issue #") != -1)
					{
						try
						{
							//text at this point is ".... Issue #nnnnn"
							//Console.WriteLine("item.Text = "+item.Text);
							//Console.WriteLine("text.Substring(text.Length-5) = "+text.Substring(text.Length-5));
							int issueNumber = int.Parse(text.Substring(text.Length-5));
							text = text.Remove(text.IndexOf("Issue #"),12);
							text = issueNumber + "\t" + text;
						}
						catch (System.Exception excep)
						{
							Console.WriteLine(excep.ToString());
						}
					}
					else continue;

					try
					{
						int count = 0;
						foreach (object subitem in item.SubItems)
						{
							count++;
							//Console.WriteLine("subitem = "+subitem.ToString()+"\tcount= "+count);
							if (count == 2 )
							{
								if (subitem.ToString().IndexOf(tb_report.Text) != -1)
								{
									text +="\t"+item.SubItems[1].Text;
									text +="\t"+item.SubItems[2].Text;
									break;
								}
								else
								{
									text = null;
								}
							}
						}
					}
					catch (System.Exception excep)
					{
						Console.WriteLine(excep.ToString());
					}
					if (text!=null)
					{
						aL.Add(text);
					}
					//text = "";
				}
				aL.TrimToSize();

				StreamWriter sw = File.CreateText(filename);
				for (int i=0; i<aL.Count; i++)
					sw.WriteLine(aL[i]);
				sw.Flush();
				sw.Close();
		}

		
		//an item in the list is selected
		/*
		private void listView1_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			if (listView1.SelectedIndices.Count == 0)
				return;

			string entryID = listView1.SelectedItems[0].SubItems[1].Text;
			string storeID = listView1.SelectedItems[0].SubItems[2].Text;
			
			listView1.Items.Clear();

			try
			{
				string path = var.Session.GetFolderFromID(entryID, storeID).FullFolderPath.ToString();
				updatePath(path, entryID, storeID);

				string [] folders = var.Session.GetFolderFromID(entryID, storeID).FullFolderPath.Split(new char [] {'\\'});
				updateLevels(folders.Length-2);
			
				updateList();
			}
			catch (System.Exception excep)
			{
				Console.WriteLine(excep.ToString());
			}
		}
		*/
		

		private void updateLevels(int count)
			{
			tb_levels.Text = count.ToString();
		}


		private void updatePath(string path, string EID, string SID)
		{
			tb_path.Text = path;
			EntryID = EID;
			StoreID= SID;
		}

		
		//not to be used before button1 / goto root
		//assumes path and EntryID and StoreID have been set
		private void updateList(){
			if (EntryID == "" || StoreID == "")
				return;
			listView1.Items.Clear();
			
			int count = 0;
			Outlook.TaskItem item = null;
			string status=null;
			string issueStatus=null;
			string customer=null;
			//Outlook.UserProperty up = null;

			//try
			//{
				//show all folders
				foreach (Outlook.MAPIFolder folder in var.Session.GetFolderFromID(EntryID, StoreID).Folders)
				{
					ListViewItem li = new ListViewItem(new string[] {folder.FullFolderPath, folder.EntryID, folder.StoreID});
					listView1.Items.Add(li);
				}
				//Outlook.TaskItem [] itemArray = new Outlook.TaskItem[] (var.Session.GetFolderFromID(EntryID, StoreID).Items);
				//^^no good

				//show Tasks
				int limit = 0;
			
			if (var.Session.GetFolderFromID(EntryID, StoreID).Items.Count > 0 )
			{
				limit = var.Session.GetFolderFromID(EntryID, StoreID).Items.Count;
				if (!rb_top.Checked && !rb_all.Checked)
				{
					DialogResult result = MessageBox.Show("Please select Top or All","Alert");
					if (result == DialogResult.OK)
					{
						return;
					}
				}
				else 
				{
					if (rb_top.Checked)
					{
						try
						{
							limit = int.Parse(tb_top.Text);
						}
						catch (System.Exception excep)
						{
							Console.WriteLine(excep.ToString());
							limit=10;
						}
					}
					else //rb_all.Checked
					{}
				}
			}

				foreach (object obj in var.Session.GetFolderFromID(EntryID, StoreID).Items)
				{
					//Console.WriteLine(count);
					if (count < limit)
					{
						if (obj is Outlook.TaskItem)
						{
							item = (Outlook.TaskItem)obj;
						}
						else 
						{
							//Console.WriteLine("obj = "+ obj.ToString() + "; " + obj.GetType().ToString());
							continue;
						}
						
						try 
						{
							issueStatus = item.UserProperties["Issue Status"].Value.ToString();
						}
						catch (System.Exception excep)
						{
							Console.WriteLine("Missing issue status on issue: \"" + item.Subject + "\" : " + excep.ToString());
							issueStatus = "";
							continue;
						}
						status = item.Status.ToString();
						if (item.Links.Count ==1)
						{
							customer = item.Links[1].Name;
						}

						//item.Status.ToString() = "olTaskNotStarted", "olTaskComplete", "olTaskInProgress", "olTaskWaiting", or "olTaskDeferred"
						//item.UserProperties["Current Task Owner"].Name = "Current JMJ Owner"
						// item.UserProperties["Current Task Owner"].Value.ToString() = actual jmj owner name

						//Excluded from reporting:

						//1- 
						//Issues Closed but not Complete-
						//	How did it happen: either mysteriously reopened (and ready to reclose with MarkComplete())
						//or misuse of Closed
						if (status != "olTaskComplete" && issueStatus.Equals("Closed"))
						{
							//ListViewItem li = new ListViewItem(new string[] {item.Subject, status, issueStatus});
							//listView1.Items.Add(li);
						}

							//2-
							//Issues Complete but not Closed
							//How did it happen: issue Completed before implementation of Item.UserProperties[Issue Status]=Closed
							//Dilemnae: a- If this issue is mysteriously reopened, 
							//	it will not be programatically reclosable based on its Closed-ness (anti glasnost?)
							//			b- User Properties cannot be programmatically affected, issue must be reclosed;
							//this doesn't work:
							//up = item.UserProperties["Issue Status"];
							//up.Value = "Closed";
							//item.UserProperties.Add("Issue Status", up.GetType(), true, true);
						else if (status.Equals("olTaskComplete") && issueStatus != "Closed")
						{
							//ListViewItem li = new ListViewItem(new string[] {item.Subject, customer, issueStatus});
							//listView1.Items.Add(li);
						}
							//must test MarkComplete() before using farther
						else if (item.Subject.Equals("ADT Error Issue #23293"))
						{
							//item.MarkComplete();
							//Console.WriteLine("Found ADT Error Issue #23293");
						}
							//just what the heck is it?
						else if (!status.Equals("olTaskComplete"))
						{
							count++;
							ListViewItem li = new ListViewItem(new string[] {item.Subject, customer, item.UserProperties["Current Task Owner"].Value.ToString()});
							listView1.Items.Add(li);
						}

						//TODO: search for invalid contacts and fix them

					}//end if count < x
					else 
					{
						if (!rb_all.Checked)
							break;
					}
				}//end foreach
			//}
			//catch (System.Exception excep)
			//{
			//	Console.WriteLine(excep.ToString());
			//}
		}

		private void listView1_DoubleClick(object sender, System.EventArgs e)
		{
			if (context != null){

				string entryID = context.SubItems[1].Text;
				string storeID = context.SubItems[2].Text;
			
				listView1.Items.Clear();

				try
				{
					string path = var.Session.GetFolderFromID(entryID, storeID).FullFolderPath.ToString();
					updatePath(path, entryID, storeID);

					string [] folders = var.Session.GetFolderFromID(entryID, storeID).FullFolderPath.Split(new char [] {'\\'});
					updateLevels(folders.Length-2);
			
					updateList();
				}
				catch (System.Exception excep)
				{
					Console.WriteLine(excep.ToString());
				}
			}
		}

		private void listView1_MouseDown(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			context = listView1.GetItemAt(e.X, e.Y);
		}

	}
}
