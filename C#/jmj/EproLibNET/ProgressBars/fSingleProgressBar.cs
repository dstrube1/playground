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
	/// Summary description for fSingleProgressBar.
	/// </summary>
	public class fSingleProgressBar : System.Windows.Forms.Form
	{
		// Threading
		static fSingleProgressBar ms_frmProgress = null;
		static Thread ms_oThread = null;

		// Fade in and out.
		private const int TIMER_INTERVAL = 100;

		// Status and progress bar
		static string ms_sStatus;
		private double m_dblCompletionFraction = 0;
		private Rectangle m_rProgress;
		private int progress=0;
		private string description;

		// Progress smoothing
		private double m_dblLastCompletionFraction = 0.0;
		private double m_dblPBIncrementPerTimerInterval = .015;

		// Self-calibration support
		private DateTime m_dtStart;
		private bool m_bFirstLaunch = false;
		private bool m_bDTSet = false;
		private int m_iIndex = 1;
		private int m_iActualTicks = 0;
		private ArrayList m_alPreviousCompletionFraction;
		private ArrayList m_alActualTimes = new ArrayList();
		private const string REG_KEY_INITIALIZATION = "Initialization";
		private const string REGVALUE_PB_MILISECOND_INCREMENT = "Increment";
		private const string REGVALUE_PB_PERCENTS = "Percents";

		private System.Windows.Forms.Label lblStatus;
		private System.Windows.Forms.Panel pnlStatus;
		private System.Windows.Forms.ProgressBar progressBar1;
		private System.Timers.Timer timer1;
		private System.ComponentModel.IContainer components;

		/// <summary>
		/// Constructor
		/// </summary>
		public fSingleProgressBar()
		{
			InitializeComponent();
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
			this.lblStatus = new System.Windows.Forms.Label();
			this.pnlStatus = new System.Windows.Forms.Panel();
			this.progressBar1 = new System.Windows.Forms.ProgressBar();
			this.timer1 = new System.Timers.Timer();
			((System.ComponentModel.ISupportInitialize)(this.timer1)).BeginInit();
			this.SuspendLayout();
			// 
			// lblStatus
			// 
			this.lblStatus.BackColor = System.Drawing.Color.Transparent;
			this.lblStatus.Location = new System.Drawing.Point(16, 40);
			this.lblStatus.Name = "lblStatus";
			this.lblStatus.Size = new System.Drawing.Size(384, 48);
			this.lblStatus.TabIndex = 0;
			// 
			// pnlStatus
			// 
			this.pnlStatus.BackColor = System.Drawing.Color.Transparent;
			this.pnlStatus.Location = new System.Drawing.Point(16, 8);
			this.pnlStatus.Name = "pnlStatus";
			this.pnlStatus.Size = new System.Drawing.Size(384, 24);
			this.pnlStatus.TabIndex = 1;
			this.pnlStatus.Visible = false;
			this.pnlStatus.Paint += new System.Windows.Forms.PaintEventHandler(this.pnlStatus_Paint);
			// 
			// progressBar1
			// 
			this.progressBar1.Location = new System.Drawing.Point(16, 8);
			this.progressBar1.Name = "progressBar1";
			this.progressBar1.Size = new System.Drawing.Size(384, 23);
			this.progressBar1.TabIndex = 3;
			// 
			// timer1
			// 
			this.timer1.Enabled = true;
			this.timer1.SynchronizingObject = this;
			this.timer1.Elapsed += new System.Timers.ElapsedEventHandler(this.timer1_Elapsed);
			// 
			// fSingleProgressBar
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.BackColor = System.Drawing.SystemColors.Control;
			this.ClientSize = new System.Drawing.Size(414, 88);
			this.ControlBox = false;
			this.Controls.Add(this.progressBar1);
			this.Controls.Add(this.pnlStatus);
			this.Controls.Add(this.lblStatus);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.Name = "fSingleProgressBar";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			((System.ComponentModel.ISupportInitialize)(this.timer1)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion

		// ************* Static Methods *************** //

		// A static method to create the thread and 
		// launch the fSingleProgressBar.
		static public void ShowProgressScreen()
		{
			// Make sure it's only launched once.
			if( ms_frmProgress != null )
				return;
			ms_oThread = new Thread( new ThreadStart(fSingleProgressBar.ShowForm));
			ms_oThread.IsBackground = true;
			ms_oThread.ApartmentState = ApartmentState.STA;
			ms_oThread.Start();
			while( ms_frmProgress == null )
			{
				Thread.Sleep(50);
			}
		}

		// A property returning the progress screen instance
		static public fSingleProgressBar ProgressForm 
		{
			get
			{
				return ms_frmProgress;
			} 
		}

		public string Description
		{
			get
			{
				return ms_frmProgress.description;
			}
			set
			{
				ms_frmProgress.description=value;
				ms_frmProgress.Text=value;
			}
		}

		// A private entry point for the thread.
		static private void ShowForm()
		{
			ms_frmProgress = new fSingleProgressBar();
			Application.Run(ms_frmProgress);
		}

		// A static method to close the fSingleProgressBar
		static public void CloseForm()
		{
			if( ms_frmProgress != null && ms_frmProgress.IsDisposed == false )
			{
				// Make it start going away.
				//ms_frmProgress.m_dblOpacityIncrement = - ms_frmProgress.m_dblOpacityDecrement;

				ms_frmProgress.Close();
			}
			ms_oThread = null;	// we don't need these any more.
			ms_frmProgress = null;
		}

		// A static method to set the status and optionally update the reference.
		// This is useful if you are in a section of code that has a variable
		// set of status string updates.  In that case, don't set the reference.
		static public void SetStatus(string newStatus)
		{
			if( ms_frmProgress == null )
				return;
			ms_sStatus = newStatus;
		}

		static public void SetProgress(int Progress)
		{
			if(ms_frmProgress==null)
				return;
			if(Progress>=0 && Progress<=100)
				ms_frmProgress.progress=Progress;
		}

		// ************ Private methods ************

		// Utility function to return elapsed Milliseconds since the 
		// fSingleProgressBar was launched.
		private double ElapsedMilliSeconds()
		{
			TimeSpan ts = DateTime.Now - m_dtStart;
			return ts.TotalMilliseconds;
		}

		//********* Event Handlers ************

		// Paint the portion of the panel invalidated during the tick event.
		private void pnlStatus_Paint(object sender, System.Windows.Forms.PaintEventArgs e)
		{
			//			if( m_bFirstLaunch == false && e.ClipRectangle.Width > 0 && m_iActualTicks > 1 )
			//			{
			//				LinearGradientBrush brBackground = new LinearGradientBrush(m_rProgress, Color.FromArgb(58, 96, 151), Color.FromArgb(181, 237, 254), LinearGradientMode.Horizontal);
			//				e.Graphics.FillRectangle(brBackground, m_rProgress);
			//			}
			if( m_rProgress.Width > 0 )
			{
				LinearGradientBrush brBackground = new LinearGradientBrush(m_rProgress, Color.FromArgb(58, 96, 151), Color.FromArgb(181, 237, 254), LinearGradientMode.Horizontal);
				e.Graphics.FillRectangle(brBackground, m_rProgress);
			}
		}

		private void timer1_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
		{
			lblStatus.Text = ms_sStatus;
			if(progress>=0 && progress <=100)
				progressBar1.Value=progress;
			Text=progress.ToString()+"% "+Description;
		}
	}
}
