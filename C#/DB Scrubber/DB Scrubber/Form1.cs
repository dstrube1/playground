using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Diagnostics;

namespace DB_Scrubber
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	
	public class Form1 : System.Windows.Forms.Form
	{

		//Methods
		private void bCancel_Click(object sender, EventArgs e)
		{
			lProgress.Text="Stopping the DB scrubbing...";
			keepLooping = false;
			lProgress.Text="DB Scrubbing has been stopped.";
		}

		private void bExecute_Click(object sender, EventArgs e)
		{
			if (null != loopThread && loopThread.IsAlive)
			{
				MessageBox.Show(this, "Already Running.");
				return;
			}

			loopThread = new System.Threading.Thread(new System.Threading.ThreadStart(loopThreadMethod));
			keepLooping = true;
			lProgress.Text="Executing";
			loopThread.Start();
		}


		private void loopThreadMethod()
		{
			try 
			{
				#region Declare local variables
				string[] textArray = new string[5] { "Server=", this.tbServer.Text, ";Database=", 
													   this.tbDatabase.Text, ";Integrated Security=SSPI;Connect Timeout=60" } ;

				//Before going any further, determine if a radio button has been selected. 
				int delPercent=0;
				int delCount=0;
				bool delSome=false;
				bool delAll=false;
				//If not, exit with a wag of the finger.
				if (! rbDeleteAll.Checked && ! rbScrubAll.Checked && ! rbScrubSome.Checked)
				{
					MessageBox.Show("Choose an option", "Error");
					return;
				}
				else if (rbScrubSome.Checked)
				{
					if (tbScrubSome.Text.EndsWith("%"))
					{
						delPercent = Int32.Parse(tbScrubSome.Text.Substring(0,tbScrubSome.Text.IndexOf("%")));
						if (delPercent < 0 || delPercent > 100)
						{
							MessageBox.Show("Invalid percentage", "Error");
							return;
						}
					}
					else 
					{
						delCount = Int32.Parse(tbScrubSome.Text);
						if (delCount < 0)
						{
							MessageBox.Show("Invalid patient count", "Error");
							return;
						}
					}
					delSome = true;
				}
				else if (rbDeleteAll.Checked){
					delAll=true;
				}

				lProgress.Text="Establishing SQL connection";

				bool debug=false;
				bool looking4ID=true;
				SqlConnection connection1 = new SqlConnection(string.Concat(textArray));
				connection1.Open();
				int countBillingID=0;
				Random rand = new Random();
				int randMax = 0;
				int test_billingID=0;
				int billingID = 0;
				string old_cpr_id = "";
				int new_cpr_id = 0;
				string temp_firstname="";
				string temp_lastname="";
				char temp_midname;
				Guid myGuid;
				string temp_filename="";
				int temp_age = 0;
				const string attachmentPath=@".\data_files\attachments\";
				const string portraitPath=@"portraits\";
				string temp_ext = "";

				SqlConnection connection_p_pt = new SqlConnection(connection1.ConnectionString);
				connection_p_pt.Open();
				SqlCommand command_p_pt = new SqlCommand("SELECT count(*) from p_patient WITH (NOLOCK)", connection_p_pt);
				SqlDataReader reader_p_pt = command_p_pt.ExecuteReader();
				
				SqlConnection connection_p_pt2= new SqlConnection(connection1.ConnectionString);
				connection_p_pt2.Open();
				SqlCommand command_p_pt2 = new SqlCommand();
				SqlDataReader reader_p_pt2;

				reader_p_pt.Read();
				countBillingID = (int)reader_p_pt[0];
				randMax = countBillingID * 100;
				reader_p_pt.Close();
				command_p_pt = new SqlCommand("SELECT * from p_patient WITH (NOLOCK)", connection_p_pt);

				SqlConnection connection_cprId = new SqlConnection(connection1.ConnectionString);
				connection_cprId.Open();
				SqlCommand command_cprId = new SqlCommand();		

				SqlConnection connection_p_attachment = new SqlConnection(connection1.ConnectionString);
				connection_p_attachment.Open();
				SqlCommand command_p_attachment = new SqlCommand("SELECT * from p_attachment WITH (NOLOCK)", connection_p_attachment);
				SqlDataReader reader_p_attachment;// = command_p_attachment.ExecuteReader();

				SqlConnection connection_NonQuery = new SqlConnection(connection1.ConnectionString);
				connection_NonQuery.Open();
				SqlCommand command_NonQuery = new SqlCommand();

				#endregion // Declare local variables

				while (keepLooping)
				{
					lProgress.Text = "Removing constaints from p tables. (This may take a few minutes.)";
					//ran this against a small db in query analyzer, duration=2 min 24 sec
					removePConstraints(command_cprId, connection_cprId);

					//Now that constraints are out of the way, we have the option of deleting patients
					if (delAll){
						deletePercentPatients(connection_NonQuery, 100);
					}
					
				
					//must initialize the readers AFTER removing constraints
					reader_p_attachment = command_p_attachment.ExecuteReader();
					reader_p_pt = command_p_pt.ExecuteReader();

					//reset the users
					lProgress.Text = "Scrubbing c_user";
					resetUsers(connection_NonQuery);

					//Create a cpr_id translation table to hold the cpr_id translations that will be 
					//performed at the end (old_cpr_id, new_cpr_id)
					create_temp_cpr_id(connection_cprId);

					//happens so fast (thus far) not bothering with progress bar update
					lProgress.Text = "Scrubbing p_patient";

					while (reader_p_pt.Read())
					{
						#region Change Pt names
						//1.	If the patient is female (p_patient.sex = ‘F’) then pick a random name from the 
						//“Female First Names” data file.  Otherwise pick a random name from the “Male First Names” 
						//data file.  Update p_Patient.first_name
						if (debug)
						{
							Console.WriteLine("Pt before transform: "+reader_p_pt["billing_ID"]+"\n"+
								reader_p_pt["first_name"]+" "+reader_p_pt["last_name"]);
						}
						if ((string)reader_p_pt["sex"]=="F")
						{
							temp_firstname = (string)femaleFirstNames[rand.Next(0, femaleFirstNames.Count-1)];
						}
							//else if ((string)reader_p_pt["sex"]=="M")
							//{
							//	temp_firstname = (string)maleFirstNames[rand.Next(0, maleFirstNames.Count-1)];
							//}
						else 
						{
							//pt is male/hemaphrodite/neuter, but let's assume male
							temp_firstname = (string)maleFirstNames[rand.Next(0, maleFirstNames.Count-1)];
						}
						command_NonQuery = new SqlCommand("UPDATE p_patient SET first_name = '"+temp_firstname+
							"' WHERE cpr_id = '"+reader_p_pt["cpr_id"]+"'", connection_NonQuery);
						command_NonQuery.ExecuteNonQuery();

						//2.	Pick a random name from the “Last Names” data file.  Update p_Patient.last_name
						temp_lastname = (string)lastNames[rand.Next(0, lastNames.Count-1)];
						command_NonQuery = new SqlCommand("UPDATE p_patient SET last_name = '"+temp_lastname+
							"' WHERE cpr_id = '"+reader_p_pt["cpr_id"]+"'", connection_NonQuery);
						command_NonQuery.ExecuteNonQuery();

						//3.	Pick a random character (A-Z).  Update p_Patient.middle_name.
						temp_midname = alphabet[rand.Next(0, 25)];
						command_NonQuery = new SqlCommand("UPDATE p_patient SET middle_name = '"+temp_midname+
							"' WHERE cpr_id = '"+reader_p_pt["cpr_id"]+"'", connection_NonQuery);
						command_NonQuery.ExecuteNonQuery();
						#endregion // Change Pt names

						//4.	Set the following fields in p_Patient to null
						setFieldsToNull(command_NonQuery, connection_NonQuery, (string)reader_p_pt["cpr_id"]);//reader_p_pt);
					
						//5.	Set p_Patient.id to a new guid
						myGuid = System.Guid.NewGuid();
						command_NonQuery = new SqlCommand("UPDATE p_patient set id= '"+myGuid+
							"' WHERE cpr_id = '"+reader_p_pt["cpr_id"]+"'", connection_NonQuery);
						command_NonQuery.ExecuteNonQuery();

						#region Change Pt billing id
						//6.	Set p_Patient.billing_id to the current “billing_id” counter.  Increment the counter.  
						//If it exceeds the number of patients, set it back to 1.
						try
						{
							while (looking4ID)
							{
								test_billingID=rand.Next(1,randMax);
								command_p_pt2 = new SqlCommand("select count(*) from p_patient where cpr_id <> '"+
									test_billingID+"' OR billing_id <> '"+test_billingID+"'",connection_p_pt2);
								reader_p_pt2 = command_p_pt2.ExecuteReader();
								reader_p_pt2.Read();
								if ((int)reader_p_pt2[0] != countBillingID)
								{
									//not all patients do not match this number; ie, some pt does match it
									//do nothing/keep looping
								}
								else
								{
									looking4ID=false;
									billingID=test_billingID;
								}
								reader_p_pt2.Close();
							}
							looking4ID=true;
							command_NonQuery = new SqlCommand("UPDATE p_patient SET billing_id = '"+billingID+
								"' WHERE cpr_id = '"+reader_p_pt["cpr_id"]+"'", connection_NonQuery);
							command_NonQuery.ExecuteNonQuery();
						}
						catch (Exception e)
						{
							Console.WriteLine("Failure assigning new billing_id");
							Console.WriteLine(e.ToString());
						}
						#endregion // Change Pt billing id
					
						//7.	Insert a record into the cpr_id translation table with the old_cpr_id is the current cpr_id 
						//and the new_cpr_id is the billing_id determined in the previous step.
						old_cpr_id = (string) reader_p_pt["cpr_id"];
						new_cpr_id = billingID;
						command_cprId = new SqlCommand("INSERT INTO temp_cpr_id (old_cpr_id, new_cpr_id) " +
							"VALUES ('"+old_cpr_id +"','"+ new_cpr_id + "')",connection_cprId);
						command_cprId.ExecuteNonQuery();

						//8.	Set p_Patient.address_line_1 to a concatenation of the new billing_id and 
						//the street name “ EncounterPRO Lane”
						command_NonQuery = new SqlCommand("UPDATE p_patient SET address_line_1 = '"+billingID + 
							" EncounterPRO Lane' WHERE cpr_id = '"+reader_p_pt["cpr_id"]+"'", connection_NonQuery);
						command_NonQuery.ExecuteNonQuery();

						//9.	Set p_Patient.city, p_Patient.state, p_Patient.zip to “Atlanta”, “GA”, and “30339”, respectively.
						command_NonQuery = new SqlCommand("UPDATE p_patient SET city = 'Atlanta', state = 'GA', zip='30339'" +
							" WHERE cpr_id = '"+reader_p_pt["cpr_id"]+"'", connection_NonQuery);
						command_NonQuery.ExecuteNonQuery();

						//10.	Pick a random number between 1 and 20.  Subtract that many days from p_Patient.date_of_birth and 
						//update p_Patient.date_of_birth with the new value.
						command_NonQuery = new SqlCommand("UPDATE p_patient SET date_of_birth=date_of_birth-"+ rand.Next(1, 20) +
							"WHERE cpr_id = '"+reader_p_pt["cpr_id"]+"'", connection_NonQuery);
						command_NonQuery.ExecuteNonQuery();
						if (debug)
						{
							Console.WriteLine("Pt after transform : "+billingID+"\n"+
								temp_firstname+" "+temp_lastname);
						}
						temp_firstname="";
						temp_lastname="";
					}

					//happens so fast (thus far) not bothering with progress bar update
					lProgress.Text = "Scrubbing p_patient_progress";

					//while (reader_p_pt_progress.Read()){
					//Delete every record from p_Patient_Progress where progress_type = ‘Modify’
					//Delete every record from p_Patient_Progress where progress_type = ‘Property’
					command_NonQuery = new SqlCommand("DELETE FROM p_patient_progress WHERE " +
						"(progress_type = 'Modify') OR (progress_type = 'Property')", connection_NonQuery);
					command_NonQuery.ExecuteNonQuery();
					//}

					#region Scrub p_attachment
					//happens so fast (thus far) not bothering with progress bar update
					lProgress.Text = "Scrubbing p_attachment";

					while (reader_p_attachment.Read())
					{
						GC.Collect();
						temp_filename = "";

						command_p_pt2 = new SqlCommand("SELECT cpr_id, sex, datediff(year, date_of_birth, getdate())" +
							" as age FROM p_patient where cpr_id = '"+reader_p_attachment["cpr_id"]+ "'", connection_p_pt2);
						reader_p_pt2 = command_p_pt2.ExecuteReader();
						reader_p_pt2.Read();
						//Console.WriteLine("reader_p_attachment[cpr_id] = "+reader_p_attachment["cpr_id"]);

						//	If attachment_type = ‘IMAGE’ and attachment_tag = ‘Portrait’, pick a random portrait image for 
						//the appropriate gender/age group and update p_Attachment.attachment_image with the image and set 
						//p_Attachment.storage_flag = ‘D’
						if ((string)reader_p_attachment["attachment_type"] == "IMAGE" && 
							(string)reader_p_attachment["attachment_tag"] == "Portrait")
						{
							//upload some portrait file based on pt age and sex
							//first prepare filename 
							temp_age = (int)reader_p_pt2["age"];
							temp_filename = attachmentPath + portraitPath;
							//Console.WriteLine("cpr_id="+reader_p_attachment["cpr_id"]);
							//Console.WriteLine("age="+temp_age);
							if ((string)reader_p_pt2["sex"]=="F")
							{
								temp_filename +="F";
							}
							else 
							{
								temp_filename +="M";
							}
							//temp_age=1;
							if (temp_age>=0 && temp_age<3)	
							{
								temp_filename+="0-3.bmp";
							}
							else if (temp_age>=3 && temp_age<8)  /* then */{temp_filename+="3-8.bmp";}
							else if (temp_age>=8 && temp_age<12) {temp_filename+="8-12.bmp";}
							else if (temp_age>=12 && temp_age<16){temp_filename+="12-16.bmp";}
							else if (temp_age>=16 && temp_age<22){temp_filename+="16-22.bmp";}
							else if (temp_age>=22 && temp_age<30){temp_filename+="22-30.bmp";}
							else if (temp_age>=30 && temp_age<45){temp_filename+="30-45.bmp";}
							else if (temp_age>=45 && temp_age<60){temp_filename+="45-60.bmp";}
							else {temp_filename+="60up.bmp";}
							//next, with the file name, upload the file to the specified table
							//Since this action is duplicated below, creating new method for this
							updatePAttachment(command_NonQuery, connection_NonQuery, (int)reader_p_attachment["attachment_id"], 
								(string)reader_p_attachment["cpr_id"], temp_filename);
							//making sure the extension is bitmap, as it will be
							command_NonQuery = new SqlCommand("UPDATE p_attachment set extension='bmp' where attachment_id = "+
								reader_p_attachment["attachment_id"],connection_NonQuery);
							command_NonQuery.ExecuteNonQuery();
						}
							//	Else if there are any sample files for the p_Attachment.extension value, then pick a random 
							//file of the correct type and update p_Attachment.attachment_image with the contents of the file 
							//and set p_Attachment.storage_flag = ‘D’
						else if (extensions.Contains("."+reader_p_attachment["extension"].ToString().ToLower()))	
						{
							//upload some non portrait file
							//first, find a file with this extension
							temp_ext = "."+reader_p_attachment["extension"].ToString().ToLower();
							//temp_filename = attachmentPath;
							temp_filename += fileAttachments[extensions.IndexOf(temp_ext)];
							updatePAttachment(command_NonQuery, connection_NonQuery, (int)reader_p_attachment["attachment_id"], 
								(string)reader_p_attachment["cpr_id"], temp_filename);
						}
							//	Else delete the record from p_Attachment and any records from p_Patient_Progress, 
							//p_Patient_Encounter_Progress, p_Assessment_Progress, and p_Treatment_Progress which have the 
							//same cpr_id and attachment_id
						else 
						{
							command_NonQuery = new SqlCommand("DELETE FROM p_attachment WHERE cpr_id = '" +
								reader_p_attachment["cpr_id"] + "' AND attachment_id = '" + reader_p_attachment["attachment_id"] +
								"'", connection_NonQuery);
							command_NonQuery.ExecuteNonQuery();

							command_NonQuery = new SqlCommand("DELETE FROM p_patient_progress WHERE cpr_id = '" +
								reader_p_attachment["cpr_id"] + "' AND attachment_id = '" + reader_p_attachment["attachment_id"] +
								"'", connection_NonQuery);
							command_NonQuery.ExecuteNonQuery();

							command_NonQuery = new SqlCommand("DELETE FROM p_patient_encounter_progress WHERE cpr_id = '" +
								reader_p_attachment["cpr_id"] + "' AND attachment_id = '" + reader_p_attachment["attachment_id"] +
								"'", connection_NonQuery);
							command_NonQuery.ExecuteNonQuery();

							command_NonQuery = new SqlCommand("DELETE FROM p_assessment_progress WHERE cpr_id = '" +
								reader_p_attachment["cpr_id"] + "' AND attachment_id = '" + reader_p_attachment["attachment_id"] +
								"'", connection_NonQuery);
							command_NonQuery.ExecuteNonQuery();

							command_NonQuery = new SqlCommand("DELETE FROM p_treatment_progress WHERE cpr_id = '" +
								reader_p_attachment["cpr_id"] + "' AND attachment_id = '" + reader_p_attachment["attachment_id"] +
								"'", connection_NonQuery);
							command_NonQuery.ExecuteNonQuery();
						}
						reader_p_pt2.Close();
						#endregion // Scrub p_attachment
					}
					//Use the cpr_id translation table to update the cpr_id in every “p” table.
					lProgress.Text = "Changing cpr_ids";
					updateCprIds(command_cprId, command_NonQuery, connection_cprId, progressBar1) ;

					//must have readers closed before rebuilding constraints
					reader_p_pt.Close();
					reader_p_attachment.Close();

					//Rebuild constraints for all “p” tables 
					rebuildConstraints(command_NonQuery, connection_NonQuery, progressBar1, lProgress);

					connection1.Close();
					connection_p_pt.Close();
					connection_cprId.Close();
					connection_p_attachment.Close();
					connection_NonQuery.Close();
					keepLooping = false;
				}
				lProgress.Text="DB Scrubbing has completed.";
			}
			catch (Exception e){
				MessageBox.Show(e.ToString(),"Error");
			}
	}

		#region Global variables
		private bool keepLooping = false;
		private System.Threading.Thread loopThread = null;
		private System.Windows.Forms.Button bExecute;
		private System.Windows.Forms.Button bCancel;
		private System.Windows.Forms.TextBox tbDatabase;
		private System.Windows.Forms.TextBox tbServer;
		private System.Windows.Forms.Label lServer;
		private System.Windows.Forms.Label lDatabase;
		private string alphabet;
		private ArrayList maleFirstNames = new ArrayList();
		private ArrayList femaleFirstNames = new ArrayList();
		private ArrayList lastNames = new ArrayList();
		private ArrayList extensions = new ArrayList();
		private ArrayList fileAttachments = new ArrayList(Directory.GetFiles(@".\data_files\attachments\"));
		private System.Windows.Forms.Label lProgress;
		private System.Windows.Forms.ProgressBar progressBar1;
		#endregion // Global variables
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.RadioButton rbScrubSome;
		private System.Windows.Forms.RadioButton rbScrubAll;
		private System.Windows.Forms.RadioButton rbDeleteAll;
		private System.Windows.Forms.TextBox tbScrubSome;

		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public Form1()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			lProgress.Text="Please have a copy of the database backed up before executing this.";
			
			const string MFN_FILE_NAME = @".\data_files\MaleFirstNames.txt";
			const string FFN_FILE_NAME = @".\data_files\FemaleFirstNames.txt";
			const string LN_FILE_NAME = @".\data_files\LastNames.txt";

			fillArray (MFN_FILE_NAME, maleFirstNames);
			fillArray (FFN_FILE_NAME, femaleFirstNames);
			fillArray (LN_FILE_NAME, lastNames);
			
			alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			for (int i=0; i<fileAttachments.Count; i++)
			{
				extensions.Add(Path.GetExtension(fileAttachments[i].ToString()));
			}
			extensions.TrimToSize();
		}


		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing ){
			if( disposing )	{
				if (components != null) {
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
			this.bExecute = new System.Windows.Forms.Button();
			this.lServer = new System.Windows.Forms.Label();
			this.lDatabase = new System.Windows.Forms.Label();
			this.tbServer = new System.Windows.Forms.TextBox();
			this.tbDatabase = new System.Windows.Forms.TextBox();
			this.bCancel = new System.Windows.Forms.Button();
			this.lProgress = new System.Windows.Forms.Label();
			this.progressBar1 = new System.Windows.Forms.ProgressBar();
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.rbScrubAll = new System.Windows.Forms.RadioButton();
			this.rbDeleteAll = new System.Windows.Forms.RadioButton();
			this.rbScrubSome = new System.Windows.Forms.RadioButton();
			this.tbScrubSome = new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			// 
			// bExecute
			// 
			this.bExecute.Location = new System.Drawing.Point(32, 96);
			this.bExecute.Name = "bExecute";
			this.bExecute.TabIndex = 0;
			this.bExecute.Text = "Execute";
			this.bExecute.Click += new System.EventHandler(this.bExecute_Click);
			// 
			// lServer
			// 
			this.lServer.Location = new System.Drawing.Point(8, 16);
			this.lServer.Name = "lServer";
			this.lServer.TabIndex = 1;
			this.lServer.Text = "Server";
			// 
			// lDatabase
			// 
			this.lDatabase.Location = new System.Drawing.Point(8, 56);
			this.lDatabase.Name = "lDatabase";
			this.lDatabase.Size = new System.Drawing.Size(80, 23);
			this.lDatabase.TabIndex = 2;
			this.lDatabase.Text = "Database";
			// 
			// tbServer
			// 
			this.tbServer.Location = new System.Drawing.Point(120, 16);
			this.tbServer.Name = "tbServer";
			this.tbServer.Size = new System.Drawing.Size(176, 20);
			this.tbServer.TabIndex = 3;
			this.tbServer.Text = "";
			// 
			// tbDatabase
			// 
			this.tbDatabase.Location = new System.Drawing.Point(120, 56);
			this.tbDatabase.Name = "tbDatabase";
			this.tbDatabase.Size = new System.Drawing.Size(176, 20);
			this.tbDatabase.TabIndex = 4;
			this.tbDatabase.Text = "";
			// 
			// bCancel
			// 
			this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.bCancel.Location = new System.Drawing.Point(128, 96);
			this.bCancel.Name = "bCancel";
			this.bCancel.TabIndex = 5;
			this.bCancel.Text = "Cancel";
			this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
			// 
			// lProgress
			// 
			this.lProgress.Location = new System.Drawing.Point(8, 128);
			this.lProgress.Name = "lProgress";
			this.lProgress.Size = new System.Drawing.Size(312, 48);
			this.lProgress.TabIndex = 7;
			// 
			// progressBar1
			// 
			this.progressBar1.Location = new System.Drawing.Point(8, 192);
			this.progressBar1.Name = "progressBar1";
			this.progressBar1.Size = new System.Drawing.Size(312, 23);
			this.progressBar1.TabIndex = 8;
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(40, 232);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(120, 23);
			this.label1.TabIndex = 9;
			this.label1.Text = "Anonymize all patients";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(40, 256);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(104, 23);
			this.label2.TabIndex = 10;
			this.label2.Text = "Delete all patients";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(40, 280);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(216, 23);
			this.label3.TabIndex = 11;
			this.label3.Text = "Anonymize this many and delete the rest";
			// 
			// rbScrubAll
			// 
			this.rbScrubAll.Location = new System.Drawing.Point(8, 232);
			this.rbScrubAll.Name = "rbScrubAll";
			this.rbScrubAll.Size = new System.Drawing.Size(24, 24);
			this.rbScrubAll.TabIndex = 12;
			// 
			// rbDeleteAll
			// 
			this.rbDeleteAll.Location = new System.Drawing.Point(8, 256);
			this.rbDeleteAll.Name = "rbDeleteAll";
			this.rbDeleteAll.Size = new System.Drawing.Size(24, 24);
			this.rbDeleteAll.TabIndex = 13;
			// 
			// rbScrubSome
			// 
			this.rbScrubSome.Location = new System.Drawing.Point(8, 280);
			this.rbScrubSome.Name = "rbScrubSome";
			this.rbScrubSome.Size = new System.Drawing.Size(24, 24);
			this.rbScrubSome.TabIndex = 14;
			// 
			// tbScrubSome
			// 
			this.tbScrubSome.Location = new System.Drawing.Point(256, 280);
			this.tbScrubSome.Name = "tbScrubSome";
			this.tbScrubSome.Size = new System.Drawing.Size(64, 20);
			this.tbScrubSome.TabIndex = 15;
			this.tbScrubSome.Text = "";
			// 
			// Form1
			// 
			this.AcceptButton = this.bExecute;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.bCancel;
			this.ClientSize = new System.Drawing.Size(328, 325);
			this.Controls.Add(this.tbScrubSome);
			this.Controls.Add(this.tbDatabase);
			this.Controls.Add(this.tbServer);
			this.Controls.Add(this.rbScrubSome);
			this.Controls.Add(this.rbDeleteAll);
			this.Controls.Add(this.rbScrubAll);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.progressBar1);
			this.Controls.Add(this.lProgress);
			this.Controls.Add(this.bCancel);
			this.Controls.Add(this.lDatabase);
			this.Controls.Add(this.lServer);
			this.Controls.Add(this.bExecute);
			this.Name = "Form1";
			this.Text = "DB Scrubber";
			this.DoubleClick += new System.EventHandler(this.Form1_DoubleClick);
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
			
		}


		private void Form1_DoubleClick(object sender, System.EventArgs e){
			if (this.WindowState == FormWindowState.Maximized){
				this.WindowState = FormWindowState.Normal;
			} 
			else if (this.WindowState == FormWindowState.Normal){
				this.WindowState = FormWindowState.Maximized;
			}
		}


		private static void fillArray (string filename, ArrayList myList){
			try {
				using (StreamReader sr = new StreamReader(filename)) {
					String line;
					while ((line = sr.ReadLine()) != null) {
						myList.Add(line);
					}
					myList.TrimToSize();
				}
			}
			catch (Exception e) {
				Console.WriteLine("The file could not be read:");
				Console.WriteLine(e.Message);
				EventLog.WriteEntry("DB Scrubber", e.ToString(), EventLogEntryType.Error);
			}
		}


		private static void removePConstraints(SqlCommand command, SqlConnection connection){
			string commandText = @"
				DECLARE @ls_tables varchar(128)
				DECLARE @tmpScript VARCHAR(8000)
				SET @ls_tables = 'p%'
				DECLARE TableCursor CURSOR LOCAL FAST_FORWARD FOR
					SELECT
						 tablename
						,index_script
					FROM
						 c_Database_Table WITH (NOLOCK)
					WHERE
						tablename LIKE @ls_tables
					AND	tablename <> 'c_database_table'
					ORDER BY
						 tablename
				DECLARE
					 @TableName SYSNAME
					,@IndexScript VARCHAR (8000)
					,@ll_error int
				OPEN TableCursor
				FETCH NEXT FROM TableCursor
				INTO
					 @TableName
					,@IndexScript
				WHILE @@FETCH_STATUS = 0
				BEGIN
					-- Drop the constraints but keep the triggers
					EXEC sp_drop_constraints @TableName
					SET @tmpScript = 'CREATE INDEX tmpidx_cpr_id ON ' + @TableName + ' (cpr_id)'
					EXEC(@tmpScript)
					FETCH NEXT FROM TableCursor
					INTO
						 @TableName
						,@IndexScript
				END
				CLOSE TableCursor
				DEALLOCATE TableCursor";

			command = new SqlCommand(commandText, connection);
			command.CommandTimeout = 0;
			//Console.WriteLine("Before running the query");
			command.ExecuteNonQuery();
			//Console.WriteLine("After running the query");
		}


		private void deletePercentPatients(SqlConnection connection, int percent){
			SqlCommand command = new SqlCommand();
			if (percent ==100)
			{
				command = new SqlCommand("DELETE FROM p_patient",connection);
				command.ExecuteNonQuery();
			}
			else if (percent==0){}
			else {}
		}

		private void resetUsers(SqlConnection connection){
			SqlConnection connection_NonQuery = new SqlConnection(connection.ConnectionString);
			connection_NonQuery.Open(); 
			SqlCommand command_NonQuery = new SqlCommand();

			SqlConnection connection_1 = new SqlConnection(connection.ConnectionString);
			connection_1.Open();
			SqlCommand command_1 = new SqlCommand("select * from c_user where user_status in ('OK', 'NA');",connection_1);
			SqlDataReader reader_1 = command_1.ExecuteReader();
			
			int count = 0;
			string firstname = "User";
			string lastname = "Smith";
			char middle;
			string license_flag;
			string license = "0123456789ACEGIKLMNOS"; //numbers plus some of the letters found in state abbreviations
			string license_number = "";
			int license_number_length = 10;
			string dea_number = "";
			int dea_number_length = 9;
			Random rand = new Random();

			while (reader_1.Read()){
				middle = alphabet[rand.Next(0, 25)];

				command_NonQuery = new SqlCommand("UPDATE c_user set user_full_name = '"+firstname+count
					+" "+middle+" "+lastname+"', user_short_name = '"+firstname+count
					+"', user_initial = 'U"+middle
					+"S', first_name = '"+firstname+count
					+"', middle_name = '"+middle
					+"', last_name = '"+lastname+"' where user_id = '"+reader_1["user_id"]+"'", connection_NonQuery);
				command_NonQuery.ExecuteNonQuery();
				
				//if it's a licensed user, change the license numbers
				if (! reader_1.IsDBNull(reader_1.GetOrdinal("license_flag")))
				{
					license_flag = (string)reader_1["license_flag"];
					if (license_flag == "P" || license_flag == "E")
					{
						//set the license numbers to random stuff
						for (int i=0; i<license_number_length; i++)
						{
							license_number += license[rand.Next(0, license.Length-1)];
						}
						for (int j=0; j<dea_number_length; j++)
						{
							dea_number += license[rand.Next(0, license.Length-1)];
						}

						//since there is no reliable way that i know of to test for whether the user already has a dea number, 
						// i'm just gonna go ahead and set it
						command_NonQuery = new SqlCommand("UPDATE c_user set dea_number = '"+dea_number
							+"', license_number = '"+license_number
							+"' where user_id = '"+reader_1["user_id"]+"'", connection_NonQuery);
						command_NonQuery.ExecuteNonQuery();
						license_number = "";
						dea_number = "";
					}
				}
				count++;
			}
			reader_1.Close();
			connection_1.Close();
			connection_NonQuery.Close();
		}


		private void create_temp_cpr_id(SqlConnection connection){
			SqlCommand command_cprId = new SqlCommand();
			try 
			{
				command_cprId = new SqlCommand("DROP TABLE temp_cpr_id", connection);
				command_cprId.ExecuteNonQuery();
			}
			catch (Exception e)
			{
				Console.WriteLine("Table temp_cpr_id doesn't already exist. This is a precaution, NOT A PROBLEM:");
				Console.WriteLine(e.ToString());
			}
			command_cprId = new SqlCommand("CREATE TABLE temp_cpr_id (old_cpr_id varchar(12), new_cpr_id varchar(12))",
				connection);
			command_cprId.ExecuteNonQuery();
		}

		private static void setFieldsToNull(SqlCommand command, SqlConnection connection, string cpr_id){
			try
			{
				command = new SqlCommand("UPDATE p_patient SET Race=NULL, Primary_language=NULL, Marital_status=NULL, " +
					"Ssn=NULL, degree=NULL, name_prefix=NULL, name_suffix=NULL, maiden_name=NULL, phone_number=NULL, patient_id=NULL, " +
					"date_of_conception=NULL, referring_provider_id=NULL, secondary_phone_number=NULL, email_address=NULL, " +
					"address_line_2=NULL, religion=NULL, nationality=NULL, country=NULL, financial_class=NULL, employer=NULL, employeeid=NULL, " +
					"department=NULL, shift=NULL, job_description=NULL, start_date=NULL, termination_date=NULL, employment_status=NULL" +
					" WHERE cpr_id = '"+cpr_id+"'", connection);
				command.ExecuteNonQuery();
			}
			catch (Exception e)
			{
				Console.WriteLine("Failure in setFieldsToNull");
				EventLog.WriteEntry("DB Scrubber", e.ToString(), EventLogEntryType.Error);
			}
		}


		private static void updatePAttachment(SqlCommand myCom, SqlConnection connection1, int attachment_id, 
			string cpr_id, string filename){
		//pretty much copied from EPAttachExtractor\Form1
			//string attachmentID = Path.GetFileNameWithoutExtension(filename);
			try
			{
				FileInfo fi = new FileInfo(filename);
				byte[] fileData = new byte[fi.Length];
				FileStream fs = new FileStream(filename, FileMode.Open);
				fs.Read(fileData,0,fileData.Length);
				fs.Close();
				myCom = new SqlCommand("UPDATE p_attachment SET attachment_image= @param WHERE attachment_id = "+
					attachment_id + " AND cpr_id ='" + cpr_id +"'", connection1);
				myCom.Parameters.Clear();
				myCom.Parameters.Add(new SqlParameter("@param", SqlDbType.Image));
				myCom.Parameters[0].Direction = ParameterDirection.Input;
				myCom.Parameters[0].Value = fileData;
				myCom.ExecuteNonQuery();
				//Console.WriteLine("Suceeded changing attachment "+attachment_id+" to "+filename);
			}
			catch (Exception e){
				Console.WriteLine("Failure in updatePAttachment");
				EventLog.WriteEntry("DB Scrubber", e.ToString(), EventLogEntryType.Error);
			}
		}


		private static void updateCprIds(SqlCommand command_1, SqlCommand command_NonQuery, SqlConnection connection_NonQuery, ProgressBar progressBar1){
			bool debug=false;
			SqlConnection connection_1 = new SqlConnection(connection_NonQuery.ConnectionString);
			connection_1.Open();
			command_1 = new SqlCommand("SELECT * FROM temp_cpr_id", connection_1);
			SqlDataReader reader_1 = command_1.ExecuteReader();

			SqlConnection connection_p_tables = new SqlConnection(connection_1.ConnectionString);
			connection_p_tables.Open();
			SqlCommand command_p_tables = new SqlCommand("SELECT tablename as name FROM c_database_table WHERE tablename like 'p_%' ORDER BY tablename",
				connection_p_tables);
			//optionally: select * from sysobjects where name like 'p\_%' escape '\' order by name
			SqlDataReader reader_p_tables = command_p_tables.ExecuteReader();

			SqlConnection connection_pt_count = new SqlConnection(connection_1.ConnectionString);
			connection_pt_count.Open();
			SqlCommand command_pt_count = new SqlCommand("SELECT count(*) FROM p_patient",
				connection_pt_count);
			//optionally: select * from sysobjects where name like 'p\_%' escape '\' order by name
			SqlDataReader reader_pt_count = command_pt_count.ExecuteReader();
			reader_pt_count.Read();
			int pt_count = (int)reader_pt_count[0];
			reader_pt_count.Close();
			progressBar1.Minimum = 0;
			progressBar1.Maximum = 100;//p_tables_count;
			progressBar1.Value = 1;
			progressBar1.Step = 100/pt_count;

			string table;

			while (reader_1.Read())
			{
				if (debug){
				Console.WriteLine("Changing records for pt from "+reader_1["old_cpr_id"]+" to "+reader_1["new_cpr_id"]);
				}
				while(reader_p_tables.Read()){
				//for (int i=0; i<pTables.Count; i++) <-- was gonna do this with another ArrayList, but ^this^ way's better
					try
					{
						table = reader_p_tables["name"].ToString();
						command_NonQuery = new SqlCommand("UPDATE "+ table +" SET cpr_id = '"+ reader_1["new_cpr_id"] + 
							"' WHERE cpr_id = '"+ reader_1["old_cpr_id"] +"'", connection_NonQuery);
						command_NonQuery.ExecuteNonQuery();
					}
					catch (Exception e)
					{
						Console.WriteLine("Failure in updateCprIds");
						EventLog.WriteEntry("DB Scrubber", e.ToString(), EventLogEntryType.Error);
					}
				}
				progressBar1.PerformStep();
				command_p_tables = new SqlCommand("SELECT tablename as name FROM c_database_table WHERE tablename like 'p_%' ORDER BY tablename",
					connection_p_tables);
				reader_p_tables.Close();
				reader_p_tables = command_p_tables.ExecuteReader();
			}
			connection_p_tables.Close();
			reader_p_tables.Close();
			reader_1.Close();
			command_1 = new SqlCommand("DROP TABLE temp_cpr_id", connection_1);
			command_1.ExecuteNonQuery();
			connection_1.Close();
		}


		private static void rebuildConstraints(SqlCommand command_NonQuery, SqlConnection connection_NonQuery, ProgressBar progressBar1, Label lProgress)
		{
			SqlConnection connection_1 = new SqlConnection(connection_NonQuery.ConnectionString);
			connection_1.Open();
			SqlCommand command_1 = new SqlCommand("SELECT count(tablename) FROM c_database_table WHERE tablename like 'p_%'",connection_1);
			SqlDataReader reader_1 = command_1.ExecuteReader();
			//see also : SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME like 'p_%'
			//only problem is returns tables where name like "p%' not 'p_%'

			reader_1.Read();
			int p_tables_count = (int) reader_1[0];
			reader_1.Close();

			progressBar1.Minimum = 0;
			progressBar1.Maximum = p_tables_count;
			progressBar1.Value = 1;
			progressBar1.Step = 1;

			command_1 = new SqlCommand("SELECT tablename as name FROM c_database_table WHERE tablename like 'p_%' ORDER BY tablename",connection_1);
			reader_1 = command_1.ExecuteReader();
			string table ="";
			while(reader_1.Read())
			{
				table = reader_1["name"].ToString();
				lProgress.Text = "Rebuilding constraints on table "+table+".";
				command_NonQuery = new SqlCommand("EXECUTE sp_Rebuild_Constraints '"+
					table+"'", connection_NonQuery);
				try
				{
					command_NonQuery.ExecuteNonQuery();
				}
				catch (Exception e)
				{
					Console.WriteLine("Failure rebuilding constraints");
					EventLog.WriteEntry("DB Scrubber", e.ToString(), EventLogEntryType.Error);
				}
				progressBar1.PerformStep();
			}
			reader_1.Close();
			connection_1.Close();
			progressBar1.Value = 0;
		}
	}
}
