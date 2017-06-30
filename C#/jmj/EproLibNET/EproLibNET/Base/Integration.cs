using System;
using System.Threading;

namespace EproLibNET.Base
{
	public enum CallbackEventType
	{
		Updated,
		Connected,
		Disconnected
	}

	/// <summary>
	/// Summary description for DeviceIntegration.
	/// </summary>
	public abstract class Integration
	{
		protected string input=null;
		protected string output=null;
		protected IntPtr callbackHandle=(IntPtr)0;

		protected Utilities util = null;

		public Integration()
		{
			util = new Utilities();
			string assmName = System.Reflection.Assembly.GetExecutingAssembly().GetName().Name;
			util.InitializeEventLog(assmName);
		}

		public virtual int Initialize(string xml)
		{
			input=xml;
			return 1;
		}
		public virtual string Do_Source()
		{
			return "";
		}

		public virtual bool Is_Connected()
		{
			return true;
		}
		public virtual int Set_Processed(string id, int status)
		{
			return 1;
		}
		public virtual void SetCallbackWindow(uint WindowHandle)
		{
			callbackHandle = (IntPtr)WindowHandle;
		}
		protected void CallBack(CallbackEventType eventType)
		{
			try
			{
				if (callbackHandle!=(IntPtr)0)
				{
					System.Windows.Forms.Message m = System.Windows.Forms.Message.Create(callbackHandle,(int)eventType,(IntPtr)0,(IntPtr)0);
					new System.Windows.Forms.Form().PreProcessMessage(ref m);
				}
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,1);
			}
		}
	}
}
