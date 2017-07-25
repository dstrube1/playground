class Composition
{
public:
	Composition (Compositor*);
	void Repair ();
private:
	Compositor* _compositor;
	Component* _components;
	int _componentCount;
	int _lineWidth;
	int* _lineBreaks;
	int _lineCount;
};

class Compositor
{
public:
	virtual int Compose (Coord natural[], Coord stretch[], Coord shrink[], int componentCount, int lineWidth, int breaks[]) = 0;
protected:
	Compositor ();
};

void Composition::Repair ()
{
	Coord* natural;
	Coord* stretchability;
	Coord* shrinkability;
	int componentCount;
	int* breaks;
	// fill the arrays
	int breakCount;
	breakCount = _compositor -> Compose (natural, stretchability, shrinkability, componentCount, _lineWidth, breaks);
	// layout components
}

class SimpleCompositor : public Compositor
{
public:
	SimpleCompositor ();
	virtual int Compose (Coord natural[], Coord stretch[], Coord shrink[], int componentCount, int lineWidth, int breaks[]);
};

Composition* quick = new Composition (new SimpleCompositor);