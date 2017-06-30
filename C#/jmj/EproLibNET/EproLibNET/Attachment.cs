using System;
using System.Runtime.InteropServices;

namespace EproLibNET
{
	/// <summary>
	/// Summary description for Attachment.
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class Attachment:Base.Attachment
	{
		public Attachment():base()
		{
		}
		public override int Display(byte[] Attachment, string Extension)
		{
			try
			{
				int rVal = 0;
				switch(Extension.ToLower().Replace(".",""))
				{
					case "car":
						rVal = new AttachmentBrentwoodSpiro().Display(Attachment, Extension);
						break;
					case "brentwood_holter":
						rVal = new AttachmentBrentwoodHolter().Display(Attachment, Extension);
						break;
					case "Image":
						rVal = new AttachmentImage().Display(Attachment, Extension);
						break;
					case "gif":
						goto case "Image";
					case "bmp":
						goto case "Image";
					case "png":
						goto case "Image";
					case "tiff":
					case "tif":
						goto case "Image";
					case "wmf":
						goto case "Image";
					case "jpg":
						goto case "Image";
					case "pcx":
						goto case "Image";
					case "psd":
						goto case "Image";
					case "pcd":
						goto case "Image";
					case "emf":
						goto case "Image";
					case "tga":
						goto case "Image";
					default:
						throw new Exception("Extension "+Extension+" not supported.");
				}
				return rVal;
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,4);
				return -1;
			}
		}
		public override byte[] Edit(byte[] Attachment, string Extension)
		{
			try
			{
				byte[] rVal = null;
				switch(Extension.ToLower().Replace(".",""))
				{
					case "car":
						rVal = new AttachmentBrentwoodSpiro().Edit(Attachment, Extension);
						break;
					case "brentwood_holter":
						rVal = new AttachmentBrentwoodHolter().Edit(Attachment, Extension);
						break;
					case "Image":
						rVal = new AttachmentImage().Edit(Attachment, Extension);
						break;
					case "gif":
						goto case "Image";
					case "bmp":
						goto case "Image";
					case "png":
						goto case "Image";
					case "tiff":
					case "tif":
						goto case "Image";
					case "wmf":
						goto case "Image";
					case "jpg":
						goto case "Image";
					case "pcx":
						goto case "Image";
					case "psd":
						goto case "Image";
					case "pcd":
						goto case "Image";
					case "emf":
						goto case "Image";
					case "tga":
						goto case "Image";
					default:
						throw new Exception("Extension "+Extension+" not supported.");
				}
				return rVal;		
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,4);
				throw exc;
			}
		}
		public override bool Is_Displayable(string Extension)
		{
			try
			{
				bool rVal = false;
				switch(Extension.ToLower())
				{
					case "car":
						rVal = new AttachmentBrentwoodSpiro().Is_Displayable(Extension);
						break;
					case "Image":
						rVal = new AttachmentImage().Is_Displayable(Extension);
						break;
					case "gif":
						goto case "Image";
					case "bmp":
						goto case "Image";
					case "png":
						goto case "Image";
					case "tiff":
					case "tif":
						goto case "Image";
					case "wmf":
						goto case "Image";
					case "jpg":
						goto case "Image";
					case "pcx":
						goto case "Image";
					case "psd":
						goto case "Image";
					case "pcd":
						goto case "Image";
					case "emf":
						goto case "Image";
					case "tga":
						goto case "Image";
					default:
						throw new Exception("Extension "+Extension+" not supported.");
				}
				return rVal;
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,4);
				return false;
			}
		}
		public override bool Is_Editable(string Extension)
		{
			try
			{
				bool rVal = false;
				switch(Extension.ToLower())
				{
					case "car":
						rVal = new AttachmentBrentwoodSpiro().Is_Editable(Extension);
						break;
					case "Image":
						rVal = new AttachmentImage().Is_Editable(Extension);
						break;
					case "gif":
						goto case "Image";
					case "bmp":
						goto case "Image";
					case "tiff":
					case "tif":
						goto case "Image";
					case "png":
						goto case "Image";
					case "wmf":
						goto case "Image";
					case "jpg":
						goto case "Image";
					default:
						throw new Exception("Extension "+Extension+" not supported.");
				}
				return rVal;
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,4);
				return false;
			}
		}
		public override byte[] render(byte[] Attachment, string Extension, int Width, int Height)
		{
			try
			{
				byte[] rVal = null;
				switch(Extension.ToLower())
				{
					case "car":
						rVal = new AttachmentBrentwoodSpiro().render(Attachment, Extension, Width, Height);
						break;
					case "Image":
						rVal = new AttachmentImage().render(Attachment, Extension, Width, Height);
						break;
					case "gif":
						goto case "Image";
					case "bmp":
						goto case "Image";
					case "png":
						goto case "Image";
					case "tiff":
					case "tif":
						goto case "Image";
					case "wmf":
						goto case "Image";
					case "jpg":
						goto case "Image";
					case "pcx":
						goto case "Image";
					case "psd":
						goto case "Image";
					case "pcd":
						goto case "Image";
					case "emf":
						goto case "Image";
					case "tga":
						goto case "Image";
					default:
						throw new Exception("Extension "+Extension+" not supported.");
				}
				return rVal;
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,4);
				throw exc;
			}
		}
	}
}
