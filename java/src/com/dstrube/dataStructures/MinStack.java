package com.dstrube.dataStructures;

/*
commands to compile and run:
from ~/Projects/java
javac -d ~/Projects/java/bin com/dstrube/dataStructures/MinStack.java 
java -cp ~/Projects/java/bin com.dstrube.dataStructures.MinStack
*/

import java.util.Stack;
import java.util.EmptyStackException;

/**
 *
 */
public class MinStack extends Stack {

    private Stack<Integer> mMin;
    public static final Integer NO_MIN = Integer.MAX_VALUE;

    public MinStack(){
        super();
        mMin = new Stack<>();
    }

    public Integer peek(){
        return Integer.valueOf(super.peek().toString());
    }

    public Integer push(Integer i){
    	if (null == mMin) mMin = new Stack<>();
    	
        if (size() == 0) {
            mMin.push(i);
        } else if (mMin.peek() <= i) {
        	//Splitting this up for debugging
        	mMin.push(i);
        }
        return Integer.valueOf(super.push(i).toString());
    }

    public Integer pop(){
        if (mMin.peek() != null && mMin.peek() == peek()){
            mMin.pop();
        }
        return Integer.valueOf(super.pop().toString());
    }

    public Integer min(){
        if (mMin.size() == 0){
            return NO_MIN;
        }
        return mMin.peek();
    }
    
    ///////////////////////////////////////////////////////
    //TESTING
    ///////////////////////////////////////////////////////
    
    private static MinStack mMinStack;
    
    public static void main(String[] args){
    	mMinStack = new MinStack();
    	testPush();
    	mMinStack = new MinStack();
    }
    
    public static void testPush() {
    	if (mMinStack == null){
    		System.out.println("mMinStack is null, #1");
    		return;
    	}
        boolean exceptionThrown = false;

        try {
            mMinStack.push(null);
        } catch (NullPointerException e){
            exceptionThrown = true;
        }
        if (!exceptionThrown){
        	System.out.println("MinStack.push() should throw an exception when pushing a null.");
        	return;
        }
        //assertTrue("MinStack.push() should throw an exception when pushing a null.", exceptionThrown);

    	if (mMinStack == null){
    		System.out.println("mMinStack is null, #2");
    		return;
    	}
    	final Integer pushing = 0;
        if (pushing == null){
    		System.out.println("pushing is null");
    		return;
    	}
    	//mMinStack = new MinStack();
    	Integer pushed = 10;
    	if (pushed == null){
    		System.out.println("pushed is null");
    		return;
    	}
		pushed = mMinStack.push(pushing);
        if (mMinStack.peek() == null){
        	System.out.println("MinStack.peek() should be not null after pushing a non null.");
        	return;
        }
        if (pushed != pushing){
        	System.out.println("pushed should be equal to pushing after push.");
        	return;
        }
        
        System.out.println("Done with testPush");
    }
    
    public static void testPop() {
        boolean exceptionThrown = false;

        try {
            mMinStack.pop();
        } catch (NullPointerException e){
            exceptionThrown = true;
        }
        //assertTrue("MinStack.pop() should throw an exception when popping before a push.", exceptionThrown);

        final int pushed = 1;
        mMinStack.push(pushed);
        final int popped = mMinStack.pop();
        //assertTrue("popped should equal pushed", pushed == popped);
    }

    public static void testPeek() {
        boolean exceptionThrown = false;
        try {
            mMinStack.peek();
        } catch (EmptyStackException e){
            exceptionThrown = true;
        }
        //assertTrue("MinStack.peek() should throw exception before pushing.", exceptionThrown);

    }
    
    public void testMin() {
    }

}
