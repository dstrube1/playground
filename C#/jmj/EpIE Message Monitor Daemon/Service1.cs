using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.ServiceProcess;
using System.Data.SqlClient;
using System.Threading;
using System.IO;
using System.Text;
using System.Reflection;
using System.Xml;

//to install: instsrv EpIE_Message_Monitor_Daemon "C:\david\EpIE Message Monitor Daemon\bin\Debug\EpIE Message Monitor Daemon.exe"
//to unstall: instsrv EpIE_Message_Monitor_Daemon REMOVE

namespace EpIE_Message_Monitor_Daemon
{
	public class Service1 : System.ServiceProcess.ServiceBase
	{
		#region global variables
		string app_name = "EpIE_Message_Monitor_Daemon";
		string server = null;
		string database = null;
		string user= null;
		string password= null;
		bool integratedSecurity = false;
		private int seconds=2;
		private System.Threading.Thread loopThread = null;
		private bool keepLooping = false;
		/// <summary> 
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		#endregion // global variables

		#region behind the scenes

		public Service1()
		{
			//EventLog.WriteEntry(app_name, "Beginning from Service1", EventLogEntryType.Information);
			// This call is required by the Windows.Forms Component Designer.
			InitializeComponent();

			// TODO: Add any initialization after the InitComponent call
		}

		
		// The main entry point for the process
		static void Main()
		{
			//global variables not loaded yet
			//EventLog.WriteEntry("EpIE_Message_Monitor_Daemon", "Beginning from Main", EventLogEntryType.Information);
			System.ServiceProcess.ServiceBase[] ServicesToRun;
	
			// More than one user Service may run within the same process. To add
			// another service to this process, change the following line to
			// create a second service object. For example,
			//
			//   ServicesToRun = new System.ServiceProcess.ServiceBase[] {new Service1(), new MySecondUserService()};
			//
			ServicesToRun = new System.ServiceProcess.ServiceBase[] { new Service1() };

			System.ServiceProcess.ServiceBase.Run(ServicesToRun);
		}


		/// <summary> 
		/// Required method for Designer support - do not modify 
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			//EventLog.WriteEntry(app_name, "Beginning from InitializeComponent", EventLogEntryType.Information);
			components = new System.ComponentModel.Container();
			this.ServiceName = app_name;//"Service1";
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#endregion // behind the scenes
		
		/// <summary>
		/// Gets the thread started to do the magic.
		/// NOTE: args[0] =! seconds; args[] are ignored; 
		/// see SvcConfig.xml for options
		/// </summary>
		protected override void OnStart(string [] args)
		{
			//order: main, Service1, InitializeComponent, this
			//EventLog.WriteEntry(app_name, "Beginning from OnStart", EventLogEntryType.Information);
			ReadSvcConfigXML();

			loopThread = new System.Threading.Thread(new System.Threading.ThreadStart(loopThreadMethod));
			keepLooping = true;
			loopThread.Start();
			//loopThread.Join();
		}

