using System;
//using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;
using System.Collections;
//using System.Reflection;
//using System.Diagnostics;

//referenced EprolibBase.dll copied from \\Techserv\devel\Common\EproLibBase
//web reference url: https://www.jmjtech.com/EPAuthority/Service.asmx?wsdl
//update AssemblyInfo.cs with version # and JMJKeyPair.snk path
//drag the dll output to C:\WINDOWS\assembly

namespace JMJSecurityManager
{
	/// <summary>
	/// Descended from base class in EprolibBase
	/// see here for overview:
	/// https://www.jmjtech.com/intranet/Departments/Development/Products/EncounterPRO%20Components/SecurityManager/COM%20Security%20Manager.doc
	/// </summary>
	public class JMJSecurityManager : EproLibBase.SecurityManager
	{
		private static JMJSecurityManager me=null;
		#region constructors
		public JMJSecurityManager() : base()
		{
			me = this;
			this.Initialized+=new EventHandler(SecurityManager_Initialized);
		}
		private void SecurityManager_Initialized(object sender, EventArgs e)
		{
			customerID = getCustomerID();

			lastLoggedIn = new ArrayList();
			lastLoggedIn.Capacity=8;
			for(int i=0; i<lastLoggedIn.Capacity; i++) lastLoggedIn.Add("");
			lastLoggedIn  = ArrayList.FixedSize(lastLoggedIn);

			string [] v = System.Reflection.
				   Assembly.GetExecutingAssembly().ToString().Split(',');
			version = v[1].Substring(1);

			// default = 14608111
			color=getColor(14608111);

		}
		#endregion //constructors
	
		//global variables
		private EPAuthority.Service svc = new EPAuthority.Service();
		private string customerID = null;
		private ArrayList lastLoggedIn = null;
		internal static int color=0;
		internal static string version = null;

		#region descending methods
		protected override string challenge(string challenge)
		{
			//not very challenging yet
			return challenge;
		}

		protected override string authenticate()
		{
			return authenticate("","");
			
		}

		protected override int reAuthenticate(string UserName)
		{
			if (UserName == "" || UserName == null)
				throw new Exception ("Invalid UserName");
			//NOTE: This method is deprecated by the EPAuthority Web service
			return reAuthenticate (UserName, "");
		}

		protected override int changePassword(string UserName)
		{
			bool passwordChanged = false;
			//bool authenticated = false;
			string passwordNew = null;
			string passwordOld = null;
			string error1 = "The length of parameter 'newPassword' needs to be greater or equal to '7'";
			string error1a = "The length of the new password must be greater than or equal to 7";
			string error2 = "Non alpha numeric characters in 'newPassword' needs to be greater than or equal to '1'.";
			string error2a = "The count of non-alphanumeric characters in the new password must be greater than or equal to 1.";
			try
			{
				while (!passwordChanged)
				{
					//	if (reAuthenticate(UserName, "Enter your old password") == 1)
					//	{						
					//		authenticated=true;
					//		MessageBox.Show("User was authenticated. Now to enter a new password...");

					fChangePassword changeForm = new fChangePassword();
					changeForm.User = UserName;
					if(changeForm.ShowDialog() == DialogResult.OK)
					{
						passwordNew = changeForm.NewPass;
						passwordOld = changeForm.OldPass;
						if(svc.ChangePassword(UserName, passwordOld, passwordNew))
						{
							c_userUpdate(UserName, passwordNew);
							passwordChanged = true;
							MessageBox.Show("Password change for user '" + UserName + "' succeeeded.");
						}
						else 
						{
							MessageBox.Show("Password change for user '" + UserName + "' failed. Please try again, this time using a tougher password.");
						}
					}
					else break;
				}
			}
			catch (Exception e)
			{
				Log(e.ToString(), System.Diagnostics.EventLogEntryType.Error);
				if (e.ToString().IndexOf(error1)!=-1){MessageBox.Show(error1a);}
				else if (e.ToString().IndexOf(error2)!=-1){MessageBox.Show(error2a);}
				else MessageBox.Show(e.ToString());
				throw e;
			}
			if (passwordChanged)
				return 1;
			else
				return 0;
		}

