using System;
using System.Diagnostics;
using System.Data;
using System.Data.SqlClient;

namespace EPIntSenderLib
{
	public enum MessageStatus
	{
		READY,
		RETRIEVED,
		SENT,
		COMPLETE,
		ERROR,
		RETURN,
		DEBUG
	}
	/// <summary>
	/// Summary description for Event.
	/// </summary>
	public class Event
	{
		private static Event sEvent = null;
		protected BaseDataSource db;

		private Event()
		{
		}

		public static void Initialize(string Server, string Database, string User, string Password, bool IntegratedSecurity)
		{
			sEvent = new Event();
			sEvent.db = new BaseDataSource(Server,Database,IntegratedSecurity,User,Password);
			sEvent.db.ConnectionObject.Close();
		}

		public static void LogStatus(string MessageID, string Key, string Info)
		{
			try
			{
				sEvent.db.ConnectionObject.Open();
				SqlCommand cmd = new SqlCommand("EXEC msg_log_message_status @ps_MessageID=@id, "+
					"@ps_key=@key, @ps_info=@info", sEvent.db.ConnectionObject);
				cmd.Parameters.Add("@id",MessageID);
				cmd.Parameters.Add("@key", Key);
				cmd.Parameters.Add("@info", Info);
            
				cmd.ExecuteNonQuery();
			}
			finally
			{
				sEvent.db.ConnectionObject.Close();
			}
		}
		public static void LogStatus(string MessageID, MessageStatus Status, string Message)
		{
			try
			{
				sEvent.db.ConnectionObject.Open();
				SqlCommand cmd = new SqlCommand("EXEC msg_log_message_status @ps_MessageID=@id, "+
					"@ps_status=@status, @ps_message=@msg", sEvent.db.ConnectionObject);
				cmd.Parameters.Add("@id",MessageID);
				cmd.Parameters.Add("@status", Status.ToString());
				cmd.Parameters.Add("@msg", Message);

				cmd.ExecuteNonQuery();
			}
			finally
			{
				sEvent.db.ConnectionObject.Close();
			}
		}
		public static void LogStatus(string MessageID, System.Collections.Specialized.NameValueCollection Info)
		{
			try
			{
				sEvent.db.ConnectionObject.Open();
				SqlCommand cmd = new SqlCommand("EXEC msg_log_message_status @ps_MessageID=@id, "+
					"@ps_key=@key, @ps_info=@info", sEvent.db.ConnectionObject);
				cmd.Parameters.Add("@id",MessageID);

				foreach(System.Collections.DictionaryEntry entry in Info)
				{
					cmd.Parameters.Add("@key", entry.Key.ToString());
					cmd.Parameters.Add("@info", entry.Value.ToString());

					cmd.ExecuteNonQuery();
				}
			}
			finally
			{
				sEvent.db.ConnectionObject.Close();
			}
		}

		public static void LogEvent(string Message, EventLogEntryType Severity, int EventID)
		{
			EventLog.WriteEntry("EPIntSender", Message, Severity, EventID);
		}
		public static void LogEvent(string Message, EventLogEntryType Severity)
		{
			LogEvent(Message, Severity, 0);
		}
		public static void LogInformation(string Message)
		{
			LogEvent(Message, EventLogEntryType.Information);
		}
		public static void LogError(string Message)
		{
			LogEvent(Message, EventLogEntryType.Error);
		}
	}
}
