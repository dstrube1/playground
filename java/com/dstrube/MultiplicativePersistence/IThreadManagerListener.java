package com.dstrube.MultiplicativePersistence;

/*
This is the interface that a class must implement so that its child threads can let the 
parent thread know when they're done, and so the parent thread can handle those completions.

From ~/java:

Compile:
javac -d bin com/dstrube/MultiplicativePersistence/IThreadManagerListener.java
*/

public interface IThreadManagerListener {
   	void notifyOfThreadManagerProgress(final Thread thread);
   	void notifyOfThreadComplete(final Thread thread);
}