using System;
using System.Net;
using System.IO;

namespace EPIntSenderLib
{
	/// <summary>
	/// Summary description for CommCyberMedx.
	/// </summary>
	public class CommCyberMedx : BaseComm
	{
		public CommCyberMedx() : base ()
		{
			//
			// TODO: Add constructor logic here
			//
		}
		protected override void recv()
		{
			string remoteUri = info["address"].ToString();

			WebClient wc = new WebClient();
			StreamReader xr = new StreamReader(wc.OpenRead(remoteUri));
			string msg = null;
			string jmjMessage = null;
			string retStatus = null;
			try
			{
				msg=xr.ReadToEnd();
				xr.Close();
				
				if (msg == "" || msg ==null)
				{
					return;
				}
				jmjMessage = this.WrapInJMJMessage(msg,info["addressee_id"].ToString(),"998",null,null,info["addressee_id"].ToString(),info["doctype"].ToString(),null);
				retStatus = this.PutJMJMessage(jmjMessage);
				if(debug)
					Event.LogInformation("PutMessage return status:"+Environment.NewLine+retStatus);

				System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
				doc.LoadXml(retStatus);

				System.Xml.XmlNodeList statusElements = doc.GetElementsByTagName("Status");
				if(statusElements.Count>0 && statusElements[0].InnerText.ToLower()!="success")
				{
					Event.LogError("PutMessage did not return success."+Environment.NewLine+retStatus);
				}
				GC.Collect();
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
