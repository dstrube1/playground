using System;
using System.Text;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.IO;
using System.Configuration;


namespace HTTPeep
{
	/// <summary>
	/// Summary description for SettingsForm.
	/// </summary>
	public class SettingsForm : System.Windows.Forms.Form
	{
		bool isHandled = false;
		string[] UAStrings;


		private System.Windows.Forms.Label label1;
		public System.Windows.Forms.TextBox TxtUserAgent;
		public System.Windows.Forms.TextBox TxtReferer;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label4;
		public System.Windows.Forms.TextBox TxtRangeFrom;
		public System.Windows.Forms.CheckBox CbxRange;
		public System.Windows.Forms.TextBox TxtRangeTo;
		public System.Windows.Forms.ListView LvwPostVars;
		private System.Windows.Forms.ColumnHeader columnHeader1;
		private System.Windows.Forms.ColumnHeader columnHeader2;
		private System.Windows.Forms.Button BtnAddPostVar;
		public System.Windows.Forms.TextBox TxtOtherHeaders;
		private System.Windows.Forms.Button BtnLoadPostVars;
		private System.Windows.Forms.Label label5;
		public System.Windows.Forms.CheckBox CbxUseHttp10;
		private System.Windows.Forms.Button BtnSavePostVars;
		public System.Windows.Forms.TextBox TxtRawPost;
		private System.Windows.Forms.CheckBox CbxRawPost;
		public System.Windows.Forms.TextBox TxtAccept;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.Button BtnSelectUA;
		private System.Windows.Forms.ContextMenu MnuSelectUA;
		private System.Windows.Forms.Button BtnClose;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public SettingsForm()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();


			TxtUserAgent.Text = ConfigurationSettings.AppSettings["DefaultUserAgent"];
			TxtAccept.Text = ConfigurationSettings.AppSettings["DefaultAccept"];
			TxtReferer.Text = ConfigurationSettings.AppSettings["DefaultReferer"];
			TxtOtherHeaders.Text = ConfigurationSettings.AppSettings["DefaultCustomHeaders"];

