using System;
using System.IO;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;

namespace EproLibNET
{
	//	public interface iGRITS
	//	{
	//		int PrintReport(string ReportID, object AdoCon, int AttributeCount, string[] Attributes, string[] Values);
	//		int Initialize(int AttributeCount, string[] Attributes, string[] Values);
	//		bool Is_Printable();
	//		bool Is_Displayable();
	//		int Finished();
	//   	}
	/// <summary>
	/// EproLibNet.GRITS Class contains methods for generating flatfiles for transfer of
	/// immunization data to the Georgia Registry of Immunization Transactions
	/// and Services (GRITS).
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class GRITS2//:iGRITS
	{

		#region Declare variables
		string ClientFileName=null, VaccineFileName=null;
		bool Batch=false;
		bool Historical=false;
		SqlConnection conn = null;
		SqlConnection conn2 = null;
		SqlCommand com = null;
		SqlCommand com2 = null;
		string OutputDir = null;
		GRITSData dsGRITSData = null;
		System.Collections.Specialized.StringDictionary AttributeDictionary = null;
		#endregion // Declare variables

		/// <summary>
		/// Constructor for GRITS class.
		/// </summary>
		public GRITS2()
		{
		}

		/// <summary>
		/// Called by EncounterPRO to order a report to be printed or displayed.
		/// For all reports, PROGKEY_ELIG and OUTPUTDIR Attributes are expected.
		/// For a batch report, function expects STARTDATE and ENDDATE Attributes.
		/// For an Encounter report, function expects CPR_ID and ENCOUNTER_ID Attributes but no
		/// STARTDATE or ENDDATE Attributes.
		/// </summary>
		/// <param name="ReportID">The unique ID for the report to run.</param>
		/// <param name="AdoCon">The ADO Connection object to connect to the EncounterPRO database.
		/// This parameter is ignored.  A new connection is built with the information provided from EncounterPRO.</param>
		/// <param name="AttributeCount">The number of items in the Attributes array.</param>
		/// <param name="Attributes">String array of Attributes.</param>
		/// <param name="Values">String array of Values.</param>
		/// <returns>1==Success, 0==Nothing Happened, -1==Error.</returns>
		public int PrintReport(string ReportID, int AttributeCount, string[] Attributes, string[] Values)
		{
			dsGRITSData = new GRITSData();

			Utilities util = new Utilities();
			util.InitializeEventLog("EncounterPRO");
			util.LogEvent("EproLibNET.GRITS2","PrintReport()","PrintReport started",1);

			try
			{
				#region Build AttributeDictionary
				if(null==Attributes||null==Values||Attributes.Length!=Values.Length)
				{
					// if Attributes or Values are null or do not have 
					// the same number of items, return Error.
					util.LogEvent("EproLibNET.GRITS2","PrintReport()","Attributes or Values is NULL or they have a different number of items.",5);
					return -1;
				}

				AttributeDictionary  = new System.Collections.Specialized.StringDictionary();

				// populate AttributeDictionary with Attributes and Values passed from EncounterPRO
				for(int i=0; i<Attributes.Length; i++)
				{
					if(null!=Attributes[i]&&!AttributeDictionary.ContainsKey(Attributes[i].ToUpper()))
					{
						AttributeDictionary.Add(Attributes[i].ToUpper(),Values[i]);
					}
				}
				if(!AttributeDictionary.ContainsKey("PROGKEY_ELIG")||!AttributeDictionary.ContainsKey("OUTPUTDIR"))
				{
					// No PROGKEY_ELIG Attribute or no OUTPUTDIR Attribute
					// return error
					util.LogEvent("EproLibNET.GRITS2","PrintReport()","No PROGKEY_ELIG or no OUTPUTDIR Attribute defined",5);

					return -1;
				}
				OutputDir = AttributeDictionary["OUTPUTDIR"];
				try
				{
					Directory.CreateDirectory(OutputDir);
				}
				catch(Exception exc)
				{
					// OUTPUTDIR is not valid
					// return error
					util.LogEvent("EproLibNET.GRITS2","PrintReport()",exc.ToString(),4);
					return -1;
				}
				#endregion // Build AttributeDictionary
			
				#region Establish database connection
				try
				{
					util.LogEvent("EproLibNET.GRITS2","PrintReport()","Establishing Database Connection",1);
					conn = new SqlConnection();
					conn.ConnectionString="Server='"+AttributeDictionary["SERVERNAME"].ToString()+"';Database='"+AttributeDictionary["DATABASE"].ToString()+"';UID='"+AttributeDictionary["UID"].ToString()+"';PWD='"+AttributeDictionary["PWD"].ToString()+"';Persist Security Info = false;Pooling=false";
					conn.Open();
					conn2 = new SqlConnection();
					conn2.ConnectionString="Server='"+AttributeDictionary["SERVERNAME"].ToString()+"';Database='"+AttributeDictionary["DATABASE"].ToString()+"';UID='"+AttributeDictionary["UID"].ToString()+"';PWD='"+AttributeDictionary["PWD"].ToString()+"';Persist Security Info = false;Pooling=false";
					conn2.Open();

					com=new SqlCommand();
					com.Connection=conn;
					com2=new SqlCommand();
					com2.Connection=conn2;
					//	--------------	No setapprole for 2.21

					//					try
					//					{
					//						// Some systems may not have the application role set up.
					//						// Do not fail if setapprole fails
					//						com = new SqlCommand("EXEC dbo.sp_setapprole 'cprsystem', '" + AttributeDictionary["DATA_WHERE"].ToString() + "'", conn);
					//						com.ExecuteNonQuery();
					//						com2 = new SqlCommand("EXEC dbo.sp_setapprole 'cprsystem', '" + AttributeDictionary["DATA_WHERE"].ToString() + "'", conn2);
					//						com2.ExecuteNonQuery();
					//					}
					//					catch(Exception exc)
					//					{
					//						MessageBox.Show(exc.ToString());
					//					}
				}
				catch(Exception exc)
				{
					util.LogEvent("EproLibNET.GRITS2","PrintReport()","Error Connecting to Database.\r\n\r\n"+exc.ToString(),4);
					return -1;
				}
				#endregion // Establish database connection

				#region Determine what Encounters to process vaccines for
				SqlDataReader reader=null;
				try
				{
					util.LogEvent("EproLibNET.GRITS2","PrintReport()","Finding Encounters to process",1);
					if(AttributeDictionary.ContainsKey("STARTDATE")&&null!=AttributeDictionary["STARTDATE"]&&AttributeDictionary.ContainsKey("ENDDATE")&&null!=AttributeDictionary["ENDDATE"])
					{
						Batch=true;
						if(AttributeDictionary.ContainsKey("HISTORICAL")&&null!=AttributeDictionary["HISTORICAL"]&&AttributeDictionary["HISTORICAL"]=="Y")
						{
							Historical=true;
						}
						// Look for a range of Encounters.
						dsGRITSData = new GRITSData();
						string start=AttributeDictionary["STARTDATE"];
						string end=AttributeDictionary["ENDDATE"];
						com.CommandText = 
							"SELECT DISTINCT "+
							"p_Patient_Encounter.cpr_id, "+
							"p_Patient_Encounter.encounter_id "+
							"FROM "+
							"p_Patient_Encounter INNER JOIN p_Treatment_Item ON "+
							"p_Patient_Encounter.cpr_id = p_Treatment_Item.cpr_id AND "+
							"p_Patient_Encounter.encounter_id = p_Treatment_Item.open_encounter_id "+
							"WHERE "+
							"p_Patient_Encounter.encounter_date >= '" + start + "' AND "+
							"p_Patient_Encounter.encounter_date < '" + System.DateTime.Parse(end,System.Globalization.DateTimeFormatInfo.CurrentInfo).AddDays(1).ToShortDateString() + "' AND "+
							"(p_Treatment_Item.treatment_type = 'IMMUNIZATION' OR "+
							"p_Treatment_Item.treatment_type = 'PASTIMMUN')";//<- changed 9/8/05
						reader = com.ExecuteReader();
						while(reader.Read())
						{
							AddGRITSEncounterData(reader["cpr_id"].ToString(),(int)reader["encounter_id"]);
						}
						reader.Close();
					}
					else if(AttributeDictionary.ContainsKey("CPR_ID")&&null!=AttributeDictionary["CPR_ID"]&&AttributeDictionary.ContainsKey("ENCOUNTER_ID")&&null!=AttributeDictionary["ENCOUNTER_ID"])
					{
						// Single Encounter.
						AddGRITSEncounterData(AttributeDictionary["CPR_ID"], Int32.Parse(AttributeDictionary["ENCOUNTER_ID"]));
					}
					else
					{
						// No valid STARTDATE/ENDDATE and no valid CPR_ID/ENCOUNTER_ID.
						// return error.
						util.LogEvent("EproLibNET.GRITS2","PrintReport()","No valid STARTDATE/ENDDATE and no valid CPR_ID/ENCOUNTER_ID.",5);
						return -1;
					}
				}
				catch(Exception exc)
				{
					// Error while getting range of Encounters to process
					// return error.
					//MessageBox.Show("Error getting range of Encounters\r\n\r\n"+exc.ToString());
					util.LogEvent("EproLibNET.GRITS2","PrintReport()","Error getting range of Encounters\r\n\r\n"+exc.ToString(),5);
					return -1;
				}
				finally
				{
					try
					{
						reader.Close();
					}
					catch{}
				}
				#endregion // Determine what Encounters to process vaccines for

				#region Get CLIENT data
				try
				{
					util.LogEvent("EproLibNET.GRITS2","PrintReport()","Getting Client Data",1);

					foreach(GRITSData.CLIENTRow ClientRow in dsGRITSData.CLIENT.Rows)
					{
						SqlDataReader p_PatientReader=null, sdr_VaccineEligibility=null;
						try
						{
							com.CommandText="SELECT cpr_id, first_name, last_name, date_of_birth, sex, "+
								"phone_number FROM " +
								"p_Patient WHERE cpr_id='"+ClientRow.CPR_ID+"'";
							p_PatientReader = com.ExecuteReader(System.Data.CommandBehavior.SingleRow);

							if(!Historical)
							{
								com2.CommandText="SELECT TOP 1 result FROM c_Observation_Result WITH (NOLOCK) "+
									"INNER JOIN p_Objective_Result ON c_Observation_Result.observation_id = "+
									"p_Objective_Result.observation_id AND c_Observation_Result.result_sequence = "+
									"p_Objective_Result.result_sequence "+
									"WHERE c_Observation_Result.result IS NOT NULL AND "+
									"c_Observation_Result.result_type = 'PERFORM' AND "+
									"p_Objective_Result.cpr_id = '" + ClientRow.CPR_ID + "' AND "+
									"c_Observation_Result.observation_id = '" + AttributeDictionary["PROGKEY_ELIG"] + "' " +
									"ORDER BY p_Objective_Result.result_date_time DESC";
								sdr_VaccineEligibility = com2.ExecuteReader(System.Data.CommandBehavior.SingleRow);
							}
							if(!p_PatientReader.Read())
							{
								// No results returned from p_Patient query
								// skip patient
								//dsGRITSData.CLIENT.RemoveCLIENTRow(ClientRow);
								continue;
							}
							if(!Historical&&!sdr_VaccineEligibility.Read())
							{
								// No results returned from fn_progress
								// skip patient
								//dsGRITSData.CLIENT.RemoveCLIENTRow(ClientRow);
								continue;
							}
							if(!DBNull.Value.Equals(p_PatientReader["first_name"])&&null!=p_PatientReader["first_name"])
							{
								ClientRow.FIRSTNAME=p_PatientReader["first_name"].ToString();
							}
							else
							{
								ClientRow.FIRSTNAME="NO FIRST NAME";
							}
							if(!DBNull.Value.Equals(p_PatientReader["last_name"])&&null!=p_PatientReader["last_name"])
							{
								ClientRow.LASTNAME=p_PatientReader["last_name"].ToString();
							}
							else
							{
								// No valid LASTNAME
								// skip patient
								//dsGRITSData.CLIENT.RemoveCLIENTRow(ClientRow);
								continue;
							}
							if(!DBNull.Value.Equals(p_PatientReader["date_of_birth"])&&null!=p_PatientReader["date_of_birth"])
							{
								ClientRow.BIRTHDATE=DateTime.Parse(p_PatientReader["date_of_birth"].ToString());
							}
							else
							{
								// No valid BIRTHDATE
								// skip patient
								//dsGRITSData.CLIENT.RemoveCLIENTRow(ClientRow);
								continue;
							}
							if(!DBNull.Value.Equals(p_PatientReader["sex"])&&null!=p_PatientReader["sex"]&&(p_PatientReader["sex"].ToString().Equals("M")||p_PatientReader["sex"].ToString().Equals("F")))
							{
								ClientRow.SEX=p_PatientReader["sex"].ToString();
							}
							else
							{
								ClientRow.SEX="U";
							}
							// NO SSN IN 2.21
							ClientRow.SSN=null;

							if(!DBNull.Value.Equals(p_PatientReader["phone_number"])&&null!=p_PatientReader["phone_number"])
							{
								ClientRow.PHONE=p_PatientReader["phone_number"].ToString().Replace("(","").Replace(")","").Replace("-","").Replace(" ","");
							}
							// NO ADDRESS IN 2.21
							ClientRow.ADDRESS=null;

							// NO CITY IN 2.21
							ClientRow.CITY=null;

							// NO STATE IN 2.21
							ClientRow.STATE=null;

							// NO ZIP IN 2.21
							ClientRow.ZIP=null;

							if(Historical)
							{
								ClientRow.ELIGIBILITY="V00";
							}
							else if(!DBNull.Value.Equals(sdr_VaccineEligibility[0])&&null!=sdr_VaccineEligibility[0])
							{
								if(sdr_VaccineEligibility[0].ToString().ToUpper()=="V01"||
									sdr_VaccineEligibility[0].ToString().ToUpper()=="V02"||
									sdr_VaccineEligibility[0].ToString().ToUpper()=="V03"||
									sdr_VaccineEligibility[0].ToString().ToUpper()=="V04"||
									sdr_VaccineEligibility[0].ToString().ToUpper()=="V05"||
									sdr_VaccineEligibility[0].ToString().ToUpper()=="V06")
								{
									ClientRow.ELIGIBILITY=sdr_VaccineEligibility[0].ToString().ToUpper();
								}
								else
								{
									// No Valid ELIGIBILITY
									// skip patient
									//dsGRITSData.CLIENT.RemoveCLIENTRow(ClientRow);
									continue;
								}
							}
						}
						catch(Exception exc)
						{
							//MessageBox.Show("Error getting Client Data\r\n\r\n"+exc.ToString());
							//dsGRITSData.CLIENT.RemoveCLIENTRow(ClientRow);
							util.LogEvent("EproLibNET.GRITS2","PrintReport()","Error getting Client Data\r\n\r\n"+exc.ToString(),4);
							continue;
						}
						finally
						{
							try
							{
								p_PatientReader.Close();
								sdr_VaccineEligibility.Close();
							}
							catch{}
						}
					}
				}
				catch(Exception exc)
				{
					//MessageBox.Show("Error getting Client Data\r\n\r\n"+exc.ToString());
					util.LogEvent("EproLibNET.GRITS2","PrintReport()","Error getting Client Data\r\n\r\n"+exc.ToString(),5);
					return -1;
				}
				finally
				{
					GRITSData.CLIENTRow[] EmptyClientRows = (GRITSData.CLIENTRow[])dsGRITSData.CLIENT.Select("FIRSTNAME IS NULL");
					GRITSData.ENCOUNTERRow[] EmptyEncounterRows;
					for(int i=EmptyClientRows.Length-1; i>-1; i--)
					{
						EmptyEncounterRows = (GRITSData.ENCOUNTERRow[])dsGRITSData.ENCOUNTER.Select("CPR_ID = '" + EmptyClientRows[i].CPR_ID + "'");
						for(int j=EmptyEncounterRows.Length-1; j>-1; j--)
						{
							EmptyEncounterRows[j].Delete();
						}
						EmptyClientRows[i].Delete();
					}
				}
				#endregion // Get CLIENT data

				#region Get VACCINE data
				try
				{
					util.LogEvent("EproLibNET.GRITS2","PrintReport()","Getting Vaccine Data",1);

					foreach(GRITSData.ENCOUNTERRow EncounterRow in dsGRITSData.ENCOUNTER.Rows)
					{
						SqlDataReader VaccineReader = null;
						try
						{
							com.CommandText = 
								"SELECT "+
								"p_Treatment_Item.cpr_id, "+
								"p_Treatment_Item.open_encounter_id, "+
								"p_Treatment_Item.treatment_id, "+
								"p_Treatment_Item.begin_date, "+
								"c_Procedure.cpt_code, "+
								"c_User.user_full_name, "+
								"c_Office.description "+
								"FROM "+
								"p_Treatment_Item INNER JOIN p_Encounter_Charge ON "+
								"p_Treatment_Item.cpr_id = p_Encounter_Charge.cpr_id AND "+
								"p_Treatment_Item.open_encounter_id = p_Encounter_Charge.encounter_id AND "+
								"p_Treatment_Item.treatment_id = p_Encounter_Charge.treatment_id "+
								"INNER JOIN c_Procedure ON p_Encounter_Charge.procedure_id = c_Procedure.procedure_id "+
								"LEFT OUTER JOIN p_Patient ON p_Treatment_Item.cpr_id = p_Patient.cpr_id "+
								"LEFT OUTER JOIN c_User ON p_Patient.primary_provider_id = c_User.user_id "+
								"LEFT OUTER JOIN c_Office ON p_Patient.office_id = c_Office.office_id "+
								"WHERE "+
								"c_Procedure.cpt_code IS NOT NULL AND "+
								"p_Treatment_Item.treatment_type = 'IMMUNIZATION' AND "+
								"p_Treatment_Item.treatment_status <> 'CANCELLED' AND "+
								"p_Treatment_Item.cpr_id = '"+ EncounterRow.CPR_ID +"' AND "+
								"p_Treatment_Item.open_encounter_id = "+EncounterRow.ENCOUNTER_ID.ToString();
							VaccineReader = com.ExecuteReader();
							try 
							{
								while(VaccineReader.Read())
								{
									try
									{
										AddGRITSVaccineData(VaccineReader["cpr_id"].ToString(), 
											VaccineReader["open_encounter_id"], VaccineReader["treatment_id"], 
											VaccineReader["begin_date"], VaccineReader["cpt_code"].ToString(), 
											VaccineReader["user_full_name"].ToString(), 
											VaccineReader["description"].ToString(),
											null);//blank common_name
									}
									catch(Exception exc)
									{
										//MessageBox.Show("Error Getting Vaccine Data\r\n\r\n"+exc.ToString());
										util.LogEvent("EproLibNET.GRITS2","PrintReport()","Error getting Vaccine Data\r\n\r\n"+exc.ToString(),4);
										continue;
									}
								}
							}
							finally
							{
								VaccineReader.Close();
							}
							//<- put new vaccinereader and new query here
							if (Historical)
							{
								SqlDataReader VaccineReader2 = null;
								com.CommandText = "SELECT "+
									"p_Treatment_Item.cpr_id, "+
									"p_Treatment_Item.open_encounter_id, "+
									"p_Treatment_Item.treatment_id, "+
									"p_Treatment_Item.begin_date, "+
									"c_Drug_Definition.common_name, "+
									"c_User.user_full_name, "+
									"c_Office.description "+
									"FROM "+
									"(c_Office "+
									"INNER JOIN ((p_Patient "+
									"INNER JOIN p_Treatment_Item "+
									"ON p_Patient.cpr_id = p_Treatment_Item.cpr_id) "+
									"INNER JOIN c_User "+
									"ON p_Patient.primary_provider_id = c_User.user_id) "+
									"ON c_Office.office_id = p_Patient.office_id) "+
									"INNER JOIN c_Drug_Definition "+
									"ON p_Treatment_Item.drug_id = c_Drug_Definition.drug_id "+
									"WHERE "+
									"p_Treatment_Item.treatment_type = 'PASTIMMUN' AND "+
									"(p_Treatment_Item.treatment_status <> 'CANCELLED' OR "+
									"p_Treatment_Item.treatment_status IS NULL) AND "+
									"p_Treatment_Item.cpr_id = '"+ EncounterRow.CPR_ID +"' AND "+
									"p_Treatment_Item.open_encounter_id = "+EncounterRow.ENCOUNTER_ID.ToString();
								VaccineReader2 = com.ExecuteReader();
								try
								{
									while(VaccineReader2.Read())
									{
										try
										{
											AddGRITSVaccineData(VaccineReader2["cpr_id"].ToString(), 
												VaccineReader2["open_encounter_id"], VaccineReader2["treatment_id"], 
												VaccineReader2["begin_date"], "     ", // cpt_code
												VaccineReader2["user_full_name"].ToString(), 
												VaccineReader2["description"].ToString(),
												VaccineReader2["common_name"].ToString());
										}
										catch(Exception exc)
										{
											//MessageBox.Show("Error Getting Vaccine Data\r\n\r\n"+exc.ToString());
											util.LogEvent("EproLibNET.GRITS2","PrintReport()","Error getting Vaccine Data\r\n\r\n"+exc.ToString(),4);
											continue;
										}
									}
								}
								finally{
									VaccineReader2.Close();
								}

							}
						}
							 
						
						catch(Exception exc)
						{
							//MessageBox.Show("Error Getting Vaccine Data\r\n\r\n"+exc.ToString());
							util.LogEvent("EproLibNET.GRITS2","PrintReport()","Error getting Vaccine Data\r\n\r\n"+exc.ToString(),4);
							continue;
						}
						finally
						{
							try
							{
								VaccineReader.Close();
							}
							catch(Exception exc)
							{
								//MessageBox.Show(exc.ToString());
								util.LogEvent("EproLibNET.GRITS2","PrintReport()",exc.ToString(),4);
							}
						}
					}
				}
				catch(Exception exc)
				{
					//MessageBox.Show("Error Getting Vaccine Data\r\n\r\n"+exc.ToString());
					util.LogEvent("EproLibNET.GRITS2","PrintReport()","Error getting Vaccine Data\r\n\r\n"+exc.ToString(),5);
					return -1;
				}
				#endregion // Get VACCINE data

				#region Generate flat files
				util.LogEvent("EproLibNET.GRITS2","PrintReport()","Generating Flat Files",1);

				if(Batch)
				{
					if(Historical)
					{
						ClientFileName="BATCH_HIST_CLIENT";
						VaccineFileName="BATCH_HIST_VACCINE";
					}
					else
					{
						ClientFileName="BATCH_CLIENT";
						VaccineFileName="BATCH_VACCINE";
					}
				}
				else
				{
					ClientFileName="REALTIME_CLIENT";
					VaccineFileName="REALTIME_VACCINE";
				}
				foreach(GRITSData.CLIENTRow ClientRow in dsGRITSData.CLIENT.Rows)
				{
					StreamWriter ClientFile = null;
					StreamWriter VaccineFile = null;
					try
					{
						// Validate data
						if(ClientRow.FIRSTNAME.Length>25)
						{
							ClientRow.FIRSTNAME=ClientRow.FIRSTNAME.Substring(0,25);
						}
						if(ClientRow.LASTNAME.Length>35)
						{
							ClientRow.LASTNAME=ClientRow.LASTNAME.Substring(0,35);
						}
						if(DBNull.Value.Equals(ClientRow["ELIGIBILITY"]) || ClientRow.ELIGIBILITY.Length>3)
						{
							// Eligibility code length should never be greater than 3.
							// skip this record
							continue;
						}

						// Open files to write to
						if(File.Exists(Path.Combine(OutputDir,ClientFileName+".txt"))&&File.Exists(Path.Combine(OutputDir,VaccineFileName+".txt")))
						{
							if(new FileInfo(Path.Combine(OutputDir,ClientFileName+".txt")).Length>150000000||new FileInfo(Path.Combine(OutputDir,VaccineFileName+".txt")).Length>150000000)
							{
								int count=2;
								while((File.Exists(Path.Combine(OutputDir,ClientFileName+count.ToString()+".txt"))&&File.Exists(Path.Combine(OutputDir,VaccineFileName+count.ToString()+".txt")))
									&&(new FileInfo(Path.Combine(OutputDir,ClientFileName+count.ToString()+".txt")).Length>150000000||new FileInfo(Path.Combine(OutputDir,VaccineFileName+count.ToString()+".txt")).Length>150000000))
								{
									count++;
								}
								ClientFileName+=count.ToString();
								VaccineFileName+=count.ToString();
							}
							ClientFile = new StreamWriter(File.OpenWrite(Path.Combine(OutputDir,ClientFileName+".txt")),System.Text.Encoding.ASCII);
							ClientFile.BaseStream.Position=ClientFile.BaseStream.Length;
							VaccineFile = new StreamWriter(File.OpenWrite(Path.Combine(OutputDir,VaccineFileName+".txt")),System.Text.Encoding.ASCII);
							VaccineFile.BaseStream.Position=VaccineFile.BaseStream.Length;
						}
						else
						{
							ClientFile = new StreamWriter(File.Create(Path.Combine(OutputDir,ClientFileName+".txt")),System.Text.Encoding.ASCII);
							VaccineFile = new StreamWriter(File.Create(Path.Combine(OutputDir,VaccineFileName+".txt")),System.Text.Encoding.ASCII);
						}
						if(dsGRITSData.VACCINE.Select("CPR_ID='"+ClientRow.CPR_ID+"'").Length>0)
						{
							WriteClientFile(ClientRow,ClientFile);
						
						
							foreach(GRITSData.VACCINERow VaccineRow in dsGRITSData.VACCINE.Select("CPR_ID='"+ClientRow.CPR_ID+"'"))
							{
								// VALIDATION
								if(VaccineRow.TREATMENT_ID.ToString().Length>24)
								{
									VaccineRow.TREATMENT_ID=Int32.Parse(VaccineRow.TREATMENT_ID.ToString().Substring(0,24));
								}
								if(VaccineRow.CPT_CODE.Length!=5)
								{
									// CPT code length should always be 5 
									// skip this record
									continue; 
								}

								WriteVaccineFile(ClientRow, VaccineRow,VaccineFile);
							}

						}


					}
					catch(Exception exc)
					{
						//MessageBox.Show("Error Writing Flat Files\r\n\r\n"+exc.ToString());
						util.LogEvent("EproLibNET.GRITS2","PrintReport()","Error Writing Flat Files\r\n\r\n"+exc.ToString(),4);
						continue;
					}
					finally
					{
						try
						{
							ClientFile.Flush();
							ClientFile.Close();
						}
						catch{}
						try
						{
							VaccineFile.Flush();
							VaccineFile.Close();
						}
						catch{}
					}
				}
				#endregion
			}
			catch(Exception exc)
			{
				util.LogEvent("EproLibNET.GRITS2","PrintReport()",exc.ToString(),4);
			}
			finally
			{
				try
				{
					conn.Close();
					conn.Dispose();
				}
				catch{}
				try
				{
					conn2.Close();
					conn2.Dispose();
				}
				catch{}
				try
				{
					com.Dispose();
				}
				catch{}
				try
				{
					com2.Dispose();
				}
				catch{}
				try
				{
					GC.Collect();
				}
				catch{}
			}

			// return success
			util.LogEvent("EproLibNET.GRITS2","PrintReport()","Finished Successfully",1);

			return 1;
		}

		/// <summary>
		/// Adds a new CLIENT row to dsGRITSData or updates an existing row.
		/// </summary>
		/// <param name="CPR_ID">Can not be null.</param>
		/// <param name="FIRSTNAME">Null will be ignored.</param>
		/// <param name="LASTNAME">Null will be ignored.</param>
		/// <param name="BIRTHDATE">Null will be ignored.</param>
		/// <param name="ELIGIBILITY">Null will be ignored.</param>
		/// <exception cref="System.NullReferenceException">Thrown if CPR_ID param is null.</exception>
		private void AddGRITSClientData(string CPR_ID, string FIRSTNAME, string LASTNAME, object BIRTHDATE, string ELIGIBILITY)
		{
			GRITSData.CLIENTRow ClientRow = null;
			bool ClientRowIsNew = false;
			if(null==CPR_ID)
			{
				throw new NullReferenceException("CPR_ID parameter is null.");
			}
			if(dsGRITSData.CLIENT.Select("CPR_ID='"+CPR_ID+"'").Length==0)
			{
				ClientRowIsNew=true;
				ClientRow = dsGRITSData.CLIENT.NewCLIENTRow();
				ClientRow.CPR_ID=CPR_ID;
			}
			else
			{
				ClientRowIsNew=false;
				ClientRow = (GRITSData.CLIENTRow)dsGRITSData.CLIENT.Select("CPR_ID='"+CPR_ID+"'")[0];
			}
			if(null!=FIRSTNAME)
			{
				ClientRow.FIRSTNAME=FIRSTNAME;
			}
			if(null!=LASTNAME)
			{
				ClientRow.LASTNAME=LASTNAME;
			}
			if(null!=BIRTHDATE)
			{
				ClientRow.BIRTHDATE=(DateTime)BIRTHDATE;
			}
			if(null!=ELIGIBILITY)
			{
				ClientRow.ELIGIBILITY=ELIGIBILITY;
			}
			if(ClientRowIsNew)
			{
				dsGRITSData.CLIENT.AddCLIENTRow(ClientRow);
			}
		}

		private void WriteClientFile(GRITSData.CLIENTRow ClientRow, StreamWriter ClientFile)
		{
			// Write Client data
			// Record Identifier
			ClientFile.Write(ClientRow.CPR_ID.ToString().PadRight(24,' '));
			// Client Status
			ClientFile.Write("A");
			// First Name
			ClientFile.Write(ClientRow.FIRSTNAME.PadRight(25,' '));
			// Middle Name
			ClientFile.Write(new string(' ',25));
			// Last Name
			ClientFile.Write(ClientRow.LASTNAME.PadRight(35,' '));
			// Name Suffix
			ClientFile.Write(new string(' ', 10));
			// Birth Date
			ClientFile.Write(ClientRow.BIRTHDATE.ToString("MMddyyyy"));
			// Death Date
			ClientFile.Write(new string(' ', 8));
			// Mothers First Name
			ClientFile.Write(new string(' ', 25));
			// Mothers Maiden Last Name
			ClientFile.Write(new string(' ', 35));
			// Sex (Gender)
			if(!DBNull.Value.Equals(ClientRow["SEX"]))
			{
				ClientFile.Write(ClientRow.SEX.PadRight(1,' '));
			}
			else
			{
				ClientFile.Write("U");
			}
			// Race
			ClientFile.Write(new string(' ', 1));
			// Ethnicity
			ClientFile.Write(new string(' ', 2));
			// SSN
			if(!DBNull.Value.Equals(ClientRow["SSN"])&&null!=ClientRow.SSN&&ClientRow.SSN.Length==9)
			{
				ClientFile.Write(ClientRow.SSN.PadRight(9,' '));
			}
			else
			{
				ClientFile.Write(new string(' ', 9));
			}
			// Contact Allowed
			ClientFile.Write("02");
			// Consent to Share
			ClientFile.Write(new string(' ', 1));
			// Chart Number
			ClientFile.Write(ClientRow.CPR_ID.PadRight(20,' '));
			// Responsible Party First Name
			ClientFile.Write(new string(' ', 25));
			// Responsible Party Middle Name
			ClientFile.Write(new string(' ', 25));
			// Responsible Party Last Name
			ClientFile.Write(new string(' ', 35));
			// Responsible Party Relationship
			ClientFile.Write(new string(' ', 2));
			// Street Address
			if(!DBNull.Value.Equals(ClientRow["ADDRESS"])&&null!=ClientRow.ADDRESS&&ClientRow.ADDRESS.Length<56)
			{
				ClientFile.Write(ClientRow.ADDRESS.PadRight(55,' '));
			}
			else
			{
				ClientFile.Write(new string(' ', 55));
			}
			// Mailing Address Line
			ClientFile.Write(new string(' ', 55));
			// Other Address Line
			ClientFile.Write(new string(' ', 55));
			// City
			if(!DBNull.Value.Equals(ClientRow["CITY"])&&null!=ClientRow.CITY&&ClientRow.CITY.Length<53)
			{
				ClientFile.Write(ClientRow.CITY.PadRight(52,' '));
			}
			else
			{
				ClientFile.Write(new string(' ', 52));
			}
			// State
			if(!DBNull.Value.Equals(ClientRow["STATE"])&&null!=ClientRow.STATE&&ClientRow.STATE.Length==2)
			{
				ClientFile.Write(ClientRow.STATE.PadRight(2,' '));
			}
			else
			{
				ClientFile.Write(new string(' ', 2));
			}
			// Zip
			if(!DBNull.Value.Equals(ClientRow["ZIP"])&&null!=ClientRow.ZIP&&(ClientRow.ZIP.Length==5||ClientRow.ZIP.Length==9))
			{
				ClientFile.Write(ClientRow.ZIP.PadRight(9,' '));
			}
			else
			{
				ClientFile.Write(new string(' ', 9));
			}
			// County
			ClientFile.Write(new string(' ', 5));
			// Phone
			if(!DBNull.Value.Equals(ClientRow["PHONE"])&&null!=ClientRow.PHONE&&ClientRow.PHONE.Length<18)
			{
				ClientFile.Write(ClientRow.PHONE.PadRight(17,' '));
			}
			else
			{
				ClientFile.Write(new string(' ', 17));
			}
			// Sending Organization
			if(AttributeDictionary.ContainsKey("SENDINGORG")&&null!=AttributeDictionary["SENDINGORG"]&&AttributeDictionary["SENDINGORG"].Length<6)
			{
				ClientFile.Write(AttributeDictionary["SENDINGORG"].PadRight(5,' '));
			}
			else
			{
				ClientFile.Write(new string(' ', 5));
			}
			// Eligibility Code
			ClientFile.Write(ClientRow.ELIGIBILITY);
			// Eligibility Effective Date
			ClientFile.Write(DateTime.Now.ToString("MMddyyyy"));
			//Carriage Return and Line Feed mark end of message
			ClientFile.Write("\r\n");
		}
		private void WriteVaccineFile(GRITSData.CLIENTRow ClientRow, GRITSData.VACCINERow VaccineRow, StreamWriter VaccineFile)
		{
			// Write Vaccine Data
			// Client Record Identifier
			VaccineFile.Write(VaccineRow.CPR_ID.ToString().PadRight(24, ' '));
			// Vaccine Group
			VaccineFile.Write(new string(' ', 16));
			// CPT Code
			VaccineFile.Write(VaccineRow.CPT_CODE);
			// Trade Name //<-changed 9/9/05
			if(!DBNull.Value.Equals(VaccineRow["COMMON_NAME"])&&null!=VaccineRow.COMMON_NAME&&VaccineRow.COMMON_NAME.Length<25)
			{
				VaccineFile.Write(VaccineRow.COMMON_NAME.PadRight(24,' '));
			}
			else
			{
				VaccineFile.Write(new string(' ', 24));
			}
			// Vaccination Date
			VaccineFile.Write(VaccineRow.VACCINE_DATE.ToString("MMddyyyy"));
			// Administration Route Code
			VaccineFile.Write(new string(' ', 2));
			// Body Site Code
			VaccineFile.Write(new string(' ', 4));
			// Reaction Code
			VaccineFile.Write(new string(' ', 8));
			// Manufacterer Code
			VaccineFile.Write(new string(' ', 4));
			// Immunization Information Source
			VaccineFile.Write("01");
			// Lot Number
			VaccineFile.Write(new string(' ', 30));
			// Provider Name
			if(!DBNull.Value.Equals(VaccineRow["PROVIDER"])&&null!=VaccineRow.PROVIDER&&VaccineRow.PROVIDER.Length<51)
			{
				VaccineFile.Write(VaccineRow.PROVIDER.PadRight(50,' '));
			}
			else
			{
				VaccineFile.Write(new string(' ', 50));
			}
			// Administered By Name
			VaccineFile.Write(new string(' ', 50));
			// Site Name
			if(!DBNull.Value.Equals(VaccineRow["CLINIC"])&&null!=VaccineRow.CLINIC&&VaccineRow.CLINIC.Length<31)
			{
				VaccineFile.Write(VaccineRow.CLINIC.PadRight(30,' '));
			}
			else
			{
				VaccineFile.Write(new string(' ', 30));
			}
			// Sending Organization
			if(AttributeDictionary.ContainsKey("SENDINGORG")&&null!=AttributeDictionary["SENDINGORG"]&&AttributeDictionary["SENDINGORG"].Length<6)
			{
				VaccineFile.Write(AttributeDictionary["SENDINGORG"].PadRight(5,' '));
			}
			else
			{
				VaccineFile.Write(new string(' ', 5));
			}
			// Eligibility Code
			VaccineFile.Write(ClientRow.ELIGIBILITY);
			//Carriage Return and Line Feed mark end of message
			VaccineFile.Write("\r\n");
		}

		
		/// <summary>
		/// Adds a new ENCOUNTER row to dsGRITSData or updates an existing row.
		/// </summary>
		/// <param name="CPR_ID">Can not be null.</param>
		/// <param name="ENCOUNTER_ID">Can not be null.</param>
		/// <exception cref="System.NullReferenceException">Thrown if CPR_ID param is null.</exception>
		private void AddGRITSEncounterData(string CPR_ID, int ENCOUNTER_ID)
		{
			if(null==CPR_ID)
			{
				throw new NullReferenceException("CPR_ID parameter is null.");
			}
			AddGRITSClientData(CPR_ID,null,null,null,null);
			if(dsGRITSData.ENCOUNTER.Select("CPR_ID='"+CPR_ID+"' AND ENCOUNTER_ID="+ENCOUNTER_ID.ToString()).Length==0)
			{
				GRITSData.ENCOUNTERRow EncounterRow = dsGRITSData.ENCOUNTER.NewENCOUNTERRow();
				EncounterRow.CPR_ID=CPR_ID;
				EncounterRow.ENCOUNTER_ID=ENCOUNTER_ID;
				dsGRITSData.ENCOUNTER.AddENCOUNTERRow(EncounterRow);
			}
		}


		/// <summary>
		/// Adds a new VACCINE row to dsGRITSData or updates an existing row.
		/// </summary>
		/// <param name="CPR_ID">Can not be null.</param>
		/// <param name="ENCOUNTER_ID">Can not be null.</param>
		/// <param name="TREATMENT_ID">Can not be null.</param>
		/// <param name="VACCINE_DATE">Can not be null.</param>
		/// <param name="CPT_CODE">Can not be null.</param>
		/// <exception cref="System.NullReferenceException">Thrown if CPR_ID param is null.</exception>
		private void AddGRITSVaccineData(string CPR_ID, object ENCOUNTER_ID, object TREATMENT_ID, object VACCINE_DATE, string CPT_CODE, string PROVIDER, string SITE, string COMMON_NAME)//<-changed 9/9/05
		{
			GRITSData.VACCINERow VaccineRow = null;
			bool newVaccineRow = false;
			if(null==CPR_ID||null==ENCOUNTER_ID||null==TREATMENT_ID||null==VACCINE_DATE||null==CPT_CODE)
			{
				throw new NullReferenceException("One or more of the parameters is null.");
			}
			AddGRITSEncounterData(CPR_ID,(int)ENCOUNTER_ID);
			if(dsGRITSData.VACCINE.Select("CPR_ID='"+CPR_ID+"' AND ENCOUNTER_ID="+ENCOUNTER_ID+" AND TREATMENT_ID="+TREATMENT_ID).Length==0)
			{
				newVaccineRow = true;
				VaccineRow = dsGRITSData.VACCINE.NewVACCINERow();
				VaccineRow.CPR_ID=CPR_ID;
				VaccineRow.ENCOUNTER_ID=(int)ENCOUNTER_ID;
				VaccineRow.TREATMENT_ID=(int)TREATMENT_ID;
			}
			if(null!=VACCINE_DATE)
			{
				VaccineRow.VACCINE_DATE=(DateTime)VACCINE_DATE;
			}
			if(null!=CPT_CODE)
			{
				VaccineRow.CPT_CODE=CPT_CODE;//Regex.Replace(CPT_CODE, "[^0-9]", ""); 
				//^<- changed because non-numeric cpt codes are necessary for past immunizations
			}
			if(null!=PROVIDER)
			{
				VaccineRow.PROVIDER=PROVIDER;
			}
			if(null!=SITE)
			{
				VaccineRow.CLINIC=SITE;
			}
			if(null!=COMMON_NAME) //<-changed 9/9/05
			{
				VaccineRow.COMMON_NAME=COMMON_NAME;
			}
			if(newVaccineRow)
			{
				dsGRITSData.VACCINE.AddVACCINERow(VaccineRow);
			}
		}
		
		
		
		#region fluff
		/// <summary>
		/// Called by EncounterPRO before a report is ordered to initialize
		/// the class.
		/// </summary>
		/// <param name="AttributeCount">The number of items in the Attributes array.</param>
		/// <param name="Attributes">String array of Attributes.</param>
		/// <param name="Values">String array of Values.</param>
		/// <returns>1==Success, 0==Nothing Happened, -1==Error.</returns>
		public int Initialize(int AttributeCount, string[] Attributes, string[] Values)
		{
			// return success
			return 1;
		}

		/// <summary>
		/// Drives whether EncounterPRO gives the option to print this report
		/// when it is selected by the user.
		/// </summary>
		/// <returns>True to offer print option.</returns>
		public bool Is_Printable()
		{
			// this report is printable
			return true;
		}

		/// <summary>
		/// Drives whether EncounterPRO gives the option to print this report
		/// when it is selected by the user.
		/// </summary>
		/// <returns>True to offer display option.</returns>
		public bool Is_Displayable()
		{
			// this report is not displayable
			return false;
		}

		/// <summary>
		/// Called by EncounterPRO when it is finished with the report.
		/// </summary>
		/// <returns>1==Success, 0==Nothing Happened, -1==Error.</returns>
		public int Finished()
		{
			// return success
			return 5;
		}
		#endregion
	}
}
