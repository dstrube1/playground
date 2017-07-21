using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.Net;
using System.IO;
using System.Text;
using System.Web;
using System.Configuration;


namespace HTTPeep
{
	/// <summary>
	/// Summary description for MainForm.
	/// </summary>
	public class MainForm : System.Windows.Forms.Form
	{
		private SettingsForm SettingsFormInst;
		private string TmpFilename;
		bool keyHandled = false;
		DateTime requestStart = DateTime.Now;


		private System.Windows.Forms.TextBox TxtUrl;
		private System.Windows.Forms.Label LblUrl;
		private System.Windows.Forms.Button BtnGo;
		private System.Windows.Forms.TextBox TxtHeaders;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox TxtContent;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.TextBox TxtStatusCode;
		private System.Windows.Forms.TextBox TxtStatusDesc;
		private System.Windows.Forms.LinkLabel LnkEditSettings;
		private System.Windows.Forms.LinkLabel LnkViewRequestText;
		private System.Windows.Forms.ContextMenu contextMenu1;
		private System.Windows.Forms.MenuItem MniCopy;
		private System.Windows.Forms.MenuItem MniSave;
		private System.Windows.Forms.ContextMenu contextMenu2;
		private System.Windows.Forms.MenuItem menuItem1;
		private System.Windows.Forms.MenuItem menuItem2;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		private System.Windows.Forms.CheckBox CbxAutoRedirect;
		private System.Windows.Forms.StatusBar statusBar1;
		private System.Windows.Forms.StatusBarPanel StatusResults;
		private System.Windows.Forms.StatusBarPanel statusBarPanel1;
		private System.Windows.Forms.Button BtnReqSettings;
		private System.Windows.Forms.LinkLabel linkLabel1;
		CookieContainer CookieCont = new CookieContainer();

