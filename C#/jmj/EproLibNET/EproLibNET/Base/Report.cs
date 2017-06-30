using System;
using System.Data.SqlClient;

namespace EproLibNET.Base
{
	/// <summary>
	/// Summary description for Report.
	/// </summary>
	public abstract class Report
	{
		protected Utilities util = null;

		/// <summary>
		/// Constructor for Report Class
		/// </summary>
		public Report()
		{
			util = new Utilities();
			string assmName = System.Reflection.Assembly.GetExecutingAssembly().GetName().Name;
			util.InitializeEventLog(assmName);
		}

		/// <summary>
		/// Called by EncounterPRO to order a report to be printed or displayed.
		/// </summary>
		/// <param name="ReportID">The unique ID for the report to run.</param>
		/// <param name="AdoCon">The ADO Connection object to connect to the EncounterPRO database.
		/// This parameter is ignored.  A new connection is built with the information provided from EncounterPRO.</param>
		/// <param name="AttributeCount">The number of items in the Attributes array.</param>
		/// <param name="Attributes">String array of Attributes.</param>
		/// <param name="Values">String array of Values.</param>
		/// <returns>1==Success, 0==Nothing Happened, -1==Error.</returns>
		public int PrintReport(string ReportID, object AdoCon, int AttributeCount, string[] Attributes, string[] Values)
		{
			SqlConnection con = null;
			SqlCommand com = null;
			System.Collections.Specialized.StringDictionary AttributeDictionary = null;

			#region Build AttributeDictionary

			if(null==Attributes||null==Values||Attributes.Length!=Values.Length)
			{
				// if Attributes or Values are null or do not have 
				// the same number of items, return Error.
				util.LogInternalEvent(new Exception("Attributes array and Values array are different lengths.  PrintReport cannot continue."),4);
				return -1;
			}

			AttributeDictionary = new System.Collections.Specialized.StringDictionary();

			try
			{
				// populate AttributeDictionary with Attributes and Values passed from EncounterPRO
				for(int i=0; i<Attributes.Length; i++)
				{
					if(null!=Attributes[i])
					{
						if(AttributeDictionary.ContainsKey(Attributes[i].ToUpper()))
							AttributeDictionary[Attributes[i].ToUpper()] = Values[i];
						else
							AttributeDictionary.Add(Attributes[i].ToUpper(),Values[i]);
					}
				}
			}
			catch(Exception exc)
			{
				Exception newExc = new Exception("Error building Attribute Dictionary", exc);
				util.LogInternalEvent(newExc,4);
				throw newExc;
			}
			#endregion // Build AttributeDictionary
			
			#region Establish database connection
			try
			{
				con = new SqlConnection();
				con.ConnectionString="Server='"+AttributeDictionary["SERVER"].ToString()+"';Database='"+AttributeDictionary["DATABASE"].ToString()+"';Integrated Security=SSPI;Persist Security Info = false;Pooling=false";
				con.Open();
				try
				{
					// Some systems may not have the application role set up.
					// Do not fail if setapprole fails
					com = new SqlCommand("EXEC dbo.sp_setapprole 'cprsystem', '" + AttributeDictionary["DATA_WHERE"].ToString() + "'", con);
					com.ExecuteNonQuery();
				}
				catch(Exception exc)
				{
					util.LogInternalEvent(new Exception("Error in sp_SetAppRole",exc),3);
				}
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(new Exception("Error Connecting to Database",exc),4);
				return -1;
			}
			#endregion // Establish database connection

			try
			{
				printReport(ReportID, AttributeDictionary, con);
				return 1;
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(new Exception("Error in printReport.",exc),4);
				return -1;
			}
			finally
			{
				try
				{
					con.Close();
				}
				catch{}
			}

		}
		
		protected abstract void printReport(string ReportID, System.Collections.Specialized.StringDictionary Attributes, SqlConnection Con);

		#region fluff
		/// <summary>
		/// Called by EncounterPRO before a report is ordered to initialize
		/// the class.
		/// </summary>
		/// <param name="AttributeCount">The number of items in the Attributes array.</param>
		/// <param name="Attributes">String array of Attributes.</param>
		/// <param name="Values">String array of Values.</param>
		/// <returns>1==Success, 0==Nothing Happened, -1==Error.</returns>
		public virtual int Initialize(int AttributeCount, string[] Attributes, string[] Values)
		{
			// return success
			return 1;
		}

		/// <summary>
		/// Drives whether EncounterPRO gives the option to print this report
		/// when it is selected by the user.
		/// </summary>
		/// <returns>True to offer print option.</returns>
		public virtual bool Is_Printable()
		{
			// this report is printable
			return false;
		}

		/// <summary>
		/// Drives whether EncounterPRO gives the option to print this report
		/// when it is selected by the user.
		/// </summary>
		/// <returns>True to offer display option.</returns>
		public virtual bool Is_Displayable()
		{
			// this report is not displayable
			return false;
		}

		/// <summary>
		/// Called by EncounterPRO when it is finished with the report.
		/// </summary>
		/// <returns>1==Success, 0==Nothing Happened, -1==Error.</returns>
		public virtual int Finished()
		{
			// return success
			return 1;
		}
		#endregion
		
	}
}
