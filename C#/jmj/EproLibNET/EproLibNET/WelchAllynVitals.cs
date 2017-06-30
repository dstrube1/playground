using System;
using WAVSMCOMSVR_CESLib;
using System.Xml;
using System.IO;
using System.Runtime.InteropServices;

namespace EproLibNET
{
	/// <summary>
	/// Summary description for WelchAllynVitals.
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDispatch)]
	public class WelchAllynVitals:Base.Integration
	{
		private string CommPort = null;

		private int pulse=0;
		private int saturation=0;
		private float temp=0f;
		private int tempMethod=0;
		private int tempProbeType=0;
		private DateTime lastTempChange=DateTime.Now;
		private DateTime lastPulseO2Change=DateTime.Now;
		private DateTime lastBPCycle=DateTime.Now;

		WAVSMInterfaceClass wav = new WAVSMInterfaceClass();

		public WelchAllynVitals():base()
		{
		}
		public override int Initialize(string xml)
		{
			try
			{
#if (DEBUG)
				if(null!=xml)		
					util.LogEvent("WelchAllynVitals","Initialize","XML String Received:"+Environment.NewLine+xml,1);
#endif
				if(Is_Connected())
				{
					wav.DeviceController.EraseCycleData();
					wav.DeviceController.ResetUnit();
					temp=0f;
					tempMethod=0;
					tempProbeType=0;
					lastTempChange=DateTime.Now;
					lastBPCycle=DateTime.Now;
					lastPulseO2Change=DateTime.Now.Subtract(TimeSpan.FromDays(1d));
					pulse=wav.DeviceReadings.SpO2.HeartRate;
					saturation=wav.DeviceReadings.SpO2.Saturation;
				}
				return base.Initialize (xml);
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc, 1);
				return -1;
			}
		}
		public override bool Is_Connected()
		{
			string snum = null;

			try
			{
				snum = wav.DeviceInformation.SerialNumber;
				return true;
			}
			catch
			{
				try
				{
					wav.CloseComm();
					if(null==CommPort)
						FindCommPort();
					if(null==CommPort)
						return false;
					wav.CommPort=CommPort;
					wav.OpenComm();
					snum = wav.DeviceInformation.SerialNumber;
					return true;
				}
				catch
				{
					return false;
				}
			}
			
		}

		public override string Do_Source()
		{
			
			string output=null;
			bool useBPPulse = false;
			try
			{
				MemoryStream ms = new MemoryStream();
				XmlTextWriter tw = new XmlTextWriter(ms,System.Text.Encoding.UTF8);
				tw.WriteStartDocument();
				tw.WriteStartElement("Observation");


				// Temperature Readings
				
				// Send temp if it has changed since the last time it was read
				// or if it has been at least 2 minutes since the last time it 
				// was read
				if(wav.DeviceReadings.CycleRecord.Temperature.Temperature!=0f&&((temp!=wav.DeviceReadings.CycleRecord.Temperature.Temperature||tempMethod!=(int)wav.DeviceReadings.CycleRecord.Temperature.Method||tempProbeType!=(int)wav.DeviceReadings.CycleRecord.Temperature.ProbeType)||lastTempChange.AddMinutes(2d)<=DateTime.Now))
				{
					temp = wav.DeviceReadings.CycleRecord.Temperature.Temperature;
					tempMethod = (int)wav.DeviceReadings.CycleRecord.Temperature.Method;
					tempProbeType = (int)wav.DeviceReadings.CycleRecord.Temperature.ProbeType;
					lastTempChange = DateTime.Now;

					tw.WriteStartElement("Temp");
					tw.WriteStartElement("Temp");
					tw.WriteAttributeString("result_unit",wav.DeviceReadings.CycleRecord.Temperature.TemperatureDisplayUnits==0?"FAHR":"CELSIUS");
					tw.WriteAttributeString("location",wav.DeviceReadings.CycleRecord.Temperature.ProbeType.ToString());
					tw.WriteString(wav.DeviceReadings.CycleRecord.Temperature.Temperature.ToString());
					tw.WriteEndElement();
					tw.WriteElementString("Method",wav.DeviceReadings.CycleRecord.Temperature.Method.ToString());
					tw.WriteEndElement();
				}

				// Cycle Readings (BP)

				// Send BP any time there is a new TimeStamp for the BP Cycle
				if(wav.DeviceReadings.CycleRecord.BP.Systolic!=0&&wav.DeviceReadings.CycleRecord.BP.Diastolic!=0&&wav.DeviceReadings.CycleRecord.Time!=lastBPCycle)
				{
					lastBPCycle=wav.DeviceReadings.CycleRecord.Time;
					useBPPulse=true;
					tw.WriteStartElement("BP");
					tw.WriteElementString("Systolic",wav.DeviceReadings.CycleRecord.BP.Systolic.ToString());
					tw.WriteElementString("Diastolic",wav.DeviceReadings.CycleRecord.BP.Diastolic.ToString());
					tw.WriteEndElement();
				}


				// SpO2 Readings

				// Send SpO2 if values have changed within the last 30 seconds
				if(wav.DeviceReadings.SpO2.HeartRate!=0)
				{
					if(wav.DeviceReadings.SpO2.HeartRate!=pulse || wav.DeviceReadings.SpO2.Saturation!=saturation)
					{
						lastPulseO2Change=DateTime.Now;
					}
					if(lastPulseO2Change.AddSeconds(30)>=DateTime.Now)
					{
						useBPPulse=false;
						pulse=wav.DeviceReadings.SpO2.HeartRate;
						saturation=wav.DeviceReadings.SpO2.Saturation;
						tw.WriteStartElement("HR");
						tw.WriteElementString("HR",wav.DeviceReadings.SpO2.HeartRate.ToString());
						tw.WriteEndElement();
						tw.WriteStartElement("O2Saturation");
						tw.WriteElementString("O2Saturation",wav.DeviceReadings.SpO2.Saturation.ToString());
						tw.WriteEndElement();
					}				
				}

				if(useBPPulse)
				{
					tw.WriteStartElement("HR");
					tw.WriteElementString("HR",wav.DeviceReadings.CycleRecord.BP.HeartRate.ToString());
					tw.WriteEndElement();
				}


				tw.WriteEndElement();
				tw.WriteEndDocument();
				tw.Flush();
				ms.Position=0;
				StreamReader sr = new StreamReader(ms,System.Text.Encoding.UTF8);
				output = sr.ReadToEnd();
				sr.Close();

				if(null==output)
					output = string.Empty;

				return output;
			}
			catch(Exception exc)
			{
				util.LogInternalEvent(exc,1);
				return string.Empty;
			}
		}

		private void FindCommPort()
		{
			WAVSMInterfaceClass wavTest = new WAVSMInterfaceClass();
			for(int i=1; i<=32; i++)
			{
				try
				{
					wavTest.CommPort="COM"+i.ToString();
					wavTest.CloseComm();
					wavTest.OpenComm();
					
					string dsig = wavTest.DeviceInformation.DeviceSignature;
					string snum = wavTest.DeviceInformation.SerialNumber;
					string sver = wavTest.DeviceInformation.DeviceSWVersion;
					util.LogEvent("WelchAllynVitals","FindCommPort","Connected to device on "+wavTest.CommPort+Environment.NewLine+
						"Device Signature: " + dsig + Environment.NewLine+
						"Device Serial No: " + snum + Environment.NewLine+
						"Software Version: " + sver,1);
					wavTest.CloseComm();
					CommPort = wavTest.CommPort;
					wavTest = null;
					return;
				}
				catch
				{
					try
					{
						wavTest.CloseComm();
					}
					catch{}
				}
			}
			util.LogEvent("WelchAllynVitals","FindCommPort","Device not found on COM1-COM32",1);
		}

	}
}
