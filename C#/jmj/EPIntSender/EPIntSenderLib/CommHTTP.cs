using System;
using System.Net;
using System.IO;
using System.Text;
using System.Web;
using System.Threading;

namespace EPIntSenderLib
{
	/// <summary>
	/// Summary description for CommHTTP.
	/// //NOTE: This is dev issue 5575
	/// </summary>
	public class CommHTTP: BaseComm
	{
		private string address=null;
		private string user=null;
		private string password=null;
		private int count=0;
		private const string header1a = "Content-Type";
		private const string header1b = "application/x-www-form-urlencoded";
		private const string header2a = "Cache-Control";
		private const string header2b = "no-cache";
		private WebClient client = new WebClient ();

		public CommHTTP():base()
		{
		}

		protected override void send()
		{
			if (debug){
				Console.Write(DateTime.Now.Ticks.ToString());
				Console.WriteLine(" : Beginning time of send in CommHTTP");
			}
			
			if (info.Contains("address"))
			address= info["address"].ToString();
			if (info.Contains("user"))
			user= info["user"].ToString();
			if (info.Contains("pwd"))
			password= info["pwd"].ToString();
			//if (info.Contains(""))
			//op1= info["op1"].ToString();
			//if (info.Contains(""))
			 
			if (user!=null && password !=null)
			{
				NetworkCredential nc = new NetworkCredential(user, password);
				client.Credentials = nc;
			}

			//from UploadData method example: do i need to use this?
			client.Headers.Add(header1a,header1b);
			client.Headers.Add(header2a,header2b);
			//RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1, available on the World Wide Web Consortium's 
			//site at http://www.w3c.org. See section 14.9 "Cache-Control" and section 13, "Caching in HTTP" 
			//HttpCachePolicy.SetNoStore();
			
			if (debug)
				Console.WriteLine("\nGetting the data to be posted to the URI {0}:",address);

			#region interval note
			/////////////////Note: Interval between sends is deterined by column send_freq 
			///in table Addressee in db Integration on server WWWSERVER
			///send_freg=number of hours between sends.
			///Frequency can be determined to be n seconds by send_freq=n/3600 
			///Example: IF send_freg = 0.0013888888888888888888888888888889, frequency=5 seconds
			///IF send_freg = 0.0083333333333333333333333333333333, frequency=30 seconds
			///IF send_freg = 0.01, frequency=36 seconds
			///IF send_freq=0.016666666666666666666666666666667, frequency=1 minute
			///IF send_freq=0.25, frequency=15 minutes
			#endregion //interval note
			
			//must loop because the GetMessagesFromEpIEGateway method only gets 35 at a time
			while (processMessages()>0){
				Thread.Sleep(1);
			}

	
			if (debug)
			{
				Console.Write(DateTime.Now.Ticks.ToString());
				Console.WriteLine(" : Ending time of send");
			}
		}
			

		protected int processMessages(){
			//data to send
			Message [] postData = GetMessagesFromEpIEGateway("HL7.ImmReg");//GetMessagesFromDB(0);
			int result = postData.Length;
			string uploadString = "";
			string response = "";

			// Upload the input string using the HTTP 1.0 POST method.
			foreach (Message msg in postData)
			{
				count++;
				if (debug)
					Console.WriteLine("\nUploading message # {1} to {0} ...",  address, count);
				try	
				{
					#region oldway
					/***************BEGIN STREAM way of doing it
					 * Stream postStream = client.OpenWrite(address, "POST");
					StreamWriter writer = new StreamWriter(postStream);

					writer.Write("USERID="+HttpUtility.UrlEncode(user, Encoding.UTF8));
					writer.Write("&PASSWORD="+HttpUtility.UrlEncode(password, Encoding.UTF8));
					writer.Write("&MESSAGEDATA="+HttpUtility.UrlEncode(msg.MessageBody, Encoding.UTF8));
					writer.Flush();
					

					//Console.WriteLine("client.ResponseHeaders:"+client.ResponseHeaders);

					//Console.WriteLine("=======");

					Stream readStream = client.OpenRead(address);
					StreamReader sr = new StreamReader(readStream);

					Console.WriteLine(sr.ReadToEnd());
					sr.Close();
					writer.Close();
					*******************END STREAM way of doing it
					*/
					#endregion //old way

					/******************BEGIN UPLOADDATA way of doing it*/
					uploadString = "USERID="+HttpUtility.UrlEncode(user, Encoding.UTF8);
					uploadString += "&PASSWORD="+HttpUtility.UrlEncode(password, Encoding.UTF8);
					uploadString += "&MESSAGEDATA="+HttpUtility.UrlEncode(msg.MessageBody, Encoding.UTF8);

					byte[] byteArray = Encoding.UTF8.GetBytes(uploadString);

					byte [] responseArray = client.UploadData(address,"POST", byteArray);
					//2005-3/14: got an error from this on 3-8; see dev issue for details
					//found solution here:
					//http://weblogs.asp.net/tgraham/archive/2004/08/12/213469.aspx

					response = Encoding.ASCII.GetString(responseArray);
					
					/***************** END UPLOADDATA way of doing it*/				

					if ((response.IndexOf("ACK")==-1)||(response.IndexOf("accepted")==-1))
					{
						Event.LogError("RESPONSE RECEIVED = \n'"+response+ "' \nWHERE MESSAGE BODY = \n'"+msg.MessageBody+ "'.");
					}
					else 
					{
						Event.LogInformation("RESPONSE RECEIVED = \n'"+response+ "' \nWHERE MESSAGE BODY = \n'"+msg.MessageBody+ "'.");
						SetMessageStatus(msg, MessageStatus.SENT);	
					}
					if (debug)
						Console.WriteLine("\nResponse received was {0}",
							response);

					uploadString = "";
					response = "";
					client = new WebClient ();
					if (user!=null && password !=null)
					{
						NetworkCredential nc = new NetworkCredential(user, password);
						client.Credentials = nc;
					}
					client.Headers.Add(header1a,header1b);
					client.Headers.Add(header2a,header2b);
					this.Complete(msg.ID.ToString(), MessageStatusEnum.Success);
				}
				catch (Exception exec)
				{
					Console.WriteLine("Oops in CommHTTP Upload Data");
					Event.LogError(exec.ToString());
					try{this.Complete(msg.ID.ToString(), MessageStatusEnum.Error);}
					catch (Exception e){Event.LogError("Failed to log message processing error:"
											+e.ToString());}
					continue;
				}
			}//end foreach
			return result;
		}

		protected override void recv()
		{
			base.recv ();
		}

	}
	
}