			UAStrings = ConfigurationSettings.AppSettings["UserAgentMenu"].Split('|');
			MnuSelectUA.MenuItems.Clear();
			for (int i=0; i<UAStrings.Length; i=i+2)
				MnuSelectUA.MenuItems.Add(UAStrings[i], new System.EventHandler(this.MnuSelectUA_Click));
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
			this.TxtUserAgent = new System.Windows.Forms.TextBox();
			this.TxtReferer = new System.Windows.Forms.TextBox();
			this.label2 = new System.Windows.Forms.Label();
			this.BtnClose = new System.Windows.Forms.Button();
			this.label3 = new System.Windows.Forms.Label();
			this.TxtRangeFrom = new System.Windows.Forms.TextBox();
			this.label4 = new System.Windows.Forms.Label();
			this.CbxRange = new System.Windows.Forms.CheckBox();
			this.TxtRangeTo = new System.Windows.Forms.TextBox();
			this.LvwPostVars = new System.Windows.Forms.ListView();
			this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
			this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
			this.BtnAddPostVar = new System.Windows.Forms.Button();
			this.TxtOtherHeaders = new System.Windows.Forms.TextBox();
			this.BtnLoadPostVars = new System.Windows.Forms.Button();
			this.label5 = new System.Windows.Forms.Label();
			this.CbxUseHttp10 = new System.Windows.Forms.CheckBox();
			this.BtnSavePostVars = new System.Windows.Forms.Button();
			this.TxtRawPost = new System.Windows.Forms.TextBox();
			this.CbxRawPost = new System.Windows.Forms.CheckBox();
			this.TxtAccept = new System.Windows.Forms.TextBox();
			this.label6 = new System.Windows.Forms.Label();
			this.BtnSelectUA = new System.Windows.Forms.Button();
			this.MnuSelectUA = new System.Windows.Forms.ContextMenu();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(8, 11);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(64, 23);
			this.label1.TabIndex = 0;
			this.label1.Text = "User Agent";
			// 
			// TxtUserAgent
			// 
			this.TxtUserAgent.Location = new System.Drawing.Point(72, 8);
			this.TxtUserAgent.Name = "TxtUserAgent";
			this.TxtUserAgent.Size = new System.Drawing.Size(424, 20);
			this.TxtUserAgent.TabIndex = 0;
			this.TxtUserAgent.Text = "";
			this.TxtUserAgent.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Textbox_KeyDown);
			this.TxtUserAgent.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.Textbox_KeyPress);
			// 
			// TxtReferer
			// 
			this.TxtReferer.Location = new System.Drawing.Point(72, 32);
			this.TxtReferer.Name = "TxtReferer";
			this.TxtReferer.Size = new System.Drawing.Size(424, 20);
			this.TxtReferer.TabIndex = 1;
			this.TxtReferer.Text = "";
			this.TxtReferer.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Textbox_KeyDown);
			this.TxtReferer.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.Textbox_KeyPress);
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 34);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(64, 16);
			this.label2.TabIndex = 2;
			this.label2.Text = "Referer";
			// 
			// BtnClose
			// 
			this.BtnClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.BtnClose.DialogResult = System.Windows.Forms.DialogResult.OK;
			this.BtnClose.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.BtnClose.Location = new System.Drawing.Point(445, 306);
			this.BtnClose.Name = "BtnClose";
			this.BtnClose.TabIndex = 32;
			this.BtnClose.Text = "&Close";
			this.BtnClose.Click += new System.EventHandler(this.BtnClose_Click);
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(8, 92);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(64, 16);
			this.label3.TabIndex = 5;
			this.label3.Text = "POST Vars";
			// 
			// TxtRangeFrom
			// 
			this.TxtRangeFrom.Enabled = false;
			this.TxtRangeFrom.Location = new System.Drawing.Point(72, 56);
			this.TxtRangeFrom.Name = "TxtRangeFrom";
			this.TxtRangeFrom.Size = new System.Drawing.Size(40, 20);
			this.TxtRangeFrom.TabIndex = 11;
			this.TxtRangeFrom.Text = "";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(120, 56);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(8, 16);
			this.label4.TabIndex = 7;
			this.label4.Text = "-";
			// 
			// CbxRange
			// 
			this.CbxRange.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.CbxRange.Location = new System.Drawing.Point(10, 56);
			this.CbxRange.Name = "CbxRange";
			this.CbxRange.Size = new System.Drawing.Size(72, 24);
			this.CbxRange.TabIndex = 10;
			this.CbxRange.Text = "Range";
			this.CbxRange.CheckedChanged += new System.EventHandler(this.CbxRange_CheckedChanged);
			// 
			// TxtRangeTo
			// 
			this.TxtRangeTo.Enabled = false;
			this.TxtRangeTo.Location = new System.Drawing.Point(136, 56);
			this.TxtRangeTo.Name = "TxtRangeTo";
			this.TxtRangeTo.Size = new System.Drawing.Size(40, 20);
			this.TxtRangeTo.TabIndex = 12;
			this.TxtRangeTo.Text = "";
			// 
			// LvwPostVars
			// 
			this.LvwPostVars.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
																						  this.columnHeader1,
																						  this.columnHeader2});
			this.LvwPostVars.FullRowSelect = true;
			this.LvwPostVars.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable;
			this.LvwPostVars.Location = new System.Drawing.Point(72, 88);
			this.LvwPostVars.Name = "LvwPostVars";
			this.LvwPostVars.Size = new System.Drawing.Size(448, 112);
			this.LvwPostVars.TabIndex = 23;
			this.LvwPostVars.View = System.Windows.Forms.View.Details;
			this.LvwPostVars.KeyDown += new System.Windows.Forms.KeyEventHandler(this.LvwPostVars_KeyDown);
			this.LvwPostVars.DoubleClick += new System.EventHandler(this.LvwPostVars_DoubleClick);
			// 
			// columnHeader1
			// 
			this.columnHeader1.Text = "Key";
			this.columnHeader1.Width = 140;
			// 
			// columnHeader2
			// 
			this.columnHeader2.Text = "Value";
			this.columnHeader2.Width = 280;
			// 
			// BtnAddPostVar
			// 
			this.BtnAddPostVar.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.BtnAddPostVar.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.BtnAddPostVar.Location = new System.Drawing.Point(8, 112);
			this.BtnAddPostVar.Name = "BtnAddPostVar";
			this.BtnAddPostVar.Size = new System.Drawing.Size(60, 20);
			this.BtnAddPostVar.TabIndex = 20;
			this.BtnAddPostVar.Text = "&Add ++";
			this.BtnAddPostVar.Click += new System.EventHandler(this.BtnAddPostVar_Click);
			// 
			// TxtOtherHeaders
			// 
			this.TxtOtherHeaders.Location = new System.Drawing.Point(72, 208);
			this.TxtOtherHeaders.Multiline = true;
			this.TxtOtherHeaders.Name = "TxtOtherHeaders";
			this.TxtOtherHeaders.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.TxtOtherHeaders.Size = new System.Drawing.Size(448, 56);
			this.TxtOtherHeaders.TabIndex = 31;
			this.TxtOtherHeaders.Text = "";
			this.TxtOtherHeaders.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Textbox_KeyDown);
			this.TxtOtherHeaders.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.Textbox_KeyPress);
			// 
			// BtnLoadPostVars
			// 
			this.BtnLoadPostVars.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.BtnLoadPostVars.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.BtnLoadPostVars.Location = new System.Drawing.Point(8, 132);
			this.BtnLoadPostVars.Name = "BtnLoadPostVars";
			this.BtnLoadPostVars.Size = new System.Drawing.Size(60, 20);
			this.BtnLoadPostVars.TabIndex = 21;
			this.BtnLoadPostVars.Text = "&Load >>";
			this.BtnLoadPostVars.Click += new System.EventHandler(this.BtnLoadPostVars_Click);
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(9, 208);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(55, 32);
			this.label5.TabIndex = 12;
			this.label5.Text = "Custom Headers";
			// 
			// CbxUseHttp10
			// 
			this.CbxUseHttp10.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.CbxUseHttp10.Location = new System.Drawing.Point(216, 56);
			this.CbxUseHttp10.Name = "CbxUseHttp10";
			this.CbxUseHttp10.Size = new System.Drawing.Size(96, 24);
			this.CbxUseHttp10.TabIndex = 13;
			this.CbxUseHttp10.Text = "Use HTTP 1.0";
			// 
			// BtnSavePostVars
			// 
			this.BtnSavePostVars.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.BtnSavePostVars.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.BtnSavePostVars.Location = new System.Drawing.Point(8, 152);
			this.BtnSavePostVars.Name = "BtnSavePostVars";
			this.BtnSavePostVars.Size = new System.Drawing.Size(60, 20);
			this.BtnSavePostVars.TabIndex = 22;
			this.BtnSavePostVars.Text = "&Save <<";
			this.BtnSavePostVars.Click += new System.EventHandler(this.BtnSavePostVars_Click);
			// 
			// TxtRawPost
			// 
			this.TxtRawPost.Location = new System.Drawing.Point(528, 88);
			this.TxtRawPost.Multiline = true;
			this.TxtRawPost.Name = "TxtRawPost";
			this.TxtRawPost.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.TxtRawPost.Size = new System.Drawing.Size(448, 112);
			this.TxtRawPost.TabIndex = 30;
			this.TxtRawPost.Text = "";
			this.TxtRawPost.Visible = false;
			this.TxtRawPost.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Textbox_KeyDown);
			this.TxtRawPost.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.Textbox_KeyPress);
			// 
			// CbxRawPost
			// 
			this.CbxRawPost.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.CbxRawPost.Location = new System.Drawing.Point(10, 172);
			this.CbxRawPost.Name = "CbxRawPost";
			this.CbxRawPost.Size = new System.Drawing.Size(54, 24);
			this.CbxRawPost.TabIndex = 33;
			this.CbxRawPost.Text = "Raw";
			this.CbxRawPost.CheckedChanged += new System.EventHandler(this.CbxRawPost_CheckedChanged);
			// 
			// TxtAccept
			// 
			this.TxtAccept.Location = new System.Drawing.Point(73, 272);
			this.TxtAccept.Name = "TxtAccept";
			this.TxtAccept.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.TxtAccept.Size = new System.Drawing.Size(448, 20);
			this.TxtAccept.TabIndex = 35;
			this.TxtAccept.Text = "";
			// 
			// label6
			// 
			this.label6.Location = new System.Drawing.Point(10, 272);
			this.label6.Name = "label6";
			this.label6.Size = new System.Drawing.Size(55, 16);
			this.label6.TabIndex = 34;
			this.label6.Text = "Accept";
			// 
			// BtnSelectUA
			// 
			this.BtnSelectUA.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.BtnSelectUA.Location = new System.Drawing.Point(498, 8);
			this.BtnSelectUA.Name = "BtnSelectUA";
			this.BtnSelectUA.Size = new System.Drawing.Size(24, 21);
			this.BtnSelectUA.TabIndex = 36;
			this.BtnSelectUA.Text = "<<";
			this.BtnSelectUA.Click += new System.EventHandler(this.BtnSelectUA_Click);
			// 
			// SettingsForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(528, 336);
			this.Controls.Add(this.BtnSelectUA);
			this.Controls.Add(this.TxtAccept);
			this.Controls.Add(this.TxtRawPost);
			this.Controls.Add(this.TxtOtherHeaders);
			this.Controls.Add(this.TxtRangeTo);
			this.Controls.Add(this.TxtRangeFrom);
			this.Controls.Add(this.TxtReferer);
			this.Controls.Add(this.TxtUserAgent);
			this.Controls.Add(this.label6);
			this.Controls.Add(this.CbxRawPost);
			this.Controls.Add(this.LvwPostVars);
			this.Controls.Add(this.BtnSavePostVars);
			this.Controls.Add(this.CbxUseHttp10);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.BtnLoadPostVars);
			this.Controls.Add(this.BtnAddPostVar);
			this.Controls.Add(this.CbxRange);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.BtnClose);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.Name = "SettingsForm";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = "Request Settings";
			this.Load += new System.EventHandler(this.SettingsForm_Load);
			this.ResumeLayout(false);

		}
		#endregion


		private void BtnClose_Click(object sender, System.EventArgs e)
		{
			try
			{
				if (TxtRangeFrom.Text.Length > 0)
					Int32.Parse(TxtRangeFrom.Text);
				if (TxtRangeTo.Text.Length > 0)
                    Int32.Parse(TxtRangeTo.Text);
			}
			catch
			{
				MessageBox.Show("Numbers are required for the range", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return;
			}

			DialogResult = DialogResult.OK;
		}


		private void SettingsForm_Load(object sender, System.EventArgs e)
		{
			TxtUserAgent.Select(0, 0);
		}

		
		private void CbxRange_CheckedChanged(object sender, System.EventArgs e)
		{
			CheckBox cbx = (CheckBox) sender;
			if (cbx.Checked)
			{
                TxtRangeFrom.Enabled = true;
				TxtRangeTo.Enabled = true;
				TxtRangeFrom.Focus();
			}
			else
			{
				TxtRangeFrom.Text = "";
				TxtRangeTo.Text = "";
				TxtRangeFrom.Enabled = false;
				TxtRangeTo.Enabled = false;
			}
		}

		private void BtnAddPostVar_Click(object sender, System.EventArgs e)
		{
			KeyValueForm dlg = new KeyValueForm();
			if (dlg.ShowDialog() == DialogResult.OK)
			{
				LvwPostVars.Items.Add(new ListViewItem(new string[2] { dlg.TxtKey.Text, dlg.TxtValue.Text }));
				LvwPostVars.Focus();
			}
		}


		private void LvwPostVars_DoubleClick(object sender, System.EventArgs e)
		{
			ListView lvw = (ListView) sender;
			KeyValueForm dlg = new KeyValueForm();
			dlg.TxtKey.Text = lvw.SelectedItems[0].SubItems[0].Text;
			dlg.TxtValue.Text = lvw.SelectedItems[0].SubItems[1].Text;
			if (dlg.ShowDialog() == DialogResult.OK)
			{
				lvw.SelectedItems[0].SubItems[0].Text = dlg.TxtKey.Text;
				lvw.SelectedItems[0].SubItems[1].Text = dlg.TxtValue.Text;
			}
		}

		private void LvwPostVars_KeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
		{
			ListView lvw = (ListView) sender;
			//MessageBox.Show(e.KeyValue.ToString());
			if (lvw.SelectedItems.Count > 0)
			{
				if (e.KeyValue == 13)
					LvwPostVars_DoubleClick(sender, EventArgs.Empty);
				if (e.KeyValue == 46)
					lvw.SelectedItems[0].Remove();
			}
		}

		private void BtnLoadPostVars_Click(object sender, System.EventArgs e)
		{
			OpenFileDialog dlg = new OpenFileDialog();
			dlg.Filter = "Text Files (*.txt)|*.txt";
			if (dlg.ShowDialog() == DialogResult.OK)
			{
				StreamReader reader = File.OpenText(dlg.FileName);
				string line;
				string currKey = null;
				Hashtable postVars = new Hashtable();
				while ((line = reader.ReadLine()) != null)
				{
					if (line.Length > 0 && line[0] == '[' && line[line.Length - 1] == ']')
					{
						currKey = line.Substring(1, line.Length - 2);
						postVars.Add(currKey, "");
					}
					else
					{
						postVars[currKey] += line + "\r\n";
					}

				}
				reader.Close();

			
				// update listview
				LvwPostVars.Items.Clear();
				foreach (DictionaryEntry de in postVars)
				{
					string val = (string)de.Value;
					if (val.EndsWith("\r\n"))
						val = val.Substring(0, val.Length - 2);
					LvwPostVars.Items.Add(new ListViewItem(new string[2] { (string)de.Key, val }));
				}
			}
		}


		private void BtnSavePostVars_Click(object sender, System.EventArgs e)
		{
			SaveFileDialog dlg = new SaveFileDialog();
			dlg.Filter = "Text Files (*.txt)|*.txt";
			if (dlg.ShowDialog() == DialogResult.OK)
			{
				StringBuilder sb = new StringBuilder();
				foreach (ListViewItem currItem in LvwPostVars.Items)
				{
					sb.AppendFormat("[{0}]\r\n{1}\r\n", currItem.SubItems[0].Text, currItem.SubItems[1].Text);
				}

				StreamWriter sw = File.CreateText(dlg.FileName);
				sw.Write(sb.ToString());
				sw.Close();
			}
		}


		private void Textbox_KeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
		{
			isHandled = false;

			if (e.Control && e.KeyCode == Keys.A)
			{
				((TextBox)sender).SelectAll();
				((TextBox)sender).Focus();
				isHandled = true;
			}
		}

		private void Textbox_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
		{
			// bit of a hack to ensure windows doesn't beep for a key action that is implemented here (i.e. in Textbox_KeyDown)
			if (isHandled)
				e.Handled = true;
		}

		private void CbxRawPost_CheckedChanged(object sender, System.EventArgs e)
		{
			if (CbxRawPost.Checked)
			{
				LvwPostVars.Visible = false;
				TxtRawPost.Visible = true;
				TxtRawPost.Location = new Point(72, TxtRawPost.Location.Y);
				TxtRawPost.Focus();
				BtnAddPostVar.Enabled = false;
				BtnLoadPostVars.Enabled = false;
				BtnSavePostVars.Enabled = false;
			}
			else
			{
				LvwPostVars.Visible = !false;
				TxtRawPost.Visible = !true;
				BtnAddPostVar.Enabled = !false;
				BtnLoadPostVars.Enabled = !false;
				BtnSavePostVars.Enabled = !false;
			}
		}

		
		private void BtnSelectUA_Click(object sender, System.EventArgs e)
		{
			Button btn = (Button) sender;
			MnuSelectUA.Show(btn, new Point(btn.Width, 0));
		}


		private void MnuSelectUA_Click(object sender, System.EventArgs e)
		{
			MenuItem item = (MenuItem) sender;

			int arrIndex = item.Index * 2 + 1;
			TxtUserAgent.Text = UAStrings[arrIndex];
		}

	}
}
