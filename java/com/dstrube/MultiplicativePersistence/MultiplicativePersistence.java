/*
#Author: David Strube
#Date: 2019-03-22

From ~/java:

Compile:
javac -d bin com/dstrube/MultiplicativePersistence/MultiplicativePersistence.java
Run:
java -cp bin com.dstrube.MultiplicativePersistence.MultiplicativePersistence

#According to this:
#https://www.youtube.com/watch?v=Wim9WJeDTHQ
#There is a conjecture that 11 is the limit

2019-05-01:
Another improvement:
v0 = use longs
v1 = use BigInteger
v2 (this): use improved incrementing algorithm
4- Changed algorithm for incrementing to the next number to check (instead of simple i++): 
	find rightmost digit that isn't 9, increment it, repeat; this assumes numbers being checked are already in ascending order
	This also requires a revision to how we limit the ranges per thread (hence v2)

2019-05-04:
5- split code out into separate classes for two reasons:
	a- instead of one big hunk of code doing everything, lots of little hunks doing small but important something(s)
	b- needed a non-static context to pass a callback when threads are created 
		so that threads could notify their creator that they're done, and their creator could handle any results
*/

package com.dstrube.MultiplicativePersistence;

import java.util.concurrent.ConcurrentHashMap;
//https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ConcurrentHashMap.html
import java.util.concurrent.atomic.AtomicReferenceArray;
import java.util.Random;
//https://docs.oracle.com/javase/8/docs/api/java/util/Random.html
import java.util.ArrayList;
import java.util.List;

//https://docs.oracle.com/javase/7/docs/api/javax/swing/package-summary.html
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.WindowConstants;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Dimension;

import java.awt.GridLayout;
import java.math.BigInteger;

public class MultiplicativePersistence extends JFrame implements IThreadManagerListener{
	
	private static final ConcurrentHashMap<String,String> startingTemplates = new ConcurrentHashMap<>();
	private static final ConcurrentHashMap<String,JLabel> threadStatuses =  new ConcurrentHashMap<>();
	private static AtomicReferenceArray<String> completedThreads;
	private static final String EMPTY = "";
	private static volatile boolean isAnotherThreadNotifying = false;
	private static final Random random = new Random();
	
	private JPanel jContentPane = null;
	private final JPanel panel = new JPanel();
	
	public MultiplicativePersistence(final int labelCount){
        super();
        initialize(labelCount);
	}
	
	private void initialize(final int labelCount) {
        this.setSize(500, 300);
        this.setContentPane(getJContentPane(labelCount));
        this.setTitle("MultiplicativePersistence");
    }
	
	private JPanel getJContentPane(final int labelCount) {
        if (jContentPane == null) {
            jContentPane = new JPanel();
            jContentPane.setLayout(new GridLayout(0, 3));//null);

            panel.setBounds(100,100,100,100);//61, 11, 81, 140);
            panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
            jContentPane.add(panel);

    		for (int i = 0; i < labelCount; i++){
    			final String name = "thread"+i;
				final JLabel label = new JLabel(name);
// 				label.setMinimumSize(new Dimension(label.getHeight(), 250));
				threadStatuses.put(name, label);
	            panel.add(label);
			}
			final JLabel label = new JLabel("Complete:");
	        panel.add(label);
			
			/*JButton button = new JButton("Update");
			button.addActionListener(new ActionListener(){  
				public void actionPerformed(ActionEvent e){  
		            threadStatuses.get("thread0").setText("blah");
		        }  
		    });
			panel.add(button);*/
        }
        return jContentPane;
    }
    
    public void notifyOfThreadManagerProgress(final Thread thread){
    	JLabel label = threadStatuses.get(thread.getName());
// 		label.setMinimumSize(new Dimension(label.getHeight(), 250));
		final NotifyingThread notifyingThread = (NotifyingThread) thread;
		final BigInteger start = notifyingThread.getStart();
		final BigInteger end = notifyingThread.getEnd();
		final BigInteger progress = notifyingThread.getProgress();
		//1: Get count of all same digits after 1st digit in start
		//2: Get count of that digit in progress that 
		//3: % changed = % done
		char c = start.toString().charAt(1);
		double startCount = start.toString().chars().filter(ch -> ch == c).count();
		double progressCount = progress.toString().chars().filter(ch -> ch == c).count();
		double percentDone = 100 - (100 * (progressCount / startCount));
		System.out.println(thread.getName() + " is " + percentDone + "% done");
		StringBuilder sb = new StringBuilder();
		sb.append(thread.getName());
		sb.append("(");
		sb.append(start.toString().substring(0,2));
		sb.append(":");
		sb.append(start.toString().length());		
		sb.append(") - ");
		try{
			if ((""+percentDone).indexOf(".") != -1){
				sb.append((""+percentDone).substring(0, (""+percentDone).indexOf(".")+2));
			}
			else{
				sb.append(""+percentDone);
			}
		}catch(StringIndexOutOfBoundsException stringIndexOutOfBoundsException){
			sb.append("error");
			System.out.println("Caught stringIndexOutOfBoundsException: percentDone = " + percentDone);
		}
		
		sb.append("% done");
    	label.setText(sb.toString());
    }
    
