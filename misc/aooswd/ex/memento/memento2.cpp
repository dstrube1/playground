class MoveCommand
{
public:
	MoveCommand (Graphic* target, const Point& Delta);
	void Execute ();
	void Unexecute ();
private:
	ConstraintSolverMemento* _state;
	Point _delta;
	Graphic* _target;
};

class ConstraintSolver
{
public:
	static ConstraintSolver* Instance ();
	void Solve ();
	void AddConstraint (Graphic* startConnection, Graphic* endConnection);
	void RemoveConstraint (Graphic* startConnection, Graphic* endConnection);
	ConstraintSolverMemento* CreateMemento ();
	void SetMemento (ConstraintSolverMemento*);
private:
…
};

class ConstraintSolverMemento
{
public:
	virtual ~ConstraintSolverMemento ();
private:
	friend class ConstraintSolver;
	ConstraintSolverMemento ();
};

void MoreCommand::Execute
{
	ConstraintSolver* solver = ConstraintSolver::Instance ();
	_state = solver -> CreateMemento ();
	_target -> Move (delta);
	solver -> Solve ();
}

void MoveCommand::Unexecute ()
{
	ConstraintSolver* solver = ConstraintSolver::Instance ();
	_target -> Move (-_delta);
	solver -> SetMemento (_state);
	solver -> Solve ();
}
