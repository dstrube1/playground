public class Composition
{
	public Composition (Compositor);
	public void Repair ()
	{
		Coord natural;
		Coord stretchability;
		Coord shrinkability;
		int componentCount;
		int breaks[];
		// fill the arrays
		int breakCount;
		breakCount = _compositor.Compose (natural, stretchability, shrinkability, componentCount, _lineWidth, breaks);
		// layout components
	}
	private Compositor _compositor;
	private Component _components;
	private int _componentCount;
	private int _lineWidth;
	private Vector _lineBreaks;
	private int _lineCount;
}

abstract public class Compositor
{
	abstract public int Compose (Coord natural[], Coord stretch[], Coord shrink[], int componentCount, int lineWidth, int breaks[]);
	protected Compositor ();
};

public class SimpleCompositor extends Compositor
{
	public SimpleCompositor ();
	int Compose (Coord natural[], Coord stretch[], Coord shrink[], int componentCount, int lineWidth, int breaks[]);
};

Composition quick = new Composition (new SimpleCompositor());