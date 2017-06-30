using System.Runtime.InteropServices;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Xml;
using System.IO;


namespace EproLibNET
{
	/// <summary>
	/// Summary description for BradyPrinter.
	/// </summary>
	/// 
	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class BradyPrinter:Base.Report
	{
	
		private MSCommLib.MSComm axMSComm1 = null;
		private string data = string.Empty;
		private char SOH = (char)0x01;
		private char STX = (char)0x02;
		private char CR = (char)0x0D;
		///Header part of each print line
		//byte rotation = 0x01;		// o degrees
		//byte font = 0x09;			// Ariel 
		//byte width = 0x00;			// not used
		//byte height = 0x00;			// not used
		//byte[] fontsize = new byte[3]{0x00,0x00,0x06};
		//byte[] row = new byte[4]{0x00,0x00,0x02,0x05};	//top of Y-COORD 0.25"
		//byte[] col = new byte[4]{0x00,0x00,0x00,0x05};	//from left X-COORD .05"
		/*
		private String line1 = "190000600050005";		//Encounter Date
		private String line2= "190000600170005";		//Last Name
		private String line3 = "190000600290005";		//First Name
		private String line4 = "190000600410005";		//Age Sex DOB
		private String line5 = "190000600520005";		//Primary Ins Name
		private String line6 = "190000600650005";		//Secondary ins Name
		private String line7a = "190000600800005";		//Billing_ID
		private String line7b = "190000600800080";		//Primary Provider
		*/
		private string first_name = string.Empty;
		private string last_name = string.Empty;
		private string billing_id = string.Empty;
		private string insurance = string.Empty;
		private string insurance2 = string.Empty;
		private string doctor = string.Empty;
		private string dob = string.Empty;
		private string encounterdate = string.Empty;
		private string age = string.Empty;
		private string sex = string.Empty;
		private string cpr_id = string.Empty;
		private string encounter_id = string.Empty;
		private string comm_port = string.Empty;
		int commPort = 1;
		private string labels = "6";
		private string labelCommand = "E0006";
		private int currYear = System.Int32.Parse(DateTime.Now.ToString("yyyy"));
		private int currMonth = System.Int32.Parse(DateTime.Now.ToString("MM"));
		private int ageYear;
		private int ageMonth;
		private decimal fracMonth;

		
		public BradyPrinter():base()
		{}
		
		protected override void printReport(string ReportID, System.Collections.Specialized.StringDictionary Attributes, SqlConnection Con)
		{
			if (Attributes.ContainsKey("CPR_ID")) 
			{
				cpr_id = Attributes["CPR_ID"];
			}
			else
				throw new Exception("no cpr_id attribute found");

			if (Attributes.ContainsKey("ENCOUNTER_ID")) 
			{
				encounter_id = Attributes["ENCOUNTER_ID"];
			}
			else
				throw new Exception("no encounter_id attribute found");

			if (Attributes.ContainsKey("COMM_PORT")) 
			{
				comm_port = Attributes["COMM_PORT"];
				if(comm_port != null && comm_port != "")
				{
					commPort = System.Int32.Parse(comm_port);
				}
			}
			else commPort = 1;
			util.LogEvent("Brady","comm_port ",comm_port,2);

			if (Attributes.ContainsKey("LABELS")) 
			{
				labels = Attributes["LABELS"];
				if(labels == null || labels == "")
				{
					labels = "6";
				}
			}
			
			if (labels.Equals("0")) 
				throw new Exception("label attribute set to 0");
			int labellen = labels.Length;
			if (labellen == 1) labelCommand = "E" + "000" + labels;
			if (labellen == 2) labelCommand = "E" + "00" + labels;
			if (labellen == 3) labelCommand = "E" + "0" + labels;
			if (labellen == 4) labelCommand = "E" + labels;
			if (labellen > 4) 
				throw new Exception("label attribute set over max 9999");
			util.LogEvent("Brady","Labels ",labels,2);
			
			SqlCommand com = null;
			com = new SqlCommand();
			com.Connection = Con;
				
			
			#region CommandText
			if((cpr_id != null && cpr_id != "")&& (encounter_id != null && encounter_id != ""))
			{
				com.CommandText = 
					"SELECT p_Patient.billing_id "+
					", p_Patient.last_name "+
					", p_Patient.first_name "+
					", date_of_birth "+
					", sex "+
					", encounter_date "+
					", user_full_name "+
					", c_Authority.name AS Insurance"+
					", c_A2.name AS Insurance2"+
					" FROM p_Patient_Encounter "+
					" INNER JOIN p_Patient "+
					" ON P_Patient_Encounter.cpr_id = '" + cpr_id + "'"+
					" AND p_Patient_Encounter.encounter_id = "+ encounter_id +
					" AND p_Patient_Encounter.cpr_id = p_Patient.cpr_id "+
					"LEFT OUTER JOIN p_Patient_Authority "+
					" ON p_Patient.cpr_id = p_Patient_Authority.cpr_id "+
					" AND p_Patient_Authority.authority_type = 'PAYOR'"+
					" AND p_Patient_Authority.status  = 'OK' "+
					" AND p_Patient_Authority.authority_sequence  = 1 "+
					"LEFT OUTER JOIN c_Authority "+
					" ON p_Patient_Authority.authority_id = c_Authority.authority_id "+
					" AND c_Authority.authority_type = 'PAYOR'"+
					"LEFT OUTER JOIN p_Patient_Authority  p_A2"+
					" ON p_Patient.cpr_id = p_A2.cpr_id "+
					" AND p_A2.authority_type = 'PAYOR'"+
					" AND p_A2.status  = 'OK' "+
					" AND p_A2.authority_sequence  = 2 "+
					"LEFT OUTER JOIN c_Authority c_A2"+
					" ON p_A2.authority_id = c_A2.authority_id "+
					" AND c_A2.authority_type = 'PAYOR'"+
					"INNER JOIN c_User"+
					" ON p_Patient_Encounter.attending_doctor = user_id ";
			}
			else
			{
				// No valid CPR_ID/ENCOUNTER_ID.
				// return error.
				throw new Exception("No valid CPR_ID/ENCOUNTER_ID");
			}
			#endregion
			#region ProcessDataSet
			DataSet ds = new DataSet();
			SqlDataAdapter da = new SqlDataAdapter(com);
			SqlDataReader reader=null;
					

			
			
			reader = com.ExecuteReader();
			if (!reader.HasRows)
				throw new Exception("No Row Returned For Select");
			reader.Close();
			try 
			{
				da.Fill(ds);
				foreach(DataRow row in ds.Tables[0].Rows)
				{
					if(!DBNull.Value.Equals(row["first_name"])&&null!=row["first_name"])
						first_name = row["first_name"].ToString();
					if(!DBNull.Value.Equals(row["last_name"])&&null!=row["last_name"])
						last_name = row["last_name"].ToString();
					if(!DBNull.Value.Equals(row["sex"])&&null!=row["sex"])
						sex = row["sex"].ToString();
					if(!DBNull.Value.Equals(row["encounter_date"])&&null!=row["encounter_date"])
						encounterdate = ((DateTime)row["encounter_date"]).ToString("MM/dd/yyyy");
					if(!DBNull.Value.Equals(row["date_of_birth"])&&null!=row["date_of_birth"])
						dob = ((DateTime)row["date_of_birth"]).ToString("MM/dd/yyyy");
					if(!DBNull.Value.Equals(row["billing_id"])&&null!=row["billing_id"])
						billing_id = row["billing_id"].ToString();
					
					if(!DBNull.Value.Equals(row["user_full_name"])&&null!=row["user_full_name"])
						doctor = row["user_full_name"].ToString();
					if(!DBNull.Value.Equals(row["Insurance"])&&null!=row["Insurance"])
						insurance = row["Insurance"].ToString();
					else 
						insurance = "no insurance";
					if(!DBNull.Value.Equals(row["Insurance2"])&&null!=row["Insurance2"])
						insurance2 = row["Insurance2"].ToString();
					else 
						insurance2 = "no secondary";	

					if(!DBNull.Value.Equals(row["date_of_birth"])&&null!=row["date_of_birth"]) 
					{
						ageYear = ((DateTime)row["date_of_birth"]).Year;
						ageMonth = ((DateTime)row["date_of_birth"]).Month;
						ageYear = currYear - ageYear;
						if (ageMonth <= currMonth) ageMonth = ageMonth - currMonth;
						else
						{
							ageYear--;
							ageMonth = 12 - ageMonth;
						}
						age = ageYear.ToString(); 
						if (ageMonth > 0)
							{fracMonth = ageMonth / 12.00M;
							fracMonth = Decimal.Round(fracMonth,2);}
						else
							fracMonth = .00M;
						
						age = age + fracMonth.ToString();
                    }
					else age = "     ";
					util.LogEvent("Brady","Age ",age,2);
					
					formatLabel();
                    
				}
				da.Dispose();
			}
			catch(Exception exc) 
			{
				util.LogEvent(exc.Source,exc.TargetSite.Name,exc.ToString(),4);
				throw exc;}
		}
		#endregion ProcessDataSet
	
		
		public override bool Is_Printable()
		{
			return true;
		}

		private void print(int CommPort, string data)
		{
			axMSComm1 = new MSCommLib.MSCommClass();
			try
			{
				axMSComm1.CommPort = (short)CommPort;
				try
				{
					if(axMSComm1.PortOpen)
						axMSComm1.PortOpen=false;
				}
				catch{}
				axMSComm1.Settings="9600,n,8,1";
				axMSComm1.Handshaking = MSCommLib.HandshakeConstants.comRTS;
				axMSComm1.InputMode = MSCommLib.InputModeConstants.comInputModeText;
				axMSComm1.PortOpen=true;
			
				axMSComm1.Output = data;
			}
			catch(Exception exc)
			{
				throw new Exception("Error printing to COM "+CommPort.ToString()+Environment.NewLine+exc.ToString(),exc);
			}
			finally
			{
				axMSComm1.PortOpen=false;
			}

		}
		#region // Format Label
		private void formatLabel()
		{
			
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append(SOH);
			sb.Append("#");
			sb.Append(STX);
			sb.Append("n");
			sb.Append(STX);
			sb.Append("L");
			// line 1
			sb.Append("190000600050005" + encounterdate);
			sb.Append(CR);
			
			// line2
			sb.Append("190000600170005" + last_name);
			sb.Append(CR);
			
			// line3
			sb.Append("190000600290005" + first_name);
			sb.Append(CR);
			
			// line4
			sb.Append("190000600410005" + age + " " + sex + " " + dob);
			sb.Append(CR);

			// line5
			sb.Append("190000600520005" + insurance);
			sb.Append(CR);
			
			// line6
			sb.Append("190000600650005" + insurance2);
			sb.Append(CR);

			// line7
			sb.Append("190000600800005" + billing_id);
			sb.Append(CR);
			sb.Append("190000600800080" + doctor);
			sb.Append(CR);

			sb.Append("X");
			sb.Append(CR);
			sb.Append(STX);
			//sb.Append("E0002");
			sb.Append(labelCommand);
			sb.Append(STX);
			sb.Append("G");

			data = sb.ToString();
			if (data== null)
				throw new Exception("No Label was formatted");
			print(commPort,data);
		}
		#endregion
		
		}
		
	}
