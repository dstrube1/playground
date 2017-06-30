using System;
using System.Runtime.InteropServices;

namespace EproLibNET
{
	/// <summary>
	/// Summary description for AttachmentBrentwoodHolter.
	/// </summary>
	public class AttachmentBrentwoodHolter:Base.Attachment
	{
		public AttachmentBrentwoodHolter():base()
		{
		}
		public override bool Is_Displayable(string Extension)
		{
			return true;
		}
		public override bool Is_Editable(string Extension)
		{
			return true;
		}

		public override int Display(byte[] Attachment, string Extension)
		{
			fBrentwoodHolter holterForm = new fBrentwoodHolter();
			holterForm.RunReview(ref Attachment,false);
			return 1;
		}
		public override byte[] Edit(byte[] Attachment, string Extension)
		{
			fBrentwoodHolter holterForm = new fBrentwoodHolter();
			if(holterForm.RunReview(ref Attachment,true))
				return Attachment;
			else
				return new byte[]{};
		}
	}
}
