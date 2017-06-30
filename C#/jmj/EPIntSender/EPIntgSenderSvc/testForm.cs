using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace EPIntSenderSvc
{
	/// <summary>
	/// Summary description for testForm.
	/// </summary>
	public class testForm : System.Windows.Forms.Form
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		static void Main()
		{
			testForm form = new testForm();
			Application.Run(form);
		}

		public testForm()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

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
			// 
			// testForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(292, 266);
			this.Name = "testForm";
			this.Text = "testForm";
			this.Load += new System.EventHandler(this.testForm_Load);
			this.Closed += new System.EventHandler(this.testForm_Closed);

		}
		#endregion

		private void testForm_Load(object sender, System.EventArgs e)
		{
			SvcManager.Run();
		}

		private void testForm_Closed(object sender, System.EventArgs e)
		{
			SvcManager.Stop();
		}
	}
}
