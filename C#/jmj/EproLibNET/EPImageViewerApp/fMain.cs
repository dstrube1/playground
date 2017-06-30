using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace EPImageViewerApp
{
	/// <summary>
	/// Summary description for fMain.
	/// </summary>
	public class fMain : System.Windows.Forms.Form
	{
		private EPImageViewer.Image img = new EPImageViewer.Image();

		private System.Windows.Forms.MainMenu mainMenu1;
		private System.Windows.Forms.MenuItem miFile;
		private System.Windows.Forms.MenuItem miOpen;
		private System.Windows.Forms.MenuItem miSep1;
		private System.Windows.Forms.MenuItem miExit;
		private System.Windows.Forms.OpenFileDialog openFileDialog1;
		private System.Windows.Forms.MenuItem miWindow;
		private System.Windows.Forms.MenuItem miMinWindows;
		private System.Windows.Forms.MenuItem miCloseWindows;
		private System.Windows.Forms.MenuItem miSep2;
		private System.Windows.Forms.MenuItem miCascade;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		private string[] args;

		public fMain(string[] Args)
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();
			args=Args;
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
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(fMain));
			this.mainMenu1 = new System.Windows.Forms.MainMenu();
			this.miFile = new System.Windows.Forms.MenuItem();
			this.miOpen = new System.Windows.Forms.MenuItem();
			this.miSep1 = new System.Windows.Forms.MenuItem();
			this.miExit = new System.Windows.Forms.MenuItem();
			this.miWindow = new System.Windows.Forms.MenuItem();
			this.miCascade = new System.Windows.Forms.MenuItem();
			this.miSep2 = new System.Windows.Forms.MenuItem();
			this.miMinWindows = new System.Windows.Forms.MenuItem();
			this.miCloseWindows = new System.Windows.Forms.MenuItem();
			this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
			// 
			// mainMenu1
			// 
			this.mainMenu1.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																					  this.miFile,
																					  this.miWindow});
			// 
			// miFile
			// 
			this.miFile.Index = 0;
			this.miFile.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																				   this.miOpen,
																				   this.miSep1,
																				   this.miExit});
			this.miFile.Text = "&File";
			// 
			// miOpen
			// 
			this.miOpen.Index = 0;
			this.miOpen.Text = "&Open...";
			this.miOpen.Click += new System.EventHandler(this.miOpen_Click);
			// 
			// miSep1
			// 
			this.miSep1.Index = 1;
			this.miSep1.Text = "-";
			// 
			// miExit
			// 
			this.miExit.Index = 2;
			this.miExit.Text = "E&xit";
			this.miExit.Click += new System.EventHandler(this.miExit_Click);
			// 
			// miWindow
			// 
			this.miWindow.Index = 1;
			this.miWindow.MdiList = true;
			this.miWindow.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																					 this.miCascade,
																					 this.miSep2,
																					 this.miMinWindows,
																					 this.miCloseWindows});
			this.miWindow.Text = "&Window";
			// 
			// miCascade
			// 
			this.miCascade.Index = 0;
			this.miCascade.Text = "Cascade Windows";
			this.miCascade.Click += new System.EventHandler(this.miCascade_Click);
			// 
			// miSep2
			// 
			this.miSep2.Index = 1;
			this.miSep2.Text = "-";
			// 
			// miMinWindows
			// 
			this.miMinWindows.Index = 2;
			this.miMinWindows.Text = "Minimize All Windows";
			this.miMinWindows.Click += new System.EventHandler(this.miMinWindows_Click);
			// 
			// miCloseWindows
			// 
			this.miCloseWindows.Index = 3;
			this.miCloseWindows.Text = "Close All Windows";
			this.miCloseWindows.Click += new System.EventHandler(this.miCloseWindows_Click);
			// 
			// openFileDialog1
			// 
			this.openFileDialog1.Filter = @"All Supported Images|*.jpg;*.png;*.tif;*.pcx;*.tga;*.bmp;*.psd;*.pcd;*.gif;*.wmf;*emf|All Files (*.*)|*.*|JPEG (*.jpg)|*.jpg|Portable Network Graphics (*.png)|*.png|TIFF (*.tif)|*.tif;*.tiff|Paintbrush PCX (*.pcx)|*.pcx|TARGA (*.tga)|*.tga|Windows Bitmap (*.bmp)|*.bmp|Adobe Photoshop Image (*.psd)|*.psd|Kodak PCD (*.pcd)|*.pcd|GIF (*.gif)|*.gif|Windows Metafile (*.wmf)|*.wmf|Enhanced Metafile (*.emf)|*.emf";
			this.openFileDialog1.Multiselect = true;
			// 
			// fMain
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(632, 345);
			this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
			this.IsMdiContainer = true;
			this.Menu = this.mainMenu1;
			this.Name = "fMain";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "EPImageViewer";
			this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
			this.Load += new System.EventHandler(this.fMain_Load);

		}
		#endregion

		private void miExit_Click(object sender, System.EventArgs e)
		{
			Close();
		}

		private void miOpen_Click(object sender, System.EventArgs e)
		{
			if(openFileDialog1.ShowDialog(this)==DialogResult.OK)
			{
				try
				{
					foreach(string filename in openFileDialog1.FileNames)
					{
						int ret = img.LoadImageFromFileInMDI(filename,false,this);
						if(ret<1)
							MessageBox.Show(this, "Error opening "+filename+".","Error Opening File",MessageBoxButtons.OK,MessageBoxIcon.Error);
					}
				}
				catch(Exception exc)
				{
					MessageBox.Show(this,exc.Message,"Error opening image file");
				}
			}
		}

		private void miMinWindows_Click(object sender, System.EventArgs e)
		{
			foreach(Form mdiChild in MdiChildren)
			{
				mdiChild.WindowState=FormWindowState.Minimized;
			}
		}

		private void miCloseWindows_Click(object sender, System.EventArgs e)
		{
			foreach(Form mdiChild in MdiChildren)
			{
				mdiChild.Close();
			}
		}

		private void miCascade_Click(object sender, System.EventArgs e)
		{
			foreach(Form mdiChild in MdiChildren)
			{
				if (mdiChild.WindowState==FormWindowState.Minimized)
					mdiChild.WindowState=FormWindowState.Normal;
			}
			LayoutMdi(MdiLayout.Cascade);
		}

		private void fMain_Load(object sender, System.EventArgs e)
		{
			foreach(string arg in args)
			{
				try
				{
					img.LoadImageFromFileInMDI(arg,false,this);
				}
				catch(Exception exc)
				{
					MessageBox.Show(this,exc.Message,"Error opening image file");
				}
			}
		}
	}
}
