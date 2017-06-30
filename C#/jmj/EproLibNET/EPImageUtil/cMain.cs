using System;

namespace EPImageUtil
{
	/// <summary>
	/// Summary description for cMain.
	/// </summary>
	class cMain
	{

		private static System.Diagnostics.EventLog log = new System.Diagnostics.EventLog("Application",Environment.MachineName,"EPImageUtil");

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			Atalasoft.Imaging.Workspace ws = new Atalasoft.Imaging.Workspace();
			try
			{
				System.Collections.Specialized.StringDictionary dict = parseArgs(args);


				try
				{
					ws.Open(dict["s"]);
				}
				catch(Exception exc)
				{
					Log("Error opening source image or no source image defined."+Environment.NewLine+exc.ToString(),System.Diagnostics.EventLogEntryType.Error);
					Environment.ExitCode=-1;
					return;
				}

				// change Size
				if(dict.ContainsKey("maxh") || dict.ContainsKey("maxw"))
				{
					try
					{
						System.Drawing.Size newSize;
						int maxw = 0;
						int maxh = 0;
						if(dict.ContainsKey("maxw"))
							maxw = Int32.Parse(dict["maxw"]);
						if(dict.ContainsKey("maxh"))
							maxh = Int32.Parse(dict["maxh"]);
						// Determine new size as smaller of two percentages
						double ratf=0;
						if(maxw>0 && maxh>0)
						{
							double ratw = ((double)maxw)/((double)ws.Image.Width);
							double rath = ((double)maxh)/((double)ws.Image.Height);
							ratf = Math.Min(ratw,rath);
						}
						else if(maxw>0)
						{
							ratf = ((double)maxw)/((double)ws.Image.Width);
						}
						else
						{
							ratf = ((double)maxh)/((double)ws.Image.Height);
						}
						newSize = new System.Drawing.Size((int)(ratf*ws.Image.Width), (int)(ratf*ws.Image.Height));
						ws.ApplyCommand(new Atalasoft.Imaging.ImageProcessing.ResampleCommand(newSize, Atalasoft.Imaging.ImageProcessing.ResampleMethod.Default));
					}
					catch(Exception exc)
					{
						Log("Error changing image size."+Environment.NewLine+exc.ToString(),System.Diagnostics.EventLogEntryType.Warning);
					}
				}

				// change Color
				if(dict.ContainsKey("pf"))
				{
					try
					{
						Atalasoft.Imaging.PixelFormat pf = getPixelFormat(dict["pf"]);
						ws.ApplyCommand(new Atalasoft.Imaging.ImageProcessing.ChangePixelFormatCommand(pf));
					}
					catch(Exception exc)
					{
						Log("Error changing pixel format."+Environment.NewLine+exc.ToString(),System.Diagnostics.EventLogEntryType.Warning);
					}
				}

				try
				{
					ws.Save(dict["d"],getEncoder(System.IO.Path.GetExtension(dict["d"]),ws.Image.PixelFormat));
				}
				catch(Exception exc)
				{
					Log("Error saving destination image or no destination image defined."+Environment.NewLine+exc.ToString(),System.Diagnostics.EventLogEntryType.Error);
					try
					{
						System.IO.File.Delete(dict["d"]);
					}
					catch{}
					Environment.ExitCode=-1;
					return;
				}
			}
			catch(Exception exc)
			{
				Log(exc.ToString(),System.Diagnostics.EventLogEntryType.Error);
				Environment.ExitCode=-1;
			}
			finally
			{	
				// Clean Up
				ws.Dispose();
			}
		}

		private static void Log(string Message, System.Diagnostics.EventLogEntryType Type)
		{
			log.WriteEntry(Message,Type);
		}

		private static Atalasoft.Imaging.PixelFormat getPixelFormat(string PixelFormat)
		{
			switch(PixelFormat.ToLower())
			{
				case "1bpp":
				case "1bppind":
					return Atalasoft.Imaging.PixelFormat.Pixel1bppIndexed;
				case "8bppgray":
					return Atalasoft.Imaging.PixelFormat.Pixel8bppGrayscale;
				case "8bpp":
				case "8bppind":
					return Atalasoft.Imaging.PixelFormat.Pixel8bppIndexed;
				case "16bppgray":
					return Atalasoft.Imaging.PixelFormat.Pixel16bppGrayscale;
				case "24bpp":
				case "24bpprgb":
					return Atalasoft.Imaging.PixelFormat.Pixel24bppBgr;
				case "32bpprgb":
					return Atalasoft.Imaging.PixelFormat.Pixel32bppBgr;
				case "32bpp":
				case "32bpprgba":
					return Atalasoft.Imaging.PixelFormat.Pixel32bppBgra;
				case "32bppcymk":
					return Atalasoft.Imaging.PixelFormat.Pixel32bppCmyk;
				case "48bpp":
				case "48bpprgb":
					return Atalasoft.Imaging.PixelFormat.Pixel48bppBgr;
				case "64bpp":
				case "64bpprgba":
					return Atalasoft.Imaging.PixelFormat.Pixel64bppBgra;
				default:
					throw new Exception("No suitable pixel format found to match string: "+PixelFormat);
			}
		}
		private static Atalasoft.Imaging.Codec.ImageEncoder getEncoder(string Extension, Atalasoft.Imaging.PixelFormat PixelFormat)
		{
			Extension = Extension.ToLower();

			switch(Extension)
			{
				case ".bmp":
					return new Atalasoft.Imaging.Codec.BmpEncoder(Atalasoft.Imaging.Codec.BmpCompression.None);
				case ".emf":
					return new Atalasoft.Imaging.Codec.EmfEncoder();
				case ".gif":
					return new Atalasoft.Imaging.Codec.GifEncoder();
				case ".jpg":
				case ".jpeg":
					return new Atalasoft.Imaging.Codec.JpegEncoder(100,0,false);
				case ".pdf":
					return new Atalasoft.Imaging.Codec.Pdf.PdfEncoder();
				case ".pcx":
					return new Atalasoft.Imaging.Codec.PcxEncoder();
				case ".png":
					return new Atalasoft.Imaging.Codec.PngEncoder();
				case ".psd":
					return new Atalasoft.Imaging.Codec.PsdEncoder();
				case ".tga":
					return new Atalasoft.Imaging.Codec.TgaEncoder();
				case ".tif":
				case ".tiff":
					if(PixelFormat==Atalasoft.Imaging.PixelFormat.Pixel1bppIndexed)
						return new Atalasoft.Imaging.Codec.TiffEncoder(Atalasoft.Imaging.Codec.TiffCompression.Group4FaxEncoding);
					else
						return new Atalasoft.Imaging.Codec.TiffEncoder(Atalasoft.Imaging.Codec.TiffCompression.JpegCompression);
				case ".tla":
					return new Atalasoft.Imaging.Codec.TlaEncoder();
				case ".wmf":
					return new Atalasoft.Imaging.Codec.WmfEncoder();
				default:
					throw new Exception("No suitable image encoder found to match extension "+Extension);
			}
		}

		private static System.Collections.Specialized.StringDictionary parseArgs(string[] args)
		{
			System.Collections.Specialized.StringDictionary dict = new System.Collections.Specialized.StringDictionary();
			foreach(string arg in args)
			{
				string[] pair = arg.Split('=');
				if(pair.Length!=2)
					continue;
				dict.Add(pair[0].ToLower(),pair[1]);
			}
			return dict;
		}
	}
}