		protected override int resetPassword(string AdminUserName, string ResetUserName)
		{
			if (AdminUserName == "" || AdminUserName == null)
				throw new Exception ("Invalid AdminUserName");
			if (ResetUserName == "" || ResetUserName == null)
				throw new Exception ("Invalid ResetUserName");
			bool successfullyReset = false;
			string password = null;
			try
			{
				while (!successfullyReset)
				{
					fResetPassword resetForm = new fResetPassword();
					resetForm.ResetUser = ResetUserName;
					resetForm.AdminUser = AdminUserName;
					if(resetForm.ShowDialog() == DialogResult.OK)
					{
						password = resetForm.AdminPass;
						if(svc.ResetPassword(AdminUserName, password, ResetUserName))
						{
							successfullyReset = true;
							MessageBox.Show("Password reset succeeded. The new password has been sent to "+ResetUserName+"'s email.");
						}
						else 
						{
							MessageBox.Show("Password reset for user '" + ResetUserName + "' failed. Please try again.");
						}
					}
					else break;
				}
			}
			catch (Exception e)
			{
				Log(e.ToString(), System.Diagnostics.EventLogEntryType.Error);
				throw e;
			}
			if (successfullyReset)
				return 1;
			else
				return 0;
		}

		protected override string establishCredentials(string UserID)
		{
			if (UserID.Length > 24) 
			{
				Log("UserID '"+UserID + "' is greater than 24 character limit", System.Diagnostics.EventLogEntryType.Error);
				throw new Exception ("UserID '"+UserID + "' is greater than 24 character limit");
			}
			if (UserID == null || UserID == ""){
				Log("Blank UserID passed to establishCredentials.",System.Diagnostics.EventLogEntryType.Error);
				throw new Exception ("Blank UserID passed to establishCredentials.");
			}
			string username = null;
			string password = null;
			string question = null;
			string answer = null;
			string email = null;
			bool finishedEstablishing = false;
			//kludgey way to rollback in case the stored procedure succeeds 
			//but webservice call fails
			string usernameOld = getOldUsername(UserID);

			while (!finishedEstablishing)
			{
				try 
				{
					fEstablish estForm = new fEstablish();
					estForm.Heading = "Please fill out all fields. \nThe password must have at least seven \ncharacters and include at least one \nnon-alphanumeric character.";
					estForm.User = username;
					estForm.Question = question;
					estForm.Answer = answer;
					estForm.Email = email; 
					estForm.User = username;
					if(estForm.ShowDialog() == DialogResult.OK)
					{
						username = estForm.User;
						if (username.Length > 40) 
						{
							MessageBox.Show("Username '"+username + "' is greater than 40 character limit. Please try again.");
							Log("Username '"+username + "' is greater than 40 character limit", System.Diagnostics.EventLogEntryType.Error);
							continue;
						}
						password = estForm.Pass;
						question = estForm.Question;
						answer = estForm.Answer;
						email = estForm.Email; 
						int dsResult = -1;
						//SqlParameter [] Pnull = null;
						SqlParameter [] Params = new SqlParameter[2];
						Params[0] = new SqlParameter("@ps_user_id", UserID);
						Params[1] = new SqlParameter("@ps_new_username", username);
						//Params[2] = new SqlParameter("@ll_rtn",System.Data.SqlDbType.Int);
						//Params[2].Direction = ParameterDirection.ReturnValue;
						DataSet ds = new System.Data.DataSet();
						ds = ExecuteSql(@"DECLARE @ll_rtn int
								EXECUTE @ll_rtn = jmj_set_username @ps_user_id, @ps_new_username
								SELECT @ll_rtn",ref Params);
						//confirmed this works by changing user name of PEDSTest from "test" to 123test"

						if(ds.Tables.Count>0 && ds.Tables[0].Rows.Count>0)
						{
							dsResult = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
						}
						else
						{
							MessageBox.Show("SQL error in getting count from setting the username.");
							Log("ds.Tables.Count = "+ds.Tables.Count.ToString(), System.Diagnostics.EventLogEntryType.Error);
							setOldUsername(UserID, usernameOld);
							return null;
						}
						if (dsResult == -1)
						{
							MessageBox.Show("SQL error in setting the username.");
							Log("SQL error in setting the username.", System.Diagnostics.EventLogEntryType.Error);
							setOldUsername(UserID, usernameOld);
						}
						else if (dsResult == 0)
						{
							MessageBox.Show("Username '"+username+"' is not unique.");
							setOldUsername(UserID, usernameOld);
						}
						else if (dsResult == 1)
						{
							//MessageBox.Show("Just before svc.CreateNewUser()");
							EPAuthority.CreateUserStatus status = svc.CreateNewUser("davidAdmin","applesauce28!", username, password, email, question, answer);
							//MessageBox.Show("Just after svc.CreateNewUser()");
							if (status == EPAuthority.CreateUserStatus.Success)
							{
								MessageBox.Show("Username '"+username+"' has been established for userID '"+UserID+"'.");
								finishedEstablishing = true;
								c_userUpdate(username, password, email);
							}
							else 
							{
								MessageBox.Show("Establishing credential failed: "+status.ToString());
								setOldUsername(UserID, usernameOld);
							}
						}
						else
						{
							setOldUsername(UserID, usernameOld);
							MessageBox.Show("Unrecognized SQL return while establishing credentials.");
						}
					}
					else 
					{//clicked cancel - they want out
						username = null;
						finishedEstablishing = true;
						setOldUsername(UserID, usernameOld);
					}
				}
				catch(Exception exec)
				{
					throw new Exception ("Dataset result is not int, or some other error:", exec);
				}
				
			}//end while
			if (username == null) 
				return string.Empty;
			return username;
		}

		protected int configureSecurity(){
//			Process p = new Process();
//			p.StartInfo.FileName = "";
//			p.Start();
			string page = "https://www.jmjtech.com/Mgmt/UserMgmt/Administration/SecuritySettings.aspx";
			try
			{
				using (System.Diagnostics.Process.Start(page))
				{
					return 1;
				}
			}
			catch (Exception e)
			{
				Log(e.ToString(), System.Diagnostics.EventLogEntryType.Error);
				throw e;
			}
		}
		protected int checkUserName(string UserName){
			try
			{
				if (!userExists(UserName)){
					return 0;
				}
				else if (isUserAtCustomer(UserName, customerID)){
					return 1;
				}
				else{
					return 2;
				}
			}
			catch (Exception e)
			{
				Log(e.ToString(), System.Diagnostics.EventLogEntryType.Error);
				throw e;
			}
		}
		#endregion //descending methods

		#region derived methods
		private string authenticate(string username, string password){

			prepareLastLoggedInList();

		//finishedAuthenticating is never set to true because there are (and should be) 
		//only 3 ways out of this loop:
		//1: successfully authenticate = return username
		//2: cancel = return empty string
		//3: an exception thrown 
			bool finishedAuthenticating = false;
			string instructions = "Enter your username and password to Authenticate.";
			
			fAuthenticate authForm = new fAuthenticate(new EproLibBase.ExecuteSql(this.ExecuteSql));
			authForm.User = username;
			authForm.FirstTime = true;
			authForm.ShowPastUsers = show_past_users();
			getLastLoggedInList();
			authForm.lastLoggedInList = lastLoggedIn;
			if (allow_PIN_registration())
			{
				instructions += "\nIf you do not have a username but do have an "+
					"EncounterPRO PIN, click the Register button.";
				authForm.CustomerID = customerID;
			}

			authForm.Instructions = instructions;
			while (!finishedAuthenticating) 
			{
				try
				{
					if(authForm.ShowDialog() == DialogResult.OK)
					{
						username = authForm.User;
						password = authForm.Pass;
						#region trycatch
						try
						{
							//on success or failure, update c_user
							EPAuthority.AuthenticateStatus status = svc.AuthenticateUser(username, password);
							if (status.UserAuthenticated )
							{
								//MessageBox.Show("User was authenticated!  Whoo-hoo!");
								//on success if row does not exist in c_user, add it
								//else update it
								c_userUpdate(username, password);
								setLastLoggedInList(username);
								return username;
							}
							else
							{
								MessageBox.Show("Authentication failed for "+username+". Please try again.");
								//on failure delete any rows in c_user that match the username and password hash
								c_userDelete(username, password);
								//return string.Empty;//comment out if using while/for

								//authForm = new fAuthenticate(new EproLibBase.ExecuteSql(this.ExecuteSql));
								authForm.User = username;
								authForm.Pass = "";
								authForm.lastLoggedInList = lastLoggedIn;
								if (allow_PIN_registration())
								{
									authForm.CustomerID = customerID;
								}
								authForm.focus = "pass";
								continue;
							}
						}
						catch(Exception exec)
						{
							Log("Authentication failed against web service. Trying against local cache. "+
								exec.ToString(), System.Diagnostics.EventLogEntryType.Error);
							//on exception, try authenticate against c_user
							if (c_userAuthenticate(username, password))
								return username;
							else
							{
								MessageBox.Show("Authentication failed. Please try again.");
								//return string.Empty;//comment out if using while/for
								continue;
							}
						}
						#endregion //trycatch 
					}
					else
					{
						//MessageBox.Show("You have cancelled out of the authentication. No other action should present this message.");
						return string.Empty;
					}
				}
				catch (Exception e)
				{
					Log(e.ToString(), System.Diagnostics.EventLogEntryType.Error);
					throw e;
				}
			}//end while
			MessageBox.Show("Authentication error. Exiting authentication.");
			return string.Empty;
		}
		private int reAuthenticate (string UserName, string instructions)
		{
			if (UserName == "" || UserName == null)
				throw new Exception ("Invalid UserName");
			//NOTE: This method is deprecated by the EPAuthority Web service
			string password = null;
			bool sameUser = false;
			try
			{
				fAuthenticate authForm = new fAuthenticate(new EproLibBase.ExecuteSql(this.ExecuteSql));
				authForm.User = UserName;
				authForm.FirstTime = false;
				authForm.Instructions = instructions;
				if(authForm.ShowDialog() == DialogResult.OK)
				{
					password = authForm.Pass;
					EPAuthority.AuthenticateStatus status = svc.AuthenticateUser(UserName, password);
					if (status.UserAuthenticated)
					{
						sameUser = true;
					}
				}
				if (sameUser)
					return 1;
				else 
					return 0;
			}
			catch (Exception e)
			{
				Log(e.ToString(), System.Diagnostics.EventLogEntryType.Error);
				throw e;
			}

		}

		internal static string establishCredentials2(string UserID)
		{
			return me.establishCredentials(UserID);
		}
		#endregion //derived methods

		#region utility methods

		private int getColor(int initializer){
			int result=initializer;
			string sqlText = "SELECT preference_value FROM o_preferences "+
				"WHERE preference_type='PREFERENCES' AND preference_level='Global' "+
				"AND preference_key = 'Global' and preference_id = 'color_background'";
			SqlParameter[] sqlParams = null;
			try 
				{
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
				result = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
			}
			catch(Exception exec)
			{
				Console.WriteLine("Error checking for background color", exec.ToString());
			}
			return result;
		}

		private bool allow_PIN_registration(){
			/*
			 * if
					Select count(*) from c_component_attribute where  component_id = 'AUTH_JMJ' AND attribute='allow_PIN_registration'
					!=0 then return true
				else if 
					""
					 and value like 'T%' or value like 'Y%'
					==1 then return true
				else return false
			 */
			bool result = false;
			if (!allow_PIN_registration_row_exists()){
				result=true;
			}
			else
			{
				int count = 0;
				string sqlText = "SELECT COUNT(*) FROM c_component_attribute "+
					"WHERE component_id = 'AUTH_JMJ' AND attribute= "+
					"'allow_PIN_registration' AND (value like 'T%' OR value like 'Y%')";
				SqlParameter[] sqlParams = null;
				try 
				{
					DataSet ds = ExecuteSql(sqlText,ref sqlParams);
					count = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
					if (count == 1)
					{
						result = true;
						//MessageBox.Show("allow_PIN_registration = true");
					}
					//else MessageBox.Show("allow_PIN_registration = false");
				}
				catch(Exception exec)
				{
					Log(exec.ToString(), System.Diagnostics.EventLogEntryType.Error);
					throw new Exception ("Error checking for allow_PIN_registration", exec);
				}
			}
			return result;
		}
		private bool allow_PIN_registration_row_exists(){
			bool result = false;
			int count = 0;
			string sqlText = "SELECT COUNT(*) FROM c_component_attribute "+
				"WHERE component_id = 'AUTH_JMJ' AND attribute= "+
				"'allow_PIN_registration'";
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
				count = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
				if (count != 0)
				{
					//MessageBox.Show("allow_PIN_registration_row_exists");
					result = true;
				}
			}
			catch(Exception exec)
			{
				Log(exec.ToString(), System.Diagnostics.EventLogEntryType.Error);
				throw new Exception ("Error checking for allow_PIN_registration_exists", exec);
			}
			return result;
		}

