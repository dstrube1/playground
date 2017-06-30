using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Threading;
using System.IO;
using System.Xml;

namespace EproLibNET
{
	/// <summary>
	/// Summary description for fBrentwoodHolter.
	/// </summary>
	public class fBrentwoodHolter : System.Windows.Forms.Form
	{
		string output=null;
		byte[]OutputData=null;

		string RawFile=null;
		string RptFile=null;
		bool complete = false;
		bool reviewComplete=false;
		PatientData.PatientRow pData = null;
		string contextXml=null;

		private AxHOLTERANALYSTXLib.AxHolterAnalystX Holter;
		private AxHOLTERREVIEWXLib.AxHolterReviewX HolterReview;
		private System.Windows.Forms.Label label1;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public fBrentwoodHolter()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}
		private PatientData ReadContext(string ContextXML)
		{
			PatientData rVal = new PatientData();
			XmlDocument doc = new XmlDocument();
			PatientData.PatientRow newRow = rVal.Patient.NewPatientRow();
			doc.LoadXml(ContextXML);
			foreach(XmlNode node in doc.GetElementsByTagName("EncounterPROContext"))
			{
				if(node.Attributes.Count>0)
				{
					if(node.Attributes[0].Name=="cpr_id")
					{
						contextXml=node.OuterXml;
						newRow.CprID=node.Attributes[0].Value;
						break;
					}
				}
			}
			foreach(XmlNode node in doc.GetElementsByTagName("ContextProperty"))
			{
				//				MessageBox.Show(node.InnerText, node.Name+ " " + node.Attributes[0].Name + " " + node.Attributes[0].Value);
				if(node.Attributes.Count>0)
				{
					switch(node.Attributes[0].Value.ToLower())
					{
						case "first_name":
							newRow.FirstName=node.InnerText;
							break;
						case "last_name":
							newRow.LastName=node.InnerText;
							break;
						case "middle_name":
							newRow.MiddleName=node.InnerText;
							break;
						case "date_of_birth":
							newRow.BirthDate=DateTime.Parse(node.InnerText);
							break;
						case "sex":
						switch(node.InnerText.ToLower())
						{
							case "m":
								newRow.Sex=1;
								break;
							case "f":
								newRow.Sex=2;
								break;
							default:
								newRow.Sex=0;
								break;
						}
							break;
						case "race":
						switch(node.InnerText.ToLower())
						{
							case "white":
								newRow.Race=1;
								break;
							case "black":
								newRow.Race=2;
								break;
							case "hispanic":
								newRow.Race=5;
								break;
							case "asian":
								newRow.Race=3;
								break;
							case "native american":
								newRow.Race=4;
								break;
							default:
								newRow.Race=0;
								break;
						}
							break;
						case "provider":
							newRow.Technician=node.InnerText;
							break;
						case "physician":
							newRow.Physician=node.InnerText;
							break;
						case "hgt":
							if(node.Attributes.Count<2)
								break;
						switch(node.Attributes[1].Value.ToLower())
						{
							case "cm":
								newRow.Height=Double.Parse(node.InnerText);
								break;
							case "inch":
								newRow.Height=Math.Round((Double.Parse(node.InnerText)*2.54d),node.InnerText.TrimStart(new char[]{'0'}).TrimEnd(new char[]{'0'}).Replace(".","").Length);
								break;
							case "feet":
								newRow.Height=Math.Round((Double.Parse(node.InnerText)*30.48d),node.InnerText.TrimStart(new char[]{'0'}).TrimEnd(new char[]{'0'}).Replace(".","").Length);
								break;
						}
							break;
						case "wgt":
							if(node.Attributes.Count<2)
								break;
						switch(node.Attributes[1].Value.ToLower())
						{
							case "kg":
								newRow.Weight=Double.Parse(node.InnerText);
								break;
							case "lb":
								newRow.Weight=Math.Round((Double.Parse(node.InnerText)*0.4535924d),node.InnerText.TrimStart(new char[]{'0'}).TrimEnd(new char[]{'0'}).Replace(".","").Length);
								break;
						}
							break;
					}
				}
			}
			rVal.Patient.AddPatientRow(newRow);
			return rVal;
		}

