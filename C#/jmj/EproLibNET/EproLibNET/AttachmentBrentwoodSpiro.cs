using System;
using System.Runtime.InteropServices;

namespace EproLibNET
{
	/// <summary>
	/// Summary description for AttachmentBrentwoodSpiro.
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class AttachmentBrentwoodSpiro:Base.Attachment
	{
		public AttachmentBrentwoodSpiro():base()
		{
		}
		public override bool Is_Displayable(string Extension)
		{
			return true;
		}
		public override int Display(byte[] Attachment, string Extension)
		{
			fBrentwoodSpiro spiroForm = new fBrentwoodSpiro();
			spiroForm.RunReview(ref Attachment,false);
			return 1;
		}
		public override byte[] Edit(byte[] Attachment, string Extension)
		{
			fBrentwoodSpiro spiroForm = new fBrentwoodSpiro();
			if(spiroForm.RunReview(ref Attachment,true))
				return Attachment;
			else
				return new byte[]{};
		}

	}
}
