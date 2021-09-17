public class Window
{
	public Window (View contents);
	public void DrawContents ();
	public void Open ();
	public void Close ();
	public void Iconify ();
	public void Deiconify ();
	public void SetOrigin (Point at);
	public void SetExtent (Point extent);
	public void Raise ();
	public void Lower ();
	public void DrawLine (Point, Point);
	public void DrawRect (Point, Point);
	public void DrawPolygon (Vector, int n);
	public void DrawText (String, Point);
	protected WindowImp GetWindowImp ()
	{
		if (_imp == null)
			_imp = WindowSystemFactory.Instance ().MakeWindowImp ();
		return _imp;
	}
	protected View GetView ();
	private	WindowImp _imp;
	private View _contents;
}

abstract public class WindowImp
{
	public abstract void ImpTop ();
	public abstract void ImpBottom ();
	public abstract void ImpSetExtent (Point);
	public abstract ImpSetOrigin (Point);
	public abstract void DeviceRect (Coord, Coord, Coord, Coord);
	public abstract void DeviceBitmap (String, Coord, Coord);
	protected WindowImp ();
}

public class ApplicationWindow extends Window
{
	public void DrawContents ()
	{
		GetView ().DrawOn (this);
	}
}

public class IconWindow extends Window
{
	public void DrawContents ()
	{
		WindowImp imp = GetWindowImp ();
		if (imp != null)
			imp.DeviceBitMap (_bitmapName, 0.0, 0.0);
	}
	public void DrawRect (Point p1, Point p2)
	{
		WindowImp imp = GetWindowImp ();
		imp. DeviceRect (p1.x(), p1.y(), p2.x(), p2.y());
	}
	private String _bitmapName;
}

public class XwindowImp extends WindowImp
{
	public XwindowImp ();
	public void DeviceRect (Coord, Coord, Coord, Coord);
	{
		int x = round (min (x0, x1));
		int y = round (min (y0, y1));
		int w = round (abs (x0 - x1));
		int h = round (abs (y0 - y1));
		XDrawRectangle (_dpy, _winid, _pc, x, y, w, h);
	}
	private	Display _dpy;
	private Drawable _winid;
	private GC _gc;
}

public class PMWindowImnp extends WindowImp
{
	public PMWindowImp ();
	public void DeviceRect (Coord, Coord, Coord, Coord);
	{
		Coord left = min (x0, x1);
		Coord right = max (x0, x1);
		Coord bottom = min (y0, y1);
		Coord top = max (y0, y1);
		PPOINTL point [4];
		point [0].x = left;
		point [0].y = top;
		point [1].x = right;
		point [1].y = bottom;
		point [2].x = right;
		point [2].y = bottom;
		point [3].x = left;
		point [3].y = bottom;
		if ((Gpi.BeginPath (_hps, iL) == false) ||
		(GpiSetCurrentPosition (_hps, point[3]) == false) ||
		(GpiPolyLine (_hps, 4L, point) == GPI_ERROR) ||
		(GpiEndPath (_hps) == false))
			// reprt error
		else
			GpiStrokePath (_hps, iL, 0L);
	}
	private HPS _hps;
}


