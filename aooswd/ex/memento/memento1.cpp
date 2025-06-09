// C++  - use friend class to implement wide interface

class Originator
{
public:
	Memento* CreateMemento ();
	void SetMemento (const Memento*);
private:
	State* _state;
};

class Memento
{
public:
	virtual ~Memento ();
private:
	friend class Originator ();
	Memento ();
	void SetState (State*);
	State* GetState ();
private:
	State* _state;
};
