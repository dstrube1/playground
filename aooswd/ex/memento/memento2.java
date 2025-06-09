public class MoveCommand extends Command
{
	private ConstraintSolverMemento _state;
	private Point _delta;
	private Graphic _target;

	public MoveCommand (Graphic target, Point Delta)
	{
		_delta = Delta;
		_target = target;
	}

	public void Execute ()
	{
		ConstraintSolver solver = new ConstraintSolver ();
		_state = solver.CreateMemento();
		_target.Move(_delta);
		solver.Solve();
	}

	public void Unexecute()
	{
		ConstraintSolver solver = new ConstraintSolver ();
		_target.Move (_delta);
		solver.SetMemento (_state);
		solver.Solve ();
	}
}

public class ConstraintSolver extends Object
{
	public ConstraintSolver ()
	{
	}

	public void Solve ();

	public void AddConstraint (Graphic startConnection, Graphic endConnection);

	public RemoveConstraint (Graphic startConnection, Graphic endConnection);

	public ConstraintSolverMemento CreateMemento ();

	public void SetMemento (ConstraintSolverMemento M);
}