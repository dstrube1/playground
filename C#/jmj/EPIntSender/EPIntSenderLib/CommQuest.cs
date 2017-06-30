using System;
using System.IO;
using System.Net;

namespace EPIntSenderLib
{
	/// <summary>
	/// Receiving:
	/// This receives all the lab results messages from Quest thru Web Service Call.
	/// All the JMJ Quest Customers that are linked to JMJ HUB Account (see m_addressee_property) for 
	/// Quest are downloaded thru this web service call. 
	/// 
	/// <code>HUB user account and password</code>
	/// 
	/// Once the message is successfully uploaded to gateway it's then acknowledged back to quest.
	/// 
	/// Sending:
	/// Not yet implemented in this class.
	/// </summary>
	public class CommQuest:BaseComm
	{
		public CommQuest():base()
		{
		}

		protected override void recv()
		{
			//
			// Make a Webservice call to Medplus (quest) and get all the provider results
			// that are linked to a single JMJ Hub account. all the messages must be 
			// acknowledged otherwise it'll re-send the same results in future requests
			// 
			//

			string username=null, password=null,jmjMessage=null, retStatus=null, recipient=null;
			int icount = 0;
			
			// create a new instance of a quest results service
			QuestResultServices.ResultsService results_service = new QuestResultServices.ResultsService();

			// create local class to handle ack generation
			ResultAckGenerator my_result_ackgenerator = new ResultAckGenerator();

			//establish a trust relationship - JMJ HUB Account to Medplus
			if(!info.Contains("username"))
			{
				Event.LogError("Expected parameter \"username\" not found.  Cannot continue.");
				return;
			}

			if(!info.Contains("password"))
			{
				Event.LogError("Expected parameter \"password\" not found.  Cannot continue.");
				return;
			}

			username = info["username"].ToString();
			password = info["password"].ToString();

			results_service.Credentials = new NetworkCredential(username,password,"");

			// create a new instance of the request object where we can limit
			// - results return by given provider accounts only
			// - given date range
			// but we are requesting all providers and so we are not filling any of
			// these properties
			QuestResultServices.ResultsRequest result_request = new QuestResultServices.ResultsRequest();

	//		result_request.startDate = "1/12/2006";
	//		result_request.endDate="1/17/2006";
			// create an instance of the response object which is used to loop
			// thru the returned results
			QuestResultServices.HL7ResultsResponse hl7_results = new QuestResultServices.HL7ResultsResponse();

			try
			{
				hl7_results = results_service.getHL7Results(result_request);
				
				if (hl7_results.HL7Messages == null)
					return;
				foreach(QuestResultServices.HL7Message hl7_response in hl7_results.HL7Messages)
				{
					icount++;
					byte[] msg_bytes = hl7_response.message;
					string msg = System.Text.Encoding.UTF8.GetString(msg_bytes);

					if(debug)
						Event.LogInformation("Quest message#"+icount+" "+Environment.NewLine+msg);

					try
					{
						recipient = getRecipient(msg); 
						jmjMessage = this.WrapInJMJMessage(msg,info["addressee_id"].ToString(),null,recipient,null,info["addressee_id"].ToString(),info["documenttype"].ToString(),null);

						if(debug)
							Event.LogInformation("JMJMessage:"+Environment.NewLine+jmjMessage);

						retStatus = this.PutJMJMessage(jmjMessage);

						if(debug)
							Event.LogInformation("PutMessage return status:"+Environment.NewLine+retStatus);
                        
						// Check for success return
						System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
						doc.LoadXml(retStatus);

						System.Xml.XmlNodeList statusElements = doc.GetElementsByTagName("Status");
						if(statusElements.Count>0 && statusElements[0].InnerText.ToLower()=="success")
						{
							//						add acknowledged code
						}
						else
						{
							Event.LogError("PutMessage did not return success ."+Environment.NewLine+" Message: "+msg+Environment.NewLine+"Status:"+retStatus);
						}
					}
					catch(Exception exc)
					{
						Event.LogError("Error logging message "+Environment.NewLine+jmjMessage+Environment.NewLine+exc.ToString());
					}
				}
			}
			catch (System.Web.Services.Protocols.SoapHeaderException ex)
			{
				Event.LogError("Soap Exception caught on gethl7results call");
				Event.LogError(ex.Message);
				Event.LogError(ex.StackTrace);
			}
			catch (Exception ex)
			{
				Event.LogError("Soap Exception caught on gethl7results call");
				Event.LogError(ex.Message);
				return;
			}
			if (icount > 0)
			{
				// acknowledge all received results
				QuestResultServices.HL7Message[] hl7_ack_msgs = my_result_ackgenerator.GenerateHL7AckMessages(hl7_results);

				try
				{

					results_service.acknowledgeHL7Results(hl7_results.requestId,hl7_ack_msgs);
				}
				catch (System.Web.Services.Protocols.SoapHeaderException ex)
				{
					Event.LogError("Soap Exception caught on acknowledging results call");
					Event.LogError(ex.Message);
					Event.LogError(ex.StackTrace);
				}
				catch (Exception ex)
				{
					Event.LogError("Soap Exception caught on acknowledging results call");
					Event.LogError(ex.Message);
					return;
				}
			}
		}

