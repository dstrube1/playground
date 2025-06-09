public class TextView
{
	public TextView ();
	public void GetOrigin (Coord x, Coord y);
	public void GetExtent (Coord width, Coord height);
	public boolean IsEmpty ();
}

public class TextShape extends Shape
{
	public TextShape ();
	public void BoundingBox (Point bottomLeft, Point topRight)
	{
		Coord bottom, left, width, height;
		GetOrigin (bottom, left);
		GetExtent (width, height);
		bottomLeft = new Point (bottom, left);
		topRight = new Point (bottom + height, left + width);
  }
	public boolean IsEmpty ()
	{
  	return TextView.IsEmpty ();
	}
	public Manipulator CreateManipulator ()
	{
		return new TextManipulator (this);
	}
}

/*************************************************************/

public class TextShape extends Shape
{
	public TextShape (TextView t)
	{
		_text = t;
	}
	public void BoundingBox (Point bottomLeft, Point topRight)
	{
		Coord bottom, left, width, height;
		_text.GetOrigin (bottom, left);
		_text.GetExtent (width, height);
		bottomLeft = new Point (bottom, left);
		topRight = new Point (bottom + height, left + width);
	}
	public boolean IsEmpty ()
	{
		return _text.IsEmpty ();
	}
	public Manipulator CreateManipulator ();
	private	TextView _text;
}