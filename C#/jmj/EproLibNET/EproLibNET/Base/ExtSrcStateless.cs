using System;

namespace EproLibNET.Base
{
	/// <summary>
	/// Summary description for ExtSrcStateless.
	/// </summary>
	public abstract class ExtSrcStateless
	{
		protected Utilities util = null;

		public ExtSrcStateless()
		{
			util = new Utilities();
			string assmName = System.Reflection.Assembly.GetExecutingAssembly().GetName().Name;
			util.InitializeEventLog(assmName);
		}

		/// <summary>
		/// Create and return a document.
		/// </summary>
		/// <param name="XML">XML string containing context information.</param>
		/// <returns></returns>
		public abstract string CreateDocument(string XML);
	}
}
