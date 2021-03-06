class Graphic
{
public:
	virtual ~Graphic ();
	virtual void Draw (const Point& at) = 0;
	virtual void HandleMouse (Event& event) = 0;
	virtual const Point& Get_Extent () = 0;
	virtual void Load (istream& from) = 0;
	virtual void Save (ostream& to) = 0;
protected:
	Graphic ();
};

class Image: public Graphic
{
public:
	Image (const char* file);
	virtual ~Image ();
	virtual void Draw (const Point& at);
	virtual void HandleMouse (Event& event);
	virtual const Point& GetExtent ();
	virtual void Load (istream& from);
	virtual void Save (ostream& to);
};

class ImageProxy: public Graphic
{
public:
	ImageProxy (const char* imageFile);
	virtual ~ImageProxy ();
	virtual void Draw (const Point& at);
	virtual void HandleMouse (Event& event);
	virtual const Point& GetExtent ();
	virtual void Load (istream& from);
	virtual void Save (ostream& to);
protected:
	Image* GetImage ();
private:
	Image* _image;
	Point _extent;
	char* _fileName;
};

ImageProxy::ImageProxy (const char* fileName)
{
	_fileName = strdup (fileName);
	_extent = Point::Zero;
	_image = 0;
}

Image* ImagePorxy::GetImage ()
{
	if (_image == 0)
		image = new Image(fileName);
	return _image;
}

const Point& ImageProxy::GetExtent ()
{
	if (_extent == Point::Zero)
		_extent = GetImage () -> GetExtent ();
}

void ImageProxy::HandleMouse (Event& event)
{
	GetImage () -> HandleMouse (event);
}

void ImageProxy::Save (ostream& to)
{
	to << _extent << _fileName;
}

void ImageProxy::Load (istream& from)
{
	from >> _extent >> _fileName;
}