		private void loopThreadMethod()
		{
			//EventLog.WriteEntry(app_name, "Beginning from loopThreadMethod", EventLogEntryType.Information);

			
			#region local variables
			string from_AddresseeID = null; 
			string to_addresseeID = null;
			string ownerID = null; 
			string toDocumentType = null;
			string messageID = null;
			string message = null;
			string wrapped_message = null;
			string filename = null;
			string EpieEntryPath = null;
			string encoding = null;

			string connection_text = "Server="+server+";Database="+database;
			if (integratedSecurity)
				connection_text += ";Integrated Security=SSPI;";
			else
				connection_text += ";User="+user+";Password="+password;
			connection_text += ";Connect Timeout=60";

			SqlConnection connection1 = new SqlConnection(connection_text);
			connection1.Open();
			SqlCommand Get_EpIE_Messages = new SqlCommand("execute msg_Get_EpIE_Messages", connection1);
			Get_EpIE_Messages.CommandTimeout = 600;
			SqlConnection connection2 = new SqlConnection(connection_text);
			connection2.Open();

			SqlCommand log_msg_status = new SqlCommand();
			log_msg_status.Connection = connection2;
			log_msg_status.CommandText = "msg_log_message_status";
			log_msg_status.CommandType = CommandType.StoredProcedure;

			log_msg_status.Parameters.Add("@ps_MessageID", SqlDbType.VarChar,36);
			log_msg_status.Parameters.Add("@ps_status", SqlDbType.VarChar,24);
			log_msg_status.Parameters.Add("@ps_key", SqlDbType.VarChar,50);
			log_msg_status.Parameters.Add("@ps_info", SqlDbType.VarChar,255);

			log_msg_status.Parameters["@ps_status"].Value = "Processing";
			log_msg_status.Parameters["@ps_key"].Value = "EpIE";

			string path = null;
			string warning_text = "File already exists at ";
			#endregion // local variables

			//EventLog.WriteEntry(app_name, "after declaring loopThreadMethod local variables", EventLogEntryType.Information);
			try
			{
				while (keepLooping)
				{
					SqlDataReader reader = Get_EpIE_Messages.ExecuteReader();
			
					while (reader.Read())
					{
						messageID = reader["messageid"].ToString();
						message = reader["message"].ToString();
						filename = reader["filename"].ToString();
						EpieEntryPath = reader["EpieEntryPath"].ToString();
						from_AddresseeID = reader["FromAddresseeId"].ToString(); 
						to_addresseeID = reader["ToAddresseeId"].ToString();
						ownerID = reader["OwnerID"].ToString(); 
						toDocumentType = reader["ToDocumentType"].ToString();
						if(!reader.IsDBNull(reader.GetOrdinal("encoding")))
							encoding = reader["encoding"].ToString();
					
						if (EpieEntryPath != "" && filename != "" )
						{
							if (EpieEntryPath[EpieEntryPath.Length-1] != '\\')
							{
								EpieEntryPath += "\\";
							}
							path = EpieEntryPath+filename;

							if(File.Exists(path))
							{
								EventLog.WriteEntry(app_name, warning_text+path, EventLogEntryType.Warning);
								File.Delete(path);
							}
							FileStream fs = File.Create(path);
							wrapped_message = GetMessageBag(from_AddresseeID, to_addresseeID, messageID, 
								ownerID, toDocumentType, message, encoding);
							Byte[] info = new UTF8Encoding(true).GetBytes(wrapped_message);
							fs.Write(info, 0, info.Length);
							fs.Flush();
							fs.Close();

							log_msg_status.Parameters["@ps_MessageID"].Value = messageID;
							log_msg_status.Parameters["@ps_info"].Value = path;

							log_msg_status.ExecuteNonQuery();
							
							//EventLog.WriteEntry(app_name, log_msg_status.CommandText, EventLogEntryType.Information);
							
							//log_msg_status.CommandText = log_msg_status_text;

							GC.Collect();
						}
					
					}//end reader while
					reader.Close();
					Get_EpIE_Messages.Dispose();
					connection1.Close();
					connection1 = new SqlConnection(connection_text);
					connection1.Open();
					Get_EpIE_Messages = new SqlCommand("execute msg_Get_EpIE_Messages", connection1);
					Get_EpIE_Messages.CommandTimeout = 600;
					path=null;
					Thread.Sleep(seconds*1000);

				}//end keepLooping while
				connection2.Close();
				//EventLog.WriteEntry(app_name, "Closing", EventLogEntryType.Information);
			}
			catch (Exception e)
			{
				EventLog.WriteEntry(app_name, e.ToString()+log_msg_status.CommandText, EventLogEntryType.Error);
			}
		}//end loopThreadMethod
 
