using System;
using System.Data;
using System.Xml;


namespace EPIntSenderLib
{
	public enum MessageStatusEnum
	{
		Error =-1,
		NoChange=0,
		Success=1
	}
	/// <summary>
	/// This class holds a Message and related information.
	/// </summary>
	public class Message
	{
		public Guid ID;
		public string MessageBody=null;
		public string MessageEncoding = null;
		public string MessageType=null;
		public string FromAddresseeID=null;
		public string ToAddresseeID=null;
		public string OwnerID=null;


		/// <summary>
		/// Message Constructor
		/// </summary>
		/// <param name="ID">The ID associated with this message from the
		/// Integration.Message table</param>
		/// <param name="MessageBody">The body of the message</param>
		/// <param name="MessageType">The MessageType from Integration.Message</param>
		public Message (Guid ID, string MessageBody, string MessageEncoding, string MessageType, string FromAddresseeID, string ToAddresseeID, string OwnerID)
		{
			this.ID=ID;
			this.MessageBody=MessageBody;
			this.MessageEncoding=MessageEncoding;
			this.MessageType=MessageType;
			this.FromAddresseeID=FromAddresseeID;
			this.ToAddresseeID=ToAddresseeID;
			this.OwnerID=OwnerID;
		}
	}

	/// <summary>
	/// Base class for all communication components.
	/// </summary>
	public abstract class BaseComm
	{
		/// <summary>
		/// The info Dictionary holds attributes from the pertinent Integration.m_addressee
		/// row.
		/// </summary>
		protected System.Collections.Specialized.HybridDictionary info = new System.Collections.Specialized.HybridDictionary(6,false);
		/// <summary>
		/// The db BaseDataSource allows easy access to the Integration DB.
		/// </summary>
		protected BaseDataSource db;
		/// <summary>
		/// debug determines whether to post informational messages to the EventLog
		/// </summary>
		protected bool debug=false;

		// Database connection information
		private string server=null,database=null,user=null,password=null;
		private bool integratedSecurity=true;

		/// <summary>
		/// BaseComm constructor
		/// </summary>
		public BaseComm()
		{
		}

		/// <summary>
		/// Method called by SvcManager to provide necessary information to BaseComm
		/// </summary>
		/// <param name="Info">Dictionary of attributes from Addressee row</param>
		/// <param name="Server">Integration server name</param>
		/// <param name="Database">Integration database name</param>
		/// <param name="User">Integration user name</param>
		/// <param name="Password">Integration user password</param>
		/// <param name="IntegratedSecurity">Uses Windows authentication if true</param>
		/// <param name="Debug">If true, BaseComm will post informational 
		/// messages to the EventLog.</param>
		public void SetInfo(System.Collections.Specialized.HybridDictionary Info, string Server, string Database, string User, string Password, bool IntegratedSecurity, bool Debug)
		{
			info = Info;

			server=Server;
			database=Database;
			user=User;
			password=Password;
			integratedSecurity=IntegratedSecurity;
			debug=Debug;
		}

		/// <summary>
		/// Public entry point for sending messages
		/// </summary>
		public void Send()
		{
			try
			{
				if(debug)
				{
					System.Diagnostics.StackTrace st = new System.Diagnostics.StackTrace();
					string className = this.GetType().FullName;
					string methodName = st.GetFrame(0).GetMethod().Name;
					Event.LogInformation("Running Method: "+className+"."+methodName);
				}

				db = new BaseDataSource(server,database,integratedSecurity,user,password);
				send();
				db.ConnectionObject.Close();
				db=null;
			}
			catch(Exception exc)
			{
				string error=string.Empty;
				foreach(System.Collections.DictionaryEntry entry in info)
				{
					error+=entry.Key.ToString();
					error+=" = ";
					error+=entry.Value.ToString();
					error+=Environment.NewLine;
				}
				Event.LogError(error+exc.ToString());
			}
			finally
			{
				try
				{
					db.ConnectionObject.Close();
					db=null;
				}
				catch
				{
				}
			}
		}

		/// <summary>
		/// Public entry point for receiving messages
		/// </summary>
		public void Recv()
		{
			try
			{
				if(debug)
				{
					System.Diagnostics.StackTrace st = new System.Diagnostics.StackTrace();
					string className = this.GetType().FullName;
					string methodName = st.GetFrame(0).GetMethod().Name;
					Event.LogInformation("Running Method: "+className+"."+methodName);
				}

				db = new BaseDataSource(server,database,integratedSecurity,user,password);
				recv();
				db.ConnectionObject.Close();
				db=null;
			}
			catch(Exception exc)
			{
				string error=string.Empty;
				foreach(System.Collections.DictionaryEntry entry in info)
				{
					error+=entry.Key.ToString();
					error+=" = ";
					error+=entry.Value.ToString();
					error+=Environment.NewLine;
				}
				Event.LogError(error+exc.ToString());
			}
			finally
			{
				try
				{
					db.ConnectionObject.Close();
					db=null;
				}
				catch
				{
				}
			}
		}

