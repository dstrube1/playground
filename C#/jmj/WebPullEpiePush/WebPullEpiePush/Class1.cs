using System;
using System.Net;
using System.Text;
using System.IO;
using System.Xml;

namespace WebPullEpiePush
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class Class1
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			
			//string remoteUri = "http://asp.cybermedx.com/cgi/po_xml.plx?Location=1";
			string remoteUri = "http://status.mitsi.com/cgi/level_xml.plx?Location=35";
			//string remoteUri = "http://status.mitsi.com/cgi/level_xml.plx";
			WebClient wc = new WebClient();
			//fix from here: http://www.robert.to/csharp/csharp10.html
			StreamReader xr = new StreamReader(wc.OpenRead(remoteUri));
			try
			{
				string download;
				download = xr.ReadToEnd();//xr.ReadString();
				if (download != "" && download !=null)
				{
					Console.WriteLine(download);
				}
					
				Console.ReadLine();
				
			}
			catch (Exception e)
			{
				Console.WriteLine("Download not successful.");
				Console.WriteLine("Caught this:"+e.ToString());
				Console.ReadLine();
			}
			xr.Close();


		}
		 
	}
}
