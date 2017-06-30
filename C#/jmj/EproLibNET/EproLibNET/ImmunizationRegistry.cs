using System;
using System.IO;
using System.Data.SqlClient;
using System.Runtime.InteropServices;
using System.Xml;

namespace EproLibNET
{
	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class ImmunizationRegistry:Base.ExtSrcStateless
	{
		public ImmunizationRegistry():base()
		{
		}

		/// <summary>
		/// for a given encounter or a date range it returns all the vaccine
		/// records
		/// </summary>
		/// <param name="xml">xml stirng that contains context and db connection info</param>
		/// <returns>xml string</returns>
		public override string CreateDocument(string xml)
		{
			string serverName = string.Empty;
			string dbName = string.Empty;
			string appRole = string.Empty;
			string appRolePwd = string.Empty;
			string cprId = string.Empty;
			string encounterId = string.Empty;
			string startDate = string.Empty;
			string endDate = string.Empty;

			SqlConnection conn = null;
			SqlCommand com = null;
			XmlNodeList list = null;
			System.IO.StringWriter ImmsXML = new System.IO.StringWriter();

			util.LogEvent(this.GetType().Name,"createdocument()",xml,1);

			// parse thru xml and construct a connection string
			XmlDocument document = new XmlDocument();
			document.LoadXml(xml);
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
			foreach(XmlNode n in document.GetElementsByTagName("start_date"))
				startDate=n.InnerText;
			foreach(XmlNode n in document.GetElementsByTagName("end_date"))
				endDate=n.InnerText;

			try
			{
				try
				{
					#region // Establish database connection
					try
					{
						conn = new SqlConnection();
						conn.ConnectionString="Server='"+serverName+"';Database='"+dbName+"';Integrated Security=SSPI;Persist Security Info = false;Pooling=false";
						conn.Open();
						try
						{
							// Some systems may not have the application role set up.
							// Do not fail if setapprole fails
							com = new SqlCommand("EXEC dbo.sp_setapprole '" +appRole + "','"+appRolePwd+"'", conn);
							com.ExecuteNonQuery();
						}
						catch(Exception exc){}
					}
					catch(Exception exc)
					{
						// Database Connection Failed
						return string.Empty;
					}
					#endregion // Establish database connection

					#region Build Imms Registry for a given date range or Single Encounter
					SqlDataReader reader=null;
					ImmsRegistry dsImmsRegistry=null;

					if((startDate != null && startDate != "" )&& (endDate !=null && endDate != ""))
					{

						com.CommandText = 
							"SELECT p_Patient.cpr_id "+
							", p_Patient.last_name "+
							", p_Patient.first_name "+
							", p_Patient.middle_name "+
							", date_of_birth "+
							", sex "+
							", treatment_type "+
							", cpt_code "+
							", description "+
							", maker_id "+
							", lot_number "+
							", dose_amount "+
							", dose_unit "+
							", p_treatment_item.ordered_by "+
							", begin_date as treatment_date "+
							", user_full_name "+
							" FROM p_Patient_Encounter "+
							" INNER JOIN p_Patient "+
							" ON P_Patient_Encounter.encounter_date > '" + startDate + "'"+
							" AND p_Patient_Encounter.encounter_date < '"+ endDate + "'"+
							" AND p_Patient_Encounter.cpr_id = p_Patient.cpr_id "+
							"INNER JOIN p_Treatment_Item "+
							" ON p_Patient_Encounter.cpr_id = p_Treatment_Item.cpr_id "+
							" AND p_Patient_Encounter.encounter_id = p_Treatment_Item.open_encounter_id "+
							" AND p_Treatment_Item.treatment_type = 'IMMUNIZATION' "+
							"INNER JOIN c_Procedure "+
							" ON p_Treatment_Item.procedure_id = c_Procedure.procedure_id "+
							"INNER JOIN c_User"+
							" ON p_Treatment_Item.ordered_by = user_id "+
							"ORDER BY p_Patient.cpr_id";
				
					}
					else if((cprId != null && cprId != "")&& (encounterId != null && encounterId != ""))
					{

						com.CommandText = 
							"SELECT p_Patient.cpr_id "+
							", p_Patient.last_name "+
							", p_Patient.first_name "+
							", p_Patient.middle_name "+
							", date_of_birth "+
							", sex "+
							", treatment_type "+
							", cpt_code "+
							", description "+
							", maker_id "+
							", lot_number "+
							", dose_amount "+
							", dose_unit "+
							", p_treatment_item.ordered_by "+
							", begin_date as treatment_date "+
							", user_full_name "+
							" FROM p_Patient_Encounter "+
							" INNER JOIN p_Patient "+
							" ON P_Patient_Encounter.cpr_id = '" + cprId + "'"+
							" AND p_Patient_Encounter.encounter_id = "+ encounterId +
							" AND p_Patient_Encounter.cpr_id = p_Patient.cpr_id "+
							"INNER JOIN p_Treatment_Item "+
							" ON p_Patient_Encounter.cpr_id = p_Treatment_Item.cpr_id "+
							" AND p_Patient_Encounter.encounter_id = p_Treatment_Item.open_encounter_id "+
							" AND p_Treatment_Item.treatment_type = 'IMMUNIZATION' "+
							"INNER JOIN c_Procedure "+
							" ON p_Treatment_Item.procedure_id = c_Procedure.procedure_id "+
							"INNER JOIN c_User"+
							" ON p_Treatment_Item.ordered_by = user_id "+
							"ORDER BY p_Patient.cpr_id";
					}
					else
					{
						// No valid STARTDATE/ENDDATE and no valid CPR_ID/ENCOUNTER_ID.
						// return error.
						return "";
					}
					dsImmsRegistry = new ImmsRegistry();
					reader = com.ExecuteReader();
					if (!reader.HasRows)
						return "";

					while(reader.Read())
					{
						// add immunization record
						ADDImmsData(reader, dsImmsRegistry);
					}
					reader.Close();

					dsImmsRegistry.WriteXml(ImmsXML);
					dsImmsRegistry.Dispose();
					#endregion Build Registry
				}
				catch(Exception exc)
				{
					throw exc;
				}
				finally
				{
					conn.Close();
					com.Dispose();
				}
			}
			catch(Exception exc)
			{
				util.LogEvent(exc.Source,exc.TargetSite.Name,exc.ToString(),4);
				throw exc;
			}
			return ImmsXML.ToString();
		} 

		#region Construct the XML for every patient row
		private void ADDImmsData(SqlDataReader reader,ImmsRegistry dsImms)
		{
			ImmsRegistry.PatientRow PatientRow = null;
			ImmsRegistry.treatmentRow VaccineRow = null;

			bool PatientRowIsNew = false;

			string CPR_ID = null;

			CPR_ID = reader["cpr_id"].ToString();

			// Beginning Of Patient Table Record
			if(null==CPR_ID)
			{
				throw new NullReferenceException("CPR_ID parameter is null.");
			}
			if(dsImms.Patient.Select("CPR_ID='"+CPR_ID+"'").Length==0)
			{
				PatientRowIsNew = true;
				PatientRow = dsImms.Patient.NewPatientRow();
				PatientRow.cpr_id=CPR_ID;
			}
			else
			{
				PatientRowIsNew = false;
				PatientRow = (ImmsRegistry.PatientRow)dsImms.Patient.Select("CPR_ID='"+CPR_ID+"'")[0];
			}
			if (PatientRowIsNew)
			{
				// Firstname
				if (reader.IsDBNull(reader.GetOrdinal("first_name")))
					PatientRow.first_name = string.Empty;
				else
					PatientRow.first_name = reader["first_name"].ToString();
				// LastName
				if (reader.IsDBNull(reader.GetOrdinal("last_name")))
					PatientRow.last_name = string.Empty;
				else
					PatientRow.last_name = reader["last_name"].ToString();
				// Middle Name
				if (reader.IsDBNull(reader.GetOrdinal("middle_name")))
					PatientRow.middle_name = string.Empty;
				else
					PatientRow.middle_name = reader["middle_name"].ToString();
				// Date Of Birth
				if (reader.IsDBNull(reader.GetOrdinal("date_of_birth")))
					PatientRow.date_of_birth = string.Empty;
				else
					PatientRow.date_of_birth = reader["date_of_birth"].ToString();
				// Sex
				if (reader.IsDBNull(reader.GetOrdinal("sex")))
					PatientRow.sex = string.Empty;
				else
					PatientRow.sex = reader["sex"].ToString();

				dsImms.Patient.AddPatientRow(PatientRow);
			}
			// End Of Patient Table Record

			// Beginning Of Vaccine Record
			VaccineRow = dsImms.treatment.NewtreatmentRow();
			// treatment type
			if (reader.IsDBNull(reader.GetOrdinal("treatment_type")))
				VaccineRow.treatmenttype = string.Empty;
			else
				VaccineRow.treatmenttype = reader["treatment_type"].ToString();
			// Vaccine code
			if (reader.IsDBNull(reader.GetOrdinal("cpt_code")))
				VaccineRow.vaccinecode = string.Empty;
			else
				VaccineRow.vaccinecode = reader["cpt_code"].ToString();
			// Vaccine name
			if (reader.IsDBNull(reader.GetOrdinal("description")))
				VaccineRow.vaccinename = string.Empty;
			else
				VaccineRow.vaccinename = reader["description"].ToString();
			// Admin date
			if (reader.IsDBNull(reader.GetOrdinal("treatment_date")))
				VaccineRow.admindate = string.Empty;
			else
				VaccineRow.admindate = reader["treatment_date"].ToString();
			// Dose amount
			if (reader.IsDBNull(reader.GetOrdinal("dose_amount")))
				VaccineRow.doseamount = string.Empty;
			else
				VaccineRow.doseamount = reader["dose_amount"].ToString();
			// Dose Unit
			if (reader.IsDBNull(reader.GetOrdinal("dose_unit")))
				VaccineRow.doseunit = string.Empty;
			else
				VaccineRow.doseunit = reader["dose_unit"].ToString();
			// Lot number
			if (reader.IsDBNull(reader.GetOrdinal("lot_number")))
				VaccineRow.lotnumber = string.Empty;
			else
				VaccineRow.lotnumber = reader["lot_number"].ToString();
			// Manufacturer
			if (reader.IsDBNull(reader.GetOrdinal("maker_id")))
				VaccineRow.manufacturer = string.Empty;
			else
				VaccineRow.manufacturer = reader["maker_id"].ToString();
			// administer id
			if (reader.IsDBNull(reader.GetOrdinal("ordered_by")))
				VaccineRow.administer_id = string.Empty;
			else
				VaccineRow.administer_id = reader["ordered_by"].ToString();
			// Administer name
			if (reader.IsDBNull(reader.GetOrdinal("user_full_name")))
				VaccineRow.administer_name = string.Empty;
			else
				VaccineRow.administer_name = reader["user_full_name"].ToString();

			VaccineRow.SetParentRow(PatientRow);
			dsImms.treatment.AddtreatmentRow(VaccineRow);
		
		}
		#endregion Construct the XML for every patient row
	}
}
