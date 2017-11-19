/*
From ~/java:

javac -d bin -cp bin/joda-time-2.9.9.jar com/dstrube/ITester.java

???:
java -cp bin com.dstrube.ITester

*/
/*


Compile:
Mac:
javac -d bin -cp bin/joda-time-2.9.9.jar IScraperRow.java 
Windows:
javac -d bin -cp bin\joda-time-2.9.9.jar IScraperRow.java 

*/


package com.dstrube;

import org.joda.time.LocalDate;

public interface ITester {
	public LocalDate date = null;
}