using System;
using System.Runtime.InteropServices;
using System.IO;
using System.Diagnostics;
using System.Threading;
using System.Xml;

namespace EPImageViewer
{
	/// <summary>
	/// Summary description for Utilities.
	/// </summary>
	public class Utilities
	{
		private EventLog eventLog=null;
		private string epVersion="Ver. NA";

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
			//
			// TODO: Add constructor logic here
			//
		}

		public int InitializeEventLog(string source)
		{
			try
			{
				eventLog = new EventLog("Application", ".", source);
				return 1;
			}
			catch
			{
				return -1;
			}
		}
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
				message = exc.Message;
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

				eventLog.WriteEntry(Environment.UserDomainName+"\\"+Environment.UserName+" on "+Environment.MachineName+ "\r\n" + EPVersion + " >>> " + objectName+" - ("+scriptName+") "+message+Environment.NewLine+helpLink, eventSeverity);
				return 1;
			}
			catch
			{
				return -1;
			}
		}
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

				eventLog.WriteEntry(Environment.UserDomainName+"\\"+Environment.UserName+" on "+Environment.MachineName+ "\r\n" + EPVersion + " >>> " + objectName+" - ("+scriptName+") "+message, eventSeverity);
				return 1;
			}
			catch
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
			catch
			{
				return -1;
			}
		}
	}
}