		/// <summary>
		/// Stop this service.
		/// </summary>
		protected override void OnStop()
		{
			keepLooping = false;
			loopThread.Join(new TimeSpan(0,2,0));
			loopThread.Abort();
			loopThread = null;
		}

		/// <summary>
		/// This method reads from SvcConfig.xml in the EXE directory and 
		/// populates local variables with information to connect to the
		/// database
		/// </summary>
		private void ReadSvcConfigXML()
		{
			DataSet configDS = new DataSet();

			configDS.ReadXml(Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location),"SvcConfig.xml"));

			if(configDS.Tables.Count>0 && configDS.Tables[0].Rows.Count>0)
			{
				if(configDS.Tables[0].Columns.Contains("Server") 
					&& !configDS.Tables[0].Rows[0].IsNull("Server"))
					server = (string)configDS.Tables[0].Rows[0]["Server"];

				if(configDS.Tables[0].Columns.Contains("Database") 
					&& !configDS.Tables[0].Rows[0].IsNull("Database"))
					database = (string)configDS.Tables[0].Rows[0]["Database"];

				if(configDS.Tables[0].Columns.Contains("IntegratedSecurity") 
					&& !configDS.Tables[0].Rows[0].IsNull("IntegratedSecurity"))
					integratedSecurity = "Y"==configDS.Tables[0].Rows[0]["IntegratedSecurity"].ToString();

				if (configDS.Tables[0].Columns.Contains("User") 
					&& !configDS.Tables[0].Rows[0].IsNull("User"))
					user = (string)configDS.Tables[0].Rows[0]["User"];

				if (configDS.Tables[0].Columns.Contains("Password") 
					&& !configDS.Tables[0].Rows[0].IsNull("Password"))
					password = (string)configDS.Tables[0].Rows[0]["Password"];

				if(configDS.Tables[0].Columns.Contains("Seconds") 
					&& !configDS.Tables[0].Rows[0].IsNull("Seconds"))
					seconds=Int32.Parse(configDS.Tables[0].Rows[0]["Seconds"].ToString());

				configDS = null;
			}
		}
	

		private string GetMessageBag(string from_addresseeID, string to_addresseeID, string messageID, string ownerID, 
			string toDocumentType, string message, string encoding){
			string rVal = null;
			MemoryStream m = new MemoryStream();
			XmlTextWriter xmlw = new XmlTextWriter(m,System.Text.Encoding.UTF8);
			xmlw.WriteStartDocument();
			xmlw.WriteStartElement("JMJMessage");
			xmlw.WriteStartElement("From");
			xmlw.WriteElementString("AddresseeID",from_addresseeID);
			xmlw.WriteEndElement();
			xmlw.WriteStartElement("To");
			xmlw.WriteElementString("AddresseeID",to_addresseeID);
			xmlw.WriteEndElement();
			xmlw.WriteElementString("JMJMessageID",messageID);
			xmlw.WriteElementString("OwnerID",ownerID);
			xmlw.WriteElementString("DocumentType",toDocumentType);

			xmlw.WriteStartElement("Payload");
			if (encoding!=null)
				xmlw.WriteAttributeString("Encoding", encoding);
			xmlw.WriteString(message);
			xmlw.WriteEndElement();
			xmlw.WriteEndElement();

			xmlw.WriteEndDocument();
			xmlw.Flush();

			// Read the Xml Document we constructed into a string
			// using StreamReader
			m.Position=0;
			StreamReader sr = new StreamReader(m,System.Text.Encoding.UTF8);
			rVal = sr.ReadToEnd();
			sr.Close();

			return rVal;
		}
	
//		static internal byte[] HexStringToBytes(string hexString)
//		{
//			byte[] result=new byte[hexString.Length/2];
//			for(int i=0, j=0;i<result.Length;i++,j+=2)
//			{
//				result[i]=Convert.ToByte(hexString.Substring(j,2),16);
//			}
//			return result;
//		}
	
	}
}
