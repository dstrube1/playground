using System;

namespace Assignment9
{
	public class Notes
	{
		private int counter;
		public string something;
		public Notes ()
		{
			counter = 0;
		}
		//here is an event, here is its delegate, and here is its name
		public event MyEventHandler myEvent;
		//here is the delegate, with the object that raised the event, and some arguments with more info
		public delegate void MyEventHandler(Notes note, EventArgs args);
		public EventArgs e = null;

		public void doStuff(){
			counter++;
			if (counter >= 10) {
				myEvent (this, e);
			}
		}
	}

	public class Other{
		private string myVar;
		private Notes myNote;

		public Other(){
			myNote = new Notes ();
		}

		public void handleMyEvent(Notes sender, EventArgs args){
			myVar = sender.something;
		}

		public void subscribeToEvent(){
			myNote.myEvent += handleMyEvent;
		}

		public void unsubscribeFromEvent(){
			myNote.myEvent -= handleMyEvent;
		}
	}
}

