using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace EproLibBaseTest
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : SaveSettingsForm
	{
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.TextBox tAssembly;
		private System.Windows.Forms.TextBox tClass;
		private System.Windows.Forms.Button bComponentAttributes;
		private System.Windows.Forms.Button bCredentialAttributes;
		private System.Windows.Forms.Button bClinicalContext;
		private System.Windows.Forms.Button bConnectClass;
		private System.Windows.Forms.OpenFileDialog openFileDialog1;
		private System.Windows.Forms.ComboBox ddlWrapperClass;
		private System.Windows.Forms.RichTextBox tComponentAttributes;
		private System.Windows.Forms.RichTextBox tCredentialAttributes;
		private System.Windows.Forms.RichTextBox tClinicalContext;
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
				if (components != null) 
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
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.label4 = new System.Windows.Forms.Label();
			this.label5 = new System.Windows.Forms.Label();
			this.ddlWrapperClass = new System.Windows.Forms.ComboBox();
			this.tAssembly = new System.Windows.Forms.TextBox();
			this.tClass = new System.Windows.Forms.TextBox();
			this.bComponentAttributes = new System.Windows.Forms.Button();
			this.bCredentialAttributes = new System.Windows.Forms.Button();
			this.bClinicalContext = new System.Windows.Forms.Button();
			this.bConnectClass = new System.Windows.Forms.Button();
			this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
			this.tComponentAttributes = new System.Windows.Forms.RichTextBox();
			this.tCredentialAttributes = new System.Windows.Forms.RichTextBox();
			this.tClinicalContext = new System.Windows.Forms.RichTextBox();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(8, 40);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(100, 16);
			this.label1.TabIndex = 0;
			this.label1.Text = "Assembly";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 64);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(100, 16);
			this.label2.TabIndex = 1;
			this.label2.Text = "Class";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(8, 88);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(152, 16);
			this.label3.TabIndex = 2;
			this.label3.Text = "ComponentAttributes XML";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(8, 224);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(152, 16);
			this.label4.TabIndex = 3;
			this.label4.Text = "CredentialAttributes XML";
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(8, 360);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(152, 16);
			this.label5.TabIndex = 4;
			this.label5.Text = "ClinicalContext XML";
			// 
			// ddlWrapperClass
			// 
			this.ddlWrapperClass.Items.AddRange(new object[] {
																 "AttachmentWrapper",
																 "DocumentWrapper",
																 "ExtSourceWrapper",
																 "SecurityManagerWrapper",
																 "ServiceWrapper"});
			this.ddlWrapperClass.Location = new System.Drawing.Point(8, 8);
			this.ddlWrapperClass.Name = "ddlWrapperClass";
			this.ddlWrapperClass.Size = new System.Drawing.Size(168, 21);
			this.ddlWrapperClass.TabIndex = 5;
			this.ddlWrapperClass.Text = "Select Wrapper...";
			// 
			// tAssembly
			// 
			this.tAssembly.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tAssembly.Location = new System.Drawing.Point(112, 38);
			this.tAssembly.Name = "tAssembly";
			this.tAssembly.Size = new System.Drawing.Size(400, 20);
			this.tAssembly.TabIndex = 9;
			this.tAssembly.Text = "";
			// 
			// tClass
			// 
			this.tClass.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tClass.Location = new System.Drawing.Point(112, 62);
			this.tClass.Name = "tClass";
			this.tClass.Size = new System.Drawing.Size(400, 20);
			this.tClass.TabIndex = 10;
			this.tClass.Text = "";
			// 
			// bComponentAttributes
			// 
			this.bComponentAttributes.Location = new System.Drawing.Point(152, 88);
			this.bComponentAttributes.Name = "bComponentAttributes";
			this.bComponentAttributes.Size = new System.Drawing.Size(24, 16);
			this.bComponentAttributes.TabIndex = 11;
			this.bComponentAttributes.Text = "...";
			this.bComponentAttributes.Click += new System.EventHandler(this.bComponentAttributes_Click);
			// 
			// bCredentialAttributes
			// 
			this.bCredentialAttributes.Location = new System.Drawing.Point(152, 224);
			this.bCredentialAttributes.Name = "bCredentialAttributes";
			this.bCredentialAttributes.Size = new System.Drawing.Size(24, 16);
			this.bCredentialAttributes.TabIndex = 12;
			this.bCredentialAttributes.Text = "...";
			this.bCredentialAttributes.Click += new System.EventHandler(this.bCredentialAttributes_Click);
			// 
			// bClinicalContext
			// 
			this.bClinicalContext.Location = new System.Drawing.Point(152, 360);
			this.bClinicalContext.Name = "bClinicalContext";
			this.bClinicalContext.Size = new System.Drawing.Size(24, 16);
			this.bClinicalContext.TabIndex = 13;
			this.bClinicalContext.Text = "...";
			this.bClinicalContext.Click += new System.EventHandler(this.bClinicalContext_Click);
			// 
			// bConnectClass
			// 
			this.bConnectClass.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bConnectClass.Location = new System.Drawing.Point(392, 504);
			this.bConnectClass.Name = "bConnectClass";
			this.bConnectClass.Size = new System.Drawing.Size(120, 23);
			this.bConnectClass.TabIndex = 14;
			this.bConnectClass.Text = "Call ConnectClass";
			this.bConnectClass.Click += new System.EventHandler(this.bConnectClass_Click);
			// 
			// tComponentAttributes
			// 
			this.tComponentAttributes.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tComponentAttributes.Location = new System.Drawing.Point(8, 104);
			this.tComponentAttributes.Name = "tComponentAttributes";
			this.tComponentAttributes.Size = new System.Drawing.Size(504, 112);
			this.tComponentAttributes.TabIndex = 15;
			this.tComponentAttributes.Text = "";
			// 
			// tCredentialAttributes
			// 
			this.tCredentialAttributes.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tCredentialAttributes.Location = new System.Drawing.Point(8, 240);
			this.tCredentialAttributes.Name = "tCredentialAttributes";
			this.tCredentialAttributes.Size = new System.Drawing.Size(504, 112);
			this.tCredentialAttributes.TabIndex = 16;
			this.tCredentialAttributes.Text = "";
			// 
			// tClinicalContext
			// 
			this.tClinicalContext.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tClinicalContext.Location = new System.Drawing.Point(8, 376);
			this.tClinicalContext.Name = "tClinicalContext";
			this.tClinicalContext.Size = new System.Drawing.Size(504, 112);
			this.tClinicalContext.TabIndex = 17;
			this.tClinicalContext.Text = "";
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(520, 533);
			this.Controls.Add(this.tClinicalContext);
			this.Controls.Add(this.tCredentialAttributes);
			this.Controls.Add(this.tComponentAttributes);
			this.Controls.Add(this.bConnectClass);
			this.Controls.Add(this.bClinicalContext);
			this.Controls.Add(this.bCredentialAttributes);
			this.Controls.Add(this.bComponentAttributes);
			this.Controls.Add(this.tClass);
			this.Controls.Add(this.tAssembly);
			this.Controls.Add(this.ddlWrapperClass);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Name = "Form1";
			this.Text = "Form1";
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

		private void bComponentAttributes_Click(object sender, System.EventArgs e)
		{
			if(openFileDialog1.ShowDialog(this)==DialogResult.OK)
			{
				System.IO.StreamReader sr = null;
				try
				{
					sr = System.IO.File.OpenText(openFileDialog1.FileName);
					tComponentAttributes.Text = sr.ReadToEnd();
				}
				catch(Exception exc)
				{
					MessageBox.Show(this, exc.ToString(), "Error opening file...", MessageBoxButtons.OK, MessageBoxIcon.Error);
				}
				finally
				{
					try
					{
						sr.Close();
					}
					catch{}				
				}
			}
		}

		private void bCredentialAttributes_Click(object sender, System.EventArgs e)
		{
			if(openFileDialog1.ShowDialog(this)==DialogResult.OK)
			{
				System.IO.StreamReader sr = null;
				try
				{
					sr = System.IO.File.OpenText(openFileDialog1.FileName);
					tCredentialAttributes.Text = sr.ReadToEnd();
				}
				catch(Exception exc)
				{
					MessageBox.Show(this, exc.ToString(), "Error opening file...", MessageBoxButtons.OK, MessageBoxIcon.Error);
				}
				finally
				{
					try
					{
						sr.Close();
					}
					catch{}				
				}
			}
		}

		private void bClinicalContext_Click(object sender, System.EventArgs e)
		{
			if(openFileDialog1.ShowDialog(this)==DialogResult.OK)
			{
				System.IO.StreamReader sr = null;
				try
				{
					sr = System.IO.File.OpenText(openFileDialog1.FileName);
					tClinicalContext.Text = sr.ReadToEnd();
				}
				catch(Exception exc)
				{
					MessageBox.Show(this, exc.ToString(), "Error opening file...", MessageBoxButtons.OK, MessageBoxIcon.Error);
				}
				finally
				{
					try
					{
						sr.Close();
					}
					catch{}				
				}
			}
		}

		private void bConnectClass_Click(object sender, System.EventArgs e)
		{
			try
			{
				System.Reflection.Assembly asm = System.Reflection.Assembly.LoadWithPartialName("EproLibNET");
				MessageBox.Show(this, asm.FullName, "EproLibNET assembly name");
				System.Type type = asm.GetModules(false)[0].GetType("EproLibNET." + ddlWrapperClass.Text, true, false);
				object wrapper = type.GetConstructor(System.Type.EmptyTypes).Invoke(null);
				object ret = type.InvokeMember("ConnectClass",System.Reflection.BindingFlags.InvokeMethod,null,wrapper,
					new object[]{tAssembly.Text, tClass.Text, tComponentAttributes.Text, tCredentialAttributes.Text,
									tClinicalContext.Text});

				MessageBox.Show(this, ret!=null?ret.ToString():"null", "ConnectClass return");
				switch(ddlWrapperClass.Text)
				{
					case "DocumentWrapper":
						fDocumentWrapper fdw = new fDocumentWrapper();
						fdw.ConnectedType = type;
						fdw.ConnectedClass = wrapper;
						fdw.Show();
						break;
					case "SecurityManagerWrapper":
						fSecurityManager fsm = new fSecurityManager();
						fsm.ConnectedType = type;
						fsm.ConnectedClass = wrapper;
						fsm.Show();
						break;
				}
			}
			catch(Exception exc)
			{
				MessageBox.Show(this, exc.ToString(), "Error calling ConnectClass()", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}
	}
}
