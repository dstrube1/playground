interface GeneralInterface
{
}

interface SpecificInterface
{
	public void SetState (State S);
	public State GetState ();
}


public class Memento implements GeneralInterface, SpecificInterface
{
	private State St;
	public Memento ();
	public void SetState (State S);
	public State GetState ();
}
