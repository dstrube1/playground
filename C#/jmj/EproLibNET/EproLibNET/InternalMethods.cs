using System;

namespace EproLibNET
{
	/// <summary>
	/// Summary description for InternalMethods.
	/// </summary>
	internal class InternalMethods
	{
		internal InternalMethods()
		{
		}

		static internal string BytesToHexString(byte[] bytes)
		{
			System.Text.StringBuilder buffer = new System.Text.StringBuilder();
			int length = bytes.Length;
			for(int i = 0; i < length; i++) 
			{
				buffer.Append(S_tableau[bytes[i] >> 4]);
				buffer.Append(S_tableau[bytes[i] & 15]);
			}
			return buffer.ToString().ToUpper();
		}
		private static char[] S_tableau = new char[]{'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};

		static internal byte[] HexStringToBytes(string hexString)
		{
			byte[] result=new byte[hexString.Length/2];
			for(int i=0, j=0;i<result.Length;i++,j+=2)
			{
				result[i]=Convert.ToByte(hexString.Substring(j,2),16);
			}
			return result;
		}
	}
}
