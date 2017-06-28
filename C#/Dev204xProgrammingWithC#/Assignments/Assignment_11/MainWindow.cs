using System;
using Gtk;
using System.Threading.Tasks;
using System.Threading;
using System.Collections.Generic;
using System.Linq;


public partial class MainWindow: Gtk.Window
{
	public MainWindow () : base (Gtk.WindowType.Toplevel)
	{
		Build ();

		task1 = Task.Run( () => MyMethod("Task.Run") );
		// Do some other work.
		// Wait for task 1 to complete.
		task1.Wait();
		// Continue with execution.

		task2.Start();

		// Using the TaskFactory.StartNew Method to Queue a Task
		task3 = Task.Factory.StartNew( () => Console.WriteLine("Task 3 has completed.") );

		// Using the Task.Run Method to Queue a Task
		task4 = Task.Run( () => Console.WriteLine("Task 4 has completed. ") );

		// Waiting for Multiple Tasks to Complete
		Task[] tasks = new Task[3]
		{
			Task.Run( () => MyMethod("task array 1 of 3")),
			Task.Run( () => MyMethod("task array 2 of 3")),
			Task.Run( () => MyMethod("task array 3 of 3"))
		};
		// Wait for any of the tasks to complete.
		Task.WaitAny(tasks);
		// Alternatively, wait for all of the tasks to complete.
		Task.WaitAll(tasks);
		// Continue with execution.

		// Retrieving a Value from a Task
		// Create and queue a task that returns the day of the week as a string.
		Task<string> task5 = Task.Run<string>( () => DateTime.Now.DayOfWeek.ToString() );
		// Retrieve and display the task result.
		Console.WriteLine(task5.Result);

		// Cancelling a Task
		// Create a cancellation token source and obtain a cancellation token.
		CancellationTokenSource cts = new CancellationTokenSource();
		CancellationToken ct = cts.Token;
		// Create and start a task.
		Task.Run( () => simpleCancellableMethod(ct) );

		if (ct.CanBeCanceled) {
			cts.Cancel ();
		}

		// Canceling a Task by Throwing an Exception
		// Create a cancellation token source and obtain a cancellation token.
		CancellationTokenSource cts0 = new CancellationTokenSource();
		CancellationToken ct0 = cts0.Token;
		// Create and start a task.
		Task.Run( () => comlpexCancellableMethod(ct0) );
		if (ct0.CanBeCanceled) {
			cts0.Cancel ();
		}

		// Using the Parallel.Invoke Method
		//tasks are created implicitly from the delegates
		Parallel.Invoke( 
			() => MyMethod("Parallel.Invoke 1 of 2"), 
			() => MyMethod("Parallel.Invoke 2 of 2") );

		// Using a Parallel.For Loop
		int from = 0;
		int to = 10;
		double[] array = new double[to];
		// This is a sequential implementation:
		for(int index = from; index < to; index++)
		{
			double d = Math.Sqrt (index);
			Console.WriteLine ("Sequentially setting array[{0}] to {1}",index,d);
			array[index] = d;
		}
		// This is the equivalent parallel implementation:
		Parallel.For(from, to, index =>
			{
				double d = Math.Sqrt (index);
				Console.WriteLine ("Parallelly setting array[{0}] to {1}",index,d);
				array[index] = d;
			});

		// Using a Parallel.ForEach Loop
		var intList = new List<int>();
		intList.Add (0);
		intList.Add (1);
		intList.Add (2);
		Parallel.ForEach(intList, listItem => MyMethod("Parallel.ForEach Loop "+listItem));

		// Using PLINQ
		intList.Add(3);
		intList.Add(4);
		intList.Add(5);
		var evens = 
			from listItem in intList.AsParallel ().AsOrdered()
			where listItem % 2 == 0
			select listItem;
		foreach (int i in evens) {
			Console.WriteLine ("i = {0}",i);
		}
	}

	protected void OnDeleteEvent (object sender, DeleteEventArgs a)
	{
		Application.Quit ();
		a.RetVal = true;
	}

	protected void onClick (object sender, EventArgs e)
	{
//		task1.Dispose ();
		task2.Dispose();
		MessageBox.Show (this, 
			DialogFlags.Modal, 
			MessageType.Info, 
			ButtonsType.OkCancel, 
			Time,
			"title"
		);
	}

	private static string Time;

	// Creating a Task by Using an Action Delegate - onymous method / delegate
	Task task1 = new Task(new System.Action(GetTheTime));
	private static void GetTheTime()
	{
		Time = "The time now is "+DateTime.Now;
	}

	// Creating a Task by Using an Action Delegate - onymous method
	Task task2 = new Task( delegate { Time = "The time now is "+ DateTime.Now; });

	//Lambda expression example
	Task task3 = new Task ( () => MyMethod("Task via lambda expression") );
	// This is equivalent to: Task task3 = new Task( delegate(MyMethod) );

	// Using a Lambda Expression to Invoke an Anonymous Method
	Task task4 = new Task( () => { Console.WriteLine("Using a Lambda Expression to Invoke an Anonymous Method"); } );
	// This is equivalent to: Task task4 = new Task( delegate { Console.WriteLine("Test") } );

	private static void MyMethod(string from){
		Console.WriteLine ("MyMethod from {0}",from);
	}

	private void simpleCancellableMethod(CancellationToken token){
		for (int i=0; i<10; i++){
			Console.WriteLine ("cancellableMethod; i= {0}",i);

			// At the end of an iteration, check for cancellation.
			if(token.IsCancellationRequested)
			{
				// Tidy up and finish.
				return;
			}
			// If the task has not been cancelled, continue running as normal.
		}
	}

	private void comlpexCancellableMethod(CancellationToken token){
		for (int i=0; i<10; i++){
			Console.WriteLine ("cancellableMethod; i= {0}",i);

			// At the end of an iteration, check for cancellation.
			// Throw an OperationCanceledException if cancellation was requested.
			token.ThrowIfCancellationRequested(); 
			// If the task has not been cancelled, continue running as normal.
		}
	}
}

public static class MessageBox 
{
	public static Gtk.ResponseType Show(Gtk.Window window, Gtk.DialogFlags dialogflags, MessageType msgType,
		ButtonsType btnType,string Message,String caption)
	{

		MessageDialog md = new MessageDialog (window,dialogflags,msgType,btnType, Message);
		md.Title = caption;
		ResponseType tp = (Gtk.ResponseType)md.Run();       
		md.Destroy(); 
		return tp;
	}
}
