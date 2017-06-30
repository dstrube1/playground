using System;

namespace EproLibNET.Base
{
	/// <summary>
	/// Summary description for AttachmentBase.
	/// </summary>
	public abstract class Attachment
	{
		System.Collections.Specialized.HybridDictionary AttributeDictionary = null;
		protected Utilities util = null;


		public Attachment()
		{
			util = new Utilities();
			string assmName = System.Reflection.Assembly.GetExecutingAssembly().GetName().Name;
			util.InitializeEventLog(assmName);
		}

		public virtual int Initialize(int AttributeCount, string[] Attributes, string[] Values)
		{
			try
			{
				AttributeDictionary = new System.Collections.Specialized.HybridDictionary(true);
				int current=0;
				if(AttributeCount>0)
				{
					foreach(string attribute in Attributes)
					{
						AttributeDictionary.Add(attribute,Values[current]);
						current++;
					}
				}
				return 1;
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,4);
				return -1;
			}
		}

		public virtual int Display(byte[] Attachment, string Extension)
		{
			return -1;
		}

		public virtual byte[] Edit(byte[] Attachment, string Extension)
		{
			return new byte[]{};
		}

		public virtual bool Is_Displayable(string Extension)
		{
			return false;
		}

		public virtual bool Is_Editable(string Extension)
		{
			return false;
		}

		public virtual byte[] render(byte[] Attachment, string Extension, int Width, int Height)
		{
			return new byte[]{};
		}

		public virtual int Finished()
		{
			util.CloseEventLog("EproLibNET.AttachmentBase");
			return 1;
		}
	}
}
