using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
using System.Diagnostics;

namespace EPImageControl
{


//	public interface iImageManipulation
//	{
//		ImageManipulation.Size GetImageSize(string sourceFile);
//		int ConvertTo1bppBmp(string sourceFile, string outputFile);
//		int ResizeDarkenBitmap(string sourceFile, string outputFile, int outputWidth, int outputHeight, int luminanceCutoff);
//	}

	/// <summary>
	/// Summary description for ImageManipulation.
	/// </summary>
	[ClassInterface(ClassInterfaceType.AutoDual)]
	public class ImageManipulation//:iImageManipulation
	{
		
		public int LogEvent(string objectName, string scriptName, string message, int severity)
		{
			EventLog eventLog=new EventLog("Application", ".", "EPImageControl");

			if(null==eventLog)
			{
				eventLog = new EventLog("Application", ".", "EncounterPRO");
				eventLog.WriteEntry("EncounterPRO Event Logging initialized automatically because it was not initialized by the caller.", EventLogEntryType.Warning);
			}
			try
			{
				EventLogEntryType eventSeverity = EventLogEntryType.Information;
				if(null==objectName)
				{
					objectName = "UnknownObject";
				}
				if(null==scriptName)
				{
					scriptName = "UnknownScript";
				}
				if(null==message)
				{
					message = "UnknownMessage";
				}
				switch(severity)
				{
					case 1:
					case 2:
						eventSeverity=EventLogEntryType.Information;
						break;
					case 3:
						eventSeverity=EventLogEntryType.Warning;
						break;
					case 4:
					case 5:
						eventSeverity=EventLogEntryType.Error;
						break;
				}

				eventLog.WriteEntry(Environment.UserDomainName+"\\"+Environment.UserName+" on "+Environment.MachineName+ "\r\n" + System.Windows.Forms.Application.ProductVersion + " >>> " + objectName+" - ("+scriptName+") "+message, eventSeverity);
				return 1;
			}
			catch(Exception exc)
			{
				return -1;
			}
			finally
			{
				eventLog.Close();
			}

		}

		public void GetImageSize(string sourceFile, out int width, out int height)
		{
			Image bmpSource = null;
			try
			{
				bmpSource = Image.FromFile(sourceFile,true);
				width = (int)(((float)bmpSource.Width*1000) / bmpSource.HorizontalResolution);
				height = (int)(((float)bmpSource.Height*1000) / bmpSource.VerticalResolution);
				return;
			}
			catch(Exception exc)
			{
				LogEvent(exc.Source,exc.TargetSite.Name,"Error getting image size\r\n\r\n"+exc.ToString(),2);
				width=-1;
				height=-1;
				return;
			}
			finally
			{
				try
				{
					bmpSource.Dispose();
				}
				catch{}
			}
		}
		public int ConvertTo1bppBmp(string sourceFile, string outputFile)
		{
			try
			{
				Image		bmpSource = Image.FromFile(sourceFile, true);
				int			luminanceCutoff = 250;

				Image		bmpOutput = new Bitmap(bmpSource.Width, bmpSource.Height);
				Graphics	gfx = Graphics.FromImage(bmpOutput);
			
				gfx.DrawImage(bmpSource, new Rectangle(0,0,bmpOutput.Width,bmpOutput.Height), 0,0,bmpSource.Width,bmpSource.Height,GraphicsUnit.Pixel);
				bmpOutput = ConvertTo1bppIndexed((Bitmap)bmpOutput, luminanceCutoff);

				if(System.IO.File.Exists(outputFile))
				{
					System.IO.File.Delete(outputFile);
				}

				bmpOutput.Save(outputFile, ImageFormat.Bmp);
			}
			catch(Exception exc)
			{
				LogEvent(exc.Source,exc.TargetSite.Name,"Error converting image to 1bpp\r\n\r\n"+exc.ToString(),4);
				return -1;
			}
			return 1;
		}

