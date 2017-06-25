package com.dstrube.test;

/*
commands to compile and run:
from ~/workspace/java
javac -d C:\Users\Unbounded\workspace\java\bin com\dstrube\test\Solution.java 
java -cp C:\Users\Unbounded\workspace\java\bin com.dstrube.test.Solution
*/

import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {
	
	static class Node {
     int data;
     Node next;
  }
  static int CompareLists(Node headA, Node headB) {
    // This is a "method-only" submission. 
    // You only need to complete this method 
    if (sizeOfList(headA) != sizeOfList(headB)){
        return 0;
    }
    if (headA == null && headB == null){
        return 1;
    }
    boolean nonMatchFound = false;
    if (headA.data != headB.data) nonMatchFound = true;
    while (!nonMatchFound || headA.next == null){
        headA = headA.next;
        headB = headB.next;
		if (headA == null && headB == null){
			break;
		}
        if (headA.data != headB.data) nonMatchFound = true;
    }
    if (nonMatchFound) return 0;
    return 1;
}

static int sizeOfList(Node node){
    if (node == null)
        return 0;
    int count = 1;
    while(node.next != null) {
        count++;
        node = node.next;
    }
    
    return count;
}

    public static void main(String[] args) {
		//TODO come back to this.
		//Compare two linked lists
		//https://www.hackerrank.com/challenges/compare-two-linked-lists
		Node headA = new Node();
		Node headB = new Node();
		headA.data = 4;
		headB.data = 4;
		System.out.println(CompareLists(headA, headB));
    }
	
	private void old(){
		//Insert a Node at the Tail of a Linked List
		//https://www.hackerrank.com/challenges/insert-a-node-at-the-tail-of-a-linked-list
		/*
		Node Insert(Node head,int data) {
// This is a "method-only" submission. 
// You only need to complete this method. 
  if (head == null) {
      head = new Node();
      head.data = data; 
      return head;
  }
    Node next, last;
    last = new Node();
    last.data = data;
        
    if (head.next == null){
        head.next = last;
    } else {
        next = head.next;
        while (next.next != null){
            next = next.next;
        }
        next.next = last;
    }
    return head;
}
		*/

		//Print the Elements of a Linked List
		//https://www.hackerrank.com/challenges/print-the-elements-of-a-linked-list
		/*
  Print elements of a linked list on console 
  head pointer input could be NULL as well for empty list
  Node is defined as 
  class Node {
     int data;
     Node next;
  }
*/
/*
// This is a "method-only" submission. 
// You only need to complete this method.   
void Print(Node head) {
    if (head == null) return;
    Node node = head;
    do{
        System.out.println(node.data);
        node = node.next;
    }while(node.next != null);
  System.out.println(node.data);
}
*/

		//Diagonal Difference
		/*
		int n = 3;
		//Scanner in = new Scanner(System.in);
		int a[][] = {{11,2,4},{4,5,6},{10,8,-12}};//new int[n][n];

		int firstSum = 0;
        for(int i=0; i < n; i++){
			firstSum += a[i][i];
        }
		int secondSum = 0;
		int j = n-1;
		for(int i = 0; i < n; i++){
			secondSum += a[i][j--];
		}
		int diff = Math.abs(firstSum - secondSum);
		System.out.print(diff);
		*/
		
		//Time Conversion 
		//Scanner in = new Scanner(System.in);
		//String time = in.next();
		//https://www.hackerrank.com/challenges/time-conversion
		/*
		String time0 = "12:00:00AM";
		int firstColon = time0.indexOf(":");
		int hour = Integer.valueOf(time0.substring(0,firstColon));
		int AMPM = time0.indexOf("PM");
		boolean isPM = AMPM != -1;
		if (!isPM){
			AMPM = time0.indexOf("AM");
			if (hour == 12) hour = 0;
		}
		String time1 = time0.substring(firstColon, AMPM);
		if (isPM) {
			if (hour != 12) hour += 12;
		}
		if (hour < 10) {
			time1 = "0" + hour + time1;
		} else {
			time1 = "" + hour + time1;
		}
        System.out.println(time1);
		*/
		
		//Staircase
        //Scanner in = new Scanner(System.in);
		//int n = in.nextInt();
		/*
        for (int i = 1; i <= n; i++){
            for (int j = n - i; j > 0; j--){
                System.out.print(" ");
            }
            for (int k = 0; k < i; k++){
                System.out.print("#");
            }
            System.out.println();
        }
		*/
		
		//PlusMinus
		/*
		Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        int arr[] = new int[n];
        int posCount = 0;
        int negCount = 0;
        int zeroCount = 0;
        for(int arr_i=0; arr_i < n; arr_i++){
            arr[arr_i] = in.nextInt();
            if (arr[arr_i] > 0){
                posCount++;
            } else if (arr[arr_i] < 0){
                negCount++;
            } else {
                zeroCount++;
            }
        }
        System.out.println((float)posCount/n);
        System.out.println((float)negCount/n);
        System.out.println((float)zeroCount/n);
		*/
	}
}
