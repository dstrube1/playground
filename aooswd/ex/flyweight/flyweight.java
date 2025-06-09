public class Glyph
{
	public void Draw (Window, GlyphContext);
	public void SetFont (Font, GlyphContext);
	public Font GetFont (GlyphContext);
	public void First (GlyphContext);
	public void Next (GlyphContext);
	public boolean IsDone (GlythContext);
	public Glyph Current (GlyphContext);
	public void Insert (Glyph, GlyphContext);
	public void Remove (GlyphContext);
	protected Glyph ();
}

public class Character extends Glyph
{
	public Character (char);
	public void Draw (Window, GlyphContext);
	private	char _charcode;
}

class GlyphContext
{
public:
	GlyphContext ();
	public void Next (int step);
	public void Insert (int quantity);
	public Font GetFont ();
	public void SetFont (Font, int span);
	private	int _index;
	private Btree _fonts;
}