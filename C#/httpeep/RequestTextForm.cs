using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;


namespace HTTPeep
{
	/// <summary>
	/// Summary description for RequestTextForm.
	/// </summary>
	public class RequestTextForm : System.Windows.Forms.Form
	{
		// NB: the issue with pressing enter and the form closing and the parent form then peforming the enter action again was caused by responding to a key_down in the childform and then a key_up in the parent form - hence the double trigger

		private System.Windows.Forms.Button btnClose;
		public System.Windows.Forms.TextBox TxtRequestText;
		private System.Windows.Forms.TextBox txtDummy;  // this has tabindex=0 so is selected by defualt. Ensures the big textbox doesn't get blinking caret or text selected
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;


		public RequestTextForm()
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
			this.btnClose = new System.Windows.Forms.Button();
			this.TxtRequestText = new System.Windows.Forms.TextBox();
			this.txtDummy = new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			// 
			// btnClose
			// 
			this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.btnClose.Location = new System.Drawing.Point(-100, 64);
			this.btnClose.Name = "btnClose";
			this.btnClose.Size = new System.Drawing.Size(78, 23);
			this.btnClose.TabIndex = 2;
			this.btnClose.Text = "close";
			this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
			// 
			// TxtRequestText
			// 
			this.TxtRequestText.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.TxtRequestText.Font = new System.Drawing.Font("Courier New", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.TxtRequestText.Location = new System.Drawing.Point(8, 8);
			this.TxtRequestText.Multiline = true;
			this.TxtRequestText.Name = "TxtRequestText";
			this.TxtRequestText.ReadOnly = true;
			this.TxtRequestText.ScrollBars = System.Windows.Forms.ScrollBars.Both;
			this.TxtRequestText.Size = new System.Drawing.Size(464, 174);
			this.TxtRequestText.TabIndex = 1;
			this.TxtRequestText.Text = "";
			this.TxtRequestText.WordWrap = false;
			// 
			// txtDummy
			// 
			this.txtDummy.Location = new System.Drawing.Point(-100, 24);
			this.txtDummy.Name = "txtDummy";
			this.txtDummy.Size = new System.Drawing.Size(25, 20);
			this.txtDummy.TabIndex = 0;
			this.txtDummy.Text = "-";
			// 
			// RequestTextForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.btnClose;
			this.ClientSize = new System.Drawing.Size(480, 190);
			this.Controls.Add(this.txtDummy);
			this.Controls.Add(this.btnClose);
			this.Controls.Add(this.TxtRequestText);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
			this.KeyPreview = true;
			this.MinimumSize = new System.Drawing.Size(220, 90);
			this.Name = "RequestTextForm";
			this.ShowInTaskbar = false;
			this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Show;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = "Request Text";
			this.ResumeLayout(false);

		}
		#endregion

		
		private void btnClose_Click(object sender, System.EventArgs e)
		{
			//MessageBox.Show(sender.ToString() + " %% ");
			//e.Handled = true;

			//this.DialogResult = DialogResult.OK;
			Close();
		}
	
	}
}
