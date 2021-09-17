public class Subject extends Observable
{
	public Subject();
	public void addObserver (Observer o);
	public void deleteObserver (Observer o);
	public void notifyObservers ();
}

public class Observer
{
	public Observer();
	public void Update (Subject s);
}
