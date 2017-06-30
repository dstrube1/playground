using System;

namespace EPIntSenderLib
{
	/// <summary>
	/// Summary description for CommNewCrop.
	/// </summary>
	public class CommNewCrop:BaseComm
	{
		public CommNewCrop():base()
		{
		}

		protected override void send()
		{
			com.newcropaccounts.secure.Pharmacy pharmacy = new EPIntSenderLib.com.newcropaccounts.secure.Pharmacy();
			Message[] messages = base.GetMessagesFromDB(0);
			foreach(Message message in messages)
			{
				System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
				doc.LoadXml(message.MessageBody);

				com.newcropaccounts.secure.Credentials cred = new EPIntSenderLib.com.newcropaccounts.secure.Credentials();
				com.newcropaccounts.secure.AccountRequest ar = new EPIntSenderLib.com.newcropaccounts.secure.AccountRequest();
				
				cred.PartnerName = doc.DocumentElement["Credentials"]["partnerName"].InnerText;
				cred.Name = doc.DocumentElement["Credentials"]["name"].InnerText;
				cred.Password = doc.DocumentElement["Credentials"]["password"].InnerText;

				ar.AccountId = doc.DocumentElement["Account"].Attributes["ID"].Value;
				ar.SiteId = doc.DocumentElement["Account"]["siteID"].InnerText;

				com.newcropaccounts.secure.PrescriptionDetailResult result = pharmacy.SendToPharmacy(cred,ar,message.MessageBody);
				if(result.result.Status==com.newcropaccounts.secure.StatusType.OK)
				{
					if(base.debug)
						Event.LogInformation("Prescription Sent Successfully"+Environment.NewLine+"TransactionID = "+result.prescriptionDetail.TransactionID);
					base.SetMessageStatus(message,MessageStatus.SENT);
					base.SetMessageStatus(message,MessageStatus.COMPLETE);
				}
				else if (base.debug)
				{
					Event.LogError("Failed Sending Prescription"+Environment.NewLine+result.result.Message);
				}
			}
		}

		protected override void recv()
		{
			base.recv ();
		}


	}
}
