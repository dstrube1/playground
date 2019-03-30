package com.dstrube.dataStructures;

/*
commands to compile and run:
from ~/Projects/java
javac -d bin com/dstrube/dataStructures/DataStructures.java 
java -cp bin com.dstrube.dataStructures.DataStructures
*/

import java.util.ArrayList;
import java.util.List;
import java.util.Hashtable;
import java.util.Stack;

import java.util.ArrayDeque;
import java.util.LinkedList;
import java.util.PriorityQueue;
import java.util.Queue;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ConcurrentLinkedDeque;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.DelayQueue;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.LinkedTransferQueue;
import java.util.concurrent.PriorityBlockingQueue;
import java.util.concurrent.SynchronousQueue;
import java.util.concurrent.ConcurrentHashMap;

public class DataStructures {

	public static void main(String[] args){
    	
    	//doArrayList();
//		System.out.println("");
//		doHashtable();
//		doStack();
//		doQueue();
		doConcurrentHashMap();
		//the only reason to use Hashtable is when a legacy API (from ca. 1996) requires it.
		//https://stackoverflow.com/questions/40471/differences-between-hashmap-and-hashtable
		System.out.println("done");
		
	}
	
	private static void doArrayList(){
        System.out.println("ArrayList:");
        try {
            List list = new ArrayList<>();
            //mixing data types is fine; be careful with datatypes when getting data out
            //Commenting these out for now, just to get quiet compilations; feel free to uncomment later
            //list.add(1);
            //list.add("2");
            for (int i = 0; i < list.size(); i++) {
                System.out.println("list[" + i + "] = " + list.get(i));
            }
        } catch (Exception e){
            System.out.println("exception: " + e.getMessage());
        }

	}
    
    private static void doHashtable(){
        System.out.println("Hashtable:");
        try {
            Hashtable hashtable = new Hashtable<>();
            //Adding duplicates will quietly fail
            //Commenting these out for now, just to get quiet compilations; feel free to uncomment later
            /*hashtable.put(1, "one");
            hashtable.put(2, "two");
            hashtable.put(1, "one");
            hashtable.put(2, "two");
            hashtable.put("one", 1);
            hashtable.put("two", 2);
            hashtable.put("one", 1);
            hashtable.put("two", 2);
            hashtable.put("three", 1);
            hashtable.put("four", 2);
            hashtable.put("5", 1);
            hashtable.put("6", 2);
            hashtable.put("8", 1);
            hashtable.put("7", 2);
            hashtable.put(5, 1);
            hashtable.put(9, 2);*/
            //objects go in / print out randomly; there's no built in sort
            for (Object o : hashtable.keySet()){
                System.out.println("hashtable[" + o.toString() + "] = " + hashtable.get(o));
            }
        } catch (Exception e){
            System.out.println("exception: " + e.getMessage());
        }
    }
    
    private static void doStack(){
        System.out.println("Stack:");
        try{
            Stack<Integer> stack = new Stack<>();
            for (int i = 0; i < 5; i++) {
                System.out.println("Pushing to stack: " + i);
                stack.push(i);
            }
            while (! stack.empty()){
                System.out.println("Popping from stack: " + stack.pop());
            }

        } catch (Exception e){
            System.out.println("exception: " + e.getMessage());
        }

    }
	
	private static void doQueue(){
	
	    Queue arrayBlockingQueue	 = new ArrayBlockingQueue(1);//capacity must be > 0
	    Queue arrayDeque			 = new ArrayDeque();
	    Queue priorityQueue			 = new PriorityQueue();
	    Queue linkedList			 = new LinkedList();
	    Queue concurrentLinkedDeque	 = new ConcurrentLinkedDeque(); //Android requires API 21
	    Queue concurrentLinkedQueue	 = new ConcurrentLinkedQueue();
	    Queue delayQueue			 = new DelayQueue();
	    Queue linkedBlockingDeque	 = new LinkedBlockingDeque();
	    Queue linkedBlockingQueue	 = new LinkedBlockingQueue();
	    Queue linkedTransferQueue	 = new LinkedTransferQueue(); //Android requires API 21
	    Queue synchronousQueue		 = new SynchronousQueue();
	    Queue priorityBlockingQueue	 = new PriorityBlockingQueue();
	    
	    List list = new ArrayList<>();
	    //Commenting these out for now, just to get quiet compilations; feel free to uncomment later
	    /*list.add(arrayBlockingQueue); 	//0
	    list.add(arrayDeque);			//1
	    list.add(priorityQueue);		//2
	    list.add(linkedList);			//3
	    list.add(concurrentLinkedDeque);//4
	    list.add(concurrentLinkedQueue);//5
	    list.add(delayQueue);			//6
	    list.add(linkedBlockingDeque);	//7
	    list.add(linkedBlockingQueue);	//8
	    list.add(linkedTransferQueue);	//9
	    list.add(synchronousQueue);		//10
	    list.add(priorityBlockingQueue);//11*/
	    String[] queueNames = {
	    	"arrayBlockingQueue",	//0
	    	"arrayDeque",			//1
	    	"priorityQueue",		//2
	    	"linkedList",			//3
	    	"concurrentLinkedDeque",//4
	    	"concurrentLinkedQueue",//5
	    	"delayQueue",			//6
	    	"linkedBlockingDeque",	//7
	    	"linkedBlockingQueue",	//8
	    	"linkedTransferQueue",	//9
	    	"synchronousQueue",		//10
	    	"priorityBlockingQueue" //11
	    	};
	    
	    for (int i=0; i< list.size(); i++){
	    	System.out.println("adding stuff to " + queueNames[i]);
	    	//Commenting these out for now, just to get quiet compilations; feel free to uncomment later
	    	//list.set(i, forEachQueue((Queue)list.get(i)));
	    }
	    for (int i=0; i< list.size()-1; i++){
	    	System.out.println("removing stuff from " + queueNames[i]);
	    	Queue queue = (Queue)list.get(i);
	    	while (null != queue.peek()){
	    		System.out.println(queue.remove()); 
	    		//ArrayBlockingQueue only has 1;
	    		//all others have all, except for DelayQueue & SynchronousQueue which have none
	    	}
	    }
	    
	    //Are items in the list tied to their originals?
	    System.out.println("removing stuff from priorityBlockingQueue");
    	while (null != priorityBlockingQueue.peek()) {
    		System.out.println(priorityBlockingQueue.remove()); 
    	}
	    //Yes
	    
	    //Investigating synchronousQueue
	    //investigateSynchronousQueue(synchronousQueue);

		//Investigating delayQueue
		//DelayQueue requires object that implements java.util.concurrent.Delayed
		//http://examples.javacodegeeks.com/core-java/util/concurrent/delayqueue/java-util-concurrent-delayqueue-example/
		
		//Investigating priorityQueue
	    
	}
	
