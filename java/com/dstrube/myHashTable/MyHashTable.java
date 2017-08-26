package com.dstrube.myHashTable;

import java.util.ArrayList;
import java.util.List;

public class MyHashTable {

	public static void main(String[] args){
    	
		System.out.println("");
		System.out.println("done");
		
	}
	
//Actual class stuff
	List buckets;
	String value;
	//To successfully store and retrieve objects from a hashtable, 
	//the objects used as keys must implement the hashCode method and the equals method.

	//Default constructor
	public MyHashTable(){
		buckets = new ArrayList<>();
	}
	
	public void insert(String key, String value){
		
	}
	public void remove(){}
	public void valueAtKey(){}
	public void keys(){}

	public String toString(){
		
		return value;
	}
	
	private static class MyHashTableEntry<String, String>{
		String key;
		String value;
		int hash;
		MyHashTableEntry next;
		
		MyHashTableEntry<String, String>(String key, String value, int hash, MyHashTableEntry next){
            this.key = key;
            this.value = value;
            this.hash = hash;
            this.next = next;			
		}
	}
}