using System;
using System.Runtime.InteropServices;
using System.Xml;
using System.IO;
using System.Threading;

namespace EproLibNET
{
	/// <summary>
	/// Summary description for BrentwoodSpiro.
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class BrentwoodSpiro:Base.Integration
	{
		public BrentwoodSpiro():base()
		{
		}
		public override int Initialize(string xml)
		{
			try
			{
#if (DEBUG)
				if(null!=xml)
					util.LogEvent("BrentwoodSpiro","Initialize","XML String Received:"+Environment.NewLine+xml,1);
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
				new fBrentwoodSpiro().Dispose();
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
			fBrentwoodSpiro spiro = null;
			try
			{
				spiro = new fBrentwoodSpiro();
				output = spiro.Run(input);
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
					spiro.Dispose();
				}
				catch{}
			}
		}

	}
}