	private static Queue forEachQueue(Queue queue){
		try{
			//Commenting these out for now, just to get quiet compilations; feel free to uncomment later
			//queue.add(1);
			try{
				//queue.add(1);
				//queue.add(2);
				//queue.add(3);
				//queue.add(5);
			} catch (IllegalStateException illegalStateException){
				//otherwise ArrayBlockingQueue complains that queue is full on second add
			}
			//queue.offer(8);
		} catch (ClassCastException classCastException){
			//otherwise DelayQueue complains "Integer cannot be cast to java.util.concurrent.Delayed" on first add
		} catch (IllegalStateException illegalStateException){
			//otherwise SynchronousQueue complains that queue is full on first add
		}
		return queue;
	}
	
	private static void investigateSynchronousQueue(Queue synchronousQueue){
		/*
	    System.out.println("adding stuff to synchronousQueue");
        //SynchronousQueue has put, but Queue does not
//        synchronousQueue.put("1");
//        synchronousQueue.put("2");
//        synchronousQueue.put("3");
		//This results in "IllegalStateException: Queue full":
        synchronousQueue.add("1");
        synchronousQueue.add("2");
        synchronousQueue.add("3");
        */
	    //System.out.println("adding stuff to synchronousQueue0");
        SynchronousQueue<String> synchronousQueue0 = new SynchronousQueue<String>();
        System.out.println("synchronousQueue0.size() = " + synchronousQueue0.size());
        System.out.println("synchronousQueue0.isEmpty() = " + (synchronousQueue0.isEmpty() ? "yes" : "no"));
        
        /*
        SynchronousQueue blocks until another thread is ready to take the element, one thread is trying to put.
		http://javarevisited.blogspot.com/2014/06/synchronousqueue-example-in-java.html
        
        try{
        	System.out.println("putting 1...");
	        synchronousQueue0.put("1");
        	System.out.println("putting 2...");
    	    synchronousQueue0.put("2");
        	System.out.println("putting 3...");
        	synchronousQueue0.put("3");
        } catch (InterruptedException interruptedException){
        	System.out.println("caught interruptedException");
        }

		System.out.println("removing stuff from synchronousQueue0");
    	while (null != synchronousQueue0.peek()) {
    		System.out.println(synchronousQueue0.remove()); 
    	}*/
    	
    	Thread producer = new Thread("PRODUCER") { 
    		public void run() { 
    			String event = "FOUR"; 
    			try { 
    				synchronousQueue0.put(event); 
    				// thread will block here 
    				System.out.printf("[%s] published event : %s %n", Thread .currentThread().getName(), event); 
    			} catch (InterruptedException e) { 
    				e.printStackTrace(); 
    			} 
    		} 
    	}; 
    	producer.start(); // starting publisher thread 
    	
    	Thread consumer = new Thread("CONSUMER") { 
    		public void run() { 
    			try { 
    				String event = synchronousQueue0.take(); 
    				// thread will block here 
    				System.out.printf("[%s] consumed event : %s %n", Thread .currentThread().getName(), event); 
    			} catch (InterruptedException e) { 
    				e.printStackTrace(); 
    			} 
    		} 
    	}; 
    	consumer.start(); // starting consumer thread
	}
	
	private static void doConcurrentHashMap(){
		final ConcurrentHashMap<String,String> concurrentHashMap = new ConcurrentHashMap<>();
		concurrentHashMap.put("thread0","blahblahblah");
		//For a more complete example, see MultiplicativePersistence.java
	}
}