using System;

namespace EproLibNET
{
	public enum Status
	{
		Pass = 1,
		Fail = 2,
		Warn = 4,
		Unkn = 8
	}

	public struct StatusInfo
	{
		private string statusText;
		private Status status;

		public string StatusText
		{
			get
			{
				return statusText;
			}
			set
			{
				statusText = value;
			}
		}
		public Status Status
		{
			get
			{
				return status;
			}
			set
			{
				status = value;
			}
		}
		public int Severity
		{
			get
			{
				switch(status)
				{
					default:
					case Status.Unkn:
						return 0;
					case Status.Pass:
						return 1;
					case Status.Warn:
						return 2;
					case Status.Fail:
						return 3;
				}
			}
		}
		public StatusInfo(string StatusText, Status Status)
		{
			statusText=StatusText;
			status=Status;
		}
	}

	/// <summary>
	/// Summary description for ccStatus.
	/// </summary>
	public class ccStatus
	{
		private static string xml=null;
		private static System.Xml.XmlDocument xmlDoc=null;
		public ccStatus()
		{
		}
		private static void init()
		{
			if(null==xml)
			{
				xml = Utilities.GetFromResources("EproLibNET.ccStatus.xml");
				xmlDoc = new System.Xml.XmlDocument();
				xmlDoc.LoadXml(xml);
			}
		}

		public static System.Collections.Specialized.HybridDictionary GetResultDictionary(string Name)
		{
			init();
			foreach(System.Xml.XmlNode node in xmlDoc.GetElementsByTagName("statuscode"))
			{
				if(node.Attributes["name"].Value.ToLower()!=Name.ToLower())
					continue;
				System.Collections.Specialized.HybridDictionary resultDictionary = new System.Collections.Specialized.HybridDictionary();
				foreach(System.Xml.XmlNode childNode in node.ChildNodes)
				{
					Status status;
					switch(Int32.Parse(childNode["severity"].InnerText))
					{
						default:
						case 0:
							status=Status.Unkn;
							break;
						case 1:
							status=Status.Pass;
							break;
						case 2:
                            status=Status.Warn;
							break;
						case 3:
							status=Status.Fail;
							break;
					}
					resultDictionary.Add(childNode.Attributes["value"].Value,new StatusInfo(childNode["statustext"].InnerText,status));
				}
				return resultDictionary;
			}
			return null;
		}
		public static string GetResultDescription(string Name)
		{
			init();
			foreach(System.Xml.XmlNode node in xmlDoc.GetElementsByTagName("statuscode"))
			{
				if(node.Attributes["name"].Value.ToLower()!=Name.ToLower())
					continue;
				return node.Attributes["desc"].Value;
			}
			return null;
		}
	}
}
