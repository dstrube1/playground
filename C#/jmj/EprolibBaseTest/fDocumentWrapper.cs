using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace EproLibBaseTest
{
	/// <summary>
	/// Summary description for fDocumentWrapper.
	/// </summary>
	public class fDocumentWrapper : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TabControl tabControl1;
		private System.Windows.Forms.TabPage tabPage1;
		private System.Windows.Forms.RichTextBox tCreateDocumentResult;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Button bCreateDocumentRun;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;


		private System.Type connectedType = null;
		private System.Windows.Forms.OpenFileDialog openFileDialog1;
		private object connectedClass = null;

		public System.Type ConnectedType
		{
			get
			{
				return connectedType;
			}
			set
			{
				connectedType = value;
			}
		}

		public object ConnectedClass
		{
			get
			{
				return connectedClass;
			}
			set
			{
				connectedClass = value;
			}
		}
		public fDocumentWrapper()
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
			this.label1 = new System.Windows.Forms.Label();
			this.tabControl1 = new System.Windows.Forms.TabControl();
			this.tabPage1 = new System.Windows.Forms.TabPage();
			this.bCreateDocumentRun = new System.Windows.Forms.Button();
			this.label3 = new System.Windows.Forms.Label();
			this.tCreateDocumentResult = new System.Windows.Forms.RichTextBox();
			this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
			this.tabControl1.SuspendLayout();
			this.tabPage1.SuspendLayout();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.label1.Location = new System.Drawing.Point(8, 8);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(428, 40);
			this.label1.TabIndex = 0;
			this.label1.Text = "Connected: ";
			// 
			// tabControl1
			// 
			this.tabControl1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tabControl1.Controls.Add(this.tabPage1);
			this.tabControl1.Location = new System.Drawing.Point(0, 48);
			this.tabControl1.Name = "tabControl1";
			this.tabControl1.SelectedIndex = 0;
			this.tabControl1.Size = new System.Drawing.Size(444, 356);
			this.tabControl1.TabIndex = 1;
			// 
			// tabPage1
			// 
			this.tabPage1.Controls.Add(this.bCreateDocumentRun);
			this.tabPage1.Controls.Add(this.label3);
			this.tabPage1.Controls.Add(this.tCreateDocumentResult);
			this.tabPage1.Location = new System.Drawing.Point(4, 22);
			this.tabPage1.Name = "tabPage1";
			this.tabPage1.Size = new System.Drawing.Size(436, 330);
			this.tabPage1.TabIndex = 0;
			this.tabPage1.Text = "CreateDocument";
			// 
			// bCreateDocumentRun
			// 
			this.bCreateDocumentRun.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bCreateDocumentRun.Location = new System.Drawing.Point(352, 296);
			this.bCreateDocumentRun.Name = "bCreateDocumentRun";
			this.bCreateDocumentRun.TabIndex = 6;
			this.bCreateDocumentRun.Text = "Run";
			this.bCreateDocumentRun.Click += new System.EventHandler(this.bCreateDocumentRun_Click);
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(8, 8);
			this.label3.Name = "label3";
			this.label3.TabIndex = 5;
			this.label3.Text = "Result";
			// 
			// tCreateDocumentResult
			// 
			this.tCreateDocumentResult.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tCreateDocumentResult.Location = new System.Drawing.Point(8, 32);
			this.tCreateDocumentResult.Name = "tCreateDocumentResult";
			this.tCreateDocumentResult.Size = new System.Drawing.Size(416, 256);
			this.tCreateDocumentResult.TabIndex = 4;
			this.tCreateDocumentResult.Text = "";
			// 
			// fDocumentWrapper
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(440, 397);
			this.Controls.Add(this.tabControl1);
			this.Controls.Add(this.label1);
			this.Name = "fDocumentWrapper";
			this.Text = "Document Wrapper";
			this.Load += new System.EventHandler(this.fDocumentWrapper_Load);
			this.tabControl1.ResumeLayout(false);
			this.tabPage1.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		private void fDocumentWrapper_Load(object sender, System.EventArgs e)
		{
			if(ConnectedType!=null && ConnectedClass!=null)
			{
				label1.Text += ConnectedType.FullName;
			}
			else
			{
				throw new Exception("ConnectedType and ConnectedClass are not instantiated.");
			}
		}

		private void bCreateDocumentRun_Click(object sender, System.EventArgs e)
		{
			try
			{
				tCreateDocumentResult.Text = ConnectedType.InvokeMember("CreateDocument", System.Reflection.BindingFlags.InvokeMethod, null, ConnectedClass, new object[]{}).ToString();
				MessageBox.Show(this, "CreateDocument() completed successfully.");
			}
			catch(Exception exc)
			{
				MessageBox.Show(this, exc.ToString(), "Error calling CreateDocument()", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}
	}
}
