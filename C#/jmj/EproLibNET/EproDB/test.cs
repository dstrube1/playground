using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace EproDB
{
	/// <summary>
	/// Summary description for test.
	/// </summary>
	public class test : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label fileName;
		private System.Windows.Forms.TextBox XMLOutput;
		private System.Windows.Forms.StatusBar statusBar1;
		private System.Windows.Forms.Button WriteFile;
		/// <summary>
		/// Required designer variable.
		/// </summary> 
		private System.ComponentModel.Container components = null;

		public test()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
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
			this.components = new System.ComponentModel.Container();
			this.Size = new System.Drawing.Size(300,300);
			this.Text = "test";
		}
		#endregion
		static void Main() 
		{
			Application.Run(new test());
		}
		private void WriteFile_Click(object sender, System.EventArgs e)
		{
//			string XmlFile;
//			System.IO.DirectoryInfo directoryInfo;
//			System.IO.DirectoryInfo directoryXML;
//			
//			//Get the applications startup path
//			directoryInfo = System.IO.Directory.GetParent(Application.StartupPath);
//
//			//Set the output path
//			if (directoryInfo.Name.ToString() == "bin")
//			{
//				directoryXML = System.IO.Directory.GetParent(directoryInfo.FullName);
//				XmlFile = directoryXML.FullName + "\\" + OutputFileName.Text;
//			}
//			else
//			{
//				XmlFile = directoryInfo.FullName + "\\" + OutputFileName.Text;
//
//			}
//			
//			//create the xml text writer object by providing the filename to write to
//			//and the desired encoding.  If the encoding is left null, then the writer
//			//assumes UTF-8.
//			XmlTextWriter XmlWtr = new System.Xml.XmlTextWriter(XmlFile,null);
//			
//			//set the formatting option of the xml file. The default indentation is 2 character spaces.
//			//To change the default, use the Indentation property to set the number of IndentChars to use
//			//and use the IndentChar property to set the character to use for indentation, such as the 
//			//tab character. Here the default is used.
//			XmlWtr.Formatting=Formatting.Indented;
//
//			//begin to write the xml document. This creates the xml declaration with the version attribute
//			//set to "1.0".
//			XmlWtr.WriteStartDocument();
//
//			//start the first element.
//			XmlWtr.WriteStartElement("database");
//									
//			//writes the entire element with the specified element name and
//			//string value respectively.
//			XmlWtr.WriteElementString("server", "techserv");
//			XmlWtr.WriteElementString("dbname", "EPRO_40_MASTER");
//			XmlWtr.WriteElementString("userid", "");
//			XmlWtr.WriteElementString("password", "");
//			//end the customer element.
//			XmlWtr.WriteEndElement();
//			
//			//create another customer.
//			XmlWtr.WriteStartElement("customer");
//			XmlWtr.WriteElementString("name", "Staci Richard");
//			XmlWtr.WriteElementString("phone", "555.122.1552");
//			//end the second customer element.
//			XmlWtr.WriteEndElement();
//			
//			//end the customers element.
//			XmlWtr.WriteEndElement();
//
//			//now end the document.
//			XmlWtr.WriteEndDocument();
//			
//			//now flush the contents of the stream.
//			XmlWtr.Flush();
//			
//			//close the text writerj and write the xml file.
//			XmlWtr.Close();
//
//			statusBar1.Text = "Output file has been written";
		}
	}

}
