using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.Threading;
using System.IO;


namespace FileMover
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox tb_From;
		private System.Windows.Forms.TextBox tb_To;
		private System.Windows.Forms.Button bGo;
		private System.Windows.Forms.Button bStop;
		private bool keepLooping = false;
		private System.Threading.Thread loopThread = null;
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
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.tb_From = new System.Windows.Forms.TextBox();
			this.tb_To = new System.Windows.Forms.TextBox();
			this.bGo = new System.Windows.Forms.Button();
			this.bStop = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(16, 16);
			this.label1.Name = "label1";
			this.label1.TabIndex = 0;
			this.label1.Text = "From";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(16, 80);
			this.label2.Name = "label2";
			this.label2.TabIndex = 1;
			this.label2.Text = "To";
			// 
			// tb_From
			// 
			this.tb_From.Location = new System.Drawing.Point(16, 48);
			this.tb_From.Name = "tb_From";
			this.tb_From.Size = new System.Drawing.Size(200, 20);
			this.tb_From.TabIndex = 2;
			this.tb_From.Text = "";
			// 
			// tb_To
			// 
			this.tb_To.Location = new System.Drawing.Point(16, 104);
			this.tb_To.Name = "tb_To";
			this.tb_To.Size = new System.Drawing.Size(200, 20);
			this.tb_To.TabIndex = 3;
			this.tb_To.Text = "";
			// 
			// bGo
			// 
			this.bGo.Location = new System.Drawing.Point(32, 152);
			this.bGo.Name = "bGo";
			this.bGo.TabIndex = 4;
			this.bGo.Text = "Go";
			this.bGo.Click += new System.EventHandler(this.bGo_Click);
			// 
			// bStop
			// 
			this.bStop.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.bStop.Location = new System.Drawing.Point(152, 152);
			this.bStop.Name = "bStop";
			this.bStop.TabIndex = 5;
			this.bStop.Text = "Stop";
			this.bStop.Click += new System.EventHandler(this.bStop_Click);
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(292, 197);
			this.Controls.Add(this.bStop);
			this.Controls.Add(this.bGo);
			this.Controls.Add(this.tb_To);
			this.Controls.Add(this.tb_From);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Name = "Form1";
			this.Text = "Form1";
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

		private void bStop_Click(object sender, System.EventArgs e)
		{
			keepLooping = false;
			loopThread = null;
		}

		private void bGo_Click(object sender, System.EventArgs e)
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
			string from = tb_From.Text;
			string to = tb_To.Text;
			if (to.LastIndexOf(@"\") != (to.Length - 1))
			{
				to += @"\";
			}
			while (keepLooping)
			{
				Thread.Sleep(3000);
				ArrayList myList = new ArrayList(Directory.GetFiles(from));
				for (int i = 0; i<myList.Count; i++)
				{
					Console.WriteLine(myList[i]);
					File.Move(myList[i].ToString(), to+ Path.GetFileName(myList[i].ToString()));
				}
			}
		}
	
	}
}
