using System;
using System.Xml;
using System.IO;

namespace EproLibNET
{
	/// <summary>
	/// Summary description for IntegrationEpIE.
	/// </summary>
	public class IntegrationEpIE:Base.Integration
	{
		string customerID=null, addresseeID=null, password="$!Epro&&*";

		public IntegrationEpIE():base()
		{
			//
			// TODO: Add constructor logic here
			//
		}

		public override int Initialize(string xml)
		{
			XmlDocument doc = new XmlDocument();
			doc.LoadXml(xml);
			
			foreach(XmlNode ContextPropertyNode in doc.GetElementsByTagName("ContextProperty"))
			{
				switch (ContextPropertyNode.Attributes.GetNamedItem("name").Value.ToLower())
				{
					case "customer_id":
						customerID = ContextPropertyNode.InnerText;
						break;
					case "addressee_id":
						addresseeID = ContextPropertyNode.InnerText;
						break;
					case "password":
						password= ContextPropertyNode.InnerText;
						break;
				}
			}

			return 1;
		}


		public override bool Is_Connected()
		{
			try
			{
				JMJIntegrationService.IntegrationService testService = new EproLibNET.JMJIntegrationService.IntegrationService();
				testService.Dispose();
				return true;
			}
			catch
			{
				return false;
			}
		}

		public override string Do_Source()
		{
			try
			{
				com.jmjtech.www.IntegrationService IS = new EproLibNET.com.jmjtech.www.IntegrationService();
				IS.Timeout=900000;
				
				System.Net.NetworkCredential cred = new System.Net.NetworkCredential();
				cred.Domain="WWWSERVER";
				cred.Password=password;
				if(null!=addresseeID)
					cred.UserName=addresseeID;
				else if(null!=customerID)
				{
					cred.UserName=customerID;
					addresseeID=customerID;
				}
				else
					return "";

				IS.PreAuthenticate=true;
				IS.Credentials=cred;
				string retString = IS.GetMessageBag(addresseeID);
				IS.Dispose();
				return retString;
			}
			catch(Exception exc)
			{
				Exception newExc = new Exception("Error calling IntegrationService.GetData with input = "+input+"\r\n\r\n\r\n"+exc.ToString());
				util.LogInternalEvent(newExc,4);
				throw newExc;
			}
		}

		public override int Set_Processed(string id, int status)
		{
			try
			{
				System.Net.NetworkCredential cred = new System.Net.NetworkCredential();
				cred.Domain="WWWSERVER";
				cred.Password=password;
				if(null!=addresseeID)
					cred.UserName=addresseeID;
				else if(null!=customerID)
				{
					cred.UserName=customerID;
					addresseeID=customerID;
				}
				else
					return -1;

				com.jmjtech.www.IntegrationService IS = new EproLibNET.com.jmjtech.www.IntegrationService();
				IS.PreAuthenticate=true;
				IS.Credentials=cred;
				IS.Complete(id,status);
				IS.Dispose();
				return 1;				
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(new Exception("Error calling IntegrationService.Complete with id = "+id+" and status = "+status.ToString(), exc),4);
				return -1;
			}
		}
	}
}