		#region SALTY WAY
		/* protected static Byte[] CreateRandomSalt()
		{
			Byte[] _saltBytes = new Byte[4];
			RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
			rng.GetBytes(_saltBytes);

			//use hard-coded key to encrypt pw into a key/salt, then 
			return _saltBytes;
		}

	
		protected string ComputeSaltedHash(Byte[] _saltBytes){
			//string password = "password";
			// Create Byte array of password string
			ASCIIEncoding encoder = new ASCIIEncoding();
			//Byte[] _secretBytes = encoder.GetBytes(password);
			Byte[] toHash = encoder.GetBytes(password);

			// append the two arrays
			//Byte[] toHash = new Byte[_secretBytes.Length + _saltBytes.Length];
			//Array.Copy(_secretBytes, 0, toHash, 0, _secretBytes.Length);
			//Array.Copy(_saltBytes, 0, toHash, _secretBytes.Length, _saltBytes.Length);

			MD5 md5 = new MD5CryptoServiceProvider();
			Byte[] computedHash = md5.ComputeHash(toHash);

			return encoder.GetString(computedHash);
		}
		protected int getSaltFromDB(string Username){
			return 0;
		}
		protected string getSaltedHashFromDB(string Username){
			return "";
		}
		*/
		#endregion //SALTY WAY

