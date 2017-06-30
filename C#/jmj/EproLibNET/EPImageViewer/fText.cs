using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace EPImageViewer
{
	/// <summary>
	/// Summary description for fText.
	/// </summary>
	public class fText : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label lMessage;
		private System.Windows.Forms.Button bFont;
		private System.Windows.Forms.Button bCancel;
		private System.Windows.Forms.Button bOK;
		private System.Windows.Forms.RichTextBox tText;
		private System.Windows.Forms.FontDialog fontDialog1;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public Font SelectedFont
		{
			get
			{
				return tText.Font;
			}
		}
		public string TextToDraw
		{
			get
			{
				return tText.Text;
			}
		}
		public fText()
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
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(fText));
			this.lMessage = new System.Windows.Forms.Label();
			this.bFont = new System.Windows.Forms.Button();
			this.bCancel = new System.Windows.Forms.Button();
			this.bOK = new System.Windows.Forms.Button();
			this.tText = new System.Windows.Forms.RichTextBox();
			this.fontDialog1 = new System.Windows.Forms.FontDialog();
			this.SuspendLayout();
			// 
			// lMessage
			// 
			this.lMessage.Location = new System.Drawing.Point(8, 8);
			this.lMessage.Name = "lMessage";
			this.lMessage.Size = new System.Drawing.Size(128, 23);
			this.lMessage.TabIndex = 3;
			this.lMessage.Text = "Text to draw:";
			// 
			// bFont
			// 
			this.bFont.Location = new System.Drawing.Point(136, 8);
			this.bFont.Name = "bFont";
			this.bFont.Size = new System.Drawing.Size(40, 20);
			this.bFont.TabIndex = 4;
			this.bFont.Text = "Font...";
			this.bFont.Click += new System.EventHandler(this.bFont_Click);
			// 
			// bCancel
			// 
			this.bCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.bCancel.Location = new System.Drawing.Point(248, 128);
			this.bCancel.Name = "bCancel";
			this.bCancel.TabIndex = 1;
			this.bCancel.Text = "&Cancel";
			this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
			// 
			// bOK
			// 
			this.bOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.bOK.Location = new System.Drawing.Point(336, 128);
			this.bOK.Name = "bOK";
			this.bOK.TabIndex = 2;
			this.bOK.Text = "&OK";
			this.bOK.Click += new System.EventHandler(this.bOK_Click);
			// 
			// tText
			// 
			this.tText.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tText.Location = new System.Drawing.Point(4, 36);
			this.tText.Name = "tText";
			this.tText.Size = new System.Drawing.Size(412, 84);
			this.tText.TabIndex = 0;
			this.tText.Text = "";
			// 
			// fText
			// 
			this.AcceptButton = this.bOK;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.bCancel;
			this.ClientSize = new System.Drawing.Size(424, 158);
			this.Controls.Add(this.tText);
			this.Controls.Add(this.bOK);
			this.Controls.Add(this.bCancel);
			this.Controls.Add(this.bFont);
			this.Controls.Add(this.lMessage);
			this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
			this.Name = "fText";
			this.Text = "Text";
			this.ResumeLayout(false);

		}
		#endregion

		private void bFont_Click(object sender, System.EventArgs e)
		{
			if(fontDialog1.ShowDialog(this)==DialogResult.OK)
				tText.Font=fontDialog1.Font;
		}

		private void bCancel_Click(object sender, System.EventArgs e)
		{
			DialogResult = DialogResult.Cancel;
		}

		private void bOK_Click(object sender, System.EventArgs e)
		{
			DialogResult = DialogResult.OK;
		}
	}
}
