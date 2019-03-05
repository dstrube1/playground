/*
Author: David Strube
Date: 2019-03-02

Compile:
javac -d bin com/dstrube/gtri/Question2.java
Run:
java -cp bin com.dstrube.gtri.Question2

Given this tree:
              C
            / | \
           /  |  \
          E   F   S
         / \     / \
        H   B   P   D

This implements
(a) a method that, when given this tree, returns "C E H B F S P D".

(b) a second method that returns "C E F S H B P D" given the same tree.

*/

package com.dstrube.gtri;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Stack;

public class Question2{

	public static void main(String[] args)
	{
		//Create all nodes
		final Node nodeC = new Node("C");
		final Node nodeE = new Node("E");
		final Node nodeF = new Node("F");
		final Node nodeS = new Node("S");
		final Node nodeH = new Node("H");
		final Node nodeB = new Node("B");
		final Node nodeP = new Node("P");
		final Node nodeD = new Node("D");
		
		//Link all nodes into a tree
		final RootedTree tree = new RootedTree();

		tree.root = nodeC; 
		
		tree.root.children.add(nodeE);//root child 0
		tree.root.children.add(nodeF);//root child 1
		tree.root.children.add(nodeS);//root child 2
				
		tree.root.children.get(0).children.add(nodeH);
		tree.root.children.get(0).children.add(nodeB);
		
		tree.root.children.get(2).children.add(nodeP);
		tree.root.children.get(2).children.add(nodeD);
		
		//Show depth first
		System.out.println(listDepthFirst(tree.root));

		//Show breadth first
		System.out.println(listBreadthFirst(tree.root));
	}

	public static String listDepthFirst(final Node node)
	{ 
		final Stack<Node> stack = new Stack<>();
		final StringBuilder stringBuilder = new StringBuilder();
		stack.push(node);
		while (! stack.isEmpty())
		{
			final Node tempNode = stack.pop();
			stringBuilder.append(tempNode.name);
			stringBuilder.append(" ");
			//Must add these to the stack in reverse order.
			//Otherwise they will append to stringBuilder in the wrong order. 
			for (int i = tempNode.children.size() - 1; i >= 0; i--)
			{
				stack.push(tempNode.children.get(i));
			}
		}
		return stringBuilder.toString();
	}

	public static String listBreadthFirst(final Node node)
	{
		//https://docs.oracle.com/javase/7/docs/api/java/util/Deque.html
		final Deque<Node> deque = new ArrayDeque<>();
		final StringBuilder stringBuilder = new StringBuilder();
		deque.add(node);
		while (! deque.isEmpty())
		{
			final Node tempNode = deque.remove();
			stringBuilder.append(tempNode.name);
			stringBuilder.append(" ");
			for (Node child : tempNode.children)
			{
				deque.add(child);
			}
		}
		return stringBuilder.toString();
	}

}