		/// <summary>
		/// This is the main method for sending messages.  This method must be 
		/// overridden to provide any functionality.
		/// </summary>
		protected virtual void send()
		{
			System.Diagnostics.StackTrace st = new System.Diagnostics.StackTrace();
			string className = st.GetFrame(0).GetType().Name;
			string methodName = st.GetFrame(0).GetMethod().Name;
			throw new NotImplementedException("Method "+methodName+" in class "+className+" has not been implemented.");
		}

		/// <summary>
		/// This is the main method for receiving messages.  This method must be
		/// overridden to provide any functionality.
		/// </summary>
		protected virtual void recv()
		{
			System.Diagnostics.StackTrace st = new System.Diagnostics.StackTrace();
			string className = st.GetFrame(0).GetType().Name;
			string methodName = st.GetFrame(0).GetMethod().Name;
			throw new NotImplementedException("Method "+methodName+" in class "+className+" has not been implemented.");
		}

		/// <summary>
		/// Gets count of messages waiting for delivery
		/// </summary>
		/// <returns>Message count as int</returns>
		protected int GetMessagesCount()
		{
			// Retrieve COUNT(*) 'READY' messages 
			int count = (int)db.ExecuteScalar("SELECT COUNT(*) FROM m_Message WHERE ToAddresseeId='"+info["addressee_id"].ToString()+
				"' AND status='READY'");

			return count;
		}

		/// <summary>
		/// This method retrieves messages from the Integration database marked 'READY'.
		/// </summary>
		/// <param name="count">Specifies the maximum number of results to return.
		/// To get all available messages, pass 0.</param>
		/// <returns>Messages retrieved from Integration database.</returns>
		protected Message[] GetMessagesFromDB(int count)
		{
			string countString = "TOP "+count.ToString();
			Guid myGuid;			//having these 3 variables
			string myMessage;		//makes debugging
			string myMessageType;	//much easier
			string myMessageEncoding;
			string fromAddresseeId=null;
			string toAddresseeId=null;
			if(count<1)
				countString=string.Empty;

			// Retrieve TOP <count> 'READY' messages 
			DataSet dsMessages = db.FillData("SELECT "+countString+" * FROM m_Message WHERE ToAddresseeId='"+info["addressee_id"].ToString()+
				"' AND status='READY'", "Message");
			
			// Instantiate and fill Message array with results of SQL SELECT
			Message[] ret = new Message[dsMessages.Tables[0].Rows.Count];
			for(int i=0; i<ret.Length; i++)
			{
				DataRow row = dsMessages.Tables[0].Rows[i];
				myGuid=new Guid(row["MessageID"].ToString());
				myMessage = row["Message"].ToString();
				myMessageType = row["FromDocumentType"].ToString();
				myMessageEncoding = row["Encoding"].ToString();
				if(!row.IsNull(dsMessages.Tables[0].Columns.IndexOf("FromAddresseeID")))
					fromAddresseeId = row["FromAddresseeID"].ToString();
				if(!row.IsNull(dsMessages.Tables[0].Columns.IndexOf("ToAddresseeID")))
					toAddresseeId = row["ToAddresseeID"].ToString();
				ret[i] = new Message(myGuid,myMessage,myMessageEncoding,myMessageType,fromAddresseeId,toAddresseeId,row["OwnerID"].ToString());
			}

			// Set status to 'RETRIEVED' for all messages returned by this method.
			SetMessageStatus(ret, MessageStatus.RETRIEVED);
			return ret;
		}