		public bool RunReviewReadOnly(byte[] Report)
		{
			HolterReview.HolterReviewEnding+=new EventHandler(HolterReview_HolterReviewEnding);

			RptFile = Environment.GetEnvironmentVariable("TMP");
			RptFile = Path.Combine(RptFile,Guid.NewGuid().ToString()+".rpt");

			HolterReview.SetReportDataDirect(Report);
			
			try
			{
				this.Show();
				int holterReviewReturn = HolterReview.StartHolterReview(0,RptFile,"");
				if(holterReviewReturn!=0)
					return false;
			}
			catch(Exception exc)
			{
				MessageBox.Show(exc.ToString());
				return false;
			}
			while(!reviewComplete)
			{
				Application.DoEvents();
				Thread.Sleep(1);
			}
			this.Hide();
			return true;
		}
		public bool RunReview(ref byte[] Report, bool Edit)
		{
			MemoryStream m = new MemoryStream(Report);
			NameTable nt = new NameTable();
			XmlTextReader reader = new XmlTextReader(m,nt);

			char[] ReportChars = new char[Report.Length];
			for(int i=0; i<Report.Length; i++)
			{
				ReportChars[i] = (char)Report[i];
			}
			string xml = new string(ReportChars);

			byte[] RawData = null;
			byte[] RptData = null;

			while(reader.Read())
			{
				if(reader.Name.ToLower()=="encounterprocontext")
				{
				}
				if(reader.Name.ToLower()=="rawfile")
				{
					MemoryStream m2 = new MemoryStream();
					int binhexlen = 0;
					byte[] binhex = new byte[1024];
					do 
					{
						binhexlen = reader.ReadBinHex(binhex, 0, binhex.Length);            
						m2.Write(binhex,0,binhexlen);
					}  while (reader.Name == "RawFile");
					m2.Position=0;
					RawData = new byte[m2.Length];
					m2.Read(RawData,0,RawData.Length);
					m2.Close();
				}
				if(reader.Name.ToLower()=="rptfile")
				{
					MemoryStream m2 = new MemoryStream();
					int binhexlen = 0;
					byte[] binhex = new byte[1024];
					do 
					{
						binhexlen = reader.ReadBinHex(binhex, 0, binhex.Length);            
						m2.Write(binhex,0,binhexlen);
					}  while (reader.Name == "RptFile");
					m2.Position=0;
					RptData = new byte[m2.Length];
					m2.Read(RptData,0,RptData.Length);
					m2.Close();
				}
			}

			if(!Edit)
				return RunReviewReadOnly(RptData);
			
			Holter.HolterReportChanged+=new EventHandler(Holter_HolterReportChanged);
			Holter.HolterAnalystEnding+=new EventHandler(Holter_HolterAnalystEnding);

			pData = (PatientData.PatientRow)ReadContext(xml).Patient.Rows[0];
			string birthdate = "";
			if(!DBNull.Value.Equals(pData["BirthDate"]))
				birthdate = pData.BirthDate.ToString("MM/dd/yyyy");
			string lastName = pData.IsLastNameNull()?"":pData.LastName;
			string firstName = pData.IsFirstNameNull()?"":pData.FirstName;
			string middleName = pData.IsMiddleNameNull()?"":pData.MiddleName;
			string cprId = pData.IsCprIDNull()?"":pData.CprID;
			int sex = pData.IsSexNull()?0:pData.Sex;
			string physician = pData.IsPhysicianNull()?"":pData.Physician;
			Holter.SetPatientData(lastName, firstName, middleName, cprId, birthdate, sex, physician, "");
			Holter.SetTestData(null,pData.Technician);

			RawFile = Environment.GetEnvironmentVariable("TMP");
			RawFile = Path.Combine(RawFile,pData.CprID+"_"+Guid.NewGuid().ToString()+".raw");
			RptFile = Environment.GetEnvironmentVariable("TMP");
			RptFile = Path.Combine(RptFile,pData.CprID+"_"+Guid.NewGuid().ToString()+".rpt");

			FileStream fs = File.Create(RawFile);
			fs.Write(RawData,0,RawData.Length);
			fs.Flush();
			fs.Close();

			fs = File.Create(RptFile);
			fs.Write(RptData,0,RptData.Length);
			fs.Flush();
			fs.Close();

			try
			{
				DialogResult result = MessageBox.Show("Do you wish to re-analyze the raw ECG data?\r\n\r\nTo edit the current report instead, click \"No\"","Re-Analyze?",MessageBoxButtons.YesNoCancel,MessageBoxIcon.Question,MessageBoxDefaultButton.Button2);
				if (result==DialogResult.Cancel)
					return false;
				if(Holter.StartHolter("",RptFile,RawFile,(int)this.Handle, (result==DialogResult.Yes)?1:0, (result==DialogResult.No)?1:0)!=0)
					return false;
			}
			catch(Exception exc)
			{
				MessageBox.Show(exc.ToString());
				return false;
			}
			while(!reviewComplete)
			{
				Application.DoEvents();
				Thread.Sleep(1);
			}

			Report = OutputData;
			return true;
		}

