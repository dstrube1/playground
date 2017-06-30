using System;

namespace EPIntSenderLib
{
	/// <summary>
	/// Summary description for CommTCPSocket.
	/// </summary>
	public class CommTCPSocket:BaseComm
	{
		public CommTCPSocket():base()
		{
		}

		protected override void recv()
		{
			base.recv ();
		}

		protected override void send()
		{
			base.send ();
		}

	}
}
