package com.dstrube;

/*
commands to compile and run:
from ~/Projects/java
javac -d bin com/dstrube/Basics.java 
java -cp bin com.dstrube.Basics

Some java basics for quick reference
*/
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class Basics{
	public static void main(String[] args){
	/*
		String string = "string";
		//https://docs.oracle.com/javase/7/docs/api/java/lang/String.html
		System.out.println(string);
		System.out.println("length: " + string.length());
		
		int[] array = new int[1];
		//https://docs.oracle.com/javase/tutorial/java/nutsandbolts/arrays.html
		System.out.println(array);
		System.out.println("length: " + array.length);
		for (int i : array){
			System.out.println("element: " + i);
		}	
		for (int i = 0; i < array.length; i++){
			System.out.println("element at " + i + " = " + array[i]);
		}	
	*/	
		//https://docs.oracle.com/javase/8/docs/api/java/util/ArrayList.html
		
		//https://stackoverflow.com/questions/40471/differences-between-hashmap-and-hashtable
		
		//https://www.geeksforgeeks.org/java/
		
		/*
		final List<Integer> list = new ArrayList<>();
		list.add(1);
		for (int i : list){
			System.out.println("element: " + i);
		}	
		manipList(list);
		for (int i : list){
			System.out.println("element: " + i);
		}
		*/
		
			
	}
	
	private static void manipList(List<Integer> list){
		list.add(2);
		final Comparator<Integer> cd = new SortByIntDescending();
		final Comparator<Integer> ca = new SortByIntAscending();
		list.sort(cd);
	}
	
	static final class SortByIntDescending implements Comparator<Integer> 	{ 
    	public int compare(Integer a, Integer b) {
	    	//to sort descending:
	    	return b.compareTo(a);
	    } 
	}
	
	static final class SortByIntAscending implements Comparator<Integer> { 
    	public int compare(Integer a, Integer b) {
	    	//to sort ascending:
	    	return a.compareTo(b);
	    	/* 
			if(a.compareTo(b)>0)
		        return -1;
	        else if(a.compareTo(b)<0)
    	        return 1; 
	        else 
    	        return 0;*/
	    } 
	} 
}