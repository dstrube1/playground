/*
From ~/java:

javac -d bin com/dstrube/line/Q2.java
java -cp bin com.dstrube.line.Q2

List the nodes of a random binary tree by nodes at the same depth.

*/

package com.dstrube.line;

import java.util.LinkedList;
import java.util.Queue;

class Node{
	public int data;
	public Node left;
	public Node right;
	
	public Node(final int data){
		this.data = data;
		this.left = null;
		this.right = null;
	}
}

public class Q2{

	//Runtime: O(n^2)
	private static void levelListInefficient(final Node root){
		final int h = height(root);
		
		for(int i = 1; i <= h; i++){
 			printLevels(root, i);
 			System.out.println();
 		}
 	}
 	
 	private static void printLevels(final Node root, final int h){
 		if(root == null) return;
 		
 		if(h == 1) System.out.print(" " + root.data);
 		else{
 			printLevels(root.left, h-1);
 			printLevels(root.right, h-1);
 		} 	
    }
    
    private static int height(final Node root){
 		if (root == null) return 0;
 		return 1 + Math.max(height(root.left), height(root.right));
 	}
 	
 	//Runtime: O(n)
 	private static void levelListQueue(final Node root){
 		final Queue queue = new LinkedList();
 		int nodeLevels = 0; 
 		
		if(root == null) return;
 		
 		queue.add(root);
 		
 		while(!queue.isEmpty()){
 			nodeLevels = queue.size();
 			while(nodeLevels > 0) {
				final Node node = (Node)queue.remove();
				System.out.print(" " + node.data);
				if(node.left != null) queue.add(node.left);
				if(node.right != null) queue.add(node.right);
				nodeLevels--;
			}
			System.out.println();
		}
	}
	
	//Get a random int between 1000 and 1
	private static int getRandom(){
		return (int)(Math.random() * 1000 + 1);
	}

	public static void main(String[] args){
		try{
			final Node root = new Node(getRandom());
			root.left = new Node(getRandom());
			root.right = new Node(getRandom());
			root.left.left = new Node(getRandom());
			root.left.right = new Node(getRandom());
			root.right.left = new Node(getRandom());
			root.right.right = new Node(getRandom());

			System.out.println(" Inefficient approach : ");
			levelListInefficient(root);
			System.out.println(" Better approach : ");
			levelListQueue(root);
		}
		catch (Exception e){
			System.out.println("Exception: " + e);
		}
	}

}