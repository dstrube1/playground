using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Net;
//using System.Data;
//using System.IO;

namespace WebFileGetter
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		//Methods
		/*private void bCancel_Click(object sender, EventArgs e)
		{
			keepLooping = false;
		}*/


		private void bGo_Click(object sender, EventArgs e)
		{
			if (null != loopThread && loopThread.IsAlive)
			{
				MessageBox.Show(this, "Already Running.");
				return;
			}

			loopThread = new System.Threading.Thread(new System.Threading.ThreadStart(loopThreadMethod));
			keepLooping = true;
			loopThread.Start();
		}


		private void loopThreadMethod()
		{
			string root_url, put_here, filename, ext, temp;
			int count_from, count_to;

			try 
			{
				//set vars from the form
				if(this.tbroot_url.Text != null && this.tbroot_url.Text != "")
					root_url = this.tbroot_url.Text;
				else
					root_url = "http://www.gutenberg.org/dirs/etext05/";
				if(this.tbput_here.Text != null && this.tbput_here.Text != "")
					put_here = this.tbput_here.Text;
				else
					put_here = @"C:\david\music\watch\books\d3- twain\";
				if (put_here.LastIndexOf("\\") != put_here.Length - 1)
					put_here += "\\";
				if(this.tbfilename.Text != null && this.tbfilename.Text != "")
					filename = this.tbfilename.Text;
				else
					filename = "beqst00";
				if(this.tbext.Text != null && this.tbext.Text != "")
					ext = this.tbext.Text;
				else
					ext = ".mp3";
				if(this.tbcount_from.Text != null && this.tbcount_from.Text != "")
					count_from = Int16.Parse(this.tbcount_from.Text);
				else
					count_from = 0;
				if(this.tbcount_to.Text != null && this.tbcount_to.Text != "")
					count_to = Int16.Parse(this.tbcount_to.Text);
				else
					count_to = 0;

				WebClient wc = new WebClient();

				pBar.Minimum = 0;
				pBar.Maximum = 105;
				pBar.Value = 1;
				pBar.Step = 100/((count_to - count_from)+1);

				//get the files till we say stop
				while (keepLooping)
				{
					for (int i=count_from; i<=count_to; i++)
					{
						GC.Collect();
						temp = filename + i + ext;
						lprogress.Text = "Getting "+temp;
						wc.DownloadFile(root_url + temp, put_here + temp);
						pBar.PerformStep();
						wc.Dispose();
						//wc = new WebClient();
					}
					lprogress.Text = "Done!";
					keepLooping = false;
				}
			}
			catch (Exception e)
			{
				Console.WriteLine("Caught this:"+e.ToString());
			}
		}
		

		private bool keepLooping = false;
		private System.Threading.Thread loopThread = null;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Button bGo;
		private System.Windows.Forms.TextBox tbroot_url;
		private System.Windows.Forms.TextBox tbfilename;
		private System.Windows.Forms.TextBox tbcount_from;
		private System.Windows.Forms.TextBox tbcount_to;
		private System.Windows.Forms.Label lprogress;
		private System.Windows.Forms.ProgressBar pBar;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.TextBox tbput_here;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.TextBox tbext;
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
			this.tbroot_url = new System.Windows.Forms.TextBox();
			this.tbfilename = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.tbcount_from = new System.Windows.Forms.TextBox();
			this.label4 = new System.Windows.Forms.Label();
			this.tbcount_to = new System.Windows.Forms.TextBox();
			this.bGo = new System.Windows.Forms.Button();
			this.lprogress = new System.Windows.Forms.Label();
			this.pBar = new System.Windows.Forms.ProgressBar();
			this.label5 = new System.Windows.Forms.Label();
			this.tbput_here = new System.Windows.Forms.TextBox();
			this.label6 = new System.Windows.Forms.Label();
			this.tbext = new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			// 
			// tbroot_url
			// 
			this.tbroot_url.Location = new System.Drawing.Point(8, 24);
			this.tbroot_url.Name = "tbroot_url";
			this.tbroot_url.Size = new System.Drawing.Size(248, 20);
			this.tbroot_url.TabIndex = 0;
			this.tbroot_url.Text = "";
			// 
			// tbfilename
			// 
			this.tbfilename.Location = new System.Drawing.Point(8, 144);
			this.tbfilename.Name = "tbfilename";
			this.tbfilename.Size = new System.Drawing.Size(136, 20);
			this.tbfilename.TabIndex = 1;
			this.tbfilename.Text = "";
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(8, 0);
			this.label1.Name = "label1";
			this.label1.TabIndex = 3;
			this.label1.Text = "root url";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 112);
			this.label2.Name = "label2";
			this.label2.TabIndex = 4;
			this.label2.Text = "filename prefix";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(8, 176);
			this.label3.Name = "label3";
			this.label3.TabIndex = 5;
			this.label3.Text = "count from";
			// 
			// tbcount_from
			// 
			this.tbcount_from.Location = new System.Drawing.Point(8, 216);
			this.tbcount_from.Name = "tbcount_from";
			this.tbcount_from.TabIndex = 6;
			this.tbcount_from.Text = "";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(168, 176);
			this.label4.Name = "label4";
			this.label4.TabIndex = 7;
			this.label4.Text = "count to";
			// 
			// tbcount_to
			// 
			this.tbcount_to.Location = new System.Drawing.Point(168, 216);
			this.tbcount_to.Name = "tbcount_to";
			this.tbcount_to.TabIndex = 8;
			this.tbcount_to.Text = "";
			// 
			// bGo
			// 
			this.bGo.Location = new System.Drawing.Point(16, 248);
			this.bGo.Name = "bGo";
			this.bGo.TabIndex = 9;
			this.bGo.Text = "Go";
			this.bGo.Click += new System.EventHandler(this.bGo_Click);
			// 
			// lprogress
			// 
			this.lprogress.Location = new System.Drawing.Point(8, 288);
			this.lprogress.Name = "lprogress";
			this.lprogress.Size = new System.Drawing.Size(248, 23);
			this.lprogress.TabIndex = 11;
			// 
			// pBar
			// 
			this.pBar.Location = new System.Drawing.Point(8, 328);
			this.pBar.Name = "pBar";
			this.pBar.Size = new System.Drawing.Size(256, 23);
			this.pBar.TabIndex = 12;
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(8, 56);
			this.label5.Name = "label5";
			this.label5.TabIndex = 13;
			this.label5.Text = "put here";
			// 
			// tbput_here
			// 
			this.tbput_here.Location = new System.Drawing.Point(8, 80);
			this.tbput_here.Name = "tbput_here";
			this.tbput_here.Size = new System.Drawing.Size(256, 20);
			this.tbput_here.TabIndex = 14;
			this.tbput_here.Text = "";
			// 
			// label6
			// 
			this.label6.Location = new System.Drawing.Point(168, 112);
			this.label6.Name = "label6";
			this.label6.TabIndex = 15;
			this.label6.Text = "extension";
			// 
			// tbext
			// 
			this.tbext.Location = new System.Drawing.Point(168, 144);
			this.tbext.Name = "tbext";
			this.tbext.TabIndex = 16;
			this.tbext.Text = "";
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(280, 357);
			this.Controls.Add(this.tbext);
			this.Controls.Add(this.label6);
			this.Controls.Add(this.tbput_here);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.pBar);
			this.Controls.Add(this.lprogress);
			this.Controls.Add(this.bGo);
			this.Controls.Add(this.tbcount_to);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.tbcount_from);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.tbfilename);
			this.Controls.Add(this.tbroot_url);
			this.Name = "Form1";
			this.Text = "WebFileGetter";
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
		}
	}
}
