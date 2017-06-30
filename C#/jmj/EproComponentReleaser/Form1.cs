using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace EproComponentReleaser
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		#region Windows Form Designer generated code
		private System.Windows.Forms.ListBox lbFiles;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Button bAddFile;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Button bRelease;
		private System.Windows.Forms.TextBox tSystemID;
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

		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.lbFiles = new System.Windows.Forms.ListBox();
			this.label1 = new System.Windows.Forms.Label();
			this.bAddFile = new System.Windows.Forms.Button();
			this.bRelease = new System.Windows.Forms.Button();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.tSystemID = new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			// 
			// lbFiles
			// 
			this.lbFiles.Location = new System.Drawing.Point(8, 32);
			this.lbFiles.Name = "lbFiles";
			this.lbFiles.Size = new System.Drawing.Size(280, 56);
			this.lbFiles.TabIndex = 0;
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(8, 8);
			this.label1.Name = "label1";
			this.label1.TabIndex = 1;
			this.label1.Text = "Files";
			// 
			// bAddFile
			// 
			this.bAddFile.Location = new System.Drawing.Point(160, 0);
			this.bAddFile.Name = "bAddFile";
			this.bAddFile.TabIndex = 2;
			this.bAddFile.Text = "&Add a file";
			this.bAddFile.Click += new System.EventHandler(this.bAddFile_Click);
			// 
			// bRelease
			// 
			this.bRelease.Location = new System.Drawing.Point(216, 352);
			this.bRelease.Name = "bRelease";
			this.bRelease.TabIndex = 3;
			this.bRelease.Text = "&Release";
			this.bRelease.Click += new System.EventHandler(this.bRelease_Click);
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(0, 96);
			this.label2.Name = "label2";
			this.label2.TabIndex = 4;
			this.label2.Text = "Component_id";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(0, 288);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(112, 23);
			this.label3.TabIndex = 5;
			this.label3.Text = "r_compile System_id";
			// 
			// tSystemID
			// 
			this.tSystemID.Location = new System.Drawing.Point(112, 288);
			this.tSystemID.Name = "tSystemID";
			this.tSystemID.Size = new System.Drawing.Size(176, 20);
			this.tSystemID.TabIndex = 6;
			this.tSystemID.Text = "";
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(292, 381);
			this.Controls.Add(this.tSystemID);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.bRelease);
			this.Controls.Add(this.bAddFile);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.lbFiles);
			this.Name = "Form1";
			this.Text = "EncounterPRO Component Releaser";
			this.ResumeLayout(false);

		}
		

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
		}
		#endregion //Windows Form Designer generated code

		private void bAddFile_Click(object sender, System.EventArgs e)
		{
			fFileAdder adder = new fFileAdder();
			if (adder.ShowDialog() == DialogResult.OK)
				MessageBox.Show("Sure did");
		}

		private void bRelease_Click(object sender, System.EventArgs e)
		{
			MessageBox.Show("Release time!");
			string filename = @"C:\david\JMJSecurityManager\bin\Debug\JMJSecurityManager.dll";
			string file2B = @"C:\WINDOWS\assembly\gac\JMJSecurityManager.dll";
			if (File.Exists(filename))
			{
				Console.WriteLine("file exists");
				File.Copy(filename,file2B);
				if (File.Exists(file2B))
					Console.WriteLine("file copied");
			}
			else Console.WriteLine("file don't exists");

		}
	}
}
