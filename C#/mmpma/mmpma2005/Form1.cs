using System;
using System.Collections;
//using System.ComponentModel;
//using System.Drawing;
//using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.IO;

//Migrated Merged Patients Missing Attachments
namespace mmpma
{
    public partial class Form1 : Form
    {
        //private string user;
        //private string pass;
        //private string db;
        //private string server;
        //private bool debug = true;
        private string[] fields;
        private int goodCount;
        private int fixedCount;
        
        public Form1()
        {
            InitializeComponent();
            //user = "sa";
            //pass = "!$Epro&&";
            //db = "cpr_126";
            //server = "markdev";
            fields = new string[6]
                {"attachment_id","cpr_id","merged_from_cpr_id","filename",
                    "should_be_here","might_be_here"};
            goodCount = 0;
            fixedCount = 0;
        }

        private void bGo_Click(object sender, EventArgs e)
        {
            #region clear the stage
            tGoodCount.Text = goodCount.ToString();
            tFixedCount.Text = fixedCount.ToString();
            #endregion //clear the stage

            #region get variables - old
            /*
            if (tUsername.Text != "") {
                user = tUsername.Text;
            }
            else {
                if (!debug){
                MessageBox.Show("Please enter a username.");
                return;
                }
            }
            if (tPassword.Text != "")
            {
                pass = tPassword.Text;
            }
            else {
                if (!debug)
                {
                    MessageBox.Show("Please enter a password.");
                    return;
                }
            }
            if (tDatabase.Text != "")
            {
                db = tDatabase.Text;
            }
            else
            {
                if (!debug)
                {
                    MessageBox.Show("Please enter a database name.");
                    return;
                }
            }
            if (tServer.Text != ""){
                server = tServer.Text;
            }
            else {
                if (!debug)
                {
                    MessageBox.Show("Please enter a server name.");
                    return;
                }
            }
             */
            #endregion //get variables  -old
            #region get variables - new
            string path = "C:\\Program Files\\JMJ\\EncounterPRO";
            string[] args = new string[2] 
                {path,"[Markdev]"};
            dbInfo.Class1 dbi = new dbInfo.Class1();
            string server_db = dbi.getInfo(args);
            if (server_db ==null) MessageBox.Show("server_db is null");
            #endregion //get variables  - new
            
            #region get dbconnection
            string connection_text = server_db+
                //"Server=" + server + ";Database=" + db +
                //";user=" + user + ";password='" + pass + 
                "Integrated Security=SSPI"+
                ";Connect Timeout=60";
            SqlConnection connection1 = new SqlConnection(connection_text);
            try
            {
                connection1.Open();
            }
            catch (Exception db_exception)
            {
                MessageBox.Show("Error connecting to the database:"
                    + db_exception.ToString());
                return;
            }
            #endregion //get dbconnection

            SqlCommand command = new SqlCommand(getQuery(), connection1);
            /*"select last_name as attachment_id, cpr_id, date_of_birth as merged_from_cpr_id, "
                + "sex as filename, billing_id as should_be_here, first_name as might_be_here "
                +"from p_patient"*/
            try
            {
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    //first put the reuslt in the All list
                    ArrayList row = new ArrayList();
                    for (int i = 0; i < fields.Length; i++)
                    {
                        //MessageBox.Show("Adding " + i + ": " + fields[i]);
                        row.Add(reader[fields[i]].ToString());
                    }
                    row.TrimToSize();
                    ListViewItem li = new ListViewItem(
                        (string[])row.ToArray(typeof(string))); //
                    listView1.Items.Add(li);

                    //now determine whether this result is good, fixable, or bad
                    determine(row);
                }
                reader.Close();
                command.Dispose();
                connection1.Close();
            }
            catch (Exception command_exception)
            {
                MessageBox.Show("Error running the command:"
                    + command_exception.ToString() + "\nconnect string = "
                    + connection_text + "\nargs[0] = "
                    + args[0] + "\nargs[1] = " + args[1]);
            }
            finally { bGo.Enabled = false; }
        }

        private void determine(ArrayList row)
        {
            string filename = row[3].ToString();
            string should_be_here = row[4].ToString();
            if (!should_be_here.EndsWith("\\"))
                should_be_here += "\\";
            string might_be_here = row[5].ToString();
            if (!might_be_here.EndsWith("\\"))
                might_be_here += "\\";
            
            if (File.Exists(should_be_here + filename))
            {
                addToGood();
            }
            else if (File.Exists(might_be_here + filename))
            {
                //File.Move(might_be_here + filename, should_be_here + filename);
                addToFixed();
            }
            else addToBad(row);
        }

        private void addToBad(ArrayList row)
        {
            ListViewItem li = new ListViewItem(
                        (string[])row.ToArray(typeof(string))); //
            listView2.Items.Add(li);
        }

        private void addToFixed()
        {
            fixedCount++;
            tFixedCount.Text = fixedCount.ToString();
        }

        private void addToGood()
        {
            goodCount++;
            tGoodCount.Text = goodCount.ToString();
        }

        private string getQuery() {
            return @"DECLARE @candidates TABLE (
	attachment_id int NOT NULL,
	cpr_id varchar(12),
	merged_from_cpr_id varchar(12),
	filename varchar(128),
	should_be_here varchar(255),
	might_be_here varchar(255))


INSERT INTO @candidates (
	attachment_id,
	cpr_id,
	filename,
	merged_from_cpr_id,
	should_be_here)
SELECT a.attachment_id,
	a.cpr_id,
	a.attachment_file + '.' + a.extension,
	merged_from_cpr_id = LEFT(a.attachment_file, CHARINDEX('_', a.attachment_file) - 1),
	should_be_here = '\\' + l.attachment_server + '\' + l.attachment_share + '\' + p.attachment_path
FROM p_Attachment a
	INNER JOIN p_Patient p
	ON a.cpr_id = p.cpr_id
	INNER JOIN c_Attachment_Location l
	ON p.attachment_location_id = l.attachment_location_id
WHERE a.cpr_id IS NOT NULL
AND a.attachment_file NOT LIKE a.cpr_id + '%'

UPDATE x
SET might_be_here = '\\' + l.attachment_server + '\' + l.attachment_share + '\' + p.attachment_path
FROM @candidates x
	INNER JOIN p_Patient p
	ON x.merged_from_cpr_id = p.cpr_id
	INNER JOIN c_Attachment_Location l
	ON p.attachment_location_id = p.attachment_location_id
WHERE p.patient_status = 'MERGED'

SELECT attachment_id ,
	cpr_id ,
	merged_from_cpr_id ,
	filename ,
	should_be_here ,
	might_be_here
FROM @candidates";
        }
    }
}