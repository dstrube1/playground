using System;

namespace EproLibNET
{
	/// <summary>
	/// Summary description for AttachmentImage.
	/// </summary>
	public class AttachmentImage:Base.Attachment
	{
		private string EproLibNETFolder = null;

		public AttachmentImage():base()
		{
			EproLibNETFolder = Environment.GetFolderPath(System.Environment.SpecialFolder.CommonProgramFiles);
			EproLibNETFolder = System.IO.Path.Combine(EproLibNETFolder, "JMJTech Common");
			EproLibNETFolder = System.IO.Path.Combine(EproLibNETFolder, "EproLibNET");
		}
		public override int Display(byte[] Attachment, string Extension)
		{
			string fileName=null;
			string viewerApp = System.IO.Path.Combine(EproLibNETFolder,"EPImageViewerApp.exe");
			try
			{
				fileName = WriteToFile(Attachment,Extension);
				System.Diagnostics.Process p = new System.Diagnostics.Process();
				p.StartInfo = new System.Diagnostics.ProcessStartInfo(viewerApp,"\""+fileName+"\"");
				p.Start();
				p.WaitForExit();

				return 1;
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,4);
				return -1;
			}
			finally
			{
				try
				{
					System.IO.File.Delete(fileName);
				}
				catch{}
			}
		}
		public override byte[] Edit(byte[] Attachment, string Extension)
		{
			string fileName=null;
			string viewerApp = System.IO.Path.Combine(EproLibNETFolder,"EPImageViewerApp.exe");
			try
			{
				fileName = WriteToFile(Attachment,Extension);
				DateTime fileModified = System.IO.File.GetLastWriteTime(fileName);
				System.Diagnostics.Process p = new System.Diagnostics.Process();
				p.StartInfo = new System.Diagnostics.ProcessStartInfo(viewerApp,"\""+fileName+"\"");
				p.Start();
				p.WaitForExit();
				if(fileModified!=System.IO.File.GetLastWriteTime(fileName))
				{
					return ReadFromFile(fileName);
				}
				else
				{
					//return null;
					// Powerbuilder chokes on null BLOB return.  Use empty byte[]
					return new byte[0];
				}
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,4);
				throw exc;
			}
			finally
			{
				try
				{
					System.IO.File.Delete(fileName);
				}
				catch{}
			}
		}
		public override bool Is_Displayable(string Extension)
		{
			return true;
		}
		public override bool Is_Editable(string Extension)
		{
			return true;
		}
		public override byte[] render(byte[] Attachment, string Extension, int Width, int Height)
		{
			string fileName=null,outputFileName=null,arguments=null;
			string imageUtil = System.IO.Path.Combine(EproLibNETFolder,"EPImageUtil.exe");
			try
			{
				fileName = WriteToFile(Attachment,Extension);
				outputFileName = getUniqueFileName("bmp");
				arguments = "s=\""+fileName+"\" d=\""+outputFileName+"\"";
				if(Width>0 && Height>0)
					arguments += " maxh="+Height.ToString()+" maxw="+Width.ToString();
				System.Diagnostics.Process p = new System.Diagnostics.Process();
				p.StartInfo = new System.Diagnostics.ProcessStartInfo(imageUtil,arguments);
				p.Start();
				p.WaitForExit();
				return ReadFromFile(outputFileName);
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,4);
				throw exc;
			}
			finally
			{
				try
				{
					System.IO.File.Delete(fileName);
				}
				catch{}
				try
				{
					System.IO.File.Delete(outputFileName);
				}
				catch{}
			}
		}
		private string getUniqueFileName(string Extension)
		{
			string fileName = System.Environment.GetEnvironmentVariable("TMP");
			fileName = System.IO.Path.Combine(fileName,Guid.NewGuid().ToString()+"."+Extension.Replace(".",""));
			return fileName;
		}
		private string WriteToFile(byte[] Attachment, string Extension)
		{
			string fileName = System.Environment.GetEnvironmentVariable("TMP");
			fileName = System.IO.Path.Combine(fileName,Guid.NewGuid().ToString()+"."+Extension.Replace(".",""));
			System.IO.FileStream fs = System.IO.File.Create(fileName);
			fs.Write(Attachment,0,Attachment.Length);
			fs.Flush();
			fs.Close();
			return fileName;
		}
		private byte[] ReadFromFile(string FileName)
		{
			System.IO.FileStream fs = System.IO.File.OpenRead(FileName);
			byte[] data = new byte[fs.Length];
			fs.Read(data,0,data.Length);
			return data;
		}
	}
}