		protected override void send()
		{
			base.send ();
		}

		private string getRecipient(string msg_string)
		{
			// there may be more than one quest account# linked to single JMJ customer

			//spilt string message into segments
			//get the quest account# from MSH.6
			string ls_recipient = null;
			string[] msg_segments = msg_string.Split('\r');

			// message header is in the first line
			string[] msh_fields = msg_segments[0].Split('|');

			// define msg parameters for format statment
			ls_recipient = msh_fields[5]; // receiving facility

			return ls_recipient;
	/*		
	 * this is now moved to a stored procedure and it takes care of look up (msg_new_message)
			try
			{
				// do the translation to get a customer#
				object ret = db.getEproCode(info["addressee_id"].ToString(),"quest_account",ls_recipient,"customer_id");
				rtn = ret.ToString();
			}
			catch (NullReferenceException)
			{
				Event.LogError("No mapping found in c_xml_code "+ls_recipient);
				rtn = null;
			}

			return rtn; */
		}
	}

	// Ack helper class
	public class ResultAckGenerator
	{
		// HL7 Ack msg template
		private const string ack_msg_format = "MSH|^~\\&|{0}|{1}|{2}|{3}|{4:yyyyMMddHHmm}||ACK|{5:#####}|D|2.3\rMSA|CA|{6}\r";

		public ResultAckGenerator(){}

		public QuestResultServices.HL7Message[] GenerateHL7AckMessages(QuestResultServices.HL7ResultsResponse results_response_in)
		{
			// generate an array of hl7 msg acking passed in response object
			QuestResultServices.HL7Message[] ack_msgs = new QuestResultServices.HL7Message[results_response_in.HL7Messages.Length];

			int i=0;
			foreach(QuestResultServices.HL7Message hl7_msg in results_response_in.HL7Messages)
			{
				ack_msgs[i] = this.GenerateHL7Ack(hl7_msg);
				i++;
			}
			return ack_msgs;
		}

		public QuestResultServices.HL7Message GenerateHL7Ack(QuestResultServices.HL7Message hl7_msg_in)
		{
			byte[] msg_bytes = hl7_msg_in.message;
			System.Object[] msg_params = new System.Object[7];
			QuestResultServices.HL7Message hl7_msg_return = new QuestResultServices.HL7Message();

			//unencode the hl7 message into a string
			string msg_string = System.Text.UTF8Encoding.UTF8.GetString(msg_bytes);

			//spilt string message into segments
			string[] msg_segments = msg_string.Split('\r');

			// message header is in the first line
			string[] msh_fields = msg_segments[0].Split('|');

			// define msg parameters for format statment
			msg_params[0] = msh_fields[4]; // receiving app
			msg_params[1] = msh_fields[5]; // receiving facility
			msg_params[2] = msh_fields[2]; // sending app
			msg_params[3] = msh_fields[3]; // sending facility
			msg_params[4] = System.DateTime.Now; // time stamp
			msg_params[5] = null;

			msg_params[6] = msh_fields[9]; //message control id

			// writing ack message
			string message_ack_string = String.Format(ack_msg_format,msg_params);

			// Encode HL7 ack message into bytes, assign to return message
			byte[] message_UTF8 = System.Text.UTF8Encoding.UTF8.GetBytes(message_ack_string);
			hl7_msg_return.message = message_UTF8;

			hl7_msg_return.controlId = msh_fields[9].ToString();

			return hl7_msg_return;
		}

	}
}