		/*UNSALTY WAY: */
		protected string ComputeHash(string password, string username)
		{
			string passwordANDusername = password + "|" + username;
			// Create Byte array of password string
			ASCIIEncoding encoder = new ASCIIEncoding();
			Byte[] toHash = encoder.GetBytes(passwordANDusername);

			using (System.Security.Cryptography.MD5 md5 = 
					   new System.Security.Cryptography.MD5CryptoServiceProvider())
				   {
				Byte[] computedHash = md5.ComputeHash(toHash);

				return encoder.GetString(computedHash);
			}
		}

		private string getCustomerID()
		{
			string result = "";
			if (ComponentAttributes.ContainsKey("CustomerID"))
				result = ComponentAttributes["CustomerID"].ToString();
			else 
			{
				//call SQL to get customerID
				SqlParameter[] sqlParams = null;
				DataSet ds = ExecuteSql("SELECT Customer_ID FROM c_database_status",ref sqlParams);
				try 
				{
					result = ds.Tables[0].Rows[0][0].ToString();
				}
				catch(Exception exec)
				{
					throw new Exception ("No customerID in the database", exec);
				}
			}
			try 
			{
				int test = Int32.Parse(result);
				//	MessageBox.Show(test.ToString());
				EPAuthority.CustomerInformation custInfo = new EPAuthority.CustomerInformation();
				custInfo.CustomerID = test;
				svc.CustomerInformationValue = custInfo;
			}
			catch(Exception exec)
			{
				throw new Exception ("CustomerID '"+customerID+"' is not int, "+
					"or there was a failure setting EPAuthority Service customer info", exec);
			}
			return result;
		}

