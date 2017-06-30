using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Threading;
using System.Diagnostics;
using Microsoft.Win32;

namespace ProgressBars
{
	/// <summary>
	/// Summary description for fStepsProgressBar.
	/// </summary>
	public class fStepsProgressBar : System.Windows.Forms.Form
	{
		// Threading
		static fStepsProgressBar ms_frmProgress = null;
		static Thread ms_oThread = null;

		// Fade in and out.
		private const int TIMER_INTERVAL = 100;

		// Status and progress bar
		static string ms_sDescription;
		static string[] ms_saSteps;
		static int currentStep=0;
		static string ms_sStatus;
//		private double m_dblCompletionFraction = 0;
		private int progress=0;

		// Progress smoothing
//		private double m_dblLastCompletionFraction = 0.0;
//		private double m_dblPBIncrementPerTimerInterval = .015;

		// Self-calibration support
		private DateTime m_dtStart;
//		private bool m_bFirstLaunch = false;
//		private bool m_bDTSet = false;
//		private int m_iIndex = 1;
//		private int m_iActualTicks = 0;
//		private ArrayList m_alPreviousCompletionFraction;
		private ArrayList m_alActualTimes = new ArrayList();
		private const string REG_KEY_INITIALIZATION = "Initialization";
		private const string REGVALUE_PB_MILISECOND_INCREMENT = "Increment";
		private const string REGVALUE_PB_PERCENTS = "Percents";

		private System.Windows.Forms.Label lblStatus;
		private System.Windows.Forms.ProgressBar progressBar1;
		private System.Windows.Forms.ListView lvSteps;
		private System.Windows.Forms.ImageList imageList1;
		private System.Windows.Forms.ProgressBar progressBar2;
		private System.Timers.Timer timer1;
		private System.ComponentModel.IContainer components;

