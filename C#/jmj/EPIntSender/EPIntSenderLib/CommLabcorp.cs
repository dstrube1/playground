using System;
using System.IO;
using System.Collections;
using System.Collections.Specialized;

namespace EPIntSenderLib
{
	/// <summary>
	/// Receiving:
	/// This receives all the lab results messages from Labcorp thru VPN connection.
	/// Labcorp exports all active JMJ Labcore customer result messages into a single
	/// FTP folder that's assigned to Labcorp.
	/// 
	/// <code>path, searchpattern, documenttype</code>
	/// 
	/// Once the message is successfully uploaded to gateway it's removed from the folder.
	/// Only files whose names match the searchpattern parameter will be 
	/// processed.
	/// 
	/// Sending:
	/// Not yet implemented in this class.
	/// </summary>
	public class CommLabcorp:BaseComm
	{
		string recipientpath = null;
		public CommLabcorp():base()
		{
		}

		protected override void recv()
		{
			string  documentType=null,searchpattern = null;
			bool retStatus = true;
			
			if(!info.Contains("documenttype"))
			{
				Event.LogError("Expected parameter \"documenttype\" not found.  Cannot continue.");
				return;
			}

			documentType = info["documenttype"].ToString();

			if(!info.Contains("recipientpath"))
			{
				Event.LogError("Expected parameter \"recipientpath\" not found.  Cannot continue.");
				return;
			}

			recipientpath = info["recipientpath"].ToString();

			if(!info.Contains("searchpattern"))
			{
				Event.LogError("Expected parameter \"searchpattern\" not found.  Cannot continue.");
				return;
			}

			searchpattern = info["searchpattern"].ToString();

			try
			{
				string[] files = Directory.GetFiles(recipientpath,searchpattern);

				foreach(string file in files)
				{
					if(debug)
						Event.LogInformation("Reading file:"+Environment.NewLine+file);

					string msgBag = null, msg=null,senderRecipient=null;
					bool markError=false;
					int iPos=0, iLength=0, iNext=0;
						
					StreamReader sr = new StreamReader(file,true);
					msgBag=sr.ReadToEnd();
					sr.Close();
	
					if(debug)
						Event.LogInformation("File contents:"+Environment.NewLine+msgBag);

					// Check whether it's a valid message
					iPos = msgBag.IndexOf("MSH|^~\\&|",0);
					if (iPos < 0) 
					{
						Event.LogInformation("CommLabcorp: Not a valid HL7 file: moving to error folder"+Environment.NewLine+msgBag);
						SaveFile(file,false,".NOTHL7"); // move invalid file to error folder
						continue;
					}
					iNext = msgBag.IndexOf("MSH|^~\\&|",iPos + 1);
					if (iNext < 0) // single message
					{
						msg = msgBag.Substring(iPos);
						// Get the SenderRecipientId
						senderRecipient = getRecipient(msg);
						if(senderRecipient.Length==0) // Recipient is not found then move to error
						{
							SaveFile(file,false,".NORECIPIENT");
							continue;
						}
						if(sendMsg(msg,info["addressee_id"].ToString(),null,senderRecipient,null,info["owner_id"].ToString(),documentType))
						{
							SaveFile(file,true,".txt");

							if(debug)
								Event.LogInformation("Finished with file, moved to success folder:"+Environment.NewLine+file);
									
						}
					}
					else // batches
					{
						retStatus = true;markError=false;
						do
						{
							iLength = iNext - iPos;
							msg = msgBag.Substring(iPos,iLength);
							// Get the SenderRecipientId
							senderRecipient = getRecipient(msg);
							if(senderRecipient.Length==0) 
							// Recipient is not found then move to next messsage in the batch but move this file to error at the end
							{
								markError=true;
							}
							else
							{
								if (!sendMsg(msg,info["addressee_id"].ToString(),null,senderRecipient,null,info["owner_id"].ToString(),documentType))
								{
									retStatus=false;
									break;
				
								}
							}
							iPos = iNext;
							iNext = msgBag.IndexOf("MSH|^~\\&|",iPos + 1);
					
						}
						while(iNext > 0);
						if(retStatus)
						{
							msg = msgBag.Substring(iPos);
							senderRecipient = getRecipient(msg);
							if(senderRecipient.Length==0) // Recipient is not found then move to error
							{
								markError=true;
							}
							else
							{
								if(sendMsg(msg,info["addressee_id"].ToString(),null,senderRecipient,null,info["owner_id"].ToString(),documentType))
								{
									if(debug)
										Event.LogInformation("Finished with file, moving to success folder:"+Environment.NewLine+file);
									
								}
							}
						}
					}
					//markerr		
					if (markError || !retStatus)
					{
						SaveFile(file,false,".ERR");
					}
					else
					{
						SaveFile(file,true,".TXT");
					}
				}
			}
			catch(Exception exc)
			{
				Event.LogError("Error:"+Environment.NewLine+exc.ToString());
			}
		}

		protected override void send()
		{
			base.send ();
		}

		private bool sendMsg(string msg,string fromAddressee,string toAddressee,string senderRecipientId,string senderMsgId,string ownerId,string documentType)
		{
			string jmjMessage = null;
			string retStatus = null;
			try
			{

				jmjMessage = this.WrapInJMJMessage(msg,fromAddressee,toAddressee,senderRecipientId,senderMsgId,ownerId,documentType,null);

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

		private string getRecipient(string msg_string)
		{
			// MSH.6 (Customer Site Identifier) uniquily identifies a message to a customer

			string ls_senderRecipientId = null;

			//spilt string message into segments
			string[] msg_segments = msg_string.Split('\r');
			
			//spilt the MSH segment
			string[] msh_fields = msg_segments[0].Split('|');

			// MSH.6 (Receiving Facility)
			try
			{
				ls_senderRecipientId = msh_fields[5].ToString();
			}
			catch (NullReferenceException)
			{
				ls_senderRecipientId=String.Empty;
				Event.LogError("SenderRecipient is null "+Environment.NewLine+msg_string);
			}
			return ls_senderRecipientId;
			
			/*			
			//spilt the PID segment
			string[] pid_fields = msg_segments[1].Split('|');

			// make sure this is PID segment
			ls_recipient = pid_fields[0].ToUpper();
			if (pid_fields[0].Equals("PID"))
			{
				// get the SenderRecipientID from (count from PID header) PID.19.1 ( since the array starts with zero it's PID.17 )
				ls_recipient = pid_fields[18];
				if (ls_recipient.IndexOf("^",0) > 0)
				{
					string[] ls_temp = ls_recipient.Split('^');
					ls_senderRecipientId = ls_temp[0];
				}
				else
				{
					ls_senderRecipientId = ls_recipient;
				}
			} */
		
		}

		private void SaveFile(string file,bool status,string extension)
		{
			// if the messages in a file is successfully processed then move to success folder
			// if it's a invalid file then move to error folder with .err extension

			string ls_error=recipientpath+"\\error\\", ls_success=recipientpath+"\\success\\";

			try
			{
				if (!Directory.Exists(ls_error))
					Directory.CreateDirectory(ls_error);
				if (!Directory.Exists(ls_success))
					Directory.CreateDirectory(ls_success);
				
				if(status)
					File.Move(file,ls_success+Guid.NewGuid().ToString()+extension);
				else
					File.Move(file,ls_error+Guid.NewGuid().ToString()+extension);
			}
			catch(Exception exec)
			{
				File.Delete(file);
				Event.LogError("Error in saving file; deleting the file "+Environment.NewLine+exec.ToString());
			}
		}
	}

}
