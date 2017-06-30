using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace EPIntSenderLib
{
	/// <summary>
	/// Summary description for BaseDataSource.
	/// </summary>
	public class BaseDataSource
	{
		protected string server, database, sqlUser, sqlPassword;
		protected bool integratedSecurity;
		protected SqlConnection con = null;

		//*********************************************************************
		//
		// Constants
		//
		// Each of the constants below represent the name of an SQL
		// stored procedures. If you need to change the name of any query
		// used by the sender/recevier, modify one of the constants.
		//
		//*********************************************************************
		
		private const string SP_LOOKUP_EPRO_ID			= "sp_lookup_epro_id";
		private const string SP_GET_ADDRESSEE			= "sp_get_addressee";
		private const string SP_GET_ADDRESSEE_PROPERTY	= "sp_get_addressee_property";
		private const string SP_GET_COMPONENT			= "sp_get_component";

		
		public SqlConnection ConnectionObject
		{
			get
			{
				return con;
			}
		}
		public string Server
		{
			get
			{
				return server;
			}
		}
		public string Database
		{
			get
			{
				return database;
			}
		}
		public bool IntegratedSecurity
		{
			get
			{
				return integratedSecurity;
			}
		}
		public string SQLUser
		{
			get
			{
				return sqlUser;
			}
		}
		public string SQLPassword
		{
			get
			{
				return sqlPassword;
			}
		}
		protected virtual void Connect()
		{
			if(integratedSecurity)
			{
				try
				{
					if(null==server||null==database||server==""||database=="")
					{
						throw new Exception("Null Server or Database values.");
					}
					con = new SqlConnection("Server="+server+";Database="+database+";Integrated Security=SSPI");
					con.Open();
				}
				catch(Exception exc)
				{
					Event.LogError("Error Connecting to SQL Server\r\n" +
						"ConnectionString=\""+con.ConnectionString+"\"\r\n\r\n"+
						exc.ToString());
					try
					{
						con.Dispose();
					}
					catch{}
					throw exc;
				}
			}
			else
			{
				try
				{
					if(null==server||null==database||server==""||database=="")
					{
						throw new Exception("Null Server or Database values.");
					}
					con = new SqlConnection("Server="+server+";Database="+database+";User ID="+sqlUser+";Password=\""+sqlPassword+"\"");
					con.Open();
				}
				catch(Exception exc)
				{
					Event.LogError("Error Connecting to SQL Server\r\n" +
						"ConnectionString=\""+con.ConnectionString+"\"\r\n\r\n"+
						exc.ToString());
					try
					{
						con.Dispose();
					}
					catch{}
					throw exc;
				}
			}
		}
		public BaseDataSource(string Server, string Database)
		{
			server=Server;
			database=Database;
			integratedSecurity=true;
			sqlUser=null;
			sqlPassword=null;
			Connect();
		}
		public BaseDataSource(string Server, string Database, string SqlUser, string SqlPassword)
		{
			server=Server;
			database=Database;
			integratedSecurity=false;
			sqlUser=SqlUser;
			sqlPassword=SqlPassword;
			Connect();
		}
		public BaseDataSource(string Server, string Database, bool IntegratedSecurity, string SqlUser, string SqlPassword)
		{
			server=Server;
			database=Database;
			integratedSecurity=IntegratedSecurity;
			sqlUser=SqlUser;
			sqlPassword=SqlPassword;
			Connect();
		}
		public SqlDataAdapter GetDataAdapter(string CommandText)
		{
			SqlDataAdapter da = new SqlDataAdapter(CommandText,con);
			return da;
		}
		public DataSet FillData(string CommandText,string table)
		{
			return FillData(CommandText,table,true);
		}
		public DataSet FillData(string CommandText,string table,bool AcceptChanges)
		{
			SqlDataAdapter da = new SqlDataAdapter(CommandText,con);
			da.AcceptChangesDuringFill=AcceptChanges;
			DataSet ds = new DataSet();
			da.Fill(ds,table);
			da.Dispose();
			return ds;
		}
		public int UpdateData(string CommandText, DataSet ds, string table)
		{
			int rVal;
			SqlDataAdapter da = new SqlDataAdapter(CommandText,con);
			SqlCommandBuilder cb = new SqlCommandBuilder(da);
			rVal=da.Update(ds, table);
			da.Dispose();
			return rVal;
		}
		public int ExecuteNonQuery(string CommandText)
		{
			SqlCommand com = null;
			try
			{
				com = new SqlCommand(CommandText,con);
				com.CommandTimeout=300;
				int returnVal = com.ExecuteNonQuery();
				com.Dispose();
				return returnVal;
			}
			catch(Exception exc)
			{
				Event.LogError("Error Executing Command\r\n"+
					"CommandText=\""+com.CommandText+"\"\r\n\r\n"+
					exc.ToString());
				throw exc;
			}
		}
		public SqlDataReader ExecuteReader(string CommandText, System.Data.CommandBehavior commandBehavior)
		{
			SqlCommand com = null;
			try
			{
				com = new SqlCommand(CommandText,con);
				com.CommandTimeout=300;
				SqlDataReader returnVal = com.ExecuteReader(commandBehavior);
				com.Dispose();
				return returnVal;
			}
			catch(Exception exc)
			{
				Event.LogError("Error Executing Command\r\n"+
					"CommandText=\""+com.CommandText+"\"\r\n\r\n"+
					exc.ToString());
				throw exc;
			}
		}

		public SqlDataReader ExecuteReader(string CommandText)
		{
			return ExecuteReader(CommandText,CommandBehavior.Default);
		}

		public object ExecuteScalar(string CommandText)
		{
			SqlCommand com = null;
			try
			{
				com = new SqlCommand(CommandText,con);
				com.CommandTimeout=300;
				object returnVal = com.ExecuteScalar();
				com.Dispose();
				return returnVal;
			}
			catch(Exception exc)
			{
				Event.LogError("Error Executing Command\r\n"+
					"CommandText=\""+com.CommandText+"\"\r\n\r\n"+
					exc.ToString());
				throw exc;
			}
		}

		public object getEproCode(string ownerid, string codedomain,string code,string eprodomain)
		{
			SqlCommand sqlCmd = new SqlCommand();

			AddParamToSQLCmd(sqlCmd, "@pl_owner_id", SqlDbType.VarChar, 10, ParameterDirection.Input,ownerid);
			AddParamToSQLCmd(sqlCmd, "@ps_code_domain", SqlDbType.VarChar, 40, ParameterDirection.Input, codedomain);
			AddParamToSQLCmd(sqlCmd, "@ps_code", SqlDbType.VarChar, 80, ParameterDirection.Input, code);
			AddParamToSQLCmd(sqlCmd, "@ps_epro_domain", SqlDbType.VarChar, 40, ParameterDirection.Input, eprodomain);

			SetCommandType(sqlCmd,CommandType.StoredProcedure, SP_LOOKUP_EPRO_ID);
			object result = ExecuteScalarCmd(sqlCmd);

			return result;

		}

		public object getComponent(string commClass)
		{
			SqlCommand sqlCmd = new SqlCommand();

			AddParamToSQLCmd(sqlCmd, "@ps_commId", SqlDbType.VarChar, 10, ParameterDirection.Input,commClass);

			SetCommandType(sqlCmd,CommandType.StoredProcedure, SP_GET_COMPONENT);
			object result = ExecuteScalarCmd(sqlCmd);

			return result;

		}


		public DataSet getAddressee()
		{
			SqlCommand sqlCmd = new SqlCommand();

			SetCommandType(sqlCmd,CommandType.StoredProcedure, SP_GET_ADDRESSEE);

			return(ExecuteAdapterCmd(sqlCmd));
		}


		public DataSet getAddresseeProperty(string addresseeId)
		{
			SqlCommand sqlCmd = new SqlCommand();

			AddParamToSQLCmd(sqlCmd, "@ps_addressee_id", SqlDbType.VarChar, 10, ParameterDirection.Input,addresseeId);

			SetCommandType(sqlCmd,CommandType.StoredProcedure, SP_GET_ADDRESSEE_PROPERTY);

			return(ExecuteAdapterCmd(sqlCmd));
		}

		//*********************************************************************
		//
		// SQL Helper Methods
		//
		// The following utility methods are used to interact with SQL Server.
		//
		//*********************************************************************


		private void AddParamToSQLCmd(SqlCommand sqlCmd, string paramId, SqlDbType sqlType, int paramSize, ParameterDirection paramDirection, object paramvalue) 
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

		private void SetCommandType(SqlCommand sqlCmd, CommandType cmdType, string cmdText) 
		{
			sqlCmd.CommandType = cmdType;
			sqlCmd.CommandText = cmdText;
		}

		private object ExecuteScalarCmd(SqlCommand sqlCmd) 
		{
			// Validate Command Properties
			if (con == null)
				throw (new ArgumentOutOfRangeException("no database connection"));

			if (sqlCmd== null)
				throw (new ArgumentNullException("sqlCmd"));

			object result = null;

			sqlCmd.Connection = con;
			result = sqlCmd.ExecuteScalar();

			return result;
		}

		private DataSet ExecuteAdapterCmd(SqlCommand sqlCmd) 
		{
			// Validate Command Properties
			if (con == null)
				throw (new ArgumentOutOfRangeException("no database connection"));

			if (sqlCmd== null)
				throw (new ArgumentNullException("sqlCmd"));

			sqlCmd.Connection = con;
			
			SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
			DataSet ds = new DataSet();
			
			da.Fill(ds);
			
			return ds;
		//	da.Dispose();

		}

	}
}