		/// <summary>
		/// Constructor
		/// </summary>
		public fStepsProgressBar(string[] Steps)
		{
			InitializeComponent();
			if(Steps!=null && Steps.Length>0)
			{
				ms_saSteps=Steps;
				currentStep=-1;
				lvSteps.Clear();
				this.Height+=ms_saSteps.Length*24;
				lvSteps.Height+=ms_saSteps.Length*24;
				progressBar1.Top+=ms_saSteps.Length*24;
				lblStatus.Top+=ms_saSteps.Length*24;
				progressBar2.Top+=ms_saSteps.Length*24;
				foreach(string step in ms_saSteps)
				{
					lvSteps.Items.Add(new ListViewItem("   "+step,0));
				}
			}
			timer1.Interval = TIMER_INTERVAL;
			timer1.Start();
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
			this.components = new System.ComponentModel.Container();
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(fStepsProgressBar));
			this.lblStatus = new System.Windows.Forms.Label();
			this.progressBar1 = new System.Windows.Forms.ProgressBar();
			this.lvSteps = new System.Windows.Forms.ListView();
			this.imageList1 = new System.Windows.Forms.ImageList(this.components);
			this.progressBar2 = new System.Windows.Forms.ProgressBar();
			this.timer1 = new System.Timers.Timer();
			((System.ComponentModel.ISupportInitialize)(this.timer1)).BeginInit();
			this.SuspendLayout();
			// 
			// lblStatus
			// 
			this.lblStatus.BackColor = System.Drawing.Color.Transparent;
			this.lblStatus.Location = new System.Drawing.Point(16, 70);
			this.lblStatus.Name = "lblStatus";
			this.lblStatus.Size = new System.Drawing.Size(568, 36);
			this.lblStatus.TabIndex = 0;
			// 
			// progressBar1
			// 
			this.progressBar1.Location = new System.Drawing.Point(16, 38);
			this.progressBar1.Name = "progressBar1";
			this.progressBar1.Size = new System.Drawing.Size(568, 23);
			this.progressBar1.TabIndex = 3;
			// 
			// lvSteps
			// 
			this.lvSteps.BackColor = System.Drawing.SystemColors.Control;
			this.lvSteps.BorderStyle = System.Windows.Forms.BorderStyle.None;
			this.lvSteps.Enabled = false;
			this.lvSteps.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.lvSteps.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.None;
			this.lvSteps.LabelWrap = false;
			this.lvSteps.Location = new System.Drawing.Point(16, 8);
			this.lvSteps.Name = "lvSteps";
			this.lvSteps.Size = new System.Drawing.Size(568, 24);
			this.lvSteps.SmallImageList = this.imageList1;
			this.lvSteps.TabIndex = 4;
			this.lvSteps.View = System.Windows.Forms.View.List;
			// 
			// imageList1
			// 
			this.imageList1.ImageSize = new System.Drawing.Size(16, 16);
			this.imageList1.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList1.ImageStream")));
			this.imageList1.TransparentColor = System.Drawing.Color.Transparent;
			// 
			// progressBar2
			// 
			this.progressBar2.Location = new System.Drawing.Point(16, 114);
			this.progressBar2.Name = "progressBar2";
			this.progressBar2.Size = new System.Drawing.Size(568, 23);
			this.progressBar2.TabIndex = 6;
			// 
			// timer1
			// 
			this.timer1.Enabled = true;
			this.timer1.SynchronizingObject = this;
			this.timer1.Elapsed += new System.Timers.ElapsedEventHandler(this.timer1_Elapsed);
			// 
			// fStepsProgressBar
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.BackColor = System.Drawing.SystemColors.Control;
			this.ClientSize = new System.Drawing.Size(598, 150);
			this.ControlBox = false;
			this.Controls.Add(this.progressBar2);
			this.Controls.Add(this.lvSteps);
			this.Controls.Add(this.progressBar1);
			this.Controls.Add(this.lblStatus);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.Name = "fStepsProgressBar";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			((System.ComponentModel.ISupportInitialize)(this.timer1)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion

		// ************* Static Methods *************** //

		// A static method to create the thread and 
		// launch the fStepsProgressBar.
		static public void ShowProgressScreen(string[] Steps)
		{
			// There must be at least one step to use the StepsProgressBar
			if(Steps.Length==0)
				return;
			// Make sure it's only launched once.
			if( ms_frmProgress != null )
				return;
			ms_saSteps = Steps;
			ms_oThread = new Thread( new ThreadStart(fStepsProgressBar.ShowForm));
			ms_oThread.IsBackground = true;
			ms_oThread.ApartmentState = ApartmentState.STA;
			ms_oThread.Start();
			while( ms_frmProgress == null )
			{
				Thread.Sleep(50);
			}
		}

		// A property returning the progress screen instance
		static public fStepsProgressBar ProgressForm 
		{
			get
			{
				return ms_frmProgress;
			} 
		}

		static public string Description
		{
			get
			{
				return ms_sDescription;
			}
			set
			{
				ms_sDescription=value;
			}
		}

		private int CurrentStep
		{
			get
			{
				return currentStep;
			}
			set
			{
				if(value>ms_saSteps.Length)
					return;
				currentStep=value;
				Font font;

				if (value>0)
				{
					this.lvSteps.Items[value-1].ImageIndex=2;
					font = this.lvSteps.Items[value-1].Font;
					this.lvSteps.Items[value-1].Font=new Font(font.FontFamily.Name,font.SizeInPoints,FontStyle.Regular);
					this.lvSteps.Items[value-1].ForeColor=Color.DarkGreen;
				}
						
				if (value<ms_saSteps.Length)
				{
					this.lvSteps.Items[value].ImageIndex=1;
					font = this.lvSteps.Items[value].Font;
					this.lvSteps.Items[value].Font=new Font(font.FontFamily.Name,font.SizeInPoints,FontStyle.Regular);
					this.lvSteps.Items[value].ForeColor=Color.Navy;
				}
				
				progress=0;
				ms_sStatus="please wait...";
			}
		}

		// A private entry point for the thread.
		static private void ShowForm()
		{
			ms_frmProgress = new fStepsProgressBar(ms_saSteps);
			Application.Run(ms_frmProgress);
		}

		// A static method to close the fStepsProgressBar
		static public void CloseForm()
		{
			if( ms_frmProgress != null && ms_frmProgress.IsDisposed == false )
			{
				try
				{
					ms_frmProgress.Close();
				}
				catch{}
			}
			ms_oThread = null;	// we don't need these any more.
			ms_frmProgress = null;
		}

		// A static method to set the status and optionally update the reference.
		// This is useful if you are in a section of code that has a variable
		// set of status string updates.  In that case, don't set the reference.
		static public void SetStatus(string newStatus)
		{
			ms_sStatus = newStatus;
			if( ms_frmProgress == null )
				return;
		}

		static public void SetProgress(int Progress)
		{
			if(ms_frmProgress==null)
				return;
			if(Progress>=0 && Progress<=100)
				ms_frmProgress.progress=Progress;
		}

		static public void NextStep()
		{
			if(ms_frmProgress==null)
				return;
			ms_frmProgress.CurrentStep++;
		}

		// ************ Private methods ************

		// Utility function to return elapsed Milliseconds since the 
		// fStepsProgressBar was launched.
		private double ElapsedMilliSeconds()
		{
			TimeSpan ts = DateTime.Now - m_dtStart;
			return ts.TotalMilliseconds;
		}


		//********* Event Handlers ************

		private void timer1_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
		{
			lblStatus.Text = ms_sStatus;
			if(ms_saSteps.Length==0)
				return;
			if(progress>=0 && progress<=100)
				progressBar1.Value=progress;
			int stepCompletePct = 100/ms_saSteps.Length;
			int totalProgress = stepCompletePct*(currentStep) + (int)(((float)progress)/100f*stepCompletePct);
			if(totalProgress>=0 && totalProgress<=100)
				progressBar2.Value=totalProgress;
			Text=totalProgress.ToString()+"% "+Description;
		}

	}
}
