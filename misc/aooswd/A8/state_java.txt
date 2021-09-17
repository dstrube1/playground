public class TCPConnection
{
	private TCPState _state;

	public TCPConnection ()
	{
		_state = TCPClosed.Instance ();
	}

	public void ActiveOpen ()
	{
		_state -> ActiveOpen (this);
	}

	public void PassiveOpen ()
	{
		_state -> PassiveOpen (this);
	}

	public void Close ()
	{
		_state -> Close (this);
	}

	public void Send ();

	public void Acknowledge ()
	{
		_state -> Acknowledge ();
	}

	public void Synchronize ();
	{
		_state -> Synchronize ();
	}

	public void ProcessOctet (TCPOctetStream*);

	private void ChangeState (TCPState s)
	{
		_state = s;
	}

}

public class TCPState
{
	public void Transmit (TCPConnection c, TCPOctetStream os)
	{
	}

	public void ActiveOpen (TCPConnection c)
	{
	}

	public void PassiveOpen (TCPConnection c)
	{
	}

	public void Close (TCPConnection c)
	{
	}

	public void Synchronize (TCPConnection c);

	public void Acknowledge (TCPConnection c);

	public void Send (TCPConnection c);

	protected void ChangeState (TCPConnection c, TCPState s)
	{
		c.ChangeState (s);
	}
}

public class TCPEstablished extends TCPState
{
	public static TCPState Instance ();

	public void Transmit (TCPConnection t, TCPOctetStream o)
	{
		t.ProcessOctet (o);
	}

	public void Close (TCPConnection t)
	{
		ChangeState (t, TCPListen.Instance ());
};

public class TCPListen extends TCPState
{
	public static TCPState Instance ();

	public void Send (TCPConnection t)
	{
		ChangeState (t, TCPEstablished.Instance ());
	}

};

class TCPClosed estends TCPState
{
	public static TCPState Instance ();
	public void ActiveOpen (TCPConnection t)
	{
		ChangeState (t, TCPEstablished.Instance ());
	}

	public void PassiveOpen (TCPConnection t)
	{
		ChangeState (t, TCPListen.Instance ());
	}
};