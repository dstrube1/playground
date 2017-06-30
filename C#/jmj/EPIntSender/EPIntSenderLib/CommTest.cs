using System;

namespace EPIntSenderLib
{
	/// <summary>
	/// Summary description for CommTest.
	/// </summary>
	public class CommTest:BaseComm
	{
		public CommTest():base()
		{
		}
		protected override void send()
		{
			Message[] Messages = GetMessagesFromDB(0);
			foreach(Message message in Messages)
				Event.LogEvent(message.ID.ToString()+Environment.NewLine+message.MessageType+Environment.NewLine+message.MessageBody,System.Diagnostics.EventLogEntryType.Information);

			SetMessageStatus(Messages,MessageStatus.SENT);
			SetMessageStatus(Messages,MessageStatus.COMPLETE);
		}

	}
}
