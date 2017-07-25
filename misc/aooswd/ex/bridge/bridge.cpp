class Window
{
public:
Window (View* contents);
	virtual void DrawContents ();
	virtual void Open ();
	virtual void Close ();
	virtual void Iconify ();
	virtual void Deiconify ();
	virtual void SetOrigin (const Point& at);
	virtual void SetExtent (const Point& extent);
	virtual void Raise ();
	virtual void Lower ();
	virtual void DrawLine (const Point&, const Point&);
	virtual void DrawRect (const Point&, const Point&);
	virtual void DrawPolygon (const Point [], int n);
	virtual void DrawText (const char*, const Point&);
protected:
	WindowImp* GetWindowImp ();
	View* GetView ();
private:
	WindowImp* _imp;
	View* _contents;
};

class WindowImp
{
public:
	virtual void ImpTop () = 0;
	virtual void ImpBottom () = 0;
	virtual void ImpSetExtent (const Point&) = 0;
	virtual void ImpSetOrigin (const Point&) = 0;
	virtual void DeviceRect (Coord, Coord, Coord, Coord) = 0;
	virtual void DeviceBitmap (const char*, Coord, Coord) = 0;
protected:
	WindowImp ();
};

class ApplicationWindow: public Window
{
public:
	virtual void DrawContents ();
};

void ApplicationWindow::DrawContents ()
{
	GetView () -> DrawOn (this);
}

class IconWindow: public Window
{
public:
	virtual void DrawContents ();
private:
	const char* _bitmapName;
};

void IconWindow::DrawContents ()
{
	WindowImp* imp = GetWindowImp ();
	if (imp != 0)
		imp -> DeviceBitMap (_bitmapName, 0.0, 0.0);
}

void IconWindow::DrawRect (const Point& p1, const Point& p2)
{
	WindowImp* imp = GetWindowImp ();
	imp -> DeviceRect (p1.x(), p1.y(), p2.x(), p2.y());
}

class XwindowImp: public WindowImp
{
public:
	XwindowImp ();
	virtual void DeviceRect (Coord, Coord, Coord, Coord);
private:
	Display* _dpy;
	Drawable _winid;
	GC _gc;
};

class PMWindowImnp: public WindowImp
{
public:
	PMWindowImp ();
	virtual void DeviceRect (Coord, Coord, Coord, Coord);
private:
	HPS _hps;
};

void XWindowImp::DeviceRect (Coord x0, Coord y0, Coord x1, Coord y1)
{
	int x = round (min (x0, x1));
	int y = round (min (y0, y1));
	int w = round (abs (x0 - x1));
	int h = round (abs (y0 - y1));
	XDrawRectangle (_dpy, _winid, _pc, x, y, w, h);
}

void PMWindowImp::DeviceRect (Coord x0, Coordy0, Coord x1, Coord y1)
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
	(GpiSetCurrentPosition (_hps, &point[3]) == false) ||
	(GpiPolyLine (_hps, 4L, point) == GPI_ERROR) ||
	(GpiEndPath (_hps) == false))
		// reprt error
	else
		GpiStrokePath (_hps, iL, 0L);
}

WindowImp* Window::GetWindowImp ()
{
	if (_imp == 0)
		_imp = WindowSystemFactory::Instance () -> MakeWindowImp ();
	return _imp;
}
