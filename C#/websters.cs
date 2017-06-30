using System;
using System.Collections;
using System.IO;

//using System.Text;
//using System.Security.Cryptography;//.X509Certificates;   
//using System.Net;
//using System.Net.Sockets;
//using System.Runtime.InteropServices.DllImportAttribute;
//using FTPAUTHLib;
//ftplib.cpp: 
//541,1568

namespace test
{
	/// <summary>
	/// This class connects to the DSHS immunization ssl-ftp server.
	/// </summary>
	class Class1
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			Console.WriteLine("Starting...");
			try
			{
				int i=1;
				int IS;//isquared;
				string IStemp;
				string ISR="";//iSquaredReversed
				double SROISR=0;//square root of ISR
				string Itemp="";
				string IRtemp="";
				int IR=0; //iReversed

				while (i<5000){
					IS=i*i;
					IStemp=IS.ToString();
					for (int j=0; j<IStemp.Length; j++){
						ISR = IStemp[j]+ISR;
						SROISR = Math.Sqrt(Int32.Parse(ISR));
					}
					Itemp = i.ToString();
					for (int k=0; k<Itemp.Length; k++){
					IRtemp = Itemp[k]+IRtemp;
					}
					IR = Int32.Parse(IRtemp);
					if (IR == SROISR)
					Console.WriteLine("i="+i+"; i^2="+IS+"; i^2R="+ISR+
						"; sqrt(i^2R)="+SROISR+"; iR="+IR);
					i++;
					ISR="";
					IRtemp = "";
				}
			
				Console.ReadLine();
			}
			catch(Exception e) 
			{
				Console.WriteLine("Caught Error :"+e.Message);
				Console.ReadLine();
			}
		}

		
		}
		
	#region old stuff
/*
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
	
	 */
	#endregion //old stuff from main
}