		public string Run(string xml)
		{
			Holter.HolterReportReady+=new EventHandler(Holter_HolterReportReady);
			Holter.HolterAnalystEnding+=new EventHandler(Holter_HolterAnalystEnding);

			pData = (PatientData.PatientRow)ReadContext(xml).Patient.Rows[0];
			string birthdate = "";
			if(!DBNull.Value.Equals(pData["BirthDate"]))
				birthdate = pData.BirthDate.ToString("MM/dd/yyyy");
			string lastName = pData.IsLastNameNull()?"":pData.LastName;
			string firstName = pData.IsFirstNameNull()?"":pData.FirstName;
			string middleName = pData.IsMiddleNameNull()?"":pData.MiddleName;
			string cprId = pData.IsCprIDNull()?"":pData.CprID;
			int sex = pData.IsSexNull()?0:pData.Sex;
			string physician = pData.IsPhysicianNull()?"":pData.Physician;
			Holter.SetPatientData(lastName, firstName, middleName, cprId, birthdate, sex, physician, "");
			Holter.SetTestData(null,pData.Technician);

			RawFile = Environment.GetEnvironmentVariable("TMP");
			RawFile = Path.Combine(RawFile,pData.CprID+"_"+Guid.NewGuid().ToString()+".raw");
			RptFile = Environment.GetEnvironmentVariable("TMP");
			RptFile = Path.Combine(RptFile,pData.CprID+"_"+Guid.NewGuid().ToString()+".rpt");

			try
			{
				if(Holter.StartHolter("",RptFile,RawFile,(int)this.Handle, 0, 0)!=0)
					return null;
			}
			catch(Exception exc)
			{
				MessageBox.Show(exc.ToString());
			}
			while(!complete)
			{
				Application.DoEvents();
				Thread.Sleep(1);
			}

			return output;
		}



		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(fBrentwoodHolter));
			this.Holter = new AxHOLTERANALYSTXLib.AxHolterAnalystX();
			this.HolterReview = new AxHOLTERREVIEWXLib.AxHolterReviewX();
			this.label1 = new System.Windows.Forms.Label();
			((System.ComponentModel.ISupportInitialize)(this.Holter)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.HolterReview)).BeginInit();
			this.SuspendLayout();
			// 
			// Holter
			// 
			this.Holter.Enabled = true;
			this.Holter.Location = new System.Drawing.Point(128, 120);
			this.Holter.Name = "Holter";
			this.Holter.OcxState = ((System.Windows.Forms.AxHost.State)(resources.GetObject("Holter.OcxState")));
			this.Holter.Size = new System.Drawing.Size(100, 50);
			this.Holter.TabIndex = 0;
			this.Holter.Visible = false;
			// 
			// HolterReview
			// 
			this.HolterReview.Enabled = true;
			this.HolterReview.Location = new System.Drawing.Point(32, 128);
			this.HolterReview.Name = "HolterReview";
			this.HolterReview.OcxState = ((System.Windows.Forms.AxHost.State)(resources.GetObject("HolterReview.OcxState")));
			this.HolterReview.TabIndex = 1;
			this.HolterReview.Visible = false;
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(24, 24);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(136, 23);
			this.label1.TabIndex = 2;
			this.label1.Text = "Running Holter Review...";
			// 
			// fBrentwoodHolter
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(176, 64);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.HolterReview);
			this.Controls.Add(this.Holter);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
			this.Name = "fBrentwoodHolter";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Holter Review";
			((System.ComponentModel.ISupportInitialize)(this.Holter)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.HolterReview)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion

		private void Holter_HolterReportReady(object sender, EventArgs e)
		{
			byte[]RawData=null;
			byte[]RptData=null;

			FileStream fs = File.OpenRead(RawFile);
			RawData = new byte[fs.Length];
			fs.Read(RawData,0,RawData.Length);
			fs.Close();

			fs = File.OpenRead(RptFile);
			RptData = new byte[fs.Length];
			fs.Read(RptData,0,RptData.Length);
			fs.Close();

			MemoryStream m = new System.IO.MemoryStream();
			XmlTextWriter writer = new XmlTextWriter(m,System.Text.Encoding.UTF8);

			writer.WriteStartDocument();
			writer.WriteStartElement("Observation");

			writer.WriteRaw(contextXml);

			writer.WriteStartElement("RawFile");
			writer.WriteAttributeString("TimeStamp",DateTime.Now.ToString());
			writer.WriteBinHex(RawData,0,RawData.Length);
			writer.WriteEndElement();

			writer.WriteStartElement("RptFile");
			writer.WriteAttributeString("TimeStamp",DateTime.Now.ToString());
			writer.WriteBinHex(RptData,0,RptData.Length);
			writer.WriteEndElement();

			writer.WriteEndElement();
			writer.WriteEndDocument();
			writer.Flush();

			m.Position=0;

			System.IO.StreamReader text = new System.IO.StreamReader(m,System.Text.Encoding.UTF8);
			output=text.ReadToEnd();
			m.Close();
			char[] chars = output.ToCharArray();
			OutputData = new byte[chars.Length];
			for(int i=0; i<chars.Length; i++)
			{
				OutputData[i]=(byte)chars[i];
			}

			m = new System.IO.MemoryStream();
			writer = new XmlTextWriter(m,System.Text.Encoding.UTF8);
			writer.WriteStartDocument();
			writer.WriteStartElement("BrentwoodHolter");
			writer.WriteAttributeString("extension","brentwood_holter");
			writer.WriteAttributeString("description","Brentwood Holter Report");
			writer.WriteBinHex(OutputData,0,OutputData.Length);
			writer.WriteEndElement();
			writer.WriteEndDocument();
			writer.Flush();
			m.Position=0;

			text = new System.IO.StreamReader(m,System.Text.Encoding.UTF8);
			output=text.ReadToEnd();
			m.Close();
		}

		private void Holter_HolterAnalystEnding(object sender, EventArgs e)
		{
			complete=true;
			reviewComplete=true;
		}

		private void Holter_HolterReportChanged(object sender, EventArgs e)
		{
			Holter_HolterReportReady(sender,e);
		}

		private void HolterReview_HolterReviewEnding(object sender, EventArgs e)
		{
			reviewComplete=true;
		}
	}
}
