/*
From ~/java:

javac -d bin com/dstrube/Permutes.java
java -cp bin com.dstrube.Permutes

Given “n” number of elements, list all permutations.)

Input example: data = {'a', 'b', 'c' }
Output example: abc, acb, bac, bca, cba, cab

takes O(n!) time
*/

package com.dstrube;

import java.util.Collections;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

public class Permutes {

	public static void main(String[] args) {
		char[] arr = null;
		System.out.println("Testing null");
		printPermutations(arr);

		System.out.println("Testing {}");
		arr = new char[] {};
		printPermutations(arr);

		System.out.println("Testing {a}");
		arr = new char[] {'a'};
		printPermutations(arr);

		System.out.println("Testing {a,b}");
		arr = new char[] { 'a', 'b' };
		printPermutations(arr);

		System.out.println("Testing {a,b,c}");
		arr = new char[] {'a','b','c'};
		printPermutations(arr);
		
		System.out.println("Using Collections: ");
		List<Character> list = new ArrayList<>();
		list.add('a');
		list.add('b');
		list.add('c');
		
		printCollectionPermutations(list);
	}

	static void printPermutations(char[] arr)
	{
		if (arr == null) { 
			System.out.println("No permutations");
			return;
		}
		permutationUtil(arr, 0);
	}


	static void permutationUtil(char[] arr, int index)
	{
		if (index >= arr.length - 1)
		{ //If we are at the last element - nothing left to permute
		  //System.out.println(Arrays.toString(arr));
		  //Print the array
			System.out.print("[");
			for (int i = 0; i < arr.length - 1; i++)
			{
				System.out.print(arr[i] + ", ");
			}
			if (arr.length > 0)
				System.out.print(arr[arr.length - 1]);
			System.out.println("]");
			return;
		}

		for (int i = index; i < arr.length; i++)
		{ //For each index in the sub array arr[index...end]

			//Swap the elements at indices index and i
			char t = arr[index];
			arr[index] = arr[i];
			arr[i] = t;

			//Recurse on the sub array arr[index+1...end]
			permutationUtil(arr, index + 1);

			//Swap the elements back
			t = arr[index];
			arr[index] = arr[i];
			arr[i] = t;
		}
	}
	
	static void printCollectionPermutations(List<Character> list){
		permutationCollectionUtil(list, 0);
	}
	
	static void permutationCollectionUtil(List<Character> arr, int k){
        for(int i = k; i < arr.size(); i++){
            Collections.swap(arr, i, k);
            permutationCollectionUtil(arr, k+1);
            Collections.swap(arr, k, i);
        }
        if (k == arr.size() - 1){
            System.out.println(Arrays.toString(arr.toArray()));
        }
    }

}


