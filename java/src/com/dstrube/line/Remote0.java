/*
From ~/java:

javac -d bin com/dstrube/line/Remote0.java
java -cp bin com.dstrube.line.Remote0

Take input of integer N followed by N strings
Output those N strings in an ascending order. Upper case is considered smaller than lower case.

Constraints: 
0 < N <= 100

Example:
Input
3
quick brown Fox

Output:
Fox brown quick

Assume words only contain alphabetical characters
TODO: don't assume that

Test with:
2 a a -> a a
2 a b -> a b
2 b a -> a b
2 a A -> A a
2 A a -> A a
2 a aa -> a aa
2 aa a -> a aa
3 quick brown Fox -> Fox brown quick
*/

package com.dstrube.line;

import java.util.Scanner;

public class Remote0 {

	static int N;
	static String[] words;
	static Scanner scanner = new Scanner(System.in);
	static final String Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	//more efficient would be Hashtable<String,Integer>, where key = letter, and value = index of key
	
	public static void main(String[] args){
		if (args.length < 2){
			setNAndWords();
		} 
		else{
			try{
				N = Integer.parseInt(args[0]);
				checkN();
				if (args.length - 1 != N) setNAndWords();
				else{
					words = new String[N];
					for (int i=1; i< args.length; i++) words[i-1] = args[i];
				}
			} catch (Exception e){
				System.out.println("Caught exception parsing N");
				return;
			}
		}
		
		//ok, now we have N and words; now sort
		if (words.length == 1){
			System.out.println(words[0]);
			return;
		}
		
		sortWords();
		
		for(String w : words) System.out.print(w + " ");
		
		System.out.println();

	}
	
	static void setNAndWords(){
		System.out.println("Input a number:");
		N = scanner.nextInt();
		checkN();
		System.out.println("Input " + N + " words:");
		String input = "";
		while (input.length() == 0) input = scanner.nextLine();
		//strange that we can't just do this:
		//String input = scanner.nextLine();
		words = input.split(" ", N);
		checkWords();
	}
	
	static void checkN(){
		while (N < 0 || N > 100){
			System.out.println("Invalid number. Try again:");
			N = scanner.nextInt();
		}
	}

	static void checkWords(){		
		while (words.length != N || !wordsContainOnlyValidCharacters()){
			System.out.println("Invalid number of words, "
			+ "or a word contained an invalid (non-alphabetical) character. "
			+ "Please enter " + N + " words:");
			String input = "";
			while (input.length() == 0) input = scanner.nextLine();
			words = input.split(" ", N);
		}
	}
	
	static boolean wordsContainOnlyValidCharacters(){
		for(String word : words){
			for(int i = 0; i < word.length(); i++){
				if (!Alphabet.contains(""+word.charAt(i))) return false;
			}
		}
		return true;
	}
	
	static void sortWords(){//bubble sort
		boolean swapped = true;
		
		while (swapped){
			swapped = false;
			for (int i = 1; i < N; i++){
				if (isGreater(words[i-1],words[i])){
					swap(i-1, i);
					swapped = true;
				}
			}
			N--;
		}
	}
	
	static boolean isGreater(String s1, String s2){
		for(int i = 0; i < s1.length(); i++){
			if (s2.length() <= i) return true; // aa > a
			if (Alphabet.indexOf(""+s1.charAt(i)) > Alphabet.indexOf(""+s2.charAt(i))) return true;
			else if (Alphabet.indexOf(""+s1.charAt(i)) < Alphabet.indexOf(""+s2.charAt(i))) return false;
			//else, they're equal; keep looking
		}
		return false; // equal is not greater 
	}
	
	static void swap(int i, int j){
		String temp = words[i];
		words[i] = words[j];
		words[j] = temp;
	}
}