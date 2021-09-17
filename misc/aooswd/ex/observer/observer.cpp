// observer interface

class Observer
{
public:
	virtual ~Observer ();
	virtual void Update (Subject* theChangeSubject) = 0;
protected:
	Observer ();
};

// subject interface

class Subject
{
public:
	virtual ~Subject ();
	virtual void Attach (Observer*);
	virtual void Detach (Observer*);
	virtual void Notify ();
protected:
	Subject ();
private:
	List<Observer*> _observers;
};
