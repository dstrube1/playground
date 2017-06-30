using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace EproLibBaseTest
{
	/// <summary>
	/// Summary description for SaveSettingsForm.
	/// </summary>
	public class SaveSettingsForm : System.Windows.Forms.Form
	{
		private string configFile = null;

		public SaveSettingsForm() : base()
		{
			configFile = System.IO.Path.Combine(Application.UserAppDataPath, this.GetType().FullName+".config.xml");
			this.Load+=new EventHandler(SaveSettingsForm_Load);
			this.Closed+=new EventHandler(SaveSettingsForm_Closed);
		}

		private System.Windows.Forms.Control FindControl(string Name)
		{
			for(int i=0; i<this.Controls.Count; i++)
			{
				if(this.Controls[i].Name==Name)
					return this.Controls[i];
			}
			return null;
		}

		private void SaveSettingsForm_Closed(object sender, EventArgs e)
		{
			// Save Settings
			System.Xml.XmlTextWriter tw = new System.Xml.XmlTextWriter(configFile, System.Text.Encoding.UTF8);
			tw.WriteStartDocument();
			tw.WriteStartElement("Form");

			foreach(Control c in this.Controls)
			{
				switch (c.GetType().ToString())
				{
					case "System.Windows.Forms.TextBox":
						tw.WriteStartElement("Control");
						tw.WriteAttributeString("Name", c.Name);
						if(c.Text!=null)
							tw.WriteString(c.Text);
						tw.WriteEndElement();
						break;
					case "System.Windows.Forms.RichTextBox":
						tw.WriteStartElement("Control");
						tw.WriteAttributeString("Name", c.Name);
						if(c.Text!=null)
							tw.WriteString(c.Text);
						tw.WriteEndElement();
						break;
					case "System.Windows.Forms.ComboBox":
						tw.WriteStartElement("Control");
						tw.WriteAttributeString("Name", c.Name);
						if(c.Text!=null)
							tw.WriteString(c.Text);
						tw.WriteEndElement();
						break;
					default:
						continue;
				}
			}

			tw.WriteEndElement();
			tw.WriteEndDocument();
			tw.Flush();
			tw.Close();
		}

		private void SaveSettingsForm_Load(object sender, EventArgs e)
		{
			// Load Settings
			try
			{
				if(System.IO.File.Exists(configFile))
				{
					System.Xml.XmlDocument configDoc = new System.Xml.XmlDocument();
					configDoc.Load(configFile);
					foreach(System.Xml.XmlNode node in configDoc.DocumentElement.ChildNodes)
					{
						if(node.Name!="Control")
							continue;
						string controlName = node.Attributes["Name"].Value;
						Control control = FindControl(controlName);
						if(control==null)
							continue;

						control.Text = node.InnerText;
					}
					try
					{
						configDoc.Load(configFile);
					}
					catch(Exception exc)
					{
						MessageBox.Show(exc.ToString());
					}
				}
			}
			catch(Exception exc)
			{
				MessageBox.Show(exc.ToString());
			}
		}
	}
}
