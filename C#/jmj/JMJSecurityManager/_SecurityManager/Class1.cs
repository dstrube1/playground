using System;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

//referenced EprolibBase.dll copied from \\Techserv\devel\Common\EproLibBase
//web reference url: https://www.jmjtech.com/EPAuthority/Service.asmx?wsdl

namespace SecurityManager
{
	/// <summary>
	/// Descended from base class in EprolibBase
	/// see here for overview:
	/// https://www.jmjtech.com/intranet/Departments/Development/Products/EncounterPRO%20Components/SecurityManager/COM%20Security%20Manager.doc
	/// </summary>
	public class SecurityManager : EproLibBase.SecurityManager
	{
		//constructors
		public SecurityManager() : base()
		{
			this.Initialized+=new EventHandler(SecurityManager_Initialized);
		}

		private void SecurityManager_Initialized(object sender, EventArgs e)
		{
			getCustomerID();

			//if (!s_backupExists())
			//	s_backupCreate();
			//if it does exist, do nothing

		}
		

		//global variables
		private EPAuthority.Service svc = new EPAuthority.Service();
		private string customerID = null;

	#region descending methods
		protected override string challenge(string challenge)
		{
			//not very challenging yet
			return challenge;
		}

		protected override string authenticate()
		{
			string username = null;
			string password = null;
			try
			{
				fAuthenticate authForm = new fAuthenticate();
				authForm.User = "";
				authForm.FirstTime = true;
				authForm.Instructions = "Enter your username and password to Authenticate";
				if(authForm.ShowDialog() == DialogResult.OK)
				{
					username = authForm.User;
					password = authForm.Pass;
					try
					{
						//on success or failure, update s_backup
						EPAuthority.AuthenticateStatus status = svc.AuthenticateUser(username, password);
						if (status.UserAuthenticated )
						{
							MessageBox.Show("User was authenticated!  Whoo-hoo!");
							//on success if row does not exist in s_backup, add it
							//else update it
							c_userUpdate(username, password);
							return username;
						}
						else
						{
							MessageBox.Show("WRONG! You have lied and entered the password falsely. "+
								"Authorities are on their way. Please stay seated.");
							//on failure delete any rows in s_backup that match the username and password hash
							c_userDelete(username, password);
							return string.Empty;
						}
					}
					catch(Exception exec){
						Log("Authentication failed against web service. Trying against local cache. "+
							exec.ToString(), System.Diagnostics.EventLogEntryType.Error);
						//on exception, try authenticate against s_backup
						if (c_userAuthenticate(username, password))
							return username;
						else
							return string.Empty;
					}
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
		}

		protected override int reAuthenticate(string UserName)
		{
			//NOTE: This method is deprecated by the EPAuthority Web service
			return reAuthenticate (UserName, "");
		}

		protected override int changePassword(string UserName)
		{
			bool passwordChanged = false;
			//bool authenticated = false;
			string passwordNew = null;
			string passwordOld = null;
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
						}
						else 
						{
							MessageBox.Show("Password change for user " + UserName + " failed. Please try again, this time using a tougher password.", this.ToString());
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
			if (passwordChanged)
				return 1;
			else
				return 0;
		}

		protected override int resetPassword(string AdminUserName, string ResetUserName)
		{
			bool successfullyReset = false;
			//bool authenticated = false;
			string password = null;
			try
			{
				while (!successfullyReset)
				{
					//if (reAuthenticate(AdminUserName, "Enter your admin password") == 1)
					//{
					//	authenticated=true;
					fResetPassword resetForm = new fResetPassword();
					resetForm.ResetUser = ResetUserName;
					resetForm.AdminUser = AdminUserName;
					//authForm.Instructions = "Enter this user's new password";
					if(resetForm.ShowDialog() == DialogResult.OK)
					{
						password = resetForm.AdminPass;
						if(svc.ChangePassword(AdminUserName, password, ResetUserName))
						{
							successfullyReset = true;
						}
						else 
						{
							MessageBox.Show("Password reset for user " + ResetUserName + " failed. Please try again.", this.ToString());
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
				return string.Empty;
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
				estForm.Heading = "Enter a username and password";
						if(estForm.ShowDialog() == DialogResult.OK)
						{
							username = estForm.User;
							if (username.Length > 40) 
							{
								MessageBox.Show("Username '"+username + "' is greater than 40 character limit");
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
								Log("ds.Tables.Count = "+ds.Tables.Count.ToString(), System.Diagnostics.EventLogEntryType.Error);
								setOldUsername(UserID, usernameOld);
								return null;
							}
							if (dsResult == -1)
							{
								MessageBox.Show("SQL error in setting the username");
								Log("SQL error in setting the username", System.Diagnostics.EventLogEntryType.Error);
								setOldUsername(UserID, usernameOld);
							}
							else if (dsResult == 0)
							{
								MessageBox.Show("New username '"+username+"' was not unique for customer "+
									customerID+".");
								setOldUsername(UserID, usernameOld);
							}
							else if (dsResult == 1)
							{
								//MessageBox.Show("Just before svc.CreateNewUser()");
								EPAuthority.CreateUserStatus status = svc.CreateNewUser("davidAdmin","applesauce28!", username, password, email, question, answer);
								//MessageBox.Show("Just after svc.CreateNewUser()");
								if (status == EPAuthority.CreateUserStatus.Success)
								{
									MessageBox.Show("Username '"+username+"' has been established for userID '"+UserID+"'. Adding to security backup table.");
									finishedEstablishing = true;
									c_userUpdate(username, password);
								}
								else 
								{
									MessageBox.Show("Establishing credential failed: "+status.ToString());
									setOldUsername(UserID, usernameOld);
									username = null;
									//MessageBox.Show("question = "+question); 
								}
							}
							else
							{
								setOldUsername(UserID, usernameOld);
								MessageBox.Show("Unrecognized SQL return while establishing credentials");
							}
						}
						else {//clicked cancel - they want out
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

	#endregion //descending methods

		//derived methods:
		private int reAuthenticate (string UserName, string instructions)
		{
			//NOTE: This method is deprecated by the EPAuthority Web service
			string password = null;
			bool sameUser = false;
			try
			{
				fAuthenticate authForm = new fAuthenticate();
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


	#region utility methods

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
		protected string ComputeHash(string password)
		{
			// Create Byte array of password string
			ASCIIEncoding encoder = new ASCIIEncoding();
			Byte[] toHash = encoder.GetBytes(password);

			MD5 md5 = new MD5CryptoServiceProvider();
			Byte[] computedHash = md5.ComputeHash(toHash);

			return encoder.GetString(computedHash);
		}

		private void getCustomerID(){
			if (ComponentAttributes.ContainsKey("CustomerID"))
				customerID = ComponentAttributes["CustomerID"].ToString();
			else 
			{
				//call SQL to get customerID
				SqlParameter[] sqlParams = null;
				DataSet ds = ExecuteSql("SELECT Customer_ID FROM c_database_status",ref sqlParams);
				try 
				{
					customerID = ds.Tables[0].Rows[0][0].ToString();
				}
				catch(Exception exec)
				{
					throw new Exception ("No customerID in the database", exec);
				}
			}
			try 
			{
				int test = Int32.Parse(customerID);
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
		
		private void c_userUpdate(string username, string password){
			//assume row for the user exists
			string updateText = "UPDATE c_user SET pwdcache = '"+ 
				ComputeHash(password)+"', modified = "+
				"getdate() where username = '"+username+"'";
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
		private void c_userDelete(string username, string password){
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
		private bool c_userAuthenticate(string username, string password){
			bool result = false;
			int count = 0;
			string sqlText = "SELECT COUNT(*) FROM c_user WHERE username = '"+username
				+"' and pwdcache = '"+ComputeHash(password)+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql(sqlText,ref sqlParams);
				count = Int32.Parse(ds.Tables[0].Rows[0][0].ToString());
				if (count == 1)
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


		private string getOldUsername(string UserID){
			string usernameOld = null;
			string getText = "SELECT username FROM c_user WHERE user_id = '"+UserID+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				DataSet ds = ExecuteSql(getText,ref sqlParams);
				usernameOld = ds.Tables[0].Rows[0][0].ToString();
			}
			catch(Exception exec)
			{
				throw new Exception ("Error preparing for username rollback", exec);
			}
			return usernameOld;
		}
		private void setOldUsername(string UserID, string usernameOld){
			string sqlText = "UPDATE c_user set username = '"+usernameOld+
				"' WHERE user_id = '"+UserID+"'";
			SqlParameter[] sqlParams = null;
			try 
			{
				ExecuteSql(sqlText,ref sqlParams);
			}
			catch(Exception exec)
			{
				throw new Exception ("Error rollbacking username change", exec);
			}
		}
		#endregion //utility methods


	}
}
