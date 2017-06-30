using System;
using System.Runtime.InteropServices;
using System.Xml;
using System.IO;
using System.Threading;

namespace EproLibNET
{
	/// <summary>
	/// Summary description for BrentwoodHolter.
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class BrentwoodHolter:Base.Integration
	{
		public BrentwoodHolter():base()
		{
		}
		public override int Initialize(string xml)
		{
			try
			{
#if (DEBUG)
				if(null!=xml)
					util.LogEvent("BrentwoodHolter","Initialize","XML String Received:"+Environment.NewLine+xml,1);
#endif
				return base.Initialize (xml);
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc, 4);
				return -1;
			}
		}
		public override bool Is_Connected()
		{
			try
			{
				new fBrentwoodHolter().Dispose();
				return true;
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc, 4);
				return false;
			}
		}


		public override string Do_Source()
		{
			fBrentwoodHolter holter = null;
			try
			{
				holter = new fBrentwoodHolter();
				output = holter.Run(input);
				if(output==null)
					return "";
				return output;
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,4);
				throw(exc);
			}
			finally
			{
				try
				{
					holter.Dispose();
				}
				catch{}
			}
		}

	}
}
