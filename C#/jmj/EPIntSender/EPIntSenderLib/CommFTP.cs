using System;
using System.IO;
using System.Text;
using System.Collections;
using System.Globalization;


namespace EPIntSenderLib
{
	/// <summary>
	/// Sending:
	/// 1- for each row in m_Message where addressee_id has component=Com ftp:
	/// 	copy message into a temp file
	/// 	Set Message status=RETRIEVED
	/// 	get connection info from addressee
	/// 	establish a secure ftp connection
	/// 	goto the remote submit folder
	/// 	upload the file
	/// 	disconnect
	/// 	set the row in the table to SENT 
	/// 	
	/// 	Receiving:
	/// 	Not yet implemented in this class.
	/// </summary>
	public class CommFTP: BaseComm
	{

		public CommFTP():base()
		{
		}

		protected override void send()
		{

			string address=null;
			string user=null;
			string password=null;
			string sendParams=null;
			string providerImportCode=null;
			string alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			int count=0;

			//Lines of the script
			ArrayList aL = new ArrayList();
			string auth = "AUTH SSL 3"; //login for ssl type connection, 3=only if certificate is on file
			string cd = "cd submit"; //goto the submit folder
			aL.Add(auth);
			aL.Add(user);
			aL.Add(password);
			aL.Add("connect "+address);
			aL.Add(cd);
			string put1 = "put "; //beginning of put ftp command
			string put2 = null;//@" /users/abcpedi/submit/"; //remote file destination
			string put3 = null;//" 1"; //=transfer type set to binary

			//data to send
			if (debug)
				Console.WriteLine("\nGetting the data to be posted to the URI {0}:",address);
			Message [] postData = GetMessagesFromDB(0);
			string localdir = @"C:\temp\";
			string filePath=null;
			string fileName=null;
			string extension = ".imp";
			string pathToScript = @"\\developer-ds\WS_FTP Professional\1.scp";
			string pathToScriptController = @"\\developer-ds\WS_FTP Professional\scriptController.bat";

			if (debug)
			{
				Console.Write(DateTime.Now.Ticks.ToString());
				Console.WriteLine(" : Beginning time of send");
			}

            if (info.Contains("address"))
                address = info["address"].ToString();
            else
            {
                Event.LogError("Expected parameter \"address\" not found.  Cannot continue.");
                return;
            }
			if (info.Contains("user"))
				user= info["user"].ToString();
            else
            {
                Event.LogError("Expected parameter \"username\" not found.  Cannot continue.");
                return;
            }
			if (info.Contains("pwd"))
				password= info["pwd"].ToString();
            else
            {
                Event.LogError("Expected parameter \"password\" not found.  Cannot continue.");
                return;
            }
			if (info.Contains("send_params"))
				sendParams= info["send_params"].ToString();
			//if (info.Contains(""))
			
			if (user!=null && password !=null)
			{
				user = "user "+user;
				password = "pass "+password;
			}
			if(sendParams !=null){
                if (sendParams.IndexOf("PIC=") != -1) //providerImportCode
					providerImportCode = sendParams.Substring(sendParams.IndexOf("PIC="+4, 4));
                if (sendParams.IndexOf("RFD=") != -1) ////remote file destination
					put2 = sendParams.Substring(sendParams.IndexOf("RFD="+4));
			}

			if (debug)
				Console.WriteLine("\nMaking file from message # {0} to {1} ...",  count, address);

			try	
			{
				// Create the files to be uploaded 
				//and update the script along the way.
				foreach (Message msg in postData)
				{
	
					fileName = providerImportCode + getYear() + getJulian() + alphabet[count] + extension;
					filePath = localdir + fileName;
					// Delete the file if it exists.
					if (File.Exists(filePath)) 
					{
                        Event.LogWarning("File already exists at "+filePath);
						File.Delete(filePath);
					}

					// Create the file.
					StreamWriter fs = File.CreateText(filePath);
					fs.Write(msg.MessageBody);					 
					
					//add a line to script for this file
					aL.Add(put1 + filePath + put2 + fileName + put3);

					fs.Flush();
					fs.Close();
					count++;
					if (count >= 26)
						count=0;
					
				}//end foreach

				//last line in the script
				aL.Add("close");
				aL.TrimToSize();
	
				//create script file
				if (File.Exists(pathToScript)) 
				{
					File.Delete(pathToScript);
				}
				StreamWriter sr = File.CreateText(pathToScript);
				for (int i=0; i<aL.Count; i++)
					sr.WriteLine(aL[i]);
				sr.Flush();
				sr.Close();

				//run the script in the script utility from ipswitch
				System.Diagnostics.Process.Start(pathToScriptController);

				foreach (Message msg in postData)
				{
					//setting each message to sent 
					SetMessageStatus(msg, MessageStatus.SENT); 
				}
			}
			catch (Exception exec)
			{
				Console.WriteLine("Oops in CommFTP Upload Data");
				Event.LogError(exec.ToString());
				//from when the try/catch was in the foreach:
				//continue;
			}

			if (debug)
			{
				Console.Write(DateTime.Now.Ticks.ToString());
				Console.WriteLine(" : Ending time of send");
			}
		}
			
		protected override void recv()
		{
		base.recv ();
		}

		private string getYear(){
			char year2 = DateTime.Now.Year.ToString()[2];
			char year3 = DateTime.Now.Year.ToString()[3];
			string year = new string(new char[]{year2, year3});
			return year;
		}

		private string getJulian(){
			JulianCalendar myCal = new JulianCalendar();
			return myCal.GetDayOfYear(DateTime.Now).ToString();
		}

	}
	
}