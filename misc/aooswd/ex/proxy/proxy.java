public abstract class Graphic
{
	protected Graphic();
	public abstract void Draw (Point at);
	public abstract void HandleMouse (Event event);
	public abstract Point Get_Extent ();
	public abstract void Load (InputStream from);
	public abstract void Save (OutputStream to);
}

public class Image extends Graphic
{
	public Image (String file);
	public void Draw (Point at);
	public void HandleMouse (Event event);
	public Point GetExtent ();
	public void Load (InputStream from);
	public void Save (OutputStream to);
};

public class ImageProxy extends Graphic
{
	public ImageProxy (String imageFile)
	{
		_fileName = fileName;
		_extent = Point.Zero;
		_image = null;
	};
	public void Draw (Point at);
	public void HandleMouse (Event event)
	{
		GetImage ().HandleMouse (event);
	};
	public Point GetExtent ()
	{
		if (_extent == Point.Zero)
			_extent = GetImage ().GetExtent ();
	};
	public void Load (InputStream from)
	{
		from.read (_extent);
		from.read (_fileName);
	};
	public void Save (OutputStream to)
	{
		to.write (_extent);
		to.write (fileName);
	};
	protected Image GetImage ()
	{
		if (_image == 0)
			image = new Image(fileName);
		return _image;
	};
	private Image _image;
	private Point _extent;
	private String _fileName;
};