using System;
//using Microsoft.Win32;
//using System.Collections;
using System.IO;
//using System.Text.RegularExpressions;
//using System.Diagnostics;
//using System.Data.SqlClient;
//using System.Web.Mail;
//using System.Net.Sockets;
//using System.Web;
//using System.Net;
//using System.Text;
//using System.Security.Cryptography;//.X509Certificates;   
//using System.Net.Sockets;
//using System.Runtime.InteropServices.DllImportAttribute;
//using FTPAUTHLib;
//using System.Reflection;
//ftplib.cpp: 
//541,1568


 /*
This is my comment. There are many like it, but this one is mine.

My comment is my best friend. It is my life. I must master it as I must master my life.

My comment, without me, is useless. Without my comment, I am useless. I must author my comment true. 
I must write clearer than my code which is trying to obfuscate my efforts. I must comment in before 
it gets me fired. I WILL...

My comment and myself know that what counts in this job is not the lines we write, the size of our file, 
nor the time to compile it. We know that it is the completed change requests that count. WE WILL COMPLETE...

My comment is human, even as I, because it is my life. Thus, I will learn it as a brother. I will learn 
its weaknesses, its strength, its words, its letters, its punctuation and its opening & closing tags. 
I will ever guard it against the ravages of re-edits and cruft as I will ever guard my legs, my arms, 
my eyes and my heart against damage. I will keep my comment clean and ready. We will become part of each other. 
WE WILL...

Before God, I swear this creed. My comment and myself are the defenders of my department. We are 
the masters of our code. WE ARE THE SAVIORS OF MY LIFE.

So be it, until the beta goes gold and there are no further patch requests, but sales!
*/


namespace test
{
	/// <summary>
	/// This class connects to the DSHS immunization ssl-ftp server.
	/// </summary>
	class Class1
	{
		private const bool debug = true;
		
		
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			
			if (debug)
				Console.WriteLine("Starting...");
				
			try
			{
				////////////////////////BEGIN Test this
				///
				foreach (string s in Directory.GetFiles(
					Directory.GetCurrentDirectory())){
					if (s.IndexOf(".txt")==-1 
						&& s.IndexOf(".exe")==-1
						&& s.IndexOf(".ahc")==-1)
						File.Move(s,s+".txt");
				}
				//Class1 instance = new Class1();
				//instance.test();

				////////////////////////END Test this

				if (debug)
				{
					Console.WriteLine("done");
					Console.ReadLine();
				}
			}
			catch(Exception e) 
			{
				Console.WriteLine("Caught Error :"+e.Message);
				Console.ReadLine();
			}
		}

		private void test(){
//			SqlConnection connection = new SqlConnection();
//			connection.ConnectionString = 
//				//"Server=jdbc:odbc:PhinmsgAccessDSN" //=Invalid connection
//				//"Server=sdnstg.cdc.gov" //=Sql Server does not exist or access denied
//				//from :http://www2a.cdc.gov/PHINMS/2.6.00/receiver_configuration_dialog__database_tab.htm
//				"Server=jdbc:microsoft:sqlserver://sdnstg.cdc.gov:443"//=Invalid connection
//				+";Database=msAccessDbUser"
//				+";Integrated Security=SSPI;";
//				//+";user=msAccessDbUser"
//				//+";password=";
//			connection.Open();
		}
		
