class Glyph
{
public:
	virtual ~Glyth ();
	virtual void Draw (Window*, GlyphContext&);
	virtual void SetFont (Font*, GlyphContext&);
	virtual Font* GetFont (GlyphContext&);
	virtual void First (GlyphContext&);
	virtual void Next (GlyphContext&);
	virtual bool IsDone (GlythContext&);
	virtual Glyph* Current (GlyphContext&);
	virtual void Insert (Glyph*, GlyphContext&);
	virtual void Remove (GlyphContext&);
protected:
	Glyph ();
};

class Character: public Glyph
{
public:
	Character (char);
	virtual void Draw (Window*, GlyphContext&);
private:
	char _charcode;
};

class GlyphContext
{
public:
	GlyphContext ();
	virtual ~GlyphContext ();
	virtual void Next (int step = 1);
	virtual void Insert (int quantity = 1);
	virtual Font* GetFont ();
	virtual void SetFont (Font*, int span = 1);
private:
	int _index;
	Btree* _fonts;
};

_index : index into B-Tree holding fonts
Next () : called by Glyph iterator
B-Tree
	interior nodes - break strings into substrings
	leaf nodes - point to fonts

























const int NCHARCODES = 128;

class GlyphFactory
{
public:
GlyphFactory ();
virtual ~GlyphFactory ();
virtual Character* CreateCharacter (char);
virtual Row* CreateRow ();
virtual Column* CreateColumn ();
private:
Character* _character [NCHARCODES];
};

GlyphFactory::GlyphFactory ()
{
for (int I = 0; I < NCHARCODES; ++I)
_characters[I] = 0;
}

Character* GlyphFactory::CreateCharacter (char c)
{
if (!_character[c])
_character[c] = new Character ?;
return _character [c];
}

Row* GlyphFactory::CreateRow ()
{
return new Row;
}

Column* GlyphFactory::CreateColumn ()
{
return new Column;
}