		public int ResizeDarkenBitmap(string sourceFile, string outputFile, int outputWidth, int outputHeight, int luminanceCutoff)
		{
			try
			{
				Image		bmpSource = Image.FromFile(sourceFile, true);

				int widthZoom = (outputWidth*100)/bmpSource.Width;
				int heightZoom = (outputHeight*100)/bmpSource.Height;

				int outputZoom = widthZoom>heightZoom? widthZoom : heightZoom;

				Image		bmpOutput = new Bitmap((bmpSource.Width*outputZoom)/100, (bmpSource.Height*outputZoom)/100);
				Graphics	gfx = Graphics.FromImage(bmpOutput);
			
				gfx.PixelOffsetMode=PixelOffsetMode.HighQuality;
				gfx.SmoothingMode=SmoothingMode.HighQuality;
				gfx.InterpolationMode=InterpolationMode.High;
				gfx.DrawImage(bmpSource, new Rectangle(0,0,bmpOutput.Width,bmpOutput.Height), 0,0,bmpSource.Width,bmpSource.Height,GraphicsUnit.Pixel);
				bmpOutput = ConvertTo1bppIndexed((Bitmap)bmpOutput, luminanceCutoff);

				if(System.IO.File.Exists(outputFile))
				{
					System.IO.File.Delete(outputFile);
				}

				bmpOutput.Save(outputFile, ImageFormat.Bmp);
			}
			catch(Exception exc)
			{
				LogEvent(exc.Source,exc.TargetSite.Name,"Error in ResizeDarkenBitmap()\r\n\r\n"+exc.ToString(),4);
				return -1;
			}
			return 1;
		}

		internal static Bitmap ConvertTo1bppIndexed(Bitmap src)
		{
			return ConvertTo1bppIndexed(src, 128);
		}
		internal static Bitmap ConvertTo1bppIndexed(Bitmap src, int luminanceCutOff)
		{
			int            width, height;
			Bitmap        dest;
			Rectangle    rect;
			BitmapData    data;
			IntPtr        pixels;
			uint        row, col;

			//Collect SOURCE Bitmap info
			width = src.Width;
			height = src.Height;

			//Create the DESTINATION Bitmap
			dest = new Bitmap(width, height, PixelFormat.Format1bppIndexed);
			dest.SetResolution(src.HorizontalResolution, src.VerticalResolution);

			//LOCK the Entire Bitmap & get the pixel pointer
			rect = new Rectangle(0, 0, width, height);
			data = dest.LockBits(rect, ImageLockMode.WriteOnly,
				PixelFormat.Format1bppIndexed);
			pixels = data.Scan0;

			unsafe
			{
				Color        srcPixel;
				byte *        pBits, pDestPixel;
				byte        bMask;
				double        luminance;
                
				//Init pointer to the Bits
				if (data.Stride > 0)    pBits = (byte *) pixels.ToPointer();
				else                    pBits = (byte *) pixels.ToPointer() + data.Stride * (height -
											1);

				//Stride could be negative
				uint stride = (uint)Math.Abs(data.Stride);

				//Go through all the Pixels in the rectangle
				for ( row = 0; row < height; row ++ )
				{
					for ( col = 0; col < width; col ++ )
					{
						//Get the Pixel from the SOURCE
						srcPixel = src.GetPixel((int)col, (int)row);
						//srcPixel = Color.White;

						//Move the DESTINATION to the correct Address / Pointer & get Pixel
						pDestPixel = pBits + (row * stride) + ((int)(col / 8));

						//Determine which Bit Represents this Pixel in 1bpp format
						bMask = (byte) (0x0080 >> (int)(col % 8));

						//Calculate LUMINANCE to help determine if black or white pixel
						luminance = (srcPixel.R * 0.299) + (srcPixel.G * 0.587) + (srcPixel.B
							* 0.114);

						//Set to Black or White using the Color. Luminance Cut Off
						if ( luminance >= luminanceCutOff )
							*pDestPixel |= (byte) bMask;        // Set Bit to 1    - White
						else
							*pDestPixel &= (byte) ~ bMask;        // Set Bit to 0 - Black
					}
				}

			}
			dest.UnlockBits(data);
			return dest;
		}
		}
}
