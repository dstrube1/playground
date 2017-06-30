using System;

namespace EPIntSenderLib
{
	/// <summary>
	/// Summary description for CommEPAgent.
	/// </summary>
	public class CommEPAgent : BaseComm
	{
		public CommEPAgent() : base()
		{
		}

		protected override void send()
		{
			Message[] messages = base.GetMessagesFromDB(0);
			if(messages.Length==0)
				return;
			BaseDataSource issues = new BaseDataSource("techserv\\sql2005","EPAgent","EPAgent","VK:#9 NV  kl;l j09-W md");
			try
			{
				foreach(Message message in messages)
				{
					if(message.MessageType!="XML.JMJ.EPAgent.Result")
					{
						Event.LogError("Invalid DocumentType: "+message.MessageType+Environment.NewLine+
							"DocumentType has to be XML.JMJ.EPAgent.Result");
						base.SetMessageStatus(message, MessageStatus.ERROR);
					}
					System.Xml.XmlDocument resultDoc = new System.Xml.XmlDocument();
					System.Data.SqlClient.SqlTransaction transaction = issues.ConnectionObject.BeginTransaction();
					
					try
					{
						resultDoc.LoadXml(message.MessageBody);
						foreach(System.Xml.XmlNode Node in resultDoc.DocumentElement.ChildNodes)
						{
							if(Node.Name!="Node")
								throw new Exception ("Invalid Format.  Unexpected Node: "+Node.Name);

							foreach(System.Xml.XmlNode Result in Node.ChildNodes)
							{
								if(Result.Name!="Result")
									continue;

								Guid newGuid = Guid.NewGuid();
								bool longValue=false;

								string insertCommand = "INSERT jmj_AgentResult (CustomerID, BranchID, NodeID, Name, Type, ResultTime";
								if(Result.InnerText.Length>128)
									longValue=true;
								if(longValue)
									insertCommand+=", LongValue";
								else
									insertCommand+=", Value";
								insertCommand+=") VALUES(@CustomerID, @BranchID, @NodeID, @Name, @Type, @ResultTime, @Value)";

								System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(insertCommand,issues.ConnectionObject, transaction);
								
								cmd.Parameters.Add("@CustomerID", System.Data.SqlDbType.Int);
								cmd.Parameters.Add("@BranchID", System.Data.SqlDbType.Int);
								cmd.Parameters.Add("@NodeID", System.Data.SqlDbType.Int);
								cmd.Parameters.Add("@Name", System.Data.SqlDbType.VarChar);
								cmd.Parameters.Add("@Type", System.Data.SqlDbType.VarChar);
								cmd.Parameters.Add("@ResultTime", System.Data.SqlDbType.DateTime);
								cmd.Parameters.Add("@Value", longValue?System.Data.SqlDbType.Text:System.Data.SqlDbType.VarChar);

								cmd.Parameters["@CustomerID"].Value=Int32.Parse(message.FromAddresseeID);
								cmd.Parameters["@BranchID"].Value=Int32.Parse(Node.Attributes["BranchID"].Value);
								cmd.Parameters["@NodeID"].Value=Int32.Parse(Node.Attributes["NodeID"].Value);
								cmd.Parameters["@Name"].Value=Node["Name"].InnerText;
								cmd.Parameters["@Type"].Value=Result["Type"].InnerText;
								cmd.Parameters["@ResultTime"].Value=System.Xml.XmlConvert.ToDateTime(Result.Attributes["Time"].Value);
								cmd.Parameters["@Value"].Value=Result["Value"].InnerText;

								cmd.ExecuteNonQuery();

//								int propCount=0;
//								foreach(System.Xml.XmlNode Property in Result.ChildNodes)
//								{
//									if(Property.Name!="Property")
//										continue;
//
//									bool longProperty=false;
//									propCount++;
//
//									string insertProperty = "INSERT jmj_AgentResultProperty (ResultID, Sequence, Property";
//									if(Property.InnerText.Length>128)
//										longProperty=true;
//									if(longProperty)
//										insertProperty+=", LongValue";
//									else
//										insertProperty+=", Value";
//									insertProperty+=") VALUES(@ResultID, @Sequence, @Property, @Value)";
//									System.Data.SqlClient.SqlCommand cmd2 = new System.Data.SqlClient.SqlCommand(insertProperty, issues.ConnectionObject, transaction);
//									cmd2.Parameters.Add("@ResultID", System.Data.SqlDbType.UniqueIdentifier);
//									cmd2.Parameters.Add("@Sequence", System.Data.SqlDbType.Int);
//									cmd2.Parameters.Add("@Property", System.Data.SqlDbType.VarChar);
//									cmd2.Parameters.Add("@Value", longProperty?System.Data.SqlDbType.Text:System.Data.SqlDbType.VarChar);
//									cmd2.Parameters["@ResultID"].Value=newGuid;
//									cmd2.Parameters["@Sequence"].Value=propCount;
//									cmd2.Parameters["@Property"].Value=Property.Attributes["Name"].Value;
//									cmd2.Parameters["@Value"].Value=Property.InnerText;
//									cmd2.ExecuteNonQuery();
//								}
							}
						}
					}
					catch(Exception exc)
					{
						Event.LogError("Error parsing EPAgent Result."+Environment.NewLine+ exc.ToString());
						base.SetMessageStatus(message,MessageStatus.ERROR);
						transaction.Rollback();
						transaction.Dispose();
						continue;
					}
					try
					{
						transaction.Commit();
						base.SetMessageStatus(message,MessageStatus.SENT);
						base.SetMessageStatus(message,MessageStatus.COMPLETE);
						transaction.Dispose();
					}
					catch(Exception exc)
					{
						Event.LogError("Error committing transaction."+Environment.NewLine+ exc.ToString());
						base.SetMessageStatus(message,MessageStatus.ERROR);
						transaction.Rollback();
						transaction.Dispose();
						continue;
					}
				}
			}
			finally
			{
				try
				{
					issues.ConnectionObject.Close();
				}
				catch{}
			}
		}

	}
}