		private void test2(string username){
		}
	}
	#region old stuff
	/*
	 ======================================================
	 ======================================================
	 for (int i=0; i<20; i++)
				{
					Console.WriteLine(i + " = " + Strube(i));
				}
		static int Strube(int i)
		{
			if (i<=0)
				return 0;
			else if (i==1)
				return i;
			else
				return i+Strube(i-1);
		}

	 * ======================================================
			static Socket createSocket(string ipAddress, int port){
				Socket ret = new 
					Socket(AddressFamily.InterNetwork,SocketType.Stream,ProtocolType.Tcp);
				IPEndPoint ep = new 
					IPEndPoint(Dns.Resolve(ipAddress).AddressList[0], port);
				try
				{
					ret.Connect(ep);
				}
				catch(Exception)
				{
					Console.WriteLine("Can't connect to remote server");
				}
				return ret;
			}
			static string readLine(Socket clientSocket)
			{
				bool debug=false;
				Encoding ASCII = Encoding.ASCII;
				int bytes;
				string mes ="";
				int BLOCK_SIZE = 512;
				Byte[] buffer = new Byte[BLOCK_SIZE];
				while(true)
				{
					bytes = clientSocket.Receive(buffer, buffer.Length, 0);
					mes += ASCII.GetString(buffer, 0, bytes);
					if(bytes < buffer.Length)
					{
						break;
					}
				}

				char[] seperator = {'\n'};
				string[] mess = mes.Split(seperator);

				if(mes.Length > 2)
				{
					mes = mess[mess.Length-2];
				}
				else
				{
					mes = mess[0];
				}

				if(!mes.Substring(3,1).Equals(" "))
				{
					return readLine(clientSocket);
				}

				if(debug)
				{
					for(int k=0;k < mess.Length-1;k++)
					{
						Console.WriteLine(mess[k]);
					}
				}
				return mes;
			}

			static void sendCommand(String command, Socket clientSocket)
			{

				Byte[] cmdBytes = 
					Encoding.ASCII.GetBytes((command+"\r\n").ToCharArray());
				clientSocket.Send(cmdBytes, cmdBytes.Length, 0);
			}	

			static void sendAndPrint(String command, Socket clientSocket){
				Console.WriteLine(command);
				sendCommand(command, clientSocket);
				Console.WriteLine(readLine(clientSocket));
			}
	*/
	#endregion // old stuff

	#region old stuff from main
	/*
	===============================================================
	===============================================================
	string test = "david4,david1,david10,david3,david9,david8,david7,david6";
				int count=0;
				ArrayList lastLoggedIn = new ArrayList(8);
				for(int i=0; i<lastLoggedIn.Capacity; i++) lastLoggedIn.Add("");
				lastLoggedIn = ArrayList.FixedSize(lastLoggedIn);

				foreach (string s in test.Split(','))
				{
					if (s != "" && s != null)
						lastLoggedIn[count]=s;
					else break;
					count ++;
					if (count==lastLoggedIn.Count) break;
				}
				foreach (string t in lastLoggedIn){
					Console.WriteLine(t);
				}
	===============================================================
	AssemblyVersionAttribute v = new AssemblyVersionAttribute("1.2");
					string version = v.Version;
					Console.WriteLine("version = "+version);
				string [] vE = Assembly.GetExecutingAssembly().ToString().Split(',');
				string versionE = vE[1].Substring(1);
				Console.WriteLine("versionE = '"+versionE+"'");
				string [] vC = Assembly.GetCallingAssembly().ToString().Split(',');
				string versionC = vC[1].Substring(1);
				Console.WriteLine("versionC = '"+versionC+"'");

	===============================================================
	RegistryKey rk = Registry.LocalMachine.OpenSubKey("SOFTWARE\\Adobe",false);
				string [] test = rk.GetSubKeyNames();
				foreach (string t in test){
					if (t == "ESD"){
						RegistryKey sot = rk.OpenSubKey("ESD");
						Console.WriteLine(sot.GetValue("Install_Dir"));
						break;
					}
				}
	===============================================================
	string server = "WWWSERVER";
				string database = "UserConference";
				string user = "EPAgent";
				string password = "VK:#9 NV  kl;l j09-W md";
				string connection_text = "Server=" + server + ";Database=" + database +
					";user=" + user + ";password='" + password + "';Connect Timeout=60";
				SqlConnection connection1 = new SqlConnection(connection_text);
				connection1.Open();
				SqlCommand getOwnerIDs = new SqlCommand("select owner_id from c_owner where "+
					"owner_id > 1800 and owner_id < 2400 and password = ''", connection1);
				SqlDataReader reader = getOwnerIDs.ExecuteReader();
				string alphanumEtc = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321`)(*&^%$#@!~";
				int len = alphanumEtc.Length;
				string newpass = "";
				Random r = new Random();
				ArrayList al = new ArrayList();

				while (reader.Read()){
					Console.WriteLine("owner_id = "+reader["owner_id"].ToString());
					for (int i=0; i<8; i++){
						newpass +=alphanumEtc[r.Next(0,len)];
					}
					Console.WriteLine("password will be "+newpass);
					al.Add("Update c_owner set password = '"+newpass+"' where owner_id = "+reader["owner_id"].ToString());
					newpass="";
				}
				reader.Close();
				al.TrimToSize();
				for (int j=0; j<al.Count; j++){
					SqlCommand setPassword = new SqlCommand(al[j].ToString(), connection1);
					setPassword.ExecuteNonQuery();
				}
	===============================================================
	string s = "n'n";
				string t = "g";
				string r = "";
				string i = null;
				Console.WriteLine("s = "+s.Replace("'","''"));
				Console.WriteLine("t = "+t.Replace("'","''"));
				Console.WriteLine("r = "+r.Replace("'","''"));
				Console.WriteLine("i = "+i.Replace("'","''"));
	===============================================================
				using System.Web.Mail;
					MailMessage msg = new MailMessage();
				msg.From = "d_54321@yahoo.com";
				msg.To = "david.strube@jmjtech.com";
				msg.Subject = "how to send mail using VC#.NET";
				msg.Body = "this is the answer";
				msg.BodyFormat = MailFormat.Text; // can be MailFormat.HTML

					// you can ignore following line for encoding, .NET will use your PC default text encoding 
				//msg.BodyEncoding = System.Text.Encoding.GetEncoding("iso-8859-2");

				// if you need attachment 
				//MailAttachment ma = new System.Web.Mail.MailAttachment(@"c:\mydoc\docToBeAttached");
				//msg.Attachments.Add(ma);
				// end attachment* section 

				SmtpMail.SmtpServer = "mail2.jmjtech.com"; //assign smtp server here
				SmtpMail.Send(msg); //this line actually fire the msg out

				Console.WriteLine("Done. Check your email");
	===============================================================
		string a = null;
				string b = "";
				string c = "neither";
				string [] d = new string[3] {a,b,c};
				foreach (string s in d){
					Console.Write("string ");
					if (!isNullOrBlank(s))
						Console.Write(s+" is not ");
					else Console.Write("is ");
					Console.WriteLine("blank or null");
				}
		static bool isNullOrBlank(string s){
			return s == null || s =="";
		}
	===============================================================
	string filein = @"C:\temp\in.txt";
				StreamReader sr = File.OpenText(filein);
				string temp;
				string temp1;
				string temp2="";
				string out1="INSERT INTO c_Vaccine_Group (vaccine_id, group_name) VALUES ('";
				string out2="','";
				string out3="')";

				//int count = 1;
				string filename = @"C:\temp\out.txt";

				StreamWriter sw = File.CreateText(filename);

				while (sr.Peek()!=-1)
				{
					temp=sr.ReadLine();
					//Console.WriteLine("temp.IndexOf(\\t) = "+temp.IndexOf("\t"));
					temp1 = temp.Substring(0,temp.IndexOf("\t"));
					//Console.WriteLine("temp1 = "+temp1);
					temp2 = temp.Substring(1 + temp.IndexOf("\t"));
					sw.WriteLine(out1+temp1+out2+temp2+out3);
					//Console.ReadLine();
					//count++;
				}
				sw.Close();
	===============================================================
	
	int currYear = System.Int32.Parse(DateTime.Now.ToString("yyyy"));
				Console.WriteLine("currYear = "+currYear);
				int currMonth = System.Int32.Parse(DateTime.Now.ToString("MM"));
				Console.WriteLine("currMonth = "+currMonth);
				int ageYear = 1993;
				int ageMonth = 6;
				decimal fracMonth=0;
				string age="";
				decimal newage = 0;
				ageYear = currYear - ageYear;
				Console.WriteLine("ageYear = "+ageYear);
				if (ageMonth <= currMonth) 
					ageMonth = ageMonth - currMonth;
				else
				{
					ageYear--;
					ageMonth = 12 - ageMonth;
				}
				Console.WriteLine("ageMonth = "+ageMonth);
				Console.WriteLine("ageYear = "+ageYear);
				age = ageYear.ToString(); 
				Console.WriteLine("age = "+age);

				if (ageMonth > 0)
				{
					fracMonth = ageMonth / 12.00M;
					fracMonth = Decimal.Round(fracMonth,2);
				}
				else
					fracMonth = .00M;
				//Console.WriteLine(""+);
				Console.WriteLine("fracMonth = "+fracMonth);
				newage = (Decimal.Parse(age) + fracMonth);
				age = age + fracMonth.ToString();
				Console.WriteLine("age = "+age);
				Console.WriteLine("newage = "+newage);
	===============================================================
					int count = 0;
				int sum=0;
				while (sum < 666){
				count ++;
					sum += count;
					Console.WriteLine("Count="+count+"\tSum="+sum);
				}
	===============================================================
	  System.Diagnostics.Process.Start(@"C:\Program Files\JMJ\DevIssues\devissues.exe", "6418");
	===============================================================
	IPAddress localAddr = IPAddress.Parse("192.168.155.64");
				int port = 13000;
				TcpListener server = new TcpListener(localAddr, port);
				server.Start();

				// Buffer for reading data
				Byte[] bytes = new Byte[256];
				String data = null;

				// Enter the listening loop.
				while(true) 
				{
					Console.Write("Waiting for a connection... ");
        
					// Perform a blocking call to accept requests.
					// You could also user server.AcceptSocket() here.
					TcpClient client = new TcpClient();//server.AcceptTcpClient();            
					server.AcceptSocket();
					Console.WriteLine("Connected!");

					data = null;

					// Get a stream object for reading and writing
					NetworkStream stream = client.GetStream();

					int i;

					// Loop to receive all the data sent by the client.
					while((i = stream.Read(bytes, 0, bytes.Length))!=0) 
					{   
						// Translate data bytes to a ASCII string.
						data = System.Text.Encoding.ASCII.GetString(bytes, 0, i);
						Console.WriteLine(String.Format("Received: {0}", data));
       
						// Process the data sent by the client.
						data = data.ToUpper();

						byte[] msg = System.Text.Encoding.ASCII.GetBytes(data);

						// Send back a response.
						stream.Write(msg, 0, msg.Length);
						Console.WriteLine(String.Format("Sent: {0}", data));            
					}
         
					// Shutdown and end connection
					client.Close();
				}
	===============================================================
				int count = 0;
				int count_R = 0;
				string connection_text = "Server=wwwserver;Database=Integration"+
					";Integrated Security=SSPI"+
					//";User="+user+";Password="+password+
					";Connect Timeout=60";
				SqlConnection connection1 = new SqlConnection(connection_text);
				connection1.Open();
				SqlCommand command = new SqlCommand("select * from m_addressee", connection1);
				while (count <2)
				{
					SqlDataReader reader = command.ExecuteReader();
			
					while (reader.Read())
					{
						if (count_R == 0)
							Console.WriteLine("countR="+count_R +"; " + reader[0].ToString());
						count_R ++;
					}//end reader while
					reader.Close();
					count++;
					connection1.Close();
					connection1 = new SqlConnection(connection_text);
					connection1.Open();
					command = new SqlCommand("select * from m_addressee", connection1);
					count_R=0;
				}//end keepLooping while
				command.Dispose(); 
	===============================================================
	 // The path to the certificate.
	//string Certificate =  @"C:\david\test\TXIR.crt";
	//X509Certificate cert = X509Certificate.CreateFromCertFile(Certificate);
	//Console.WriteLine(cert.ToString(true));
	//Console.WriteLine(cert.ToString(false));

	//string host = "ftp.jmjtech.com";
	//string host = "immtrac-regserv.dshs.state.tx.us";

	//string user= @"jmj\david.strube";
	//string user= "abcpedi";
	//string pass = "year2005";

	//Console.WriteLine(Certificate); 
				System.Diagnostics.ProcessStartInfo psi =
					new System.Diagnostics.ProcessStartInfo(@"C:\david\ftps\scriptController.bat");
				psi.RedirectStandardOutput = true;
				psi.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
				psi.UseShellExecute = false;
				System.Diagnostics.Process listFiles;
				listFiles = System.Diagnostics.Process.Start(psi);
				System.IO.StreamReader myOutput = listFiles.StandardOutput;
				listFiles.WaitForExit(2000);
				if (listFiles.HasExited)
				{
					string output = myOutput.ReadToEnd();
					Console.WriteLine(output);
	=================================================================
	//first 5 lines will always be the same
				string line1 = "AUTH SSL 3"; //login for ssl type connection, only if certificate is on file
				string line2 = "user abcpedi"; //username
				string line3 = "pass year2005"; //password
				//connect with parameters set, specified port:
				string line4 = "connect immtrac-regserv.dshs.state.tx.us 1423"; 
				string line5 = "cd submit"; //goto the submit folder
				string lineX = @"put C:\david\ftps\test.txt /users/abcpedi/submit/test.txt 1";

				ArrayList aL = new ArrayList();
				aL.Add(line1);
				aL.Add(line2);
				aL.Add(line3);
				aL.Add(line4);
				aL.Add(line5);
				//for (int j=0; j<=puts.Length; j++)
				//	aL.Add(puts[j]);
				aL.Add(lineX);

				aL.Add("close");
                
				string filename = @"C:\david\ftps\2.scp";

				if (File.Exists(filename)) 
				{
					Console.WriteLine("{0} already exists.", filename);
					Console.ReadLine();
					return;
				}
				StreamWriter sr = File.CreateText(filename);
				for (int i=0; i<aL.Count; i++)
					sr.WriteLine(aL[i]);
				sr.Close();


				//from http://blogs.msdn.com/csharpfaq/archive/2004/06/01/146375.aspx
				//System.Diagnostics.Process.Start(@"C:\david\ftps\scriptController.bat");
				
	===
	string url = "http://my.opera.com/community/party/reg.dml?email=yourname%40invalid.com";
				WebClient client = new WebClient();
				string response = "";
				string license = "";
				int end = 0;
				int start = 0;
				while (true)
				{
					byte [] responseArray = client.DownloadData(url);
					response = Encoding.ASCII.GetString(responseArray);
					if (debug)
						Console.WriteLine("\nResponse received was {0}",
							response);

					start = response.IndexOf("<tr><th>Windows</th><td>");
					if (debug)
						Console.WriteLine("Start = {0}", start);

					end = response.IndexOf("</td>", start);
					if (debug)
						Console.WriteLine("End = {0}", end);

					if (start!= -1 && start < response.Length)
						license = response.Substring(start+24, end-(start+24));
					else
						license = "";

					if (debug) 
						Console.WriteLine("license = {0}", license);

					if (license	!= "" && license != null)
						 Console.WriteLine(license);
				}
	=======================================================
				string address="http://hegel.research.att.com/tts/cgi-bin/nph-talk";
				WebClient client = new WebClient ();
				string header1a = "Content-Type";
				string header1b = "text/html; charset=iso-8859-1";
				//string header2a = "";
				//string header2b = "";
				client.Headers.Add(header1a,header1b);
				//client.Headers.Add(header2a,header2b);

				string voice = "audrey";
				string txt = "testing";
				string downloadButton = "DOWNLOAD";
				//string response = "";
				//Encoding utf8 = Encoding.UTF8
				Stream postStream = client.OpenWrite(address, "POST");
				StreamWriter writer = new StreamWriter(postStream);

				writer.Write("?voice="+voice);
				writer.Write("&txt="+txt);
				writer.Write("&downloadButton="+downloadButton);
				writer.Flush();
				//Console.WriteLine("client.ResponseHeaders:"+client.ResponseHeaders);

				
				Stream readStream = client.OpenRead(address);
				StreamReader sr = new StreamReader(readStream);

				Console.WriteLine(sr.ReadToEnd());
				sr.Close();
				writer.Close();
	==================================
				string filein = @"C:\temp\in.txt";
				StreamReader sr = File.OpenText(filein);
				string temp;
				string tempout;

				string fileprefix = @"C:\temp\out\out";
				int count = 1;
				string ext = ".txt";
				string filename = fileprefix + count+ ext;

				StreamWriter sw = File.CreateText(filename);

				temp = sr.ReadToEnd();
				while (count < 100 && temp.IndexOf("MSH") != -1)
				{
					tempout = temp.Substring(0, temp.IndexOf("MSH", 1));
					//Console.WriteLine("tempout="+tempout+"\ttemp.IndexOf(MSH) = "+temp.IndexOf("MSH"));
					//Console.WriteLine(temp.Substring(0, 10));
					temp = temp.Substring(temp.IndexOf("MSH", 1));
					GC.Collect();
					sw.Write(tempout);
					count++;
					if (count%10 == 1)
					{
						sw.Close();
						filename = fileprefix + (count/10) + ext;
						sw = File.CreateText(filename);
					}
				
				
				}
	================================
	ArrayList files = new ArrayList(Directory.GetFiles(@".\"));
				files.TrimToSize();
				int count = 0;
				
				string filein = null;
				string temp=null;
				string ext = ".txt";
				string searchFor2Of = "99212";

				while (count < files.Count)
				{
					if (files[count].ToString().EndsWith(ext))
					{
						filein = files[count].ToString();
						StreamReader sr = File.OpenText(filein);
						temp = sr.ReadToEnd();
						if (temp.IndexOf(searchFor2Of) != -1)
						{
							if (temp.LastIndexOf(searchFor2Of) != temp.IndexOf(searchFor2Of))
							{
								Console.WriteLine(files[count]);
							}
						}
					}
					count++;
					GC.Collect();
				}
====================================================
	 */
	#endregion //old stuff from main
}