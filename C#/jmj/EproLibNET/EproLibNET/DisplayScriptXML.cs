using System;
// Couldn't Compile because EproDB isn't checked in
//using EproDB;

namespace EproLibNET
{
//	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class DisplayScriptXML
	{
		public string xmlConnection = string.Empty;

		public DisplayScriptXML()
		{
		}

		public void Initialize(string xml)
		{
			xmlConnection = xml;
		}

		public string CreateDocument(int displayscriptid,string attributes,string values)
		{
		
			return null;
		}

	}
}