		private string getDBStatus(){
			string result = "";
			SqlParameter[] sqlParams = null;
			DataSet ds = ExecuteSql("SELECT database_mode FROM c_database_status",
				ref sqlParams);
			try 
			{
				result = ds.Tables[0].Rows[0][0].ToString();
			}
			catch(Exception exec)
			{
				throw new Exception ("No DB status in the database.", exec);
			}
			if (result != "Production" && result != "Testing" && result != "Beta" )
				throw new Exception ("Unrecognized DB status.");
			return result;
		}
	
		#region deprecated
		/*
		private bool s_backupExists()
		{
			//Deprecated: using columns 'username' and 'pwdcache' in c_user on mod 127
			bool exists = false;
			int count = 0;
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql("SELECT count (*) FROM sysobjects where xtype = 'U' and name = 's_backup'",ref sqlParams);
				count = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
				if (count > 0)
					exists = true;
			}
			catch(Exception exec)
			{
				throw new Exception ("Error getting count for exist of s_backup", exec);
			}
			return exists;
		}
		private void s_backupCreate(){
			//Deprecated: using columns 'username' and 'pwdcache' in c_user on mod 127
			string create_text = @"SET ANSI_NULLS ON
				SET QUOTED_IDENTIFIER ON
				CREATE TABLE [s_backup](
					[username] [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
					[password_hash] [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
					[last_updated] [datetime] NULL
				) ON [PRIMARY]";
			SqlParameter[] sqlParams = null;
			try 
			{
				ExecuteSql(create_text,ref sqlParams);
			}
			catch(Exception exec)
			{
				throw new Exception ("Error creating s_backup", exec);
			}
		}

		private void s_backupAddOrUpdate(string username, string password)
		{
			//Deprecated: using columns 'username' and 'pwdcache' in c_user on mod 127
			if (!s_backupExists())
			{
				MessageBox.Show("Security backup table not found");
				return;
			}
			int count = 0;
			string sqlText = "SELECT COUNT(*) from s_backup where username = '"+username+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
				count = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
				if (count > 0)
				{
					string updateText = "UPDATE s_backup SET password_hash = '"+
						ComputeHash(password)+"', last_updated = getdate() where username = '"+
						username+"'";
					ExecuteSql(updateText,ref sqlParams);
				}
				else
				{
					string addText = "INSERT INTO s_backup (username, password_hash, last_updated) "+
						"VALUES('"+username+"','"+ComputeHash(password)+"',getdate())";
					ExecuteSql(addText,ref sqlParams);
				}
			}
			catch(Exception exec)
			{
				throw new Exception ("Error adding to or updating s_backup", exec);
			}
		}
		private void s_backupDelete(string username, string password){
			//Deprecated: using columns 'username' and 'pwdcache' in c_user on mod 127
			if (!s_backupExists())
			{
				MessageBox.Show("Security backup table not found");
				return;
			}
			string sqlText = "DELETE FROM s_backup WHERE username = '"+username
				+"' and password_hash = '"+ComputeHash(password)+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				ExecuteSql(sqlText,ref sqlParams);
			}
			catch(Exception exec)
			{
				throw new Exception ("Error deleting from s_backup", exec);
			}
		}
		private bool s_backupAuthenticate(string username, string password){
			//Deprecated: using columns 'username' and 'pwdcache' in c_user on mod 127
			bool result = false;
			if (!s_backupExists())
			{
				MessageBox.Show("Security backup table not found");
				return result;
			}
			int count = 0;
			string sqlText = "SELECT COUNT(*) FROM s_backup WHERE username = '"+username
				+"' and password_hash = '"+ComputeHash(password)+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
				count = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
				if (count > 0){
					result = true;
				}
			}
			catch(Exception exec)
			{
				throw new Exception ("Error authenticating against s_backup", exec);
			}
			return result;
		}
		*/
		#endregion //deprecated
		
