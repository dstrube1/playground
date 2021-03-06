//Bowling in java
//DS 2014-02-03

package com.dstrube;

import java.io.*;

public class Bowling {

	private static final char SPARE = '/';
	private static final char STRIKE = 'x';
	private static final char GUTTER = '-';
	
	public static void main(String[] args) {
		InputStreamReader isr = new InputStreamReader(System.in);  
		BufferedReader br = new BufferedReader(isr);
		String input = "";
		
		while (true){
			//This will return when an invalid sequence is entered, like "done", 
			//or "Okay, I've had enough of this game. Please let me go now.".
			System.out.println("Please enter the sequence of rolls.");
			
			try{
				input = br.readLine();
			} catch (IOException e){
				System.out.println(e.getMessage());
			}
			
			if (input == "" || input.length() ==0){ //newline != "", but it does have length === 0
				System.out.println("You entered nothing. Exiting");
				return;
			}//else{
//				System.out.println("Length = "+input.length()+". You entered: '"+input+"'");
//			}
			if (! hasOnlyValidCharacters(input)){
				System.out.println("You entered a sequence that has an invalid character. Exiting.");
				return;
			}
			
			int total = parse(input);
			System.out.println("Total = " + total);
		}
	}
	
	public static int parse(String input) {
		char c = Character.UNASSIGNED;
		char c1back = Character.UNASSIGNED;
		//char c2back = Character.UNASSIGNED;
		char c1ahead = Character.UNASSIGNED;
		char c2ahead = Character.UNASSIGNED;
		int total = 0;
		//checking for CORRECT number of frames != checking for number of frames  
		int frame = 1;
		boolean prevRollWasNumber = false;
		boolean beginningOfFrame = true;
		int j = 0;
		
		if (input == null || input.length() == 0){
			return 0;
		}
		input = input.toLowerCase();
		
		if (!hasOnlyValidCharacters(input)){
			return 0;
		}
		
		if(input.length()==1){
			return getCharacterValue(input.charAt(0));
		}
		
		for (int i = 0; i< input.length(); i++){
			
			c=input.charAt(i);
			if (i + 1 < input.length()){
				c1ahead = input.charAt(i + 1);
			}else{
				c1ahead = Character.UNASSIGNED;
			}
			if (i + 2 < input.length()){
				c2ahead = input.charAt(i + 2);
			}else{
				c2ahead = Character.UNASSIGNED;
			}

			if(i == 0){
				c1back = Character.UNASSIGNED;
			}else{
				c1back = input.charAt(i-1);
			}
			//oops, this was unnecessary
//			if(i-2 > 0){
//				c2back = input.charAt(i-2);
//			}else{
//				c2back = Character.UNASSIGNED;
//			}
			
			j = getCharacterValue(c);
			
			if (c == STRIKE && i == input.length() - 3 && frame == 10) {
				//handle special case of strike at end of game
				return total + j + getCharacterValue(c1ahead) + getCharacterValue(c2ahead);
			}
			else if (c == SPARE && i == input.length() - 2 && frame == 10) {
				//handle special case of spare at end of game
				return total + j + getCharacterValue(c1ahead);
			}else if (c == STRIKE ){ //&& i < input.length() - 3){
				if (c2ahead == SPARE){ //if next two chars are 5 and /, ignore the 5
					total+= j + getCharacterValue(c2ahead);
				}
				else{// (c1ahead == 'x' && c2ahead == 'x'){
					total+= j + getCharacterValue(c1ahead) + getCharacterValue(c2ahead);
				}
			}
			//is this taken care of by the last else?
//			else if (c == STRIKE && i < input.length() - 2){
//				total+= j + getCharacterValue(c1ahead);
//			}
			else if (c == SPARE ){ //&& i < input.length() - 2){
				total+= j + getCharacterValue(c1ahead);
			}
			//this is taken care of by the last else
//			else if (c == SPARE ) { //&& i < input.length() - 1){
//				total+= j;
//			}
			else if (c1ahead == SPARE) {
				//if this is part of a spare frame, ignore it
			}else{
				total += j;
			}
			
			prevRollWasNumber = isCharPostiveNumber(c1back);
			if (!beginningOfFrame && prevRollWasNumber && isCharPostiveNumber(c)){
				beginningOfFrame  = true;
				frame++;
			}
			else if (c == SPARE || c == STRIKE){
				beginningOfFrame  = true;
				frame++;
			}else{
				beginningOfFrame  = false;
			}
			
		}
		return total;
	}

	//This is not the same as testing to see if it is a valid sequence. This only looks for invalid characters.
	//Difference? This doesn't check for valid lengths. This game can last years.
	public static boolean hasOnlyValidCharacters(String s){
		
		if (s == null || s.length() == 0){return false;}
		
		String sLower = s.toLowerCase();
		char c = Character.UNASSIGNED;
		boolean invalidFound = false;
		//int j = 0;
		
		for (int i = 0; i < s.length(); i++){
			c = sLower.charAt(i);
//			j = 0;
//			try {
//				j = Integer.parseInt(sLower.substring(i,i+1)); //even good at i=length
//			}
//			catch (NumberFormatException e){
//				//System.out.println(e.getMessage());
//			}
//			
//			if (c == '0'){return false;} //invalid number

			if (c != STRIKE && c != SPARE && c != GUTTER && ! isCharPostiveNumber(c)){
				//System.out.println("Not a valid sequence: " + s);
				//return false;
				//^ that's too elegant and easy; let's do this a little differently:
				invalidFound = true; 
				break;
            }
        }
		//return true;
		return !invalidFound;
	}
	
	public static boolean isCharPostiveNumber(char c){
		int j = 0;
		try {
			j = Integer.parseInt(String.valueOf(c)); 
		}
		catch (NumberFormatException e){
			//System.out.println(e.getMessage());
		}
		if (j==0){
			return false;
		}
		return true;
	}

	public static int getCharacterValue(char c){
		
		c = String.valueOf(c).toLowerCase().charAt(0);
		
		if (c == Character.UNASSIGNED || c == GUTTER){
			return 0;
		}
		if (c == STRIKE || c == SPARE){
			return 10;
		}

		//else: some single digit integer
		int i = 0;
		String s = String.valueOf(c);
		try {
			i = Integer.parseInt(s); 
		}
		catch (NumberFormatException e){
			//if it's not a number, fail quietly
		}
		return i;
	}
}
