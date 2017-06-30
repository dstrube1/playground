using System;
using System.Windows.Forms;

namespace EPImageViewerApp
{
	/// <summary>
	/// Summary description for Program.
	/// </summary>
	public class Program
	{
		public Program()
		{
			//
			// TODO: Add constructor logic here
			//
		}
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] Args) 
		{
			try
			{
				if(Args.Length==1)
				{
					EPImageViewer.Image img = new EPImageViewer.Image();
					img.LoadImageFromFileModal(Args[0],false,null);
				}
				else
				{ Application.Run(new fMain(Args)); }
			}
			catch(Exception exc)
			{
				try
				{
					System.Diagnostics.EventLog.WriteEntry("EPImageViewerApp",exc.ToString(), System.Diagnostics.EventLogEntryType.Error);
				}
				catch{}
			}
		}
	}
}
