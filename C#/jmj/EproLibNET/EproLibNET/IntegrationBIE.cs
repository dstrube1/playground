using System;
using System.Xml;
using System.Runtime.InteropServices;
using System.IO;

namespace EproLibNET
{
	/// <summary>
	/// Summary description for IntegrationBIE.
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class IntegrationBIE:Base.Integration
	{
		public IntegrationBIE():base()
		{
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
				JMJIntegrationService.IntegrationService iService = new EproLibNET.JMJIntegrationService.IntegrationService();
				iService.Timeout=900000;
				XmlDocument doc = new XmlDocument();
				doc.LoadXml(input);
				string customerID=null, password="password";
				foreach(XmlNode ContextPropertyNode in doc.GetElementsByTagName("ContextProperty"))
				{
					if(ContextPropertyNode.Attributes.GetNamedItem("name").Value.ToLower()=="customer_id")
					{
						customerID = ContextPropertyNode.InnerText;
					}
					if(ContextPropertyNode.Attributes.GetNamedItem("name").Value.ToLower()=="password")
					{
						password = ContextPropertyNode.InnerText;
					}
				}
				if(customerID!=null)
					return DecryptString(iService.GetData(customerID,password));
				iService.Dispose();
				return "";
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(new Exception("Error calling IntegrationService.GetData with input = "+input+"\r\n\r\n\r\n"+exc.ToString()),4);
				throw new Exception("Error calling IntegrationService.GetData with input = "+input+"\r\n\r\n\r\n"+exc.ToString());
			}
		}

		public override int Set_Processed(string id, int status)
		{
			try
			{
				JMJIntegrationService.IntegrationService iService = new EproLibNET.JMJIntegrationService.IntegrationService();
				iService.Complete(id,status);
				iService.Dispose();
				return 1;				
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(new Exception("Error calling IntegrationService.Complete with id = "+id+" and status = "+status.ToString(), exc),4);
				return -1;
			}
		}
		public string DecryptString(string value)
		{
			try
			{

				byte[] resultBA=new byte[value.Length/2], valueBA=new byte[value.Length/2];
				byte[] iv = new byte[]{0x14, 0xD7, 0x5B, 0xA2, 0x47, 0x83, 0x0F, 0xC4};
				byte[] key = new byte[]{0x0E, 0x4B, 0xEB, 0xA6, 0xC9, 0x1F, 0x05, 0x5E, 
										   0x84, 0xE5, 0xD7, 0x7A, 0xF6, 0x60, 0xB4, 0x96, 
										   0xC6, 0xD9, 0xA5, 0x92, 0x25, 0x1F, 0xFD, 0xE3};
				System.Text.ASCIIEncoding ascEncoding = new System.Text.ASCIIEncoding();

				MemoryStream memStream = new MemoryStream();
				byte[] tempBA=InternalMethods.HexStringToBytes(value);
				memStream.Write(tempBA,0,tempBA.Length);
				memStream.Position=0;
				System.Security.Cryptography.CryptoStream cStream = new System.Security.Cryptography.CryptoStream(memStream,System.Security.Cryptography.TripleDESCryptoServiceProvider.Create().CreateDecryptor(key,iv),System.Security.Cryptography.CryptoStreamMode.Read);
				cStream.Read(resultBA,0,resultBA.Length);
				cStream.Close();

				return ascEncoding.GetString(resultBA);
			}
			catch(Exception exc)
			{
				util.LogEvent(exc.Source, "DecryptString()", exc.ToString(), 4);
				return "";
			}
		}

	}
}
