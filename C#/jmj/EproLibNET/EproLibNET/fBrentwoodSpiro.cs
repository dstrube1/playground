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
	/// Summary description for fBrentwoodSpiro.
	/// </summary>
	internal class fBrentwoodSpiro : System.Windows.Forms.Form
	{
		bool complete = false;
		bool reviewComplete = false;
		bool reviewEdited = false;
		byte[] reviewOutput = null;
		string output=null;

		PatientData.PatientRow pData = null;
		
		internal AxERCACTIVEXLib.AxERCActiveX ERC;
		internal AxSPIROACTIVEXLib.AxSpiroActiveX Spiro;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public fBrentwoodSpiro()
		{

			InitializeComponent();
			//this.VisibleChanged+=new EventHandler(fBrentwoodSpiro_VisibleChanged);
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

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(fBrentwoodSpiro));
			this.ERC = new AxERCACTIVEXLib.AxERCActiveX();
			this.Spiro = new AxSPIROACTIVEXLib.AxSpiroActiveX();
			((System.ComponentModel.ISupportInitialize)(this.ERC)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.Spiro)).BeginInit();
			this.SuspendLayout();
			// 
			// ERC
			// 
			this.ERC.Enabled = true;
			this.ERC.Location = new System.Drawing.Point(8, 56);
			this.ERC.Name = "ERC";
			this.ERC.OcxState = ((System.Windows.Forms.AxHost.State)(resources.GetObject("ERC.OcxState")));
			this.ERC.Size = new System.Drawing.Size(100, 50);
			this.ERC.TabIndex = 0;
			// 
			// Spiro
			// 
			this.Spiro.Enabled = true;
			this.Spiro.Location = new System.Drawing.Point(0, 0);
			this.Spiro.Name = "Spiro";
			this.Spiro.OcxState = ((System.Windows.Forms.AxHost.State)(resources.GetObject("Spiro.OcxState")));
			this.Spiro.Size = new System.Drawing.Size(100, 50);
			this.Spiro.TabIndex = 1;
			// 
			// fBrentwoodSpiro
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(292, 266);
			this.Controls.Add(this.Spiro);
			this.Controls.Add(this.ERC);
			this.Name = "fBrentwoodSpiro";
			this.Text = "fBrentwoodSpiro";
			((System.ComponentModel.ISupportInitialize)(this.ERC)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.Spiro)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion

		public bool RunReview(ref byte[] Report, bool Edit)
		{
			ERC.ReportDataChanged+=new EventHandler(ERC_ReportDataChanged);
			ERC.ReviewEnding+=new EventHandler(ERC_ReviewEnding);

			int edit = Edit?1:0;
			ERC.SetSpiroPermissions(edit,edit,edit,0,0,edit);
			ERC.SetReportDataDirect(Report);

			if(ERC.StartReview()!=0)
				return false;
			while(!reviewComplete)
			{
				Application.DoEvents();
				Thread.Sleep(1);
			}
			if(reviewEdited)
			{
				Report = reviewOutput;
				return true;
			}
			else
			{
				return false;
			}
		}

		public string Run(string xml)
		{
			Spiro.SpiroReportReady+=new EventHandler(Spiro_SpiroReportReady);
			Spiro.SpiroEnding+=new EventHandler(Spiro_SpiroEnding);

			pData = (PatientData.PatientRow)ReadContext(xml).Patient.Rows[0];
			string birthdate = "";
			if(!DBNull.Value.Equals(pData["BirthDate"]))
				birthdate = pData.BirthDate.ToString("MM/dd/yyyy");
			Spiro.SetPatientData(pData.LastName, pData.FirstName, pData.MiddleName, pData.CprID, birthdate, pData.Sex, pData.Weight, pData.Height, pData.Race, 0);
			Spiro.SetTechnicianName(pData.Technician);
			Spiro.SetReqPhysician(pData.Physician);
			Spiro.SetPatSmokingHistory(pData.Smoke?1:0,pData.SmokePerDay,pData.SmokeDuration,pData.SmokeQuit?1:0,pData.SmokeQuitTime);
			try
			{
				if(Spiro.StartSpiro()!=0)
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


		private void fBrentwoodSpiro_VisibleChanged(object sender, EventArgs e)
		{
			if(this.Visible)
				this.Visible=false;
		}

		private void Spiro_SpiroReportReady(object sender, EventArgs e)
		{
			string newFile = Environment.GetEnvironmentVariable("TMP");
			newFile = Path.Combine(newFile,pData.CprID+"_"+Guid.NewGuid().ToString()+".car");
			if(Spiro.GetSpiroReportToFile(newFile)==0)
			{
				System.IO.FileStream file = new System.IO.FileStream(newFile,System.IO.FileMode.Open,System.IO.FileAccess.Read, System.IO.FileShare.ReadWrite);
				byte[] fileBytes = new byte[file.Length];
				file.Read(fileBytes,0,(int)file.Length);
				file.Close();

				System.IO.MemoryStream m = new System.IO.MemoryStream();
				System.Xml.XmlTextWriter writer = new XmlTextWriter(m,System.Text.Encoding.UTF8);
				writer.WriteStartDocument(true);
				writer.WriteStartElement("BrentwoodSpirometer");
				writer.WriteAttributeString("extension","car");
				writer.WriteAttributeString("description","Brentwood Spirometer Report");
				writer.WriteBinHex(fileBytes,0,fileBytes.Length);
				writer.WriteEndElement();
				writer.WriteEndDocument();
				writer.Flush();
				m.Position=0;

				System.IO.StreamReader text = new System.IO.StreamReader(m,System.Text.Encoding.UTF8);
				output=text.ReadToEnd();
				m.Close();
			}
		}

		private void Spiro_SpiroEnding(object sender, EventArgs e)
		{
			complete=true;
		}

		private void ERC_ReportDataChanged(object sender, EventArgs e)
		{
			string newFile = Environment.GetEnvironmentVariable("TMP");
			newFile = Path.Combine(newFile,Guid.NewGuid().ToString()+".car");

			if(ERC.GetReportDataToFile(newFile)==0)
			{
				System.IO.FileStream file = new System.IO.FileStream(newFile,System.IO.FileMode.Open,System.IO.FileAccess.Read, System.IO.FileShare.ReadWrite);
				byte[] fileBytes = new byte[file.Length];
				file.Read(fileBytes,0,(int)file.Length);
				file.Close();
				reviewEdited=true;
				reviewOutput=fileBytes;
			}
		}

		private void ERC_ReviewEnding(object sender, EventArgs e)
		{
			reviewComplete=true;
		}
	}
}