		/// <summary>
		/// Use this method to set the status of messages in the Integration DB.
		/// </summary>
		/// <param name="Messages">Array of Message objects to change status for</param>
		/// <param name="Status">New status string</param>
		protected void SetMessageStatus(Message[] Messages, MessageStatus Status)
		{
			// Loop through all Message objects in Messages and update the status
			// of each message in the Integration.Messages table
			foreach(Message msg in Messages)
			{
				if(debug)
					Event.LogInformation("Setting message status to "+Status.ToString()+
						Environment.NewLine+"MessageID = "+msg.ID.ToString());

				Event.LogStatus(msg.ID.ToString(),Status,msg.MessageBody);
			}
		}
		protected void SetMessageStatus(Message Message, MessageStatus Status){
			Message[] sendMessage = new Message[1];
			sendMessage[0]=Message;
			SetMessageStatus(sendMessage, Status);
		}
		/// <summary>
		/// Accepts input parameters and wraps a message in a JMJMessage XML document
		/// </summary>
		/// <param name="Message">Message to wrap</param>
		/// <param name="FromAddrID">From AddresseeID</param>
		/// <param name="ToAddrID">To AddresseeID (must have this or To SenderRecipientID)</param>
		/// <param name="SenderRecipientID">To SenderRecipientID (must have this or To AddresseeID</param>
		/// <param name="SenderMessageID">Sender's unique identifier for this message</param>
		/// <param name="OwnerID">ID of the owner of this information</param>
		/// <param name="DocumentType">DocumentType for the message payload</param>
		/// <returns>JMJMessage XML Document</returns>
		protected string WrapInJMJMessage(string Message, string FromAddrID, string ToAddrID, string SenderRecipientID, string SenderMessageID, string OwnerID, string DocumentType, string Description)
		{
			if(ToAddrID==null && SenderRecipientID==null)
				throw new Exception("Must provide ToAddresseeID or SenderRecipientID");

			System.IO.MemoryStream ms = new System.IO.MemoryStream();
			XmlTextWriter tw = new XmlTextWriter(ms, System.Text.Encoding.UTF8);

			tw.WriteStartDocument();
			tw.WriteStartElement("JMJMessage");
			tw.WriteStartElement("From");
			tw.WriteElementString("AddresseeID",FromAddrID);
			tw.WriteEndElement();
			tw.WriteStartElement("To");
			if(ToAddrID!=null)
				tw.WriteElementString("AddresseeID",ToAddrID);
			if(SenderRecipientID!=null)
				tw.WriteElementString("SenderRecipientID",SenderRecipientID);
			tw.WriteEndElement();
			tw.WriteElementString("SenderMessageID",SenderMessageID);
			tw.WriteElementString("OwnerID",OwnerID);
			tw.WriteElementString("DocumentType",DocumentType);
			if(Description!=null)
				tw.WriteElementString("Description", Description);
			tw.WriteElementString("Payload",Message);
			tw.WriteEndElement();
			tw.WriteEndDocument();
			tw.Flush();

			ms.Position=0;

			System.IO.StreamReader sr = new System.IO.StreamReader(ms,System.Text.Encoding.UTF8);
			string ret = sr.ReadToEnd();
			sr.Close();

			return ret;
		}

		/// <summary>
		/// Uploads JMJMessage to IntegrationSecure
		/// </summary>
		/// <param name="JMJMessage"></param>
		/// <returns>Status XML</returns>
		protected string PutJMJMessage(string JMJMessage)
		{
			com.jmjtech.www.Service IS = new EPIntSenderLib.com.jmjtech.www.Service();
			//IS.Credentials = new System.Net.NetworkCredential("IntSender","!!53nder","WWWSERVER");
			//IS.PreAuthenticate=true;
			com.jmjtech.www.CredentialsHeader credentials = new EPIntSenderLib.com.jmjtech.www.CredentialsHeader();
			credentials.User = "EpIESender";
			credentials.Password = "FI:evnkw@$22Fd105";
			IS.CredentialsHeaderValue = credentials;
			string ret = IS.PutMessage(JMJMessage);
			IS.Dispose();

			return ret;
		}

		protected Message[] GetMessagesFromEpIEGateway(string DocumentType)
		{
			com.jmjtech.www.Service IS = new EPIntSenderLib.com.jmjtech.www.Service();
			//IS.Credentials = new System.Net.NetworkCredential("IntSender","!!53nder","WWWSERVER");
			//IS.PreAuthenticate=true;
			com.jmjtech.www.CredentialsHeader credentials = new EPIntSenderLib.com.jmjtech.www.CredentialsHeader();
			credentials.User = "EpIESender";
			credentials.Password = "FI:evnkw@$22Fd105";
			IS.CredentialsHeaderValue = credentials;
			string messageBag = IS.GetMessageBag(info["addressee_id"].ToString(), DocumentType);
			IS.Dispose();
			XmlDocument doc = new XmlDocument();
			doc.LoadXml(messageBag);
			System.Collections.ArrayList messages = new System.Collections.ArrayList();
			foreach(XmlElement message in doc.DocumentElement.ChildNodes)
			{
				if(message.Name!="JMJMessage")
					continue;
				Guid id = new Guid(message["JMJMessageID"].InnerText);
				string fromAddresseeId = message["From"]["AddresseeID"].InnerText;
				string toAddresseeId = message["To"]["AddresseeID"].InnerText;
				string ownerId = message["OwnerID"].InnerText;
				string messageType = message["DocumentType"].InnerText;
				string messageBody = message["Payload"].InnerText;
				string messageEnc = "UTF-8";
				if(message["Payload"].HasAttribute("Encoding"))
					messageEnc = message["Payload"].Attributes["Encoding"].Value;
				messages.Add(new Message(id, messageBody,messageEnc,messageType,fromAddresseeId,toAddresseeId,ownerId));
			}
			return (Message[])messages.ToArray(typeof(Message));
		}

		protected void Complete(string MessageID, MessageStatusEnum Status)
		{
			com.jmjtech.www.Service IS = new EPIntSenderLib.com.jmjtech.www.Service();
			//IS.Credentials = new System.Net.NetworkCredential("IntSender","!!53nder","WWWSERVER");
			//IS.PreAuthenticate=true;
			com.jmjtech.www.CredentialsHeader credentials = new EPIntSenderLib.com.jmjtech.www.CredentialsHeader();
			credentials.User = "EpIESender";
			credentials.Password = "FI:evnkw@$22Fd105";
			IS.CredentialsHeaderValue = credentials;
			IS.Complete(MessageID, (int)Status);
			IS.Dispose();
		}
	}
}
