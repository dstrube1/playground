package com.dstrube.nodeStuff;

/*
commands to compile and run:
from ~/Projects/java
javac -d ~/Projects/java/bin com/dstrube/nodeStuff/Node.java 
java -cp ~/Projects/java/bin com.dstrube.nodeStuff.Node
*/
import java.util.Stack;

public class Node implements Cloneable {

	public static void main(String[] args){
        Node nA = setOriginal();
		
		System.out.println("original nA: " + nA);
		Node reversed = ReverseHugeLinkedList(nA);
		System.out.println("printing reversed without using a stack: " + reversed);
		System.out.println("printing nA: " + nA);
		
		System.out.println("resetting nA...");
		nA = setOriginal();
		
		System.out.println("original nA: " + nA);
		reversed = ReverseLinkedListWithStack(nA);
		System.out.println("printing reversed with using a stack: " + reversed);
		System.out.println("printing nA: " + nA);
		
		
	}
	
	static Node setOriginal(){
		Node nA = new Node();
        Node nB = new Node();
        Node nC = new Node();
        Node nD = new Node();
        Node nE = new Node();
        nA.value = "a";
        nB.value = "b";
        nC.value = "c";
        nD.value = "d";
        nE.value = "e";
        nA.next = nB;
        nB.next = nC;
        nC.next = nD;
        nD.next = nE;
        
        return nA;
	}
	
	static Node ReverseLinkedListWithStack(Node list) {
		if (list == null || list.next == null) {
            return list;
        }
        
        //This results in the original list turning to 
        //a -> b -> c -> d -> e -> d -> c -> b -> a -> 
        //Node listClone = (Node) list.clone();

        //This results in the original list turning to 
        //a -> b -> c -> d -> e -> d clone -> c clone -> b clone -> a clone clone -> 
//        Node listClone = new Node(list);

		//On second thought, we can do this without making a new Node listClone.
		//This can be done using list without affecting the original

        final Stack<Node> stack = new Stack<>();
        Node node;
        while (list.next != null) {
            //node = (Node) listClone.clone();
            node = new Node(list);
            node.next = null;
            stack.push(node);
            list = list.next;
        }
        // stack has all but one of the nodes
        // list points to last / first node
        Node result = new Node(list);
        //keep the root so we return the right node
        final Node resultRoot = result;
        
        while (!stack.empty()) {
            result.next = stack.pop();
            result = result.next;
        }
        return resultRoot;
	}

	//Reverses Linked list without a stack, and doesn't mess up the input
	static Node ReverseHugeLinkedList(Node list) {
        if (list == null || list.next == null) {
            return list;
        }
        //This is the list of nodes reversed
        Node reversed = null;
        Node reversedPrevious;

        //This is what gets tacked on to the reversed list as we go along
        Node tackOn;

        while (list.next != null) {
//            tackOn = (Node) list.clone();
			tackOn = new Node(list);
            tackOn.next = null;
            if (null == reversed) {
                reversedPrevious = tackOn;
            } else {
                reversedPrevious = reversed;
            }
            //reversed = (Node) list.next.clone();
            reversed = new Node(list.next);
            reversed.next = reversedPrevious;
            list = list.next;
        }
        return reversed;
	}

//Actual class stuff
	//Default constructor
	public Node(){}
	
	//Copy constructor
	public Node (final Node another){
		this.value = another.value + " clone";
		//If we don't have this line, 
		//then the copy we make will only have itself with no children
		this.next = another.next;
	}
	
	String value;
	Node next;

	public String toString(){
		if (next != null && next.value.equals(value)) return value + " -> " + value;
		return value + " -> " + ((next != null) ? next.toString() : "");
	}
	
	//Implementing Cloneable
	public Object clone() {
        Object o = null;
        try {
            o = super.clone();
            //Can't do this
//            o.value += " clone ";
        } catch (CloneNotSupportedException ex) {
        	System.out.println("CloneNotSupportedException");
        } catch (Exception e) {
        	System.out.println("Exception: " + e.getMessage());
        }
        return o;
    }
}