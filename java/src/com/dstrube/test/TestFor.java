package com.dstrube.test;

/*
commands to compile and run:
from ~/Projects/java
javac -d ~/Projects/java/bin com/dstrube/test/TestFor.java 
java -cp ~/Projects/java/bin com.dstrube.test.TestFor
*/

import java.io.IOException;

public class TestFor {
//++i is more efficient than i++
	public static void main(String[] args){
		forTest3();
  }
  
  private static void forTest1(){
  	for (int i=0, j = 10; i < j; i++, j--){
			System.out.println("i = "+i+"; j = "+j);
		}
	}
  private static void forTest2(){
   for (int i = 1; i <= 4; i++) { 
   		for (int j = 1; j <= 5; j++) { 
   			System.out.print("*"); 
   		} 
   	System.out.println();
	}   
  }
  
  //private public Test(){}
  
  private static void forTest3(){
  /**/
	  System.out.println("output of first question:");
	  for (int i=1; i<=10; i++){
	  	for (int j=1;i<=5;j++){
		  	System.out.println(j); //j just gets bigger without stop
	  	}
	  	System.out.println();
	  	try{
	  		System.in.read();
	  	}catch(IOException e){
	  		System.out.println("IOException");
	  	}
	  }
	/**/
	/*  
	  System.out.println("output of second question:");
	  for (int i=1; i<=10; i++){
	  	for (int j=1;j<=5;i++){
	  		System.out.print(j); //j never gets increments, so stays 1
	  	}
	  	System.out.println();
	  }
	  */
  }
}

