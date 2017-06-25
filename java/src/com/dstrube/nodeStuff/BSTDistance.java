package com.dstrube.nodeStuff;

/*
commands to compile and run:
from ~/workspace/java
javac -d C:\Users\Unbounded\workspace\java\bin com\dstrube\nodeStuff\BSTDistance.java 
java -cp C:\Users\Unbounded\workspace\java\bin com.dstrube.nodeStuff.BSTDistance
*/

//for find distance:
//http://algorithms.tutorialhorizon.com/find-the-distance-between-two-nodes-of-a-binary-tree/
//for everything else:
//http://algorithms.tutorialhorizon.com/binary-search-tree-complete-implementation/

import java.io.*;
import java.util.Scanner;
public class BSTDistance{
public static void main(String args[] ) throws Exception {
    Scanner in = new Scanner(System.in);
    int a = in.nextInt();
    //System.out.println("a: " + a);
    int b = in.nextInt();
    //System.out.println("b: " + b);
    int n = in.nextInt();
    //System.out.println("n: " + n);
    //String intsString = in.next();
    //System.out.println("intsString: " + intsString);
    ///////////////////////////////////////////////////////////
    // Incorrect input! Expected: 4 1 2 3; actual: 4 (newline) 1 (newline) ....
    ///////////////////////////////////////////////////////////
    
    int[] arr = new int[n];
	for (int i=0; i<n; i++){			
        /*
		if (intsString.indexOf(" ") != -1){
			String t = intsString.substring(0, intsString.indexOf(" "));
			arr[i] = Integer.valueOf(t);
			intsString = intsString.substring(intsString.indexOf(" ")+1);
		} else {
			arr[i] = Integer.valueOf(intsString);
		}
        */
        arr[i] = in.nextInt();
	}
    
    BST bst = new BST();
    for (int i = 0; i < n; i++){
        //System.out.println("Inserting " + arr[i]);
        bst.insert(arr[i]);
    }
    
    if (!bst.isInTree(a)|| !bst.isInTree(b)){
        System.out.print("Not found");
        return;
    }
    
    //System.out.println("Distance between " + a + " and " + b + ":");
    System.out.print(bst.findDistance(a,b));
    
}
    static class Node{
        int data;
        Node left;
        Node right;
        public Node(int data){
            this.data = data;
            left = null;
            right = null;
        }
    }
    
    static class BST{
        public Node root;
        
        public BST(){
            this.root = null;
        }
        
        public void insert(int id){
            Node newNode = new Node(id);
            if (root == null){
                root = newNode;
                return;
            }
            Node current = root;
            Node parent = null;
            while(true){
                parent = current;
                if(id < current.data){
                    current = current.left;
                    if (current == null){
                        parent.left = newNode;
                        return;
                    }
                } else {
                    current = current.right;
                    if (current == null){
                        parent.right = newNode;
                        return;
                    }
                }
            }
        }
        
        public boolean isInTree(int id){
            Node current = root;
            while (current != null){
                if (current.data == id){
                    return true;
                }else if (current.data > id){
                    current = current.left;
                }else{
                    current = current.right;
                }
            }
            return false;
        }
        
        public int findDistance(int A, int B){
            if (A == B){return 0;}
            //System.out.println("root: "+root.data);
            int x = pathLen(root, A) - 1;
            //System.out.println("x: "+x);
            int y = pathLen(root, B) - 1;
            //System.out.println("y: "+ y);
            int lcaData = findLCA(root, A, B).data;
            //System.out.println("lcaData: "+ lcaData);
            int lcaDistance = pathLen(root, lcaData)-1;
            //System.out.println("lcaDistance: "+ lcaDistance);
            return (x + y) - 2*lcaDistance;
        }
        
        private int pathLen(Node tempRoot, int i){
            if (tempRoot != null){
                int x = 0;
                if ((tempRoot.data == i) || (x = pathLen(tempRoot.left, i)) > 0 || (x = pathLen(tempRoot.right, i)) > 0){
                    return x + 1;
                }
                return 0;
            }
            return 0;
        }
        
        private Node findLCA(Node tempRoot, int A, int B){
            if (tempRoot != null){
                if (tempRoot.data == A || tempRoot.data == B){
                    return tempRoot;
                }
                Node left = findLCA(tempRoot.left,A,B);
                Node right = findLCA(tempRoot.right,A,B);
                if (left != null && right != null) return tempRoot;
                if (left != null) return left;
                if (right != null) return right;
            }
            return null;
        }
        
    }
}