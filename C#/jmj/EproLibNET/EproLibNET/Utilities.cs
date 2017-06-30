using System;
using System.Runtime.InteropServices;
using System.IO;
using System.Diagnostics;
using com.enterprisedt.net.ftp;
using System.Threading;
using System.Xml;
using System.DirectoryServices;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Net;
using System.Web;
using System.Text;


namespace EproLibNET
{
	public delegate void ProgressUpdate(int Progress, string Status);
	
	/// <summary>
	/// Summary description for Utilities.
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class Utilities
	{

		private string EproLibNETFolder = null;
		private EventLog eventLog=null;
		private string epVersion="Ver. NA";
		private string eproLibNETVersion=null;

		public string EPVersion
		{
			get
			{
				return epVersion;
			}
			set
			{
				epVersion=value;
			}
		}
		public Utilities()
		{
			EproLibNETFolder = Environment.GetFolderPath(System.Environment.SpecialFolder.CommonProgramFiles);
			EproLibNETFolder = System.IO.Path.Combine(EproLibNETFolder, "JMJTech Common");
			EproLibNETFolder = System.IO.Path.Combine(EproLibNETFolder, "EproLibNET");

			eproLibNETVersion = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
		}

		/// <summary>
		/// Initializes the Application Event Log
		/// </summary>
		/// <param name="source">The Event Source to show in the Event Log</param>
		/// <returns></returns>
		public int InitializeEventLog(string source)
		{
			try
			{
				eventLog = new EventLog("Application", ".", source);
				return 1;
			}
			catch(Exception)
			{
				return -1;
			}
		}

		/// <summary>
		/// Use to log a System.Exception.
		/// </summary>
		/// <param name="exc">Exception to log</param>
		/// <param name="severity">1,2 = Information; 3 = Warning; 4,5 = Error</param>
		/// <returns></returns>
		internal int LogInternalEvent(Exception exc, int severity)
		{
			if(null==eventLog)
			{
				eventLog = new EventLog("Application", ".", "EncounterPRO");
				eventLog.WriteEntry("EncounterPRO Event Logging initialized automatically because it was not initialized by the caller.", EventLogEntryType.Warning);
			}
			try
			{
				EventLogEntryType eventSeverity = EventLogEntryType.Information;
				string objectName=null, scriptName=null, message=null, helpLink=null;
				objectName = exc.Source;
				if(null!=exc.TargetSite)
					scriptName = exc.TargetSite.Name;
				message = exc.ToString();
				helpLink = exc.HelpLink;
				if(null==objectName)
				{
					objectName = "UnknownObject";
				}
				if(null==scriptName)
				{
					scriptName = "UnknownScript";
				}
				if(null==message)
				{
					message = "UnknownMessage";
				}
				if(null==helpLink)
				{
					helpLink = "";
				}
				switch(severity)
				{
					case 1:
					case 2:
						eventSeverity=EventLogEntryType.Information;
						break;
					case 3:
						eventSeverity=EventLogEntryType.Warning;
						break;
					case 4:
					case 5:
						eventSeverity=EventLogEntryType.Error;
						break;
				}

				eventLog.WriteEntry("EproLibNET version: "+eproLibNETVersion+Environment.NewLine+
					Environment.UserDomainName+"\\"+Environment.UserName+
					" on "+Environment.MachineName+ "\r\n" + EPVersion + " >>> " + objectName+
					" - ("+scriptName+") "+message+Environment.NewLine+helpLink, eventSeverity);
				return 1;
			}
			catch(Exception)
			{
				return -1;
			}
		}

		/// <summary>
		/// Log a custom event
		/// </summary>
		/// <param name="objectName">The name of the class the event pertains to</param>
		/// <param name="scriptName">The name of the method the event pertains to</param>
		/// <param name="message">The message to log in the event</param>
		/// <param name="severity">1,2 = Information; 3 = Warning; 4,5 = Error</param>
		/// <returns>1 = Success; -1 = Error</returns>
		public int LogEvent(string objectName, string scriptName, string message, int severity)
		{
			if(null==eventLog)
			{
				eventLog = new EventLog("Application", ".", "EncounterPRO");
				eventLog.WriteEntry("EncounterPRO Event Logging initialized automatically because it was not initialized by the caller.", EventLogEntryType.Warning);
			}
			try
			{
				EventLogEntryType eventSeverity = EventLogEntryType.Information;
				if(null==objectName)
				{
					objectName = "UnknownObject";
				}
				if(null==scriptName)
				{
					scriptName = "UnknownScript";
				}
				if(null==message)
				{
					message = "UnknownMessage";
				}
				switch(severity)
				{
					case 1:
					case 2:
						eventSeverity=EventLogEntryType.Information;
						break;
					case 3:
						eventSeverity=EventLogEntryType.Warning;
						break;
					case 4:
					case 5:
						eventSeverity=EventLogEntryType.Error;
						break;
				}

				eventLog.WriteEntry("EproLibNET version: "+eproLibNETVersion+Environment.NewLine+
					Environment.UserDomainName+"\\"+Environment.UserName+" on "+
					Environment.MachineName+ "\r\n" + EPVersion + " >>> " + objectName+
					" - ("+scriptName+") "+message, eventSeverity);
				return 1;
			}
			catch(Exception)
			{
				return -1;
			}
		}
		public int CloseEventLog(string source)
		{
			try
			{
				eventLog.Close();
				return 1;
			}
			catch(Exception)
			{
				return -1;
			}
		}

		public bool IsDomainUserExists(string User)
		{
			DirectoryEntry rootEntry = new DirectoryEntry("LDAP://"+Environment.UserDomainName);
			DirectorySearcher ADSearcher = new DirectorySearcher(rootEntry);

			ADSearcher.Filter="(&(objectClass=user)(anr="+User+"))";
			SearchResult result = ADSearcher.FindOne();
			if(null==result)
				return false;
			if(result.GetDirectoryEntry().SchemaClassName.ToLower()!="computer")
				return true;
			else
				return false;
		}
		public void DomainRemoveUser(string User)
		{
			DirectoryEntry rootEntry = new DirectoryEntry("LDAP://"+Environment.UserDomainName);
			DirectorySearcher ADSearcher = new DirectorySearcher(rootEntry);

			ADSearcher.Filter="(&(objectClass=user)(anr="+User+"))";
			SearchResult result = ADSearcher.FindOne();
			if(null==result)
				return;
			result.GetDirectoryEntry().DeleteTree();
		}
		public void DomainCreateUser(string User, string Password, bool AdminPrivileges)
		{
		}
		public void RemoveServices(string ServiceNameFilter)
		{
			// Declare and initialize the Regex for the ServiceNameFilter
			System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex(ServiceNameFilter);

			// Get an array of all services running on local computer
			System.ServiceProcess.ServiceController[] services = System.ServiceProcess.ServiceController.GetServices();
			foreach(System.ServiceProcess.ServiceController service in services)
			{
				// If the ServiceName does not match the ServiceNameFilter
				// Continue to next iteration
				if(!r.IsMatch(service.ServiceName))
					continue;
				// If service status is not Stopped, stop the service
				if(service.Status != System.ServiceProcess.ServiceControllerStatus.Stopped)
				{
					try
					{
						service.Stop();
					}
					catch(Exception exc)
					{
						LogInternalEvent(exc,2);
					}
				}
				try
				{
					System.Diagnostics.Process p = new Process();
					p.StartInfo = new ProcessStartInfo("INSTSRV.EXE","\""+service.ServiceName+"\" REMOVE");
					p.Start();
					p.WaitForExit(1000);
				}
				catch(Exception exc)
				{
					LogInternalEvent(exc,2);
				}
			}
		}

		public void DisableServices(string ServiceNameFilter)
		{
			// Declare and initialize the Regex for the ServiceNameFilter
			System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex(ServiceNameFilter);

			// Get an array of all services running on local computer
			System.ServiceProcess.ServiceController[] services = System.ServiceProcess.ServiceController.GetServices();
			foreach(System.ServiceProcess.ServiceController service in services)
			{
				// If the ServiceName does not match the ServiceNameFilter
				// Continue to next iteration
				if(!r.IsMatch(service.ServiceName))
					continue;
				// If service status is not Stopped, stop the service
				if(service.Status != System.ServiceProcess.ServiceControllerStatus.Stopped)
				{
					try
					{
						service.Stop();
						service.WaitForStatus(System.ServiceProcess.ServiceControllerStatus.Stopped,TimeSpan.FromSeconds(30d));
					}
					catch(Exception exc)
					{
						LogInternalEvent(exc,2);
					}
				}
				try
				{
					ServiceControl.ChangeServiceStartType(service.ServiceName,ServiceControl.ServiceStartType.SERVICE_DISABLED);
				}
				catch(Exception exc)
				{
					LogInternalEvent(exc,2);
				}
			}
		}

		public int ConvertImage(string sourceFile, string destFile)
		{
			int rVal=1;			
			string imageUtil = System.IO.Path.Combine(EproLibNETFolder,"EPImageUtil.exe");
			try
			{
				System.Diagnostics.Process p = new System.Diagnostics.Process();
				p.StartInfo = new System.Diagnostics.ProcessStartInfo(imageUtil,"\"s="+sourceFile+"\" \"d="+destFile+"\"");
				p.Start();
				p.WaitForExit();
				return 1;
			}
			catch(Exception exc)
			{
				LogInternalEvent(exc,4);
				throw exc;
			}
			return rVal;
		}


		public void FTPPut(string FTPPath, string LocalPath, string FTPUser, string FTPPassword, bool Subdir)
		{
			if(FTPUser==null)
				FTPUser="Anonymous";
			if(FTPPassword==null)
				FTPPassword="anon@domain.com";

			string[] sourceFileList = GetFileList(LocalPath, Subdir);
			Uri uri = new Uri(FTPPath);
			FTPClient ftp = new FTPClient(uri.Host);
			
			ftp.Login(FTPUser,FTPPassword);
			if(uri.AbsolutePath!="/")
				ftp.Chdir(uri.AbsolutePath);
			ftp.TransferType = FTPTransferType.BINARY;
			foreach(string file in sourceFileList)
			{
				ftp.Put(file,Path.GetFileName(file));
			}
			ftp.Quit();
		}

		public void FTPGet(string FTPPath, string LocalPath, string FTPUser, string FTPPassword, bool Subdir)
		{
		}

		public void ZIP(string SourcePath, string DestFile, int Compression, bool Subdir)
		{
			string[] fileList = GetFileList(SourcePath, Subdir);

			if( !Directory.Exists( Path.GetDirectoryName( DestFile ) ) )
				Directory.CreateDirectory( Path.GetDirectoryName(DestFile));
			FileStream fs = File.Create(DestFile);
			ICSharpCode.SharpZipLib.Zip.ZipOutputStream s = new ICSharpCode.SharpZipLib.Zip.ZipOutputStream(fs);
			s.SetLevel(Compression);
			foreach(string fileName in fileList)
			{
				FileStream fs2 = File.OpenRead(fileName);
            			
				byte[] buffer = new byte[fs2.Length];
				fs2.Read(buffer, 0, buffer.Length);
				fs2.Close();
		
				ICSharpCode.SharpZipLib.Zip.ZipEntry entry = new ICSharpCode.SharpZipLib.Zip.ZipEntry(fileName);
            			
				s.PutNextEntry(entry);
            			
				s.Write(buffer, 0, buffer.Length);

			}
			s.Finish();
			s.Close();
		}

		public string[] GetFileList(string SourcePath, bool Subdir)
		{
			SourcePath = SourcePath.Trim().TrimEnd(new char[] {Path.DirectorySeparatorChar});
			string sourceDir = null;
			string fileFilter = "*";
			if(Directory.Exists(SourcePath))
			{ // Source is a Directory
				sourceDir = SourcePath;
			}
			else if(Directory.Exists(Path.GetDirectoryName(SourcePath)))
			{ // Source is a File Filter
				sourceDir = Path.GetDirectoryName(SourcePath);
				fileFilter = Path.GetFileName(SourcePath);
			}
			else
			{ // Source not found
				throw new DirectoryNotFoundException("Cannot find \""+Path.GetDirectoryName(SourcePath)+"\".");
			}

			System.Collections.ArrayList fileList = new System.Collections.ArrayList();
			fileList.AddRange(System.IO.Directory.GetFiles(sourceDir,fileFilter));
			if(Subdir)
			{
				foreach(string subDir in System.IO.Directory.GetDirectories(sourceDir))
				{
					fileList.AddRange(GetFileList(Path.Combine(subDir, fileFilter),Subdir));
				}
			}

			return (string[]) fileList.ToArray(Type.GetType("System.String"));
		}

		public void UnZIP(string SourceFile, string DestPath, bool PreservePath, string[] ZipEntry)
		{
			FileStream fs = File.OpenRead(SourceFile);
			ICSharpCode.SharpZipLib.Zip.ZipInputStream s = new ICSharpCode.SharpZipLib.Zip.ZipInputStream(fs);
			ICSharpCode.SharpZipLib.Zip.ZipEntry theEntry;
			while ((theEntry = s.GetNextEntry()) != null) 
			{
				if(theEntry.IsDirectory)
					continue;

				if(null!=ZipEntry && ZipEntry.Length>0 && Array.BinarySearch(ZipEntry,Path.GetFileName(theEntry.Name),System.Collections.CaseInsensitiveComparer.Default)<0)
					continue;

				int size = 2048;
				byte[] data = new byte[2048];
                
				string outputFileName = null;
				if(PreservePath)
					outputFileName = Path.Combine(DestPath,theEntry.Name);
				else
					outputFileName = Path.Combine(DestPath,Path.GetFileName(theEntry.Name));
				if(!Directory.Exists(Path.GetDirectoryName(outputFileName)))
					Directory.CreateDirectory(Path.GetDirectoryName(outputFileName));

				FileStream destFS = new FileStream(outputFileName,FileMode.Create);

				while(s.Available>0)
				{
					int readLen = s.Read(data,0,size);
					destFS.Write(data,0,readLen);
				}
				destFS.Flush();
				destFS.Close();
			}
			s.Close();
		}

		public string[] ZIPContents(string SourceFile)
		{
			System.Collections.ArrayList contents = new System.Collections.ArrayList();
			ICSharpCode.SharpZipLib.Zip.ZipFile zip = new ICSharpCode.SharpZipLib.Zip.ZipFile(SourceFile);
			for(int i=0; i<zip.Size; i++)
			{
				if(!zip[i].IsDirectory)
					contents.Add(zip[i].Name);
			}
			return (string[])contents.ToArray(Type.GetType("System.String"));
		}

		#region EP Attachment Management
		public void EPAttchToFile(string[] CprID, string Server, string Database, string AppRolePwd, ProgressUpdate ProgressUpdateMethod)
		{
			SqlConnection con = GetNewConnection(Server, Database, AppRolePwd);
			SqlCommand cmd = null;
			SqlDataReader r = null;
			// TODO: Method code
			// Validate c_Attachment_Location entries
			if(!ValidateAttachmentLocations(con))
				throw new Exception("One or more entries in c_Attachment_Location does not refer to a valid path.");
			for(int i=0; i<CprID.Length; i++)
			{
				if(ProgressUpdateMethod!=null)
					ProgressUpdateMethod(i*100/CprID.Length,CprID[i]);
				try
				{
					if(PatientAttachmentCount(CprID[i], con)==0)
						continue;
					if(!ValidatePatientAttachmentPath(CprID[i], con))
						continue;

					// Get Patient Attachment Path and create folder if it does not exist
					string patientAttchPath = GetPatientAttachmentPath(CprID[i],con);
					if(!Directory.Exists(patientAttchPath))
						Directory.CreateDirectory(patientAttchPath);

					// Get a list of Attachment IDs for this patient
					int[] attchID = GetAttachmentIDList(CprID[i], con);
					// Loop through all attachments for this patient and move them to files
					for(int j=0; j<attchID.Length; j++)
					{
						string storageFlag = null;
						string fullPath = patientAttchPath;
						string fileName = null;
						byte[] latestAttachmentData = null;
						try
						{
							cmd = con.CreateCommand();
							cmd.CommandText = "SELECT p_Attachment.storage_flag FROM p_Attachment "+
								"WHERE p_Attachment.attachment_id = "+attchID[j].ToString();
							storageFlag = cmd.ExecuteScalar().ToString();
							if(storageFlag.ToLower() != "d")
								continue;
							cmd.CommandText = "SELECT p_Attachment.* FROM p_Attachment "+
								"WHERE p_Attachment.attachment_id = "+attchID[j].ToString();
							r = cmd.ExecuteReader();
							if(!r.Read())
								continue;
							// Get attachment_file_path (if there is one)
							if(!r.IsDBNull(r.GetOrdinal("attachment_file_path")) && null!=r["attachment_file_path"])
								fullPath = Path.Combine(fullPath,r["attachment_file_path"].ToString());
							// Get file name
							if(r.IsDBNull(r.GetOrdinal("attachment_file")) || null==r["attachment_file"] || r["attachment_file"].ToString()=="")
								fileName = Guid.NewGuid().ToString();
							else
								fileName = r["attachment_file"].ToString();
							// Get extension
							if(!r.IsDBNull(r.GetOrdinal("extension")) && null!=r["extension"] && r["extension"].ToString()!="")
								fileName += "."+r["extension"].ToString();
							r.Close();

							// Get attachment data
							latestAttachmentData = GetAttachment(attchID[j], con);
							if(latestAttachmentData == null)
								continue;
					
							// Get unique filename
							string newFileName = GetUniqueFileName(fullPath, fileName);
							if(newFileName!=fileName)
							{
								fileName = newFileName;
								// Update database with new filename, if different from original
								UpdateAttachmentFileName(attchID[j],fileName,con);
							}
							// Write attachment to file
							FileStream fs = File.Create(Path.Combine(fullPath,fileName));
							fs.Write(latestAttachmentData,0,latestAttachmentData.Length);
							fs.Flush();
							fs.Close();

							bool hasEdits = AttachmentHasEdits(attchID[j],con);

							// Begin Transaction
							SqlTransaction tr = null;
							tr = con.BeginTransaction();
							cmd.Transaction = tr;
							try
							{
								// Set storage_flag = 'F'
								cmd.CommandText = "UPDATE p_Attachment SET storage_flag = 'F' WHERE attachment_id = "+attchID[j].ToString();
								cmd.ExecuteNonQuery();

								// If attachment has no edits
								if(!hasEdits)
								{
									// Remove image data from p_Attachment
									cmd.CommandText = "UPDATE p_Attachment SET attachment_image = NULL WHERE attachment_id = "+attchID[j].ToString();
									cmd.ExecuteNonQuery();
								}
								tr.Commit();
							}
							catch
							{
								tr.Rollback();
								continue;
							}
							finally
							{
								cmd.Transaction = null;
								tr.Dispose();
							}
						}
						catch(Exception exc)
						{
							System.Windows.Forms.MessageBox.Show(exc.ToString());
							continue;
						}
					}
				}
			
				catch(Exception exc)
				{
					System.Windows.Forms.MessageBox.Show(exc.ToString());
					continue;
				}
			}
			con.Close();
		}

		public void EPAttchToDB(string[] CprID, string Server, string Database, string AppRolePwd, ProgressUpdate ProgressUpdateMethod)
		{
			SqlConnection con = GetNewConnection(Server, Database, AppRolePwd);
			// TODO: Method code
			throw new Exception("This method has not been implemented yet");
			con.Close();
		}
		private int PatientAttachmentCount(string CprID, SqlConnection con)
		{
			SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM p_Attachment WHERE p_Attachment.cpr_id = '"+CprID+"'",con);
			return (int) cmd.ExecuteScalar();
		}

		private int[] GetAttachmentIDList(string CprID, SqlConnection con)
		{
			System.Collections.ArrayList list = new System.Collections.ArrayList();
			SqlCommand cmd = new SqlCommand("SELECT attachment_id FROM p_Attachment WITH (NOLOCK) "+
				"WHERE cpr_id = '"+CprID+"'",con);
			SqlDataReader r = null;
			r = cmd.ExecuteReader();
			while(r.Read())
			{
				list.Add((int)r[0]);
			}
			r.Close();
			return (int[])list.ToArray(System.Type.GetType("System.Int32"));
		}
		private bool ValidateAttachmentLocations(SqlConnection con)
		{
			// Validate c_Attachment_Location entries
			SqlCommand cmd = new SqlCommand("SELECT * FROM c_Attachment_Location WITH (NOLOCK)",con);
			SqlDataReader r = null;
			try
			{
				r = cmd.ExecuteReader();
				while(r.Read())
				{
					string AttchServ = r["attachment_server"].ToString();
					string AttchShare = r["attachment_share"].ToString();
					if(!Directory.Exists("\\\\"+AttchServ+"\\"+AttchShare))
						return false;
				}
			}
			catch
			{
				return false;
			}
			finally
			{
				try
				{
					r.Close();
				}
				catch{}
			}
			return true;
		}

		private bool ValidatePatientAttachmentPath(string CprID, SqlConnection con)
		{
			SqlCommand cmd = new SqlCommand("SELECT * FROM p_Patient WITH (NOLOCK) WHERE p_Patient.cpr_id = '"+CprID+"'",con);
			SqlDataReader r = null;
			
			try
			{
				r = cmd.ExecuteReader();
				if(!r.Read())
				{
					r.Close();
					return false;
				}

				int AttchLocID = -1;
				string AttchPath = null;

				// Validate p_Patient.attachment_location_id
				if ( !r.IsDBNull(r.GetOrdinal("attachment_location_id")) )
					AttchLocID = (int) r["attachment_location_id"];
				// Validate p_Patient.attachment_path
				if ( !r.IsDBNull(r.GetOrdinal("attachment_path")) )
					AttchPath = r["attachment_path"].ToString();

				// Close reader
				r.Close();

				// If not set, set attachment_location_id
				if ( AttchLocID == -1 )
				{
					cmd.CommandText = "UPDATE p_Patient SET p_Patient.attachment_location_id = "+
						"( SELECT TOP 1 c_Attachment_Location.attachment_location_id "+
						"FROM c_Attachment_Location ORDER BY sort_sequence ) "+
						"WHERE p_Patient.cpr_id = '"+CprID+"'";
					cmd.ExecuteNonQuery();
				}

				// If not set, set attachment_path to cpr_id
				if ( AttchPath == null )
				{
					cmd.CommandText = "UPDATE p_Patient SET p_Patient.attachment_path = '"+
						CprID + "' WHERE cpr_id = '"+CprID+"'";
					cmd.ExecuteNonQuery();
				}

			}
			catch
			{
				return false;
			}
			finally
			{
				try
				{
					r.Close();
				}
				catch{}
			}
			return true;
		}

		private string GetPatientAttachmentPath(string CprID, SqlConnection con)
		{
			SqlCommand cmd = new SqlCommand();
			SqlDataReader r = null;
			cmd.Connection = con;

			// Get p_Patient row
			cmd.CommandText = "SELECT * FROM p_Patient WITH (NOLOCK) WHERE p_Patient.cpr_id = '"+CprID+"'";
			r = cmd.ExecuteReader();
			r.Read();

			// Get attachment_location_id
			int attchLocID = (int) r["attachment_location_id"];

			// Get attachment_path
			string attchPath = r["attachment_path"].ToString();

			r.Close();

			// Get c_Attachment_Location row
			cmd.CommandText = "SELECT * FROM c_Attachment_Location WITH (NOLOCK) WHERE attachment_location_id = "+attchLocID.ToString();
			r = cmd.ExecuteReader();
			r.Read();

			// Get attachment_server
			string attchServer = r["attachment_server"].ToString();

			// Get attachment_share
			string attchShare = r["attachment_share"].ToString();

			r.Close();

			// Build and return patient attachment path
			string rval = "\\\\"+attchServer+"\\"+attchShare;
			rval = Path.Combine(rval,attchPath);

			return rval;
		}

		private bool AttachmentHasEdits(int AttachmentID, SqlConnection con)
		{
			SqlCommand cmd = new SqlCommand();
			cmd.Connection = con;

			// Check for UPDATE records in p_Attachment_Progress
			cmd.CommandText = "SELECT COUNT(*) FROM p_Attachment_Progress WITH (NOLOCK) WHERE progress_type = 'UPDATE' "+
				"AND attachment_id = "+AttachmentID;

			return ( ( (int) cmd.ExecuteScalar() ) > 0 );
		}

		private byte[] GetAttachment(int AttachmentID, SqlConnection con)
		{
			SqlCommand cmd = new SqlCommand();
			byte[] data = null;
			cmd.Connection = con;

			if( AttachmentHasEdits(AttachmentID, con) )
			{
				int latestSeq = -1;
				cmd.CommandText = "SELECT MAX(attachment_progress_sequence) FROM p_Attachment_Progress WITH (NOLOCK) "+
					"WHERE progress_type = 'UPDATE' AND attachment_id = "+AttachmentID;
				latestSeq = (int) cmd.ExecuteScalar();
				return GetAttachment(AttachmentID, latestSeq, con);
			}
			int retryCount = 0;
			READDATA:
				cmd.CommandText = "SELECT attachment_image FROM p_Attachment WITH (NOLOCK) WHERE attachment_image IS NOT NULL AND attachment_id = "+AttachmentID;
			SqlDataReader r = cmd.ExecuteReader(CommandBehavior.SequentialAccess);
			try
			{
				r.Read();
				try
				{
					data = r.GetSqlBinary(0).Value;
				}
				catch
				{
					return null;
				}
				finally
				{
					r.Close();
				}
				return data;
			}
			catch(SqlException sexc)
			{
				Thread.Sleep(5000);
				retryCount++;
				if(retryCount<20)
					goto READDATA;
			}
			finally
			{
				try
				{
					r.Close();
				}
				catch{}
			}
			return data;
		}
		private byte[] GetAttachment(int AttachmentID, int AttachmentProgressSequence, SqlConnection con)
		{
			SqlCommand cmd = new SqlCommand();
			byte[] data = null;
			cmd.Connection = con;
			int retryCount = 0;
			READDATA:
				cmd.CommandText = "SELECT attachment_image FROM p_Attachment_Progress WITH (NOLOCK) WHERE attachment_image IS NOT NULL "+
					"AND attachment_id = "+AttachmentID+" AND attachment_progress_sequence = "+AttachmentProgressSequence;
			SqlDataReader r = cmd.ExecuteReader(CommandBehavior.SequentialAccess);
			try
			{
				r.Read();
				try
				{
					data = r.GetSqlBinary(0).Value;
				}
				catch
				{
					return null;
				}
				finally
				{
					r.Close();
				}
				return data;
			}
			catch(SqlException sexc)
			{
				Thread.Sleep(5000);
				retryCount++;
				if(retryCount<20)
					goto READDATA;
			}
			finally
			{
				try
				{
					r.Close();
				}
				catch{}
			}
			return data;
		}
		
		private string GetUniqueFileName(string DirName, string FileName)
		{
			if(!File.Exists(Path.Combine(DirName,FileName)))
				return FileName;
			
			int ordinal = 1;
			while(File.Exists(Path.Combine(DirName,Path.GetFileNameWithoutExtension(FileName)+"_"+ordinal.ToString()+"."+Path.GetExtension(FileName).Replace(".",""))))
				ordinal++;

			return Path.GetFileNameWithoutExtension(FileName)+"_"+ordinal.ToString()+"."+Path.GetExtension(FileName).Replace(".","");
		}
		private void UpdateAttachmentFileName(int AttachmentID, string FileName, SqlConnection con)
		{
			SqlCommand cmd = new SqlCommand();
			cmd.Connection = con;

			cmd.CommandText = "UPDATE p_Attachment SET attachment_file = '"+Path.GetFileNameWithoutExtension(FileName)+"' WHERE attachment_id = "+AttachmentID.ToString();
			cmd.ExecuteNonQuery();
		}
		#endregion

		public byte[] ConvertHexToBinary(string hex_text)
		{
			try
			{
				return InternalMethods.HexStringToBytes(hex_text);
			}
			catch(Exception exc)
			{
				LogInternalEvent(exc,4);
				throw exc;
			}
		}

		public string ConvertBinaryToHex(byte[] binary)
		{
			try
			{
				return InternalMethods.BytesToHexString(binary);
			}
			catch(Exception exc)
			{
				LogInternalEvent(exc,4);
				throw exc;
			}
		}

		public int BytesToFile(string filename, byte[] data)
		{
			FileStream stream = null;
			try
			{
				try
				{
					if(!Directory.Exists(Path.GetDirectoryName(filename)))
						Directory.CreateDirectory(Path.GetDirectoryName(filename));
				}
				catch(Exception exc1)
				{
					LogEvent(exc1.Source, "BytesToFile(string, object)",exc1.ToString(),3);
				}
				stream = new FileStream(filename,FileMode.CreateNew,FileAccess.ReadWrite,FileShare.None);
				stream.Write((byte[])data,0,((byte[])data).Length);
				stream.Flush();
				stream.Close();
				return 1;
			}
			catch(Exception exc)
			{
				try
				{
					stream.Close();
				}
				catch{}
				LogEvent(exc.Source, "BytesToFile(string, object)",exc.ToString(),4);
				return -1;
			}
		}

		public byte[] FileToBytes(string filename)
		{
			byte[] data = null;
			FileStream stream = null;
			int buffersize=500;
			long buffercount=0;
			int remainder=0;
			int currentpos=0;
			try
			{
				stream=File.OpenRead(filename);
				
				buffercount=stream.Length/buffersize;
				remainder=(int)(stream.Length%buffersize);

				data = new byte[stream.Length];
				
				stream.Read((byte[])data,currentpos,remainder);
				currentpos+=remainder;

				while(buffercount>0)
				{
					stream.Read((byte[])data,currentpos,buffersize);
					currentpos+=buffersize;
					buffercount--;
				}

				stream.Close();
				
				return data;
			}
			catch(Exception exc)
			{
				LogEvent(exc.Source,"FileToBytes(string, ref object)",exc.ToString(),4);
				return new byte[]{};
			}
		}

		public int GetMainWindowHandle(int PID)
		{
			int rval = 0;
			try
			{
				rval= System.Diagnostics.Process.GetProcessById(PID).MainWindowHandle.ToInt32();
			}
			catch(Exception exc)
			{
				LogEvent(exc.Source,"GetMainWindowHandle(int)",exc.ToString(),4);
				return -1;
			}
			return rval;
		}
		public bool CloseMainWindow(int PID, int timeout)
		{
			int timer=0;
			int sleeptime = 500;
			System.Diagnostics.Process p=null;
			bool rval;
			try
			{
				p = System.Diagnostics.Process.GetProcessById(PID);
				rval = p.CloseMainWindow();
				if(!rval)
				{
					return rval;
				}
				else
				{
					while(timer<timeout && !p.HasExited)
					{
						System.Threading.Thread.Sleep(sleeptime);
						timer+=sleeptime;
					}
					if(p.HasExited)
					{
						return true;
					}
					else
					{
						return false;
					}
				}
			}
			catch(Exception exc)
			{
				LogEvent(exc.Source,"CloseMainWindow(int, int)", exc.ToString(),4);
				return false;
			}
		}
		public string TransformXML(string xml, string xsl)
		{
			System.IO.StringReader stringReader = null;
			System.Xml.Xsl.XslTransform xslTransform = null;
			System.Xml.XmlTextReader xmlTextReader = null;
			System.IO.MemoryStream xmlTextWriterStream = null;
			System.Xml.XmlTextWriter xmlTextWriter = null;
			System.Xml.XmlDocument xmlDocument = null;
			System.IO.StreamReader streamReader = null;
			System.Security.Policy.Evidence evidence = null;
			try
			{
				stringReader = new System.IO.StringReader(xsl);
				xslTransform = new System.Xml.Xsl.XslTransform();
				xmlTextReader = new System.Xml.XmlTextReader(stringReader);
				xmlTextWriterStream = new System.IO.MemoryStream();
				xmlTextWriter = new System.Xml.XmlTextWriter(xmlTextWriterStream, System.Text.Encoding.Default);
				xmlDocument = new System.Xml.XmlDocument();

				evidence =  new System.Security.Policy.Evidence();
				evidence.AddAssembly(this);
				xmlDocument.LoadXml(xml);
				xslTransform.Load(xmlTextReader,null, evidence);
				xslTransform.Transform(xmlDocument,null,xmlTextWriter, null);
				xmlTextWriter.Flush();

				xmlTextWriterStream.Position=0;
				streamReader = new System.IO.StreamReader(xmlTextWriterStream);
				return streamReader.ReadToEnd();
			}
			catch(Exception exc)
			{
				LogEvent(exc.Source, "TransformXML()", exc.ToString(), 4);
				return "";
			}
			finally
			{
				streamReader.Close();
				xmlTextWriter.Close();
				xmlTextWriterStream.Close();
				xmlTextReader.Close();
				stringReader.Close();
				GC.Collect();
			}
		}
		public int CopyFTPToUNC(string source, string user, string pwd, string dest, bool showProgress)
		{
			FTPClient ftpClient = null;
			Uri uri = null;
			try
			{
				if(showProgress)
				{
					ProgressBars.fSingleProgressBar.ShowProgressScreen();
					ProgressBars.fSingleProgressBar.ProgressForm.Description="Copying Files...";
				}
				uri = new Uri(source);
				ftpClient = new FTPClient(uri.Host);

				if(showProgress)
				{
					ProgressBars.fSingleProgressBar.SetProgress(0);
					ProgressBars.fSingleProgressBar.SetStatus("Connecting to FTP...");
				}
				ftpClient.Login(user,pwd);

				ftpClient.TransferType=FTPTransferType.BINARY;

				string[] segs = uri.Segments;
				for(int i=1; i<segs.Length-1; i++)
				{
					ftpClient.Chdir(segs[i]);
				}
				try
				{
					ftpClient.Chdir(segs[segs.Length-1]);
				}
				catch
				{
					//The last segment does not represent a folder
					if(Directory.Exists(dest))
					{
						//Destination is an existing folder.  Copy file with same name
						if(showProgress)
						{
							ProgressBars.fSingleProgressBar.SetProgress(100);
							ProgressBars.fSingleProgressBar.SetStatus("Copying "+segs[segs.Length-1]+"...");
						}
						ftpClient.Get(Path.Combine(dest,segs[segs.Length-1]),segs[segs.Length-1]);
						return 1;
					}
					else if(dest[dest.Length-1]==Path.DirectorySeparatorChar)
					{
						//Destination ends in DirSepChar.  Destination represents a directory.
						Directory.CreateDirectory(dest);
						if(showProgress)
						{
							ProgressBars.fSingleProgressBar.SetProgress(100);
							ProgressBars.fSingleProgressBar.SetStatus("Copying "+segs[segs.Length-1]+"...");
						}
						ftpClient.Get(Path.Combine(dest,segs[segs.Length-1]),segs[segs.Length-1]);
						return 1;
					}
					else
					{
						//Assume destination is a filename.
						Directory.CreateDirectory(dest.Substring(0,dest.LastIndexOf(Path.DirectorySeparatorChar.ToString())));
						if(showProgress)
						{
							ProgressBars.fSingleProgressBar.SetProgress(100);
							ProgressBars.fSingleProgressBar.SetStatus("Copying "+segs[segs.Length-1]+"...");
						}
						ftpClient.Get(dest,segs[segs.Length-1]);
						return 1;
					}
				}
				//The last segment represents a folder
				Directory.CreateDirectory(dest);
				int fileCount=0;
				string[] files = ftpClient.Dir("*.*");
				fileCount=files.Length;
				for(int i=0; i<fileCount; i++)
				{
					if(showProgress)
					{
						ProgressBars.fSingleProgressBar.SetProgress((i+1)*100/fileCount);
						ProgressBars.fSingleProgressBar.SetStatus("Copying "+files[i]+"...");
					}
					ftpClient.Get(Path.Combine(dest,files[i]),files[i]);
				}
				return 1;
			}
			catch(Exception exc)
			{
				LogEvent(exc.Source, "CopyFTPToUNC()", exc.ToString(), 4);
				return -1;
			}
			finally
			{
				try
				{
					ftpClient.Quit();
				}
				catch{}
				try
				{
					ProgressBars.fSingleProgressBar.CloseForm();
				}
				catch{}
				GC.Collect();
			}
		}
		public string EncryptString(string value, string keyString)
		{
			try
			{
				byte[] resultBA=new byte[value.Length], valueBA=new byte[value.Length];
				byte[] iv = new byte[]{0x14, 0xD7, 0x5B, 0xA2, 0x47, 0x83, 0x0F, 0xC4};
				System.Text.ASCIIEncoding ascEncoding = new System.Text.ASCIIEncoding();
				byte[] key = new byte[24];
				ascEncoding.GetBytes(keyString,0,keyString.Length<24?keyString.Length:24,key,0);
			
				MemoryStream memStream = new MemoryStream();
				byte[] tempBA = new byte[value.Length];
				ascEncoding.GetBytes(value,0,value.Length,tempBA,0);
				System.Security.Cryptography.CryptoStream cStream = new System.Security.Cryptography.CryptoStream(memStream,System.Security.Cryptography.TripleDESCryptoServiceProvider.Create().CreateEncryptor(key,iv),System.Security.Cryptography.CryptoStreamMode.Write);
				cStream.Write(tempBA,0,tempBA.Length);
				cStream.FlushFinalBlock();
				resultBA = memStream.ToArray();
				cStream.Close();

			
				return InternalMethods.BytesToHexString(resultBA);
			}
			catch(Exception exc)
			{
				LogEvent(exc.Source, "EncryptString()", exc.ToString(), 4);
				return "";
			}
			
		}
		public string DecryptString(string value, string keyString)
		{
			try
			{

				byte[] resultBA=new byte[value.Length/2], valueBA=new byte[value.Length/2];
				byte[] iv = new byte[]{0x14, 0xD7, 0x5B, 0xA2, 0x47, 0x83, 0x0F, 0xC4};
				System.Text.ASCIIEncoding ascEncoding = new System.Text.ASCIIEncoding();
				byte[] key = new byte[24];
				ascEncoding.GetBytes(keyString,0,keyString.Length<24?keyString.Length:24,key,0);

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
				LogEvent(exc.Source, "DecryptString()", exc.ToString(), 4);
				return "";
			}
		}
		public SqlConnection GetNewConnection(string Server, string Database, string AppRolePwd)
		{
			SqlConnection con = new SqlConnection("Server="+Server+";Database="+Database+";Integrated Security=SSPI;Pooling=FALSE");
			con.Open();
			SqlCommand cmd = new SqlCommand("exec sp_SetAppRole 'cprsystem', '"+AppRolePwd+"'",con);
			cmd.ExecuteNonQuery();
			return con;
		}

		// Uses Secure SSL SOAP Gateway
		public string PutJMJMessage(string JMJMessage, string User, string Password)
		{
			EproLibNET.com.jmjtech.www.IntegrationService IS = null;
			try
			{
				IS =  new EproLibNET.com.jmjtech.www.IntegrationService();
				IS.Credentials = new System.Net.NetworkCredential("WWWSERVER\\"+User,Password);
				IS.PreAuthenticate=true;				

				return IS.PutMessage(JMJMessage);
			}
			catch(Exception exc)
			{
				LogInternalEvent(exc,4);
				throw exc;
			}
			finally
			{
				IS.Dispose();
			}
		}

		// Not Secure
		public void SendDocument(string Document)
		{
			JMJIntegrationService.IntegrationService intSvc = null;
			try
			{
				intSvc = new EproLibNET.JMJIntegrationService.IntegrationService();
				intSvc.Timeout=900000;
				intSvc.PutJMJMessage(Document);
			}
			catch(Exception exc)
			{
				LogEvent(exc.Source, "SendDocument()",exc.ToString(),4);
			}
			finally
			{
				try
				{
					intSvc.Dispose();
				}
				catch{}
				intSvc = null;
			}
		}
		public string PutHTTPRequest(string Address, ICredentials Credentials, IDictionary Variables)
		{
			WebClient client = new WebClient();
			if(Credentials!=null)
				client.Credentials = Credentials;

			try
			{
				foreach(DictionaryEntry entry in Variables)
				{
					client.QueryString.Add(entry.Key.ToString(), entry.Value.ToString());
				}
				StreamReader sr = new StreamReader(client.OpenRead(Address));
				string response = sr.ReadToEnd();
				return response;
			}
			catch(Exception exc)
			{
				LogInternalEvent(new Exception("Error in HTTP Request",exc),4);
				throw exc;
			}
			finally
			{
				client.Dispose();
			}
		}
		public string PutHTTPForm(string Address, ICredentials Credentials, IDictionary Variables)
		{
			WebClient client = new WebClient ();
			if (Credentials != null)
			{
				client.Credentials = Credentials;
			}
			string uploadString = "";
			string response = "";
			IDictionaryEnumerator myEnumerator = Variables.GetEnumerator();
			int count = 0;
			while (myEnumerator.MoveNext())
			{
				if (count > 0) /* then */ uploadString += "&";
				else count ++;
				uploadString += myEnumerator.Key;
				uploadString += "=" + myEnumerator.Value;
			}
			try	
			{
				//Console.WriteLine("uploadString = " + uploadString);
				byte[] byteArray = Encoding.UTF8.GetBytes(uploadString);
				byte [] responseArray = client.UploadData(Address,"POST", byteArray);
				response = Encoding.ASCII.GetString(responseArray);
				return response;
			}
			catch (Exception exc)
			{
				LogInternalEvent(exc,4);
				throw exc;
			}
			finally
			{
				client.Dispose();
			}
		}
		internal static string GetFromResources(string resourceName)
		{  
			System.Reflection.Assembly assem = System.Reflection.Assembly.GetExecutingAssembly();
			using( Stream stream = assem.GetManifestResourceStream(resourceName) )   
			{
				try      
				{ 
					using( StreamReader reader = new StreamReader(stream) )         
					{
						return reader.ReadToEnd();         
					}
				}     
				catch(Exception e)      
				{
					throw new Exception("Error retrieving from Resources. Tried '" 
						+ resourceName+"'\r\n"+e.ToString());      
				}
			}
		}
	}
}
