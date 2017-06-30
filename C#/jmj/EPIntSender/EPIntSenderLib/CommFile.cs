using System;
using System.IO;
using System.Collections;
using System.Collections.Specialized;

namespace EPIntSenderLib
{
	/// <summary>
	/// Receiving:
	/// This decendent of BaseComm expects the following parameters:
	/// <code>address, searchpattern, documenttype, recipients, recipientpaths</code>
	/// 
	/// recipients should be a comma-delimited list of recipient AddresseeID values.
	/// 
	/// recipientpaths should be a comma-delimited list of paths relative to 'address'
	/// where files intended for the matching recipient can be found.  recipientpaths
	/// should be a list equal in length to recipients, as the values for each list should 
	/// match up in order.
	/// 
	/// Each recipientpath folder may contain messages that will be read and then deleted 
	/// by this service.  Only files whose names match the searchpattern parameter will be 
	/// processed.
	/// 
	/// Sending:
	/// Not yet implemented in this class.
	/// </summary>
	public class CommFile:BaseComm
	{
		public CommFile():base()
		{
		}

		protected override void recv()
		{
			string  property=null, documentType=null;
			//string[] recipients=null, recipientpaths=null, searchpatterns=null;
			bool retStatus = true;
			
			System.Collections.Specialized.HybridDictionary alRecipients = null, alRecipientPaths=null, alSearchPatterns=null;
			//System.Collections.ArrayList alRecipients = null, alRecipientPaths=null, alSearchPatterns=null;
			alRecipients = new HybridDictionary();
			alRecipientPaths = new HybridDictionary();
			alSearchPatterns = new HybridDictionary();

			if(!info.Contains("documenttype"))
			{
				Event.LogError("Expected parameter \"documenttype\" not found.  Cannot continue.");
				return;
			}

			documentType = info["documenttype"].ToString();

			// get all the recipients (to addressee id's)
			foreach(DictionaryEntry de in info)
			{
				property = de.Key.ToString();
				if( property.StartsWith("recipient_"))
				{
					alRecipients.Add(property.Split('_')[1],de.Value.ToString());
				}				
			}
//			recipients = (string[])alRecipients.ToArray(Type.GetType("System.String"));

			// get all the recipient path
			foreach(DictionaryEntry de in info)
			{
				property = de.Key.ToString();
				if( property.StartsWith("recipientpath_"))
				{
					alRecipientPaths.Add(property.Split('_')[1],de.Value.ToString());
				}				
			}

			foreach(DictionaryEntry de in info)
			{
				property = de.Key.ToString();
				if( property.StartsWith("searchpattern_"))
				{
					alSearchPatterns.Add(property.Split('_')[1],de.Value.ToString());
				}				
			}

			if(alRecipients.Count==0)
			{
				Event.LogEvent("No recipients defined.  Cannot continue.",System.Diagnostics.EventLogEntryType.Warning);
				return;
			}

			if(alRecipientPaths.Count!=alRecipients.Count)
			{
				Event.LogEvent("Length of recipients array does not equal length of recipientpaths array.  Cannot continue.",System.Diagnostics.EventLogEntryType.Warning);
				return;
			}

			if(alRecipientPaths.Count!=alSearchPatterns.Count)
			{
				Event.LogEvent("Length of recipients array does not equal length of searchpatterns array.  Cannot continue.",System.Diagnostics.EventLogEntryType.Warning);
				return;
			}

			foreach(DictionaryEntry de in alRecipients)
			{
				string recipient = null;
				string recipientpath = null;
				string searchpattern = null;
				
				recipient = (string) de.Value;
				if (alRecipientPaths.Contains(de.Key))
					recipientpath = (string) alRecipientPaths[de.Key];

				if (alSearchPatterns.Contains(de.Key))
					searchpattern = (string) alSearchPatterns[de.Key];

				if(debug)
				{
					Event.LogInformation("recipient = "+recipient);
					Event.LogInformation("recipientpath = "+recipientpath);
					Event.LogInformation("searchpattern = "+searchpattern);
				}
				try
				{
					string[] files = Directory.GetFiles(recipientpath,searchpattern);

					foreach(string file in files)
					{
						if(debug)
							Event.LogInformation("Reading file:"+Environment.NewLine+file);

						string msgBag = null, msg=null;
						int iPos=0, iLength=0, iNext=0;
						
						StreamReader sr = new StreamReader(file,true);
						msgBag=sr.ReadToEnd();
						sr.Close();
	
						if(debug)
							Event.LogInformation("File contents:"+Environment.NewLine+msgBag);

						// Check whether it's a single message or batch
						iPos = msgBag.IndexOf("MSH|^~\\&|",0);
						if (iPos < 0) 
						{
							Event.LogInformation("CommFile: Not a valid HL7 file:"+Environment.NewLine+msgBag);
							continue;
						}
						iNext = msgBag.IndexOf("MSH|^~\\&|",iPos + 1);
						if (iNext < 0) // single message
						{
							msg = msgBag.Substring(iPos);
							if(sendMsg(msg,info["addressee_id"].ToString(),recipient,null,info["addressee_id"].ToString(),documentType))
							{
								File.Delete(file);

								if(debug)
									Event.LogInformation("Finished with file, deleting:"+Environment.NewLine+file);
									
							}
						}
						else // batches
						{
							retStatus = true;
							do
							{
								iLength = iNext - iPos;
								msg = msgBag.Substring(iPos,iLength);
								if (!sendMsg(msg,info["addressee_id"].ToString(),recipient,null,info["addressee_id"].ToString(),documentType))
								{
									retStatus = false;
									break;
								}
								iPos = iNext;
								iNext = msgBag.IndexOf("MSH|^~\\&|",iPos + 1);
					
							}
							while(iNext > 0);
							if (retStatus)
							{
								msg = msgBag.Substring(iPos);
								if(sendMsg(msg,info["addressee_id"].ToString(),recipient,null,info["addressee_id"].ToString(),documentType))
								{
									File.Delete(file);

									if(debug)
										Event.LogInformation("Finished with file, deleting:"+Environment.NewLine+file);
									
								}
							}
							
						}
					}
				}
				catch(Exception exc)
				{
					Event.LogError("Error:"+Environment.NewLine+exc.ToString());
				}
			}
		}

		protected override void send()
		{
			base.send ();
		}

		protected bool sendMsg(string msg,string fromAddressee,string toAddressee,string senderMsgId,string ownerId,string documentType)
		{
			string jmjMessage = null;
			string retStatus = null;
			try
			{

				jmjMessage = this.WrapInJMJMessage(msg,fromAddressee,toAddressee,null,senderMsgId,ownerId,documentType,null);

				if(debug)
					Event.LogInformation("JMJMessage:"+Environment.NewLine+jmjMessage);

				retStatus = this.PutJMJMessage(jmjMessage);

				if(debug)
					Event.LogInformation("PutMessage return status:"+Environment.NewLine+retStatus);
                        
				// Check for success return
				System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
				doc.LoadXml(retStatus);

				System.Xml.XmlNodeList statusElements = doc.GetElementsByTagName("Status");
				if(statusElements.Count>0 && statusElements[0].InnerText.ToLower()=="success")
				{
					return true;
				}
				else
				{
					Event.LogError("PutMessage did not return success."+Environment.NewLine+retStatus);
				}
			}
			catch(Exception exc)
			{
				Event.LogError("Error sending file to EpIE Gateway."+Environment.NewLine+msg+Environment.NewLine+exc.ToString());
			}
			return false;

		}
	}
}