    public void notifyOfThreadComplete(final Thread thread){
		try{
			final int sleep = 100 + random.nextInt(900);
			if (isAnotherThreadNotifying){
// 				System.out.println(thread.getName() + " is waiting, locked out by " + lockedBy.get() + "; sleeping for " + sleep);
			}
			while (isAnotherThreadNotifying){
				thread.sleep(sleep);
			}
		}catch(InterruptedException interruptedException){
			System.out.println("Caught InterruptedException: " + interruptedException);
		}
		isAnotherThreadNotifying = true;
    	if (!completedThreads.get(completedThreads.length()-1).equals(EMPTY)){
//     		make arraylist, populate it with all values, then put them in new this:
//     		completedThreads = new AtomicReferenceArray<>(completedThreads.length()+10);
			final List<String> strings = new ArrayList<>();
			for(int i= 0; i<completedThreads.length(); i++){
				strings.add(completedThreads.get(i));
			}
			completedThreads = new AtomicReferenceArray<String>(completedThreads.length() + 10);
			int index = 0;
			for(String string : strings){
				completedThreads.set(index, string);
				index++;
			}
    	}
    	boolean added = false;
    	final NotifyingThread notifyingThread = (NotifyingThread) thread;
		final BigInteger start = notifyingThread.getStart();
    	for (int i = 0; i < completedThreads.length(); i++){
    		final String completedThread = completedThreads.get(i);
    		if (completedThread.equals(EMPTY)){
    			StringBuilder sb = new StringBuilder();
				sb.append(thread.getName());
				sb.append("(");
				sb.append(start.toString().substring(0,2));
				sb.append(":");
				sb.append(start.toString().length());		
				sb.append(")");
				final JLabel label = new JLabel(sb.toString());
	            panel.add(label);
    			added = true;
    			break;
    		}
    	}
    	if (!added){
    		System.out.println("Warning: No line added for this thread: " + notifyingThread.getName());
    	}
    	isAnotherThreadNotifying = false;
    }
	
	public static void main(String[] args) {
		setStartingTemplates();
		
		final int numOfTrailingDigits = 100; //if more than billions of digits, then change this (and all comparisons to it) to long
		final int limitTrailingDigits = 101;
		final int processors = Runtime.getRuntime().availableProcessors();
// 		System.out.println("processors: " + processors);
        
        completedThreads = new AtomicReferenceArray<>(1);
        completedThreads.set(0, EMPTY);

		ThreadManager.getInstance().setProcessors(processors);
		ThreadManager.getInstance().setTrailingDigits(numOfTrailingDigits, limitTrailingDigits);
		ThreadManager.getInstance().setStartingTemplates(startingTemplates);
		ThreadManager.getInstance().doStuff();
		
		final int labelCount = ThreadManager.getInstance().getIndexLimit();
		
		MultiplicativePersistence frame = new MultiplicativePersistence(labelCount);
		ThreadManager.getInstance().setListener(frame);
		frame.setVisible(true);
        frame.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
	}
	
	private static void setStartingTemplates(){
		//start (inclusive) => end (inclusive) 
		//2+6 => 3+4
		//3+4 => 4+4
		//4+4 => 5+7
		//5+7 => 6+6
		//6+6 => 7+7
		//7+7 => 8+8
		//8+8 => 9+9
		startingTemplates.put("26","27");
		startingTemplates.put("27","28");
		startingTemplates.put("28","29");
		startingTemplates.put("29","30");
		startingTemplates.put("34","35");
		startingTemplates.put("35","36");
		startingTemplates.put("36","37");
		startingTemplates.put("37","38");
		startingTemplates.put("38","39");
		startingTemplates.put("39","40");
		startingTemplates.put("44","45");
		startingTemplates.put("46","47");
		startingTemplates.put("47","48");
		startingTemplates.put("48","49");
		startingTemplates.put("49","50");
		startingTemplates.put("55","56");
		startingTemplates.put("57","58");
		startingTemplates.put("59","60");
		startingTemplates.put("66","67");
		startingTemplates.put("67","68");
		startingTemplates.put("68","69");
		startingTemplates.put("69","70");
		startingTemplates.put("77","80");
		startingTemplates.put("88","99");	
	}
}






