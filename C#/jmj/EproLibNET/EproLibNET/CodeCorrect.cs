using System.Runtime.InteropServices;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Xml;
using System.IO;

namespace EproLibNET
{  
	/// <summary>
	/// Summary description for CodeCorrect.
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class CodeCorrect:Base.ExtSrcStateless
	{
		string serverName = string.Empty;
		string dbName = string.Empty;
		string appRole = string.Empty;
		string appRolePwd = string.Empty;
		string cprId = string.Empty;
		string encounterId = string.Empty;
		string first_name = string.Empty;
		string last_name = string.Empty;
		string middle_name = string.Empty;
		string sex = string.Empty;
		string encounter_description = string.Empty;
		DateTime encounter_date;
		DateTime birth_date;

		private string ccURL = "http://dev.codecorrect.com/claimvalidator/claim_robot.cfm";

		public CodeCorrect():base()
		{
		}

		public override string CreateDocument(string XML)
		{
			//ToDO: add sql query to get code correct user id data from c_component_attribute table
			string ccUser="jmj.testing", ccPassword="testing";
			string cidClient="14750", cidUser="58619";
			string ccXML=null, ccResponse=null;
			string jmjXML=null;
			
			SqlConnection con = null;
			SqlCommand cmd = null;

			#region Get Variables from context XML
			// parse thru xml and construct a connection string
			XmlDocument document = new XmlDocument();
			document.LoadXml(XML);
			foreach(XmlNode n in document.GetElementsByTagName("servername"))
				serverName=n.InnerText;
			foreach(XmlNode n in document.GetElementsByTagName("database"))
				dbName=n.InnerText;
			foreach(XmlNode n in document.GetElementsByTagName("approle"))
				appRole=n.InnerText;
			foreach(XmlNode n in document.GetElementsByTagName("approlepwd"))
				appRolePwd=n.InnerText;
			foreach(XmlNode n in document.GetElementsByTagName("cpr_id"))
				cprId=n.InnerText;
			foreach(XmlNode n in document.GetElementsByTagName("encounter_id"))
				encounterId=n.InnerText;

			#endregion

			#region Open Database Connection
			try
			{
				con = new SqlConnection();
				con.ConnectionString="Server='"+serverName+"';Database='"+dbName+"';Integrated Security=SSPI;Persist Security Info = false;Pooling=false";
				con.Open();
				try
				{
					// Some systems may not have the application role set up.
					// Do not fail if setapprole fails
					cmd = new SqlCommand("EXEC dbo.sp_setapprole '" +appRole + "','"+appRolePwd+"'", con);
					cmd.ExecuteNonQuery();
				}
				catch(Exception exc)
				{
					util.LogInternalEvent(new Exception("Error in sp_SetAppRole",exc),3);
				}
			}
			catch(Exception exc)
			{
				System.Exception exc2 = new Exception("Error Connecting to Database",exc);
				util.LogInternalEvent(exc2,4);
				throw(exc2);
			}
			#endregion

			#region Generate ccXML
			try
			{
				if(cprId==String.Empty || encounterId==String.Empty)
					throw new Exception("CPR_ID and/or ECOUNTER_ID not available.  Cannot continue.");
				cmd = new SqlCommand();
				cmd.Connection = con;
				#region CommandText
				cmd.CommandText = 
					"SELECT "+
					" NEWID() as unique_id "+
					", first_name "+
					", last_name "+
					", middle_name "+
					", date_of_birth "+
					", sex "+
					", encounter_date "+
					", encounter_description "+
					", c_procedure.cpt_code "+
					", c_procedure.modifier "+
					", c_procedure.other_modifiers "+
					", c_assessment_definition.icd_9_code "+
					", p_Encounter_Assessment.assessment_sequence "+
					", c_Office.state "+
					" FROM p_Patient_Encounter "+
					" INNER JOIN p_Patient "+
					" ON P_Patient_Encounter.cpr_id = '" + cprId + "'"+
					" AND p_Patient_Encounter.encounter_id = "+ encounterId +
					" AND p_Patient_Encounter.cpr_id = p_Patient.cpr_id "+
					"INNER JOIN p_encounter_assessment_charge "+
					" ON p_Patient_Encounter.cpr_id = p_encounter_assessment_charge.cpr_id "+
					" AND p_Patient_Encounter.encounter_id = p_encounter_assessment_charge.encounter_id "+
					" AND p_encounter_assessment_charge.bill_flag = 'Y' "+
					"INNER JOIN p_encounter_charge "+
					" ON p_Patient_Encounter.cpr_id = p_encounter_charge.cpr_id "+
					" AND p_Patient_Encounter.encounter_id = p_encounter_charge.encounter_id "+
					" AND p_encounter_assessment_charge.encounter_charge_id = p_encounter_charge.encounter_charge_id "+
					"INNER JOIN c_Procedure "+
					" ON p_encounter_charge.procedure_id = c_Procedure.procedure_id "+
					"INNER JOIN p_Encounter_Assessment "+
					" ON p_Patient_Encounter.cpr_id = p_Encounter_Assessment.cpr_id "+
					" AND p_Patient_Encounter.encounter_id = p_Encounter_Assessment.encounter_id "+
					" AND p_encounter_assessment_charge.problem_id = p_Encounter_Assessment.problem_id "+
					" AND p_Encounter_Assessment.bill_flag = 'Y' "+
					"INNER JOIN c_Assessment_definition "+
					" ON p_Encounter_Assessment.assessment_id = c_Assessment_Definition.assessment_id "+
					"INNER JOIN c_OFFICE "+
					" ON p_Patient_Encounter.office_id = c_Office.office_id "+
					"ORDER BY c_procedure.cpt_code,p_encounter_assessment_charge.problem_id,p_Encounter_Assessment.assessment_sequence";
				#endregion
			
				DataSet ds = new DataSet();
				SqlDataAdapter da = new SqlDataAdapter(cmd);
				da.Fill(ds);
				MemoryStream ms = new MemoryStream();
				XmlTextWriter xmlw = new XmlTextWriter(ms, System.Text.Encoding.UTF8);
				xmlw.WriteStartDocument();
			
				xmlw.WriteStartElement("wddxPacket");
				xmlw.WriteAttributeString("version","1.0");
				xmlw.WriteElementString("header",null);
			
				xmlw.WriteStartElement("data");
			
				xmlw.WriteStartElement("struct");
			
				xmlw.WriteStartElement("var");
				xmlw.WriteAttributeString("name","USERNAME");
				xmlw.WriteElementString("string",ccUser);
				xmlw.WriteEndElement();
			
				xmlw.WriteStartElement("var");
				xmlw.WriteAttributeString("name","USERPASSWORD");
				xmlw.WriteElementString("string",ccPassword);
				xmlw.WriteEndElement();

				bool isFirstRow = true;
				int iCptCount= 0;
				string lastCPT = null;
				int iDxCount = 0;
				foreach(DataRow row in ds.Tables[0].Rows)
				{
					if(isFirstRow)
					{	
						isFirstRow=false;
						//Stuff to pass back to Epro
						first_name = row["first_name"].ToString();
						last_name = row["last_name"].ToString();
						middle_name = row["middle_name"].ToString();
						sex = row["sex"].ToString();
						encounter_date = (DateTime)row["encounter_date"];
						encounter_description = row["encounter_description"].ToString();
						birth_date = (DateTime)row["date_of_birth"];
					
						//STATE
						xmlw.WriteStartElement("var");
						xmlw.WriteAttributeString("name","STATE");
						xmlw.WriteElementString("string",row["state"].ToString());
						xmlw.WriteEndElement();

						//SVCDATE
						xmlw.WriteStartElement("var");
						xmlw.WriteAttributeString("name","SVCDATE");
						xmlw.WriteElementString("string",DateTime.Parse(row["encounter_date"].ToString()).ToString("yyyyMMdd"));
						xmlw.WriteEndElement();

						//DOB
						xmlw.WriteStartElement("var");
						xmlw.WriteAttributeString("name","DOB");
						xmlw.WriteElementString("string",DateTime.Parse(row["date_of_birth"].ToString()).ToString("yyyyMMdd"));
						xmlw.WriteEndElement();
					

						//GENDER
						xmlw.WriteStartElement("var");
						xmlw.WriteAttributeString("name","GENDER");
						xmlw.WriteElementString("string",row["sex"].ToString());
						xmlw.WriteEndElement();

						//TODO: Maternity should not be hard-coded!!
						//MATERNITY
						xmlw.WriteStartElement("var");
						xmlw.WriteAttributeString("name","MATERNITY");
						xmlw.WriteElementString("string","N");
						xmlw.WriteEndElement();
					}

					if(lastCPT == null || lastCPT!=row["cpt_code"].ToString())
					{
						iCptCount++;
						lastCPT=row["cpt_code"].ToString();
						iDxCount=0;

						//UNIQUEID
						xmlw.WriteStartElement("var");
						xmlw.WriteAttributeString("name","UNIQUEID"+iCptCount.ToString());
						xmlw.WriteElementString("string",((Guid)row["unique_id"]).ToString());
						xmlw.WriteEndElement();
						
						//CPTCODE
						xmlw.WriteStartElement("var");
						xmlw.WriteAttributeString("name","CPTCODE"+iCptCount.ToString());
						xmlw.WriteElementString("string",row["cpt_code"].ToString());
						xmlw.WriteEndElement();

						//MODIFIER
						if(!row.IsNull("modifier"))
						{
							xmlw.WriteStartElement("var");
							xmlw.WriteAttributeString("name","MODIFIER"+iCptCount.ToString());
							xmlw.WriteElementString("string",row["modifier"].ToString());
							xmlw.WriteEndElement();
						}
					}

					//DX
					iDxCount++;
					string fieldName = null;
					switch(iDxCount)
					{
						case 1:
							fieldName="PRIMDX";
							break;
						case 2:
							fieldName="SECDX";
							break;
						case 3:
							fieldName="THIRDDX";
							break;
						case 4:
							fieldName="FOURTHDX";
							break;
						default:
							continue;
					}
				
					xmlw.WriteStartElement("var");
					xmlw.WriteAttributeString("name",fieldName+iCptCount.ToString());
					xmlw.WriteElementString("string",row["icd_9_code"].ToString());
					xmlw.WriteEndElement();
				}

				xmlw.WriteEndElement(); //struct
				xmlw.WriteEndElement(); //data
				xmlw.WriteEndElement(); //wddxPacket
				xmlw.WriteEndDocument();
				xmlw.Flush();
				ms.Position=0;
				StreamReader sr = new StreamReader(ms,System.Text.Encoding.UTF8);
				ccXML = sr.ReadToEnd();
				sr.Close();
			}
			catch(Exception exc)
			{
				Exception exc2 = new Exception("Error Generating CodeCorrect XML for transmission",exc);
				util.LogInternalEvent(exc2,4);
				throw exc2;
			}
			#endregion

			util.LogEvent("test","test","ccXML:"+Environment.NewLine+ccXML,2);

			try
			{
				System.Collections.Specialized.ListDictionary vars = new System.Collections.Specialized.ListDictionary();
				vars.Add("WDDXContent",ccXML.Substring(ccXML.IndexOf("<wddx")));

				ccResponse=util.PutHTTPRequest(ccURL,null,vars).Trim();
			}
			catch(Exception exc)
			{
				Exception exc2 = new Exception("Error in HTTP send to CodeCorrect",exc);
				util.LogInternalEvent(exc2,4);
				throw exc2;
			}

			util.LogEvent("test","test","ccResponse:"+Environment.NewLine+ccResponse,2);
			
			try
			{
				jmjXML = convertCCResponse("<?xml version=\"1.0\" encoding=\"utf-8\"?>" + ccResponse,ccXML);
			}
			catch(Exception exc)
			{
				Exception exc2 = new Exception("Error converting CodeCorrect response to JMJ XML",exc);
				util.LogInternalEvent(exc2,4);
				throw exc2;
			}

			util.LogEvent("test","test","jmjXML:"+Environment.NewLine+jmjXML,2);
			return jmjXML;
		}


		private string convertCCResponse(string ccResponse, string ccXml)
		{
			//System.Collections.Specialized.HybridDictionary codes = getCodeDictionary();
			XmlDocument docXML = null;
			XmlDocument responseXML = new XmlDocument();
			responseXML.LoadXml(ccResponse);

			//TODO: JMJ XML CREATION
			string newAttr=null, cpt_code=null;
			StatusInfo info = new StatusInfo(String.Empty,Status.Unkn); 
			string[] noProcess = {"statuscode","statusdesc","state","svcdate","contractorstatesstatus","uniqueid","dxncd","dxlmrp","cpt_status","rvuunits","work_rvu","na_indicator","pctc_indicator","globaldays","mult_proc","bilat_surgery","assist_surgery","co-surgeons","team_surgery","endobase_code"};
			bool noResult = false; 
			int codestatus = 0;
			int newstatus = 0;
			string now = XmlConvert.ToString(DateTime.Now);
			string newcodestatus;
			if (passPacket(ccResponse) == "Fail")
				throw new Exception("WDDX response : failed");
							
			docXML = createClaimsScrubberXML(cprId, first_name, last_name, middle_name, XmlConvert.ToString(birth_date), sex, 
				encounterId, XmlConvert.ToString(encounter_date), encounter_description);

			foreach (XmlNode n in responseXML.GetElementsByTagName("var"))
			{
				XmlAttribute attr = n.Attributes["name"];
				//				util.LogEvent("test","test",attr.Value,2);

				//				util.LogEvent("test","test","firstchild="+n.FirstChild.InnerText,2);
				if(n.FirstChild.InnerText.Trim().Length==0)
					continue;
				
				newAttr = reformatCode(attr.Value.ToLower());
				//				util.LogEvent("test","test","attrwonum="+newAttr,2);
				noResult = false;
				foreach(string nn in noProcess)
					if (nn == newAttr)
					{
						noResult = true;
						break;}
				//				util.LogEvent("test","test","noResult="+noResult.ToString(),2);
				if (! noResult)
				{

					cpt_code = getCpt(ccResponse,attr.Value); 
					//System.Collections.Specialized.HybridDictionary tempDic = (System.Collections.Specialized.HybridDictionary)codes[newAttr];
					//if(codes.Contains(newAttr))
					System.Collections.Specialized.HybridDictionary tempDic = ccStatus.GetResultDictionary(newAttr);
					if (tempDic != null)
					{
						//						string eventstring = newAttr+Environment.NewLine;
						//						foreach(System.Collections.DictionaryEntry entry in tempDic)
						//						{
						//							eventstring += entry.Key.ToString()+ " = "+((StatusInfo)entry.Value).StatusText+Environment.NewLine;
						//						}
						//						util.LogEvent("test","test",eventstring,2);
						//if (newAttr == "dxncdv") {checkdxresult(ccResponse,attr,newAttr,n.FirstChild.InnerText[0]);}
						//if (newAttr == "dxlmrpv") {checkdxresult(ccResponse,attr,newAttr,n.FirstChild.InnerText[0]);} 
					
						if(Char.IsNumber(n.FirstChild.InnerText[0]) || (n.FirstChild.InnerText[0]=='-' && Char.IsNumber(n.FirstChild.InnerText[1])))
							info = (StatusInfo)tempDic[((int)Double.Parse(n.FirstChild.InnerText)).ToString()];
						else
							info = (StatusInfo)tempDic[n.FirstChild.InnerText];}
					else
						info = new StatusInfo(n.FirstChild.InnerText,Status.Unkn);
					//					util.LogEvent("test","test","info variable assigned"+Environment.NewLine+
					//						info.StatusText+Environment.NewLine+info.Status.ToString(),2);
					switch (info.Status)
					{
						case Status.Pass:
							newstatus =1;
							newcodestatus="Pass";
							break;
						case Status.Warn:
							newstatus = 2;
							newcodestatus="Warning";
							break;
						case Status.Fail:
							newstatus = 3;
							newcodestatus="Fail";
							break;
						default :
							newstatus = 0;
							newcodestatus="Unknown";
							break;
					}
					string special_status = "Pass";
					if (newAttr == "dxncdv") 
					{
						special_status =checkdxresult(ccResponse,attr.Value,newAttr,n.FirstChild.InnerText);
						newcodestatus = special_status;}
					if (newAttr == "dxlmrpv") 
					{
						special_status =checkdxresult(ccResponse,attr.Value,newAttr,n.FirstChild.InnerText);
						newcodestatus = special_status;} 
					//					util.LogEvent("test","test","newcodestatus="+newcodestatus,2);
					string resultDesc = ccStatus.GetResultDescription(newAttr);
					//					util.LogEvent("test","test","resultDesc="+resultDesc,2);
					docXML = addEncounterNoteToClaimsScrubberXML(docXML,"Code Check Detail",cpt_code + " " + ((resultDesc==null)?newAttr:resultDesc),newcodestatus+" - "+info.StatusText,now,"#JMJ",newstatus.ToString());
					codestatus = codestatus | (int)info.Status;		
				}
									
			}
			//			util.LogEvent("test","test","Exited Loop",2);
			string severity;
			
			if((codestatus & (int)Status.Fail) == (int)Status.Fail)
			{
				newcodestatus="Fail";
				severity="3";
			}
			else if((codestatus & (int)Status.Warn) == (int)Status.Warn)
			{
				newcodestatus="Warning";
				severity="2";
			}
			else if((codestatus & (int)Status.Pass) == (int)Status.Pass)
			{
				newcodestatus="Pass";
				severity="1";
			}
			else
			{
				newcodestatus="Warning";
				severity="2";
			}
			
			docXML = addEncounterNoteToClaimsScrubberXML(docXML,"Property","Code Check Status",newcodestatus,now,"#JMJ",severity);
			return docXML.DocumentElement.OuterXml;
		}
		private string getCpt(string xml,string attr)
		{
			XmlDocument newdoc =  new XmlDocument();
			newdoc.LoadXml(xml);
			string newcode = attr;
			string cptnumber = null; 
			string primdx = "PRIMDX";
			string secdx = "SECDX";
			string thirddx = "THIRDDX";
			string fourthdx = "FOURTHDX";
			string cptname = "CPTCODE";
			int mylen = attr.Length;
			char last='0';
			foreach(char c in attr)
			{
				if(Char.IsNumber(c))
				{
					if (c=='2' && last.ToString().ToUpper()=="V") 
						continue;
					cptnumber = c.ToString();
					break;
				}
				last=c;
			}
			cptname = cptname + cptnumber;
			foreach (XmlNode node in newdoc.DocumentElement.GetElementsByTagName("var"))
			{
				if (node.Attributes["name"].Value.ToUpper() == cptname) 
				{
					cptname = "CPT=" + node.FirstChild.InnerText.Trim();
					break;
				}
			}
			if (attr.IndexOf("prim")==0)
			{
				primdx = primdx + cptnumber;
				foreach (XmlNode node2 in newdoc.DocumentElement.GetElementsByTagName("var"))
				{
					if (node2.Attributes["name"].Value == primdx) 
					{
						cptname = cptname + " ICD=" + node2.FirstChild.InnerText.Trim();
						break;
					}
				}
			}
			if (attr.IndexOf("sec")==0)
			{
				secdx = secdx + cptnumber;
				foreach (XmlNode node3 in newdoc.DocumentElement.GetElementsByTagName("var"))
				{
					if (node3.Attributes["name"].Value == secdx) 
					{
						cptname = cptname + " ICD=" + node3.FirstChild.InnerText.Trim();
						break;
					}
				}
			}
			if (attr.IndexOf("third")==0)
			{
				thirddx = thirddx + cptnumber;
				foreach (XmlNode node4 in newdoc.DocumentElement.GetElementsByTagName("var"))
				{
					if (node4.Attributes["name"].Value == thirddx) 
					{
						cptname = cptname + " ICD=" + node4.FirstChild.InnerText.Trim();
						break;
					}
				}	
			}
			if (attr.IndexOf("fourth")==0)
			{
				fourthdx = fourthdx + cptnumber;
				foreach (XmlNode node5 in newdoc.DocumentElement.GetElementsByTagName("var"))
				{
					if (node5.Attributes["name"].Value == fourthdx) 
					{
						cptname = cptname + " ICD=" + node5.FirstChild.InnerText.Trim();
						break;
					}
				}	
			}
			return cptname;
		}
		private string passPacket(string xml)
		{
			XmlDocument newdoc =  new XmlDocument();
			newdoc.LoadXml(xml);

			foreach (XmlNode n in newdoc.DocumentElement.GetElementsByTagName("var"))
			{
				if (n.Attributes["name"].Value.ToUpper() == "STATUSCODE") 
				{
					if (n.FirstChild.InnerText == "0.0")
						return "Pass";
					else
						return "Fail";
				}
			}
			return "Fail";
		}
	
		
		private string checkdxresult(string xml,string var,string attr,string value)
		{
			XmlDocument newdoc =  new XmlDocument();
			newdoc.LoadXml(xml);
			string newvar = var.Substring(0,var.Length-1) + "RESULT";
			foreach (XmlNode n in newdoc.DocumentElement.GetElementsByTagName("var"))
			{
				if (n.Attributes["name"].Value.ToUpper() == newvar) 
				{
					if (n.FirstChild.InnerText == "R")
					{
						if (value == "1.0")
							return "Fail";
						if (value == "7.0")
							return "Fail";
						if (value == "10.0")
							return "Fail";
						if (value == "11.0")
							return "Fail";
					}
					if (n.FirstChild.InnerText == "Y")
						if (value == "11.0")
							return "Warning";
				}	
				else
					return "Pass";
			}
			return "Pass";
		}
			
	
		//		private System.Collections.Specialized.HybridDictionary getCodeDictionary()
		//		{
		//			System.Collections.Specialized.HybridDictionary myhash = new System.Collections.Specialized.HybridDictionary();
		//			
		//			#region codes
		//
		//			System.Collections.Specialized.HybridDictionary codes = new System.Collections.Specialized.HybridDictionary();
		//
		//			codes.Add(0, new StatusInfo("success",Status.Pass));
		//			codes.Add(1, new StatusInfo("No data passed to validator",Status.Fail));
		//			codes.Add(2, new StatusInfo("Data passed to validator not a structure",Status.Fail));
		//			codes.Add(3, new StatusInfo("Invalid login",Status.Fail));
		//			codes.Add(4, new StatusInfo("Data not WDDX packet",Status.Fail));
		//			codes.Add(99, new StatusInfo("Failed insert on the unique number table",Status.Fail));
		//
		//			myhash.Add("statuscode", codes);
		//
		//			codes = new System.Collections.Specialized.HybridDictionary();
		//            codes.Add(0, new StatusInfo("Valid CPT code",Status.Pass));
		//			codes.Add(1, new StatusInfo("Invalid CPT code",Status.Fail));
		//			codes.Add(2, new StatusInfo("Expired CPT code",Status.Fail));
		//
		//			myhash.Add("cptcoderesult", codes);
		//			
		//			codes = new System.Collections.Specialized.HybridDictionary();
		//			codes.Add(0, new StatusInfo("No age issue",Status.Pass));
		//			codes.Add(2, new StatusInfo("ICD9 issue with age",Status.Fail));
		//
		//			myhash.Add("age_issue", codes);
		//			
		//			codes = new System.Collections.Specialized.HybridDictionary();
		//			codes.Add(0, new StatusInfo("No gender issue",Status.Pass));
		//			codes.Add(1, new StatusInfo("CPT issue with gender",Status.Fail));
		//			codes.Add(2, new StatusInfo("ICD9 issue with gender",Status.Fail));
		//			codes.Add(3, new StatusInfo("CPT and ICD9 issue with gender",Status.Fail));
		//
		//			myhash.Add("gender_issue", codes);
		//
		//			codes = new System.Collections.Specialized.HybridDictionary();
		//			codes.Add(0, new StatusInfo("No maternity issue",Status.Pass));
		//			codes.Add(2, new StatusInfo("ICD9 issue with maternity",Status.Fail));
		//
		//			myhash.Add("maternity_issue", codes);
		//
		//			codes = new System.Collections.Specialized.HybridDictionary();
		//			codes.Add(0, new StatusInfo("Valid Modifier/CPT combination",Status.Pass));
		//			codes.Add(1, new StatusInfo("Invalid Modifier/CPT combination",Status.Fail));
		//			codes.Add(2, new StatusInfo("Modifier is missing and may be required",Status.Warn));
		//
		//			myhash.Add("modifierresult", codes);
		//
		//			codes = new System.Collections.Specialized.HybridDictionary();
		//			codes.Add(0, new StatusInfo("Valid Dx Code",Status.Pass));
		//			codes.Add(1, new StatusInfo("Invalid Dx Code",Status.Fail));
		//			codes.Add(2, new StatusInfo("Not coded to highest level",Status.Fail));
		//			codes.Add(3, new StatusInfo("Unspecified code",Status.Warn));
		//			codes.Add(4, new StatusInfo("Nonspecific code",Status.Warn));
		//			codes.Add(5, new StatusInfo("Manifestation code",Status.Warn));
		//
		//			myhash.Add("dxresult", codes);
		//
		//			//Medical Necessity
		//			codes = new System.Collections.Specialized.HybridDictionary();
		//			codes.Add("R", new StatusInfo("Medical necessity issue -Red",Status.Fail));
		//			codes.Add("G", new StatusInfo("Medical necessity requirement met -Green",Status.Pass));
		//			codes.Add("Y", new StatusInfo("Possible medical necessity issue -Yellow",Status.Warn));
		//			codes.Add("C", new StatusInfo("No policy exists -Clear",Status.Pass));
		//			codes.Add("S", new StatusInfo("Not covered by Medicare -Shaded",Status.Warn));
		//
		//			myhash.Add("dxncdresult",codes);
		//			myhash.Add("dxlmrpresult",codes);
		//
		//			codes = new System.Collections.Specialized.HybridDictionary();
		//			codes.Add(-1, new StatusInfo("Policy not found",Status.Pass));
		//			codes.Add(1, new StatusInfo("CPT and ICD-9 combination",Status.Pass));
		//			codes.Add(2, new StatusInfo("Valid CPT that requires 2 ICD9's",Status.Warn));
		//			codes.Add(4, new StatusInfo("Time sensitive frequency edit",Status.Warn));
		//			codes.Add(5, new StatusInfo("Unlisted/unspecifiec CPT for policy where unlisted CPT is only code",Status.Warn));
		//			codes.Add(6, new StatusInfo("Unlisted/unspecified CPT code for policy when multiple CPT codes are in policy",Status.Warn));
		//			codes.Add(7, new StatusInfo("Policy list all diagnosis that do not meet necessity or lists non-covered procedure",Status.Pass));
		//			codes.Add(8, new StatusInfo("Experimental/investigational",Status.Fail));
		//			codes.Add(9, new StatusInfo("Two CPT codes to meet Medical necessity",Status.Warn));
		//			codes.Add(10, new StatusInfo("Policy list of ICD9 codes are designated as invalid or rest of ICD9 codes not mentioned in the policy",Status.Warn));
		//			codes.Add(11, new StatusInfo("Policy list of ICD9 codes are designated as invalid or rest of universe is in the policy",Status.Warn));
		//			codes.Add(12, new StatusInfo("Contains additional CPT codes not directly related to the ICD9",Status.Warn));
		//			codes.Add(13, new StatusInfo("Requires additional documentation",Status.Warn));
		//			codes.Add(14, new StatusInfo("CPT code covered but no ICD-9 codes are specified",Status.Warn));
		//			codes.Add(15, new StatusInfo("Ambulance edit",Status.Warn));
		//			codes.Add(16, new StatusInfo("Policy too complex for existing logic",Status.Warn));
		//			codes.Add(17, new StatusInfo("Medicare will deny payment",Status.Warn));
		//
		//			
		//			myhash.Add("dxncdv",codes);
		//			myhash.Add("dxlmrpv",codes);
		//
		//			codes = new System.Collections.Specialized.HybridDictionary();
		//			codes.Add(-1, new StatusInfo("Does not apply",Status.Pass));
		//			codes.Add(1, new StatusInfo("Bundling issue and modifier is allowed",Status.Warn));
		//			codes.Add(0, new StatusInfo("Bundling code cannot be used",Status.Fail));
		//			codes.Add(9, new StatusInfo("Bundling issue and modifier is allowed",Status.Pass));
		//
		//			myhash.Add("ccistatus",codes);
		//			#endregion
		//
		//			return myhash;
		//		}
		private string reformatCode(string orig_code)
		{
			string newcode = orig_code;
			
			int mylen = orig_code.Length;
			for (int i = mylen-1;i>-1;i--) 
			{
				if(Char.IsNumber(orig_code[i]))
				{
					orig_code = orig_code.Substring(0,i) + orig_code.Substring(i+1,orig_code.Length-(i+1));
				}
			}
			if (orig_code.IndexOf("prim")==0)
			{
				orig_code = orig_code.Substring(4,orig_code.Length-4);
			}
			if (orig_code.IndexOf("sec")==0)
			{
				orig_code = orig_code.Substring(3,orig_code.Length-3);
			}
			if (orig_code.IndexOf("third")==0)
			{
				orig_code = orig_code.Substring(5,orig_code.Length-5);
			}
			if (orig_code.IndexOf("fourth")==0)
			{
				orig_code = orig_code.Substring(6,orig_code.Length-6);
			}
			if (newcode != orig_code)
				newcode = orig_code;
			return newcode;
		}
		private XmlDocument createClaimsScrubberXML(String strPatientID, 
			String strFirstName, 
			String strLastName, 
			String strMiddleName,
			String strDateOfBirth,
			String strSex,
			String strJMJValue,
			String strEncounterDate,
			String strDescription)
		{
			System.Xml.XmlDocument docXML = new System.Xml.XmlDocument();
			String strClaimsScrubberResponse = "" + 
				"<JMJDocument>" + 
				"<CustomerID>999</CustomerID>" + 
				"<OwnerID>0</OwnerID>" + 
				"<Actors>" + 
				"<Actor ActorID=\"1\">" + 
				"<Name>CodeCorrect, Inc.</Name>" + 
				"<ObjectID>" + 
				"<OwnerID>0</OwnerID>" + 
				"<IDDomain>OwnerID</IDDomain>" + 
				"<IDValue>110</IDValue>" + 
				"</ObjectID>" + 
				"</Actor>" + 
				"</Actors>" + 
				"<PatientRecord>" + 
				"<PatientID>" + 
				"<OwnerID>999</OwnerID>" + 
				"<JMJDomain>cpr_id</JMJDomain>" + 
				"<JMJValue>" + strPatientID + "</JMJValue>" + 
				"</PatientID>" + 
				"<FirstName>" + strFirstName + "</FirstName>" + 
				"<LastName>" + strLastName + "</LastName>" + 
				"<MiddleName>" + strMiddleName + "</MiddleName>" + 
				"<DateOfBirth>" + strDateOfBirth + "</DateOfBirth>" + 
				"<Sex>" + strSex + "</Sex>" + 
				"<Encounter>" + 
				"<ObjectID>" + 
				"<OwnerID>999</OwnerID>" + 
				"<JMJDomain>encounter_id</JMJDomain>" + 
				"<JMJValue>" + strJMJValue + "</JMJValue>" + 
				"</ObjectID>" + 
				"<EncounterDate>" + strEncounterDate + "</EncounterDate>" + 
				"<Description>" + strDescription + "</Description>" + 
				"</Encounter>" + 
				"</PatientRecord>" + 
				"</JMJDocument>";

			docXML.LoadXml(strClaimsScrubberResponse);
			return docXML;

		}
		private XmlDocument addEncounterNoteToClaimsScrubberXML(
			XmlDocument xmlDoc,
			String strNoteType,
			String strNoteKey,
			String strNoteText,
			String strNoteDate,
			String strNoteBy,
			String strNoteSeverity)
		{
			XmlNode n = xmlDoc.SelectSingleNode("//JMJDocument/PatientRecord/Encounter");

			XmlElement eEncounterNote = xmlDoc.CreateElement("EncounterNote");

			XmlElement eNoteType = xmlDoc.CreateElement("NoteType");
			XmlNode eNoteTypeText = xmlDoc.CreateTextNode(strNoteType);
			eNoteType.AppendChild(eNoteTypeText);

			XmlElement eNoteKey = xmlDoc.CreateElement("NoteKey");
			XmlNode eNoteKeyText = xmlDoc.CreateTextNode(strNoteKey);
			eNoteKey.AppendChild(eNoteKeyText);

			XmlElement eNoteText = xmlDoc.CreateElement("NoteText");
			XmlNode eNoteTextText = xmlDoc.CreateTextNode(strNoteText);
			eNoteText.AppendChild(eNoteTextText);

			XmlElement eNoteDate = xmlDoc.CreateElement("NoteDate");
			XmlNode eNoteDateText = xmlDoc.CreateTextNode(strNoteDate);
			eNoteDate.AppendChild(eNoteDateText);

			XmlElement eNoteBy = xmlDoc.CreateElement("NoteBy");
			XmlNode eNoteByText = xmlDoc.CreateTextNode(strNoteBy);
			eNoteBy.AppendChild(eNoteByText);

			XmlElement eNoteSeverity = xmlDoc.CreateElement("NoteSeverity");
			XmlNode eNoteSeverityText = xmlDoc.CreateTextNode(strNoteSeverity);
			eNoteSeverity.AppendChild(eNoteSeverityText);

			eEncounterNote.AppendChild(eNoteType);
			eEncounterNote.AppendChild(eNoteKey);
			eEncounterNote.AppendChild(eNoteText);
			eEncounterNote.AppendChild(eNoteDate);
			eEncounterNote.AppendChild(eNoteBy);
			eEncounterNote.AppendChild(eNoteSeverity);

			n.AppendChild(eEncounterNote);

			return xmlDoc;
		}
	}
}
