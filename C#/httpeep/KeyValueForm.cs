using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;


namespace HTTPeep
{
	/// <summary>
	/// Summary description for KeyValueForm.
	/// </summary>
	public class KeyValueForm : System.Windows.Forms.Form
	{
		bool isHandled = false;


		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		public System.Windows.Forms.TextBox TxtKey;
		public System.Windows.Forms.TextBox TxtValue;
		private System.Windows.Forms.Button BtnOK;
		private System.Windows.Forms.Button BtnCancel;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public KeyValueForm()
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
			this.label2 = new System.Windows.Forms.Label();
			this.TxtKey = new System.Windows.Forms.TextBox();
			this.TxtValue = new System.Windows.Forms.TextBox();
			this.BtnOK = new System.Windows.Forms.Button();
			this.BtnCancel = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(8, 8);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(48, 23);
			this.label1.TabIndex = 0;
			this.label1.Text = "Key";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 40);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(48, 23);
			this.label2.TabIndex = 1;
			this.label2.Text = "Value";
			// 
			// TxtKey
			// 
			this.TxtKey.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.TxtKey.Location = new System.Drawing.Point(56, 8);
			this.TxtKey.Name = "TxtKey";
			this.TxtKey.Size = new System.Drawing.Size(328, 20);
			this.TxtKey.TabIndex = 2;
			this.TxtKey.Text = "";
			this.TxtKey.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Textbox_KeyDown);
			this.TxtKey.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.Textbox_KeyPress);
			// 
			// TxtValue
			// 
			this.TxtValue.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.TxtValue.Location = new System.Drawing.Point(56, 40);
			this.TxtValue.Multiline = true;
			this.TxtValue.Name = "TxtValue";
			this.TxtValue.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.TxtValue.Size = new System.Drawing.Size(328, 152);
			this.TxtValue.TabIndex = 3;
			this.TxtValue.Text = "";
			this.TxtValue.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Textbox_KeyDown);
			this.TxtValue.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.Textbox_KeyPress);
			// 
			// BtnOK
			// 
			this.BtnOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.BtnOK.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.BtnOK.Location = new System.Drawing.Point(232, 200);
			this.BtnOK.Name = "BtnOK";
			this.BtnOK.TabIndex = 4;
			this.BtnOK.Text = "&OK";
			this.BtnOK.Click += new System.EventHandler(this.BtnOK_Click);
			// 
			// BtnCancel
			// 
			this.BtnCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.BtnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.BtnCancel.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.BtnCancel.Location = new System.Drawing.Point(312, 200);
			this.BtnCancel.Name = "BtnCancel";
			this.BtnCancel.TabIndex = 5;
			this.BtnCancel.Text = "&Cancel";
			// 
			// KeyValueForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.BtnCancel;
			this.ClientSize = new System.Drawing.Size(392, 228);
			this.Controls.Add(this.BtnCancel);
			this.Controls.Add(this.BtnOK);
			this.Controls.Add(this.TxtValue);
			this.Controls.Add(this.TxtKey);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
			this.MinimumSize = new System.Drawing.Size(250, 150);
			this.Name = "KeyValueForm";
			this.ShowInTaskbar = false;
			this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = "Edit Value";
			this.ResumeLayout(false);

		}
		#endregion


		private void BtnOK_Click(object sender, System.EventArgs e)
		{
			if (TxtKey.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please specify the key              ", "", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return;
			}
			this.DialogResult = DialogResult.OK;
		}


		private void Textbox_KeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
		{
			isHandled = false;

			if (e.Control && e.KeyCode == Keys.A)
			{
				((TextBox)sender).SelectAll();
				((TextBox)sender).Focus();
				isHandled = true;
			}
		}

		private void Textbox_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
		{
			// bit of a hack to ensure windows doesn't beep for a key action that is implemented here (i.e. in Textbox_KeyDown)
			if (isHandled)
				e.Handled = true;
		}


	}
}