		public MainForm()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			SettingsFormInst = new SettingsForm();
			//TmpFilename = Application.StartupPath + "\\content.tmp";
			//TmpFilename = Path.GetTempPath() + "http_content.tmp";
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
			this.TxtUrl = new System.Windows.Forms.TextBox();
			this.LblUrl = new System.Windows.Forms.Label();
			this.BtnGo = new System.Windows.Forms.Button();
			this.TxtHeaders = new System.Windows.Forms.TextBox();
			this.contextMenu1 = new System.Windows.Forms.ContextMenu();
			this.MniCopy = new System.Windows.Forms.MenuItem();
			this.MniSave = new System.Windows.Forms.MenuItem();
			this.TxtContent = new System.Windows.Forms.TextBox();
			this.contextMenu2 = new System.Windows.Forms.ContextMenu();
			this.menuItem1 = new System.Windows.Forms.MenuItem();
			this.menuItem2 = new System.Windows.Forms.MenuItem();
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.TxtStatusCode = new System.Windows.Forms.TextBox();
			this.TxtStatusDesc = new System.Windows.Forms.TextBox();
			this.label4 = new System.Windows.Forms.Label();
			this.LnkEditSettings = new System.Windows.Forms.LinkLabel();
			this.LnkViewRequestText = new System.Windows.Forms.LinkLabel();
			this.CbxAutoRedirect = new System.Windows.Forms.CheckBox();
			this.statusBar1 = new System.Windows.Forms.StatusBar();
			this.StatusResults = new System.Windows.Forms.StatusBarPanel();
			this.statusBarPanel1 = new System.Windows.Forms.StatusBarPanel();
			this.BtnReqSettings = new System.Windows.Forms.Button();
			this.linkLabel1 = new System.Windows.Forms.LinkLabel();
			((System.ComponentModel.ISupportInitialize)(this.StatusResults)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.statusBarPanel1)).BeginInit();
			this.SuspendLayout();
			// 
			// TxtUrl
			// 
			this.TxtUrl.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.TxtUrl.Location = new System.Drawing.Point(37, 5);
			this.TxtUrl.Name = "TxtUrl";
			this.TxtUrl.Size = new System.Drawing.Size(570, 20);
			this.TxtUrl.TabIndex = 0;
			this.TxtUrl.Text = "";
			this.TxtUrl.KeyDown += new System.Windows.Forms.KeyEventHandler(this.TxtUrl_KeyDown);
			this.TxtUrl.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TxtUrl_KeyPress);
			// 
			// LblUrl
			// 
			this.LblUrl.Location = new System.Drawing.Point(8, 9);
			this.LblUrl.Name = "LblUrl";
			this.LblUrl.Size = new System.Drawing.Size(32, 16);
			this.LblUrl.TabIndex = 1;
			this.LblUrl.Text = "URL";
			// 
			// BtnGo
			// 
			this.BtnGo.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.BtnGo.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.BtnGo.Location = new System.Drawing.Point(608, 5);
			this.BtnGo.Name = "BtnGo";
			this.BtnGo.Size = new System.Drawing.Size(32, 21);
			this.BtnGo.TabIndex = 1;
			this.BtnGo.Text = "&GO";
			this.BtnGo.Click += new System.EventHandler(this.BtnGo_Click);
			// 
			// TxtHeaders
			// 
			this.TxtHeaders.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.TxtHeaders.ContextMenu = this.contextMenu1;
			this.TxtHeaders.Location = new System.Drawing.Point(8, 104);
			this.TxtHeaders.Multiline = true;
			this.TxtHeaders.Name = "TxtHeaders";
			this.TxtHeaders.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.TxtHeaders.Size = new System.Drawing.Size(632, 88);
			this.TxtHeaders.TabIndex = 30;
			this.TxtHeaders.Text = "";
			this.TxtHeaders.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Handle_KeyDown);
			this.TxtHeaders.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.Handle_KeyPress);
			// 
			// contextMenu1
			// 
			this.contextMenu1.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																						 this.MniCopy,
																						 this.MniSave});
			// 
			// MniCopy
			// 
			this.MniCopy.Index = 0;
			this.MniCopy.Text = "&Copy";
			this.MniCopy.Click += new System.EventHandler(this.MniCopy_Click);
			// 
			// MniSave
			// 
			this.MniSave.Index = 1;
			this.MniSave.Text = "&Save";
			this.MniSave.Click += new System.EventHandler(this.MniSave_Click);
			// 
			// TxtContent
			// 
			this.TxtContent.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.TxtContent.ContextMenu = this.contextMenu2;
			this.TxtContent.Location = new System.Drawing.Point(8, 216);
			this.TxtContent.MaxLength = 100000;
			this.TxtContent.Multiline = true;
			this.TxtContent.Name = "TxtContent";
			this.TxtContent.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.TxtContent.Size = new System.Drawing.Size(632, 192);
			this.TxtContent.TabIndex = 40;
			this.TxtContent.Text = "";
			this.TxtContent.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Handle_KeyDown);
			this.TxtContent.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.Handle_KeyPress);
			// 
			// contextMenu2
			// 
			this.contextMenu2.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																						 this.menuItem1,
																						 this.menuItem2});
			// 
			// menuItem1
			// 
			this.menuItem1.Index = 0;
			this.menuItem1.Text = "&Copy";
			this.menuItem1.Click += new System.EventHandler(this.MniCopy_Click);
			// 
			// menuItem2
			// 
			this.menuItem2.Index = 1;
			this.menuItem2.Text = "&Save";
			this.menuItem2.Click += new System.EventHandler(this.MniSave_Click);
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(8, 88);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(104, 16);
			this.label1.TabIndex = 5;
			this.label1.Text = "Returned Headers";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 200);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(128, 16);
			this.label2.TabIndex = 6;
			this.label2.Text = "Content";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(8, 60);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(72, 16);
			this.label3.TabIndex = 7;
			this.label3.Text = "Status Code";
			// 
			// TxtStatusCode
			// 
			this.TxtStatusCode.Location = new System.Drawing.Point(75, 56);
			this.TxtStatusCode.Name = "TxtStatusCode";
			this.TxtStatusCode.Size = new System.Drawing.Size(32, 20);
			this.TxtStatusCode.TabIndex = 20;
			this.TxtStatusCode.Text = "";
			this.TxtStatusCode.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
			this.TxtStatusCode.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Handle_KeyDown);
			this.TxtStatusCode.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.Handle_KeyPress);
			// 
			// TxtStatusDesc
			// 
			this.TxtStatusDesc.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.TxtStatusDesc.Location = new System.Drawing.Point(216, 56);
			this.TxtStatusDesc.Name = "TxtStatusDesc";
			this.TxtStatusDesc.Size = new System.Drawing.Size(424, 20);
			this.TxtStatusDesc.TabIndex = 21;
			this.TxtStatusDesc.Text = "";
			this.TxtStatusDesc.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Handle_KeyDown);
			this.TxtStatusDesc.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.Handle_KeyPress);
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(120, 60);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(96, 16);
			this.label4.TabIndex = 9;
			this.label4.Text = "Status Description";
			// 
			// LnkEditSettings
			// 
			this.LnkEditSettings.LinkArea = new System.Windows.Forms.LinkArea(2, 17);
			this.LnkEditSettings.Location = new System.Drawing.Point(36, 28);
			this.LnkEditSettings.Name = "LnkEditSettings";
			this.LnkEditSettings.Size = new System.Drawing.Size(104, 16);
			this.LnkEditSettings.TabIndex = 10;
			this.LnkEditSettings.TabStop = true;
			this.LnkEditSettings.Text = "» Request Settings";
			this.LnkEditSettings.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.LnkEditSettings_LinkClicked);
			// 
			// LnkViewRequestText
			// 
			this.LnkViewRequestText.LinkArea = new System.Windows.Forms.LinkArea(2, 17);
			this.LnkViewRequestText.Location = new System.Drawing.Point(144, 28);
			this.LnkViewRequestText.Name = "LnkViewRequestText";
			this.LnkViewRequestText.Size = new System.Drawing.Size(88, 16);
			this.LnkViewRequestText.TabIndex = 11;
			this.LnkViewRequestText.TabStop = true;
			this.LnkViewRequestText.Text = "» Request Text";
			this.LnkViewRequestText.Visible = false;
			this.LnkViewRequestText.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.LnkViewRequestText_LinkClicked);
			// 
			// CbxAutoRedirect
			// 
			this.CbxAutoRedirect.Checked = true;
			this.CbxAutoRedirect.CheckState = System.Windows.Forms.CheckState.Checked;
			this.CbxAutoRedirect.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.CbxAutoRedirect.Location = new System.Drawing.Point(248, 30);
			this.CbxAutoRedirect.Name = "CbxAutoRedirect";
			this.CbxAutoRedirect.Size = new System.Drawing.Size(112, 16);
			this.CbxAutoRedirect.TabIndex = 12;
			this.CbxAutoRedirect.Text = "Follow Redirects";
			// 
			// statusBar1
			// 
			this.statusBar1.Location = new System.Drawing.Point(0, 418);
			this.statusBar1.Name = "statusBar1";
			this.statusBar1.Panels.AddRange(new System.Windows.Forms.StatusBarPanel[] {
																						  this.StatusResults,
																						  this.statusBarPanel1});
			this.statusBar1.ShowPanels = true;
			this.statusBar1.Size = new System.Drawing.Size(648, 20);
			this.statusBar1.TabIndex = 18;
			// 
			// StatusResults
			// 
			this.StatusResults.Width = 350;
			// 
			// statusBarPanel1
			// 
			this.statusBarPanel1.AutoSize = System.Windows.Forms.StatusBarPanelAutoSize.Spring;
			this.statusBarPanel1.Width = 282;
			// 
			// BtnReqSettings
			// 
			this.BtnReqSettings.Location = new System.Drawing.Point(-200, -200);
			this.BtnReqSettings.Name = "BtnReqSettings";
			this.BtnReqSettings.Size = new System.Drawing.Size(95, 31);
			this.BtnReqSettings.TabIndex = 41;
			this.BtnReqSettings.Text = "Req &Settings";
			this.BtnReqSettings.Click += new System.EventHandler(this.BtnReqSettings_Click);
			// 
			// linkLabel1
			// 
			this.linkLabel1.LinkArea = new System.Windows.Forms.LinkArea(2, 55);
			this.linkLabel1.Location = new System.Drawing.Point(384, 28);
			this.linkLabel1.Name = "linkLabel1";
			this.linkLabel1.Size = new System.Drawing.Size(160, 16);
			this.linkLabel1.TabIndex = 42;
			this.linkLabel1.TabStop = true;
			this.linkLabel1.Text = "» Default Request Settings";
			this.linkLabel1.Visible = false;
			// 
			// MainForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(648, 438);
			this.Controls.Add(this.linkLabel1);
			this.Controls.Add(this.BtnReqSettings);
			this.Controls.Add(this.statusBar1);
			this.Controls.Add(this.CbxAutoRedirect);
			this.Controls.Add(this.TxtStatusDesc);
			this.Controls.Add(this.TxtStatusCode);
			this.Controls.Add(this.TxtContent);
			this.Controls.Add(this.TxtHeaders);
			this.Controls.Add(this.TxtUrl);
			this.Controls.Add(this.LnkViewRequestText);
			this.Controls.Add(this.LnkEditSettings);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.BtnGo);
			this.Controls.Add(this.LblUrl);
			this.MinimumSize = new System.Drawing.Size(540, 350);
			this.Name = "MainForm";
			this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Show;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "HTTPeep";
			this.Load += new System.EventHandler(this.MainForm_Load);
			this.Closed += new System.EventHandler(this.MainForm_Closed);
			((System.ComponentModel.ISupportInitialize)(this.StatusResults)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.statusBarPanel1)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion


		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.EnableVisualStyles();
			Application.DoEvents();

			Application.Run(new MainForm());
		}


		private void ToggleControlsEnabled(bool enabled)
		{
			TxtUrl.Enabled = enabled;
			BtnGo.Enabled = enabled;
			LnkEditSettings.Enabled = enabled;
			LnkViewRequestText.Enabled = enabled;
			CbxAutoRedirect.Enabled = enabled;
		}

		
		void ResetForm()
		{
			TxtStatusCode.Text = "";
			TxtStatusDesc.Text = "";
			TxtHeaders.Text = "";
			TxtContent.Text = "";
		}


		private void BtnGo_Click(object sender, System.EventArgs e)
		{
			requestStart = DateTime.Now;

			if (TmpFilename != null)
				File.Delete(TmpFilename);

			TmpFilename = Path.GetTempPath() + "http_content" + requestStart.Ticks + ".tmp";


			ToggleControlsEnabled(false);
			ResetForm();

			string url = TxtUrl.Text;
			if (!url.StartsWith("http://") && !url.StartsWith("https://"))
			{
				url = "http://" + url;
				TxtUrl.Text = url;
			}

			Application.DoEvents();


			HttpWebRequest req;
			try
			{
				req = (HttpWebRequest) HttpWebRequest.Create(url);
			}
			catch (Exception err)
			{
				MessageBox.Show("Error: " + err.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

				ToggleControlsEnabled(true);
				TxtUrl.Focus();

				return;
			}


			if (SettingsFormInst.CbxUseHttp10.Checked)
				req.ProtocolVersion = HttpVersion.Version10;

			req.AllowAutoRedirect = CbxAutoRedirect.Checked;
			req.UserAgent = SettingsFormInst.TxtUserAgent.Text;
			req.CookieContainer = CookieCont;

			if (SettingsFormInst.TxtReferer.Text.Length > 0)
				req.Referer = SettingsFormInst.TxtReferer.Text;

			if (SettingsFormInst.TxtAccept.Text.Length > 0)
				req.Accept = SettingsFormInst.TxtAccept.Text;

			if ((SettingsFormInst.CbxRange.Checked) && (SettingsFormInst.TxtRangeFrom.Text.Length + SettingsFormInst.TxtRangeTo.Text.Length > 0))
			{
				if (SettingsFormInst.TxtRangeFrom.Text.Length == 0)
					req.AddRange(Int32.Parse(SettingsFormInst.TxtRangeTo.Text) * -1);
				else if (SettingsFormInst.TxtRangeTo.Text.Length == 0)
					req.AddRange(Int32.Parse(SettingsFormInst.TxtRangeFrom.Text));
				else
					req.AddRange(Int32.Parse(SettingsFormInst.TxtRangeFrom.Text), Int32.Parse(SettingsFormInst.TxtRangeTo.Text));
			}


			// custom additional headers
			if (SettingsFormInst.TxtOtherHeaders.Text.Length > 0)
			{
				string[] lines = SettingsFormInst.TxtOtherHeaders.Text.Split('\n');
				foreach (string line in lines)
				{
					int pos = line.IndexOf(':');
					if (pos != -1)
					{
						string header = line.Substring(0, pos).Trim();
						string headerValue = line.Substring(pos + 1).Trim();
						try
						{
							req.Headers.Add(header, headerValue);
						}
						catch (ArgumentException)
						{
							MessageBox.Show("ERROR: The header '" + header + "' has to be set explicitly using one of the properties.    ");
						}
					}
				}
			}


			// add any post variables
			if (SettingsFormInst.LvwPostVars.Items.Count > 0)
			{
				req.Method = "POST";
				req.ContentType = "application/x-www-form-urlencoded";

				StringBuilder postData = new StringBuilder();
				foreach (ListViewItem item in SettingsFormInst.LvwPostVars.Items)
				{
					postData.AppendFormat("{0}={1}&", HttpUtility.UrlEncode(item.SubItems[0].Text), HttpUtility.UrlEncode(item.SubItems[1].Text));
				}
				postData.Remove(postData.Length - 1, 1);

				byte[] postDataBytes = Encoding.UTF8.GetBytes(postData.ToString());

				req.ContentLength = postDataBytes.Length;

				Stream postDataStream = req.GetRequestStream();
				postDataStream.Write(postDataBytes, 0, postDataBytes.Length);
				postDataStream.Close();
			}
			else if (SettingsFormInst.TxtRawPost.Text.Length > 0) // raw post data - alternative to variables
			{
				req.Method = "POST";
				req.ContentType = "text/xml; charset=utf-8";
				
				byte[] postDataBytes = Encoding.UTF8.GetBytes(SettingsFormInst.TxtRawPost.Text.Trim());
				req.ContentLength = postDataBytes.Length;

				Stream postDataStream = req.GetRequestStream();
				postDataStream.Write(postDataBytes, 0, postDataBytes.Length);
				postDataStream.Close();
			}


			HttpWebResponse resp;
			try
			{			
				resp = (HttpWebResponse) req.GetResponse();
			}
			catch (WebException err)
			{
				MessageBox.Show(err.Status + " - " + err.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

				resp = (HttpWebResponse) err.Response;
				if (resp == null)
				{
					ToggleControlsEnabled(true);
					TxtUrl.Focus();
					return;
				}
			}
			catch (Exception err)
			{
				MessageBox.Show("Error: " + err.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

				ToggleControlsEnabled(true);
				TxtUrl.Focus();
				return;
			}


			Stream rcvStream = resp.GetResponseStream();
			byte[] respBytes = new byte[256];
			int byteCount;

			FileStream fs = new FileStream(TmpFilename, FileMode.Create, FileAccess.Write);
			do
			{
				byteCount = rcvStream.Read(respBytes, 0, 256);
				fs.Write(respBytes, 0, byteCount);
			} while (byteCount > 0);

			fs.Close();

			resp.Close();
			rcvStream.Close();

			
			string respContent;
			FileInfo info = new FileInfo(TmpFilename);
			long contentLength = info.Length;

			if (resp.ContentType.StartsWith("text/"))
			{
				if (contentLength > TxtContent.MaxLength)
				{
					respContent = "Excessive text was returned. Right-click and choose 'Save' to save the response content.";
				}
				else
				{
					StreamReader reader = File.OpenText(TmpFilename);
					respContent = reader.ReadToEnd();
					reader.Close();
					respContent = respContent.Replace("\r\n", "\n");
					respContent = respContent.Replace("\n", "\r\n");
				}
			}
			else
				respContent = "Non-text response received. Right-click and choose 'Save' to save the response content.";

			TxtStatusCode.Text = ((int)resp.StatusCode) + "";
			TxtStatusDesc.Text = resp.StatusDescription;
			TxtHeaders.Text = resp.Headers.ToString().Trim();
			TxtContent.Text = respContent.ToString().Trim();
			//TxtContentLength.Text = contentLength.ToString("#,###,###");


			TimeSpan dur = DateTime.Now - requestStart;
			double avg = -1;
			if (dur.TotalSeconds > 0)
				avg = Math.Round(((double)contentLength / (double)1024) / (double)dur.TotalSeconds, 2);
			StatusResults.Text = string.Format(" {0} bytes downloaded in {1:0.00} seconds (avg. {2:0.00} KB/s)", contentLength.ToString("#,###,###"), dur.TotalSeconds, avg);

			ToggleControlsEnabled(true);
			TxtUrl.Focus();


			if (resp.ResponseUri.ToString() != TxtUrl.Text)
			{
				RequestTextForm dlg = new RequestTextForm();
				dlg.Height = 130;
				dlg.TxtRequestText.Text = "URL that responded:\r\n" + resp.ResponseUri.ToString();
				dlg.ShowDialog();
			}
		}


		private void MainForm_Load(object sender, System.EventArgs e)
		{
			TxtUrl.Text = ConfigurationSettings.AppSettings["DefaultURL"];
			TxtUrl.Select(TxtUrl.Text.Length, 0);

			string version = Application.ProductVersion;
			if (version.EndsWith(".0"))
				version = version.Substring(0, version.Length - 2);
			this.Text += " v" + version + "";
		}


		private void LnkEditSettings_LinkClicked(object sender, System.Windows.Forms.LinkLabelLinkClickedEventArgs e)
		{
			SettingsFormInst.ShowDialog();
		}

		
		private void LnkViewRequestText_LinkClicked(object sender, System.Windows.Forms.LinkLabelLinkClickedEventArgs e)
		{
			StringBuilder sb = new StringBuilder();

			string method = (SettingsFormInst.LvwPostVars.Items.Count == 0) ? "GET" : "POST";
			Uri enteredUrl;
			try 
			{
				enteredUrl = new Uri(TxtUrl.Text);
			}
			catch (Exception err)
			{
				MessageBox.Show("Error: bad url - " + err.Message);
				return;
			}

			sb.AppendFormat("{0} {1} HTTP/1.1\r\n", method, enteredUrl.AbsolutePath);
			sb.AppendFormat("Host: {0}\r\n", enteredUrl.Host);

			if (SettingsFormInst.TxtReferer.Text.Length > 0)
				sb.AppendFormat("Referer: {0}\r\n", SettingsFormInst.TxtReferer.Text);

			if (SettingsFormInst.LvwPostVars.Items.Count > 0)
			{
				StringBuilder postData = new StringBuilder();
				foreach (ListViewItem item in SettingsFormInst.LvwPostVars.Items)
				{
					postData.AppendFormat("{0}={1}&", HttpUtility.UrlEncode(item.SubItems[0].Text), HttpUtility.UrlEncode(item.SubItems[1].Text));
				}
				postData.Remove(postData.Length - 1, 1);

				byte[] postDataBytes = Encoding.UTF8.GetBytes(postData.ToString());

				sb.AppendFormat("Content-Length: {0}\r\n", postDataBytes.Length);
				sb.AppendFormat("Content-Type: application/x-www-form-urlencoded\r\n");

				sb.AppendFormat("\r\n{0}", postData);
			}

			RequestTextForm dlg = new RequestTextForm();
			dlg.TxtRequestText.Text = sb.ToString().Trim();

			Rectangle frmBounds = this.DesktopBounds;

			dlg.ShowDialog();
		}

		private void Handle_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
		{
			e.Handled = true;
		}

		private void Handle_KeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
		{
			if (e.Control)
			{
				if (e.KeyCode == Keys.A)
				{
					((TextBox)sender).SelectAll();
					((TextBox)sender).Focus();
					e.Handled = true;
				}
				else if (e.KeyCode == Keys.C)
				{
					if (((TextBox)sender).SelectionLength == 0)
						Clipboard.SetDataObject(((TextBox)sender).Text, true);
					else
						Clipboard.SetDataObject(((TextBox)sender).SelectedText, true);
					e.Handled = true;
				}
			}
		}

		
		private void MniCopy_Click(object sender, System.EventArgs e)
		{
			MenuItem mni = (MenuItem) sender;
			if (mni.Parent == contextMenu1)
			{
				if (TxtHeaders.SelectionLength == 0)
					Clipboard.SetDataObject(TxtHeaders.Text, true);
				else
					Clipboard.SetDataObject(TxtHeaders.SelectedText, true);
			}
			else if (mni.Parent == contextMenu2)
			{
				if (TxtContent.SelectionLength == 0)
					Clipboard.SetDataObject(TxtContent.Text, true);
				else
					Clipboard.SetDataObject(TxtContent.SelectedText, true);
			}
		}

		
		private void MniSave_Click(object sender, System.EventArgs e)
		{
			MenuItem mni = (MenuItem) sender;
			
			if (mni.Parent == contextMenu1)
			{
				SaveFileDialog dlg = new SaveFileDialog();
				dlg.Filter = "Text File (*.txt)|*.txt";
				if (dlg.ShowDialog() == DialogResult.OK)
				{
					StreamWriter wr = File.CreateText(dlg.FileName);
					wr.Write(TxtHeaders.Text);
					wr.Close();
				}
			}
			else if (mni.Parent == contextMenu2)
			{
				SaveFileDialog dlg = new SaveFileDialog();
				dlg.Filter = "All Files (*.*)|*.*";
				if (dlg.ShowDialog() == DialogResult.OK)
					File.Copy(TmpFilename, dlg.FileName, true);
			}
		}


		private void BtnReqSettings_Click(object sender, System.EventArgs e)
		{
			SettingsFormInst.ShowDialog();
		}


		private void TxtUrl_KeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
		{
			keyHandled = false;

			if (e.KeyValue == 13)
			{
				BtnGo.PerformClick();
				keyHandled = true;
			}
			else if (e.Control && e.KeyCode == Keys.A)
			{
				((TextBox)sender).SelectAll();
				((TextBox)sender).Focus();
				keyHandled = true;
			}
		}

		
		private void TxtUrl_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
		{
			// bit of a hack to ensure windows doesn't beep for a key action that is implemented here (i.e. in Textbox_KeyDown)
			if (keyHandled)
				e.Handled = true;
		}


		private void MainForm_Closed(object sender, System.EventArgs e)
		{
			if (TmpFilename != null)
				File.Delete(TmpFilename);
		}

	}
}