		private void c_userUpdate(string username, string password, string email)
		{
			//assume row for the user exists
			string pwdcache = ComputeHash(password, username);
			if (pwdcache.IndexOf("'")!=-1)
				pwdcache = pwdcache.Replace("'","''");
			string updateText = "UPDATE c_user SET pwdcache = '"+ 
				pwdcache +"', modified = "+
				"getdate(), email_address = '"+email+"' where username = '"+username+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				ExecuteSql(updateText,ref sqlParams);
			}
			catch(Exception exec)
			{
				throw new Exception ("Error updating user data backup", exec);
			}
		}
		private void c_userUpdate(string username, string password)
		{
			//assume row for the user exists
			string pwdcache = ComputeHash(password, username);
			if (pwdcache.IndexOf("'")!=-1)
				pwdcache = pwdcache.Replace("'","''");
			string updateText = "UPDATE c_user SET pwdcache = '"+ 
				pwdcache +"', modified = "+
				"getdate() where username = '"+username+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				ExecuteSql(updateText,ref sqlParams);
			}
			catch(Exception exec)
			{
				throw new Exception ("Error updating user data backup\n\n updateText = "+updateText, exec);
			}
		}
		private void c_userDelete(string username, string password)
		{
			string sqlText = "UPDATE c_user set pwdcache = '' "+
				"WHERE username = '"+username+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				ExecuteSql(sqlText,ref sqlParams);
			}
			catch(Exception exec)
			{
				throw new Exception ("Error clearing user data cache", exec);
			}
		}
		private bool c_userAuthenticate(string username, string password)
		{
			bool result = false;
			string pwdcache = null;
			string sqlText = "SELECT pwdcache FROM c_user WHERE username = '"
				+username+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
				pwdcache = ds.Tables[0].Rows[0][0].ToString();
				if (pwdcache.Equals(ComputeHash(password, username)))
				{
					result = true;
				}
			}
			catch(Exception exec)
			{
				throw new Exception ("Error authenticating against local database", exec);
			}
			return result;
		}


		private string getOldUsername(string UserID)
		{
			string usernameOld = null;
			string getText = "SELECT username FROM c_user WHERE user_id = '"+UserID+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql(getText,ref sqlParams);
				
				if(ds.Tables.Count>0 && ds.Tables[0].Rows.Count>0)
				{
					usernameOld = ds.Tables[0].Rows[0][0].ToString();
				}
				else usernameOld = "";
			}
			catch(Exception exec)
			{
				throw new Exception ("Error preparing for username rollback", exec);
			}
			return usernameOld;
		}
		private void setOldUsername(string UserID, string usernameOld)
		{
			//old way:
			//string sqlText = "UPDATE c_user set username = '"+usernameOld+
			//	"' WHERE user_id = '"+UserID+"'";
			//SqlParameter[] sqlParams = null;

			SqlParameter [] Params = new SqlParameter[2];
			Params[0] = new SqlParameter("@ps_user_id", UserID);
			Params[1] = new SqlParameter("@ps_new_username", usernameOld);
			DataSet ds = new System.Data.DataSet();
			int dsResult = 0;
			try 
			{
				ds = ExecuteSql(@"DECLARE @ll_rtn int
								EXECUTE @ll_rtn = jmj_set_username @ps_user_id, @ps_new_username
								SELECT @ll_rtn",ref Params);
				if(ds.Tables.Count>0 && ds.Tables[0].Rows.Count>0)
				{
					dsResult = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
				}
				else throw new Exception ("Error rollbacking username change");

				if (dsResult != 1)
					throw new Exception ("Error rollbacking username change");
			}
			catch(Exception exec)
			{
				throw new Exception ("Error rollbacking username change", exec);
			}
		}
		
		private bool isUserAtCustomer(string UserName, string customerID){
			return false;
		}
		private bool userExists(string UserName){
			return false;
		}
		private void prepareLastLoggedInList(){
			//--execute dbo.sp_set_preference @ps_preference_type = 'JMJSECURITYMANAGER', @ps_preference_level='Global', 
			//--	@ps_preference_key='Global',@ps_preference_id='last_logged_in',@ps_preference_value=',,,,,,,'
			int count = 0;
			string sqlText = "SELECT COUNT(*) FROM o_preferences "+
				"WHERE preference_type='JMJSECURITYMANAGER' and  "+
				"preference_id = 'last_logged_in'";
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
				count = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
				if (count == 1)
				{
					return;
				}
				else 
				{
					sqlText = "execute dbo.sp_set_preference @ps_preference_type, "+
						"@ps_preference_level, @ps_preference_key, "+
						"@ps_preference_id, @ps_preference_value";
					sqlParams = new SqlParameter[5];
					sqlParams[0] = new SqlParameter("@ps_preference_type", "JMJSECURITYMANAGER");
					sqlParams[1] = new SqlParameter("@ps_preference_level", "Global");
					sqlParams[2] = new SqlParameter("@ps_preference_key","Global");
					sqlParams[3] = new SqlParameter("@ps_preference_id","last_logged_in");
					sqlParams[4] = new SqlParameter("@ps_preference_value",",,,,,,,");
					ds = ExecuteSql(sqlText,ref sqlParams);
				}
			}
			catch(Exception exec)
			{
				Log("Error preparing last logged in list: "+
					exec.ToString(), System.Diagnostics.EventLogEntryType.Error);
			}
		}
		private void getLastLoggedInList(){
			string sqlText = "select dbo.fn_get_preference ('JMJSECURITYMANAGER','last_logged_in', DEFAULT, DEFAULT)";
			SqlParameter[] sqlParams = null;
			string result=null;
			int count=0;
			try 
			{
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
				if(ds.Tables.Count>0 && ds.Tables[0].Rows.Count>0)
				{
					result = ds.Tables[0].Rows[0][0].ToString();
					foreach (string s in result.Split(','))
					{
						if (s != "" && s != null)
							lastLoggedIn[count]=s;
						else break;
						count ++;
						if (count==lastLoggedIn.Count) break;
					}
				}
			}
			catch(Exception exec)
			{
				Log("Error getting last logged in list: "+
					exec.ToString(), System.Diagnostics.EventLogEntryType.Error);
			}
		}
		private void setLastLoggedInList(string username){
			int place = lastLoggedIn.Count-1;
			string list="";
			try
			{
				for (int i=0; i<lastLoggedIn.Count; i++)
				if (lastLoggedIn[i].ToString().ToLower() == username.ToLower())
				{
					place = i;
					break;
				}
				for (int i=place; i>0; i--)
				{
					lastLoggedIn[i] = lastLoggedIn[i-1];
				}
				lastLoggedIn[0]=username;

				//now update the database with the list
				for (int j=0; j<lastLoggedIn.Capacity; j++){
					if (lastLoggedIn[j] != null && lastLoggedIn[j].ToString() != "")
						list+=lastLoggedIn[j].ToString();
					if (j != lastLoggedIn.Capacity-1)
						list+=",";
				}
				string sqlText = "execute dbo.sp_set_preference @ps_preference_type, "+
					"@ps_preference_level, @ps_preference_key, "+
					"@ps_preference_id, @ps_preference_value";
				SqlParameter[] sqlParams = new SqlParameter[5];
				sqlParams[0] = new SqlParameter("@ps_preference_type", "JMJSECURITYMANAGER");
				sqlParams[1] = new SqlParameter("@ps_preference_level", "Global");
				sqlParams[2] = new SqlParameter("@ps_preference_key","Global");
				sqlParams[3] = new SqlParameter("@ps_preference_id","last_logged_in");
				sqlParams[4] = new SqlParameter("@ps_preference_value",list);
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
			}
			catch(Exception exec)
			{
				Log("Error attempting to update the list of recent logins: "+
					exec.ToString(), System.Diagnostics.EventLogEntryType.Error);
			}
		}
		private bool show_past_users_row_exists()
		{
			bool result = false;
			int count = 0;
			string sqlText = "SELECT COUNT(*) FROM c_component_attribute "+
				"WHERE component_id = 'AUTH_JMJ' AND attribute= "+
				"'show_past_users'";
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
				count = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
				if (count != 0)
				{
					result = true;
				}
			}
			catch(Exception exec)
			{
				Log(exec.ToString(), System.Diagnostics.EventLogEntryType.Error);
				throw new Exception ("Error checking for show_past_users_row_exists", exec);
			}
			return result;
		}
		private bool show_past_users()
		{
			bool result = true;
			if (show_past_users_row_exists())
			{
				int count = 0;
				string sqlText = "SELECT COUNT(*) FROM c_component_attribute "+
					"WHERE component_id = 'AUTH_JMJ' AND attribute= "+
					"'show_past_users' AND (value like 'F%' OR value like 'N%')";
				SqlParameter[] sqlParams = null;
				try 
				{
					DataSet ds = ExecuteSql(sqlText,ref sqlParams);
					count = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
					if (count == 1)
					{
						result = false;
					}
				}
				catch(Exception exec)
				{
					Log(exec.ToString(), System.Diagnostics.EventLogEntryType.Error);
					throw new Exception ("Error checking for show_past_users", exec);
				}
			}
			return result;
		}
		#endregion //utility methods
	}
}
