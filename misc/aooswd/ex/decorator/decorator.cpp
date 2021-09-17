class VisualComponent
{
public:
	VisualComponent ();
	virtual void Draw ();
	virtual void Resize ();
};

class Decorator : public VisualComponent
{
public:
	Decorator (VisualComponent*);
	virtual void Draw ();