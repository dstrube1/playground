using System;
using System.Data;
using System.Data.SqlClient;
using System.Xml;

/***************************************************
*  This is a database base class contains common
* dbaccess methods.
* ************************************************/
namespace EproDB
{
	public class DataExportBase
	{
		protected string connectionString = string.Empty;

		//*********************************************************************
		//
		// Constants
		//
		// Each of the constants below represent the name of an SQL
		// Query. If you need to change the name of any query, modify
		// one of the constants.
		//
		//*********************************************************************
		
		private const string XML_GET_PATIENTDATA			= "xml_get_patient";

		private const string XML_GET_ENCOUNTERDATA			= "xml_get_encounter";
		private const string XML_GET_ENCOUNTERTREATMENTS	= "xml_get_encountertreatments";



		public DataExportBase(string xml)
		{

		/***************************************************
		*  This method parses the XML document and construct
		*  a connection string.
		* ************************************************/

			XmlNodeList list = null;
			string server = string.Empty;
			string db = string.Empty;
			string userid = string.Empty;
			string password = string.Empty;

			// parse thru xml and construct a connection string
			XmlDocument document = new XmlDocument();
			document.LoadXml(xml);
			list = document.GetElementsByTagName("database");
			foreach(XmlNode n in list)
			{
				server = n["server"].InnerText;
				db = n["dbname"].InnerText;
				userid = n["userid"].InnerText;
				password = n["password"].InnerText;

			}
			// set a connection string
			//"Server=(local);Database=testSQL;Trusted_Connection=false;uid=sa;pwd=21st"
			connectionString = "Server=" + server + ";Database=" + db + ";uid=" + userid + ";pwd=" + password+";Pooling=false";
		}

		/***************************************************
		*  Patient Methods
		* ************************************************/
		public PatientData GetPatient(string cprId)
		{
			SqlCommand cmd = null;
			PatientData patient = null;
			
			patient = new PatientData();
			
			using (SqlConnection cn = new SqlConnection(this.connectionString))
			{
				try
				{
					cmd = new SqlCommand();
					cmd.Connection = cn;

					AddParamToSQLCmd(cmd,"@ps_cpr_id",SqlDbType.VarChar,24,ParameterDirection.Input,cprId);
					SetCommandType(cmd,CommandType.StoredProcedure,XML_GET_PATIENTDATA);
					SqlDataAdapter adapter = new SqlDataAdapter(cmd);
			
					cn.Open();			

					adapter.Fill(patient,"Patient");

					cn.Close();

					return patient;
				}
				catch (SqlException e) 
				{
					string errorMessages = "";

					for (int i=0; i < e.Errors.Count; i++)
					{
						errorMessages += "Index #" + i + "\n" +
							"Message: " + e.Errors[i].Message + "\n" +
							"LineNumber: " + e.Errors[i].LineNumber + "\n" +
							"Source: " + e.Errors[i].Source + "\n" +
							"Procedure: " + e.Errors[i].Procedure + "\n";
					}
					return null;
				}
			}
		}

		/***************************************************
		*  Encounter Methods
		* ************************************************/
		public EncounterData GetEncounter(string cprId,int encounterId)
		{
			SqlCommand cmd = null;
			EncounterData encounter = null;
			
			encounter = new EncounterData();
			
			using (SqlConnection cn = new SqlConnection(this.connectionString))
			{
				try
				{
					cmd = new SqlCommand();
					cmd.Connection = cn;

					AddParamToSQLCmd(cmd,"@ps_cpr_id",SqlDbType.VarChar,24,ParameterDirection.Input,cprId);
					AddParamToSQLCmd(cmd,"@pl_encounter_id",SqlDbType.Int,0,ParameterDirection.Input,encounterId);
					SetCommandType(cmd,CommandType.StoredProcedure,XML_GET_ENCOUNTERDATA);
					SqlDataAdapter adapter = new SqlDataAdapter(cmd);
			
					cn.Open();			

					adapter.Fill(encounter,"Encounter");

					cn.Close();

					return encounter;
				}
				catch (SqlException e) 
				{
					string errorMessages = "";

					for (int i=0; i < e.Errors.Count; i++)
					{
						errorMessages += "Index #" + i + "\n" +
							"Message: " + e.Errors[i].Message + "\n" +
							"LineNumber: " + e.Errors[i].LineNumber + "\n" +
							"Source: " + e.Errors[i].Source + "\n" +
							"Procedure: " + e.Errors[i].Procedure + "\n";
					}
					return null;
				}
			}

		}

