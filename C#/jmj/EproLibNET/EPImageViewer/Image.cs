using System;
using System.Runtime.InteropServices;

namespace EPImageViewer
{

	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDual)]
	public class Image
	{
		private string EproLibNETFolder = null;

		private Utilities util=null;
		public Image()
		{
			util=new Utilities();
			util.InitializeEventLog("EPImageViewer");

			EproLibNETFolder = Environment.GetFolderPath(System.Environment.SpecialFolder.CommonProgramFiles);
			EproLibNETFolder = System.IO.Path.Combine(EproLibNETFolder, "JMJTech Common");
			EproLibNETFolder = System.IO.Path.Combine(EproLibNETFolder, "EproLibNET");
		}

		public int LoadImageFromFileInMDI(string fileName, bool readOnly, System.Windows.Forms.Form mdiParent)
		{
			try
			{
				ImageViewer viewer = new ImageViewer();
				viewer.MdiParent=mdiParent;
				if(viewer.LoadImageFromFile(fileName,readOnly)==1)
				{
					viewer.Show();
					viewer.Activate();
					return 1;
				}
				return 0;
			}
			catch(Exception exc)
			{
				util.LogEvent(exc.Source,exc.TargetSite.Name,"Error Loading Image in file "+fileName+"\r\n\r\n"+exc.ToString(),4);
				return 0;
			}
		}

		public int LoadImageFromFile(string fileName, bool readOnly)
		{
			string viewerApp = System.IO.Path.Combine(EproLibNETFolder,"EPImageViewerApp.exe");
			try
			{
				System.Diagnostics.Process p = new System.Diagnostics.Process();
				p.StartInfo = new System.Diagnostics.ProcessStartInfo(viewerApp,"\""+fileName+"\"");
				p.Start();
				p.WaitForExit();

				return 1;
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,4);
				return -1;
			}
		}
		
//		public int LoadImageFromFile(string fileName, bool readOnly)
//		{
//			try
//			{
//				ImageViewer viewer = new ImageViewer();
//				if(viewer.LoadImageFromFile(fileName,readOnly)==1)
//				{
//					viewer.Show();
//					return 1;
//				}
//				return -1;
//			}
//			catch(Exception exc)
//			{
//				util.LogEvent(exc.Source,exc.TargetSite.Name,"Error Loading Image in file "+fileName+"\r\n\r\n"+exc.ToString(),4);
//				return -1;
//			}
//		}

		public int LoadImageFromFileModal(string fileName, bool readOnly, System.Windows.Forms.IWin32Window owner)
		{
			try
			{
				ImageViewer viewer = new ImageViewer();
				if(viewer.LoadImageFromFile(fileName,readOnly)==1)
				{
					viewer.ShowDialog(owner);
					return 1;
				}
				return -1;
			}
			catch(Exception exc)
			{
				util.LogEvent(exc.Source,exc.TargetSite.Name,"Error Loading Image in file "+fileName+"\r\n\r\n"+exc.ToString(),4);
				return -1;
			}
		}
	}
}