		public TreatmentData GetEncounterTreatments(string cprId,int encounterId)
		{
			SqlCommand cmd = null;
			TreatmentData treatment = null;
			
			treatment = new TreatmentData();
			
			using (SqlConnection cn = new SqlConnection(this.connectionString))
			{
				try
				{
					cmd = new SqlCommand();
					cmd.Connection = cn;

					AddParamToSQLCmd(cmd,"@ps_cpr_id",SqlDbType.VarChar,24,ParameterDirection.Input,cprId);
					AddParamToSQLCmd(cmd,"@pl_encounter_id",SqlDbType.Int,0,ParameterDirection.Input,encounterId);
					SetCommandType(cmd,CommandType.StoredProcedure,XML_GET_ENCOUNTERTREATMENTS);
					SqlDataAdapter adapter = new SqlDataAdapter(cmd);
			
					cn.Open();			

					adapter.Fill(treatment,"Treatment");

					cn.Close();

					return treatment;
				}
				catch (SqlException e) 
				{
					string errorMessages = "";

					for (int i=0; i < e.Errors.Count; i++)
					{
						errorMessages += "Index #" + i + "\n" +
							"Message: " + e.Errors[i].Message + "\n" +
							"LineNumber: " + e.Errors[i].LineNumber + "\n" +
							"Source: " + e.Errors[i].Source + "\n" +
							"Procedure: " + e.Errors[i].Procedure + "\n";
					}
					return null;
				}
			}
		}

		public string GetVaccines(string beginDate,string endDate)
		{
			return null;
		}

		public string GetVaccines(string cprId,int encounterId)
		{
			return null;
		}

		/***************************************************
		*  SQL Helper Methods
		* ************************************************/


		/***************************************************
		*  common mehtod that adds sql parameters for
		*  stored procedure calls.
		* ************************************************/

		protected void AddParamToSQLCmd(SqlCommand sqlCmd, string paramId, SqlDbType sqlType, int paramSize, ParameterDirection paramDirection, object paramvalue) 
		{
			// Validate Parameter Properties
			if (sqlCmd== null)
				throw (new ArgumentNullException("sqlCmd"));
			if (paramId == string.Empty)
				throw (new ArgumentOutOfRangeException("paramId"));

			// Add Parameter
			SqlParameter newSqlParam = new SqlParameter();
			newSqlParam.ParameterName= paramId;
			newSqlParam.SqlDbType = sqlType;
			newSqlParam.Direction = paramDirection;

			if (paramSize > 0)
				newSqlParam.Size=paramSize;

			if (paramvalue != null)
				newSqlParam.Value = paramvalue;

			sqlCmd.Parameters.Add (newSqlParam);
		}

		/***************************************************
		* executes the sql stored procedure or a query and
		* returns a result set [SqlDataReader]
		* ************************************************/

		protected SqlDataReader ExecuteReaderCmd(SqlCommand sqlCmd) 
		{
			if (connectionString == string.Empty)
				throw (new ArgumentOutOfRangeException("ConnectionString"));

			if (sqlCmd== null)
				throw (new ArgumentNullException("sqlCmd"));

			using (SqlConnection cn = new SqlConnection(this.connectionString))
			{
				try
				{
					sqlCmd.Connection = cn;
					cn.Open();
					return (sqlCmd.ExecuteReader(CommandBehavior.CloseConnection));
				}
				catch (SqlException e) 
				{
					string errorMessages = "";

					for (int i=0; i < e.Errors.Count; i++)
					{
						errorMessages += "Index #" + i + "\n" +
							"Message: " + e.Errors[i].Message + "\n" +
							"LineNumber: " + e.Errors[i].LineNumber + "\n" +
							"Source: " + e.Errors[i].Source + "\n" +
							"Procedure: " + e.Errors[i].Procedure + "\n";
					}
					return null;
				}

			}
		}


		/***************************************************
		*  sets the sql command type and text values
		* ************************************************/

		protected void SetCommandType(SqlCommand sqlCmd, CommandType cmdType, string cmdText) 
		{
			sqlCmd.CommandType = cmdType;
			sqlCmd.CommandText = cmdText;
		}


	}
}