/*
Coding tests for Black & Decker

From ~/java:

javac -d bin com/dstrube/BnDFunctions.java
java -cp bin com.dstrube.BnDFunctions

*/

package com.dstrube;

import java.util.Hashtable;

public class BnDFunctions{
	
	public static void main(String[] args){
		//String input = "acp";
		final String fInput = "Errors in strategy cannot be correct through tactical maneuvers";
		System.out.println("Input of f: " + fInput);
		System.out.println("Output of f: " + f(fInput));

		final String gInput = "Hello there! Apple!";
		System.out.println("Input of g: " + gInput);
		System.out.println("Output of g: " + g(gInput));
		System.out.println();
	}
	
	//encodes a String
	//The encoding algorithm replaces every character in the string with the letter that 
	//has exactly the same position when counting backwards from letter “z” 
	//(with alphabet sort order in mind.)
	//Non-alphabet characters are ignored.
	//Ex: when string “acp” is encoded, the return value is string “zxk”
    public static String f(String s){
        if (s == null || s.length() == 0) return s;

        final String alpha = "abcdefghijklm";
        final String bet = "zyxwvutsrqpon";
        final int size = s.length();
        char[] chars = s.toCharArray();
        for (int i = 0; i < size; i++) {
            boolean isUpper = Character.isUpperCase(s.codePointAt(i)); 
            if (alpha.indexOf(s.toLowerCase().charAt(i)) == -1 
                    && bet.indexOf(s.toLowerCase().charAt(i)) == -1) continue;
            if (bet.indexOf(s.toLowerCase().charAt(i)) == -1) {
                //it's in alpha
                int index = alpha.indexOf(s.toLowerCase().charAt(i));
                if (isUpper)
                    chars[i] = bet.toUpperCase().charAt(index);
                else
                    chars[i] = bet.charAt(index);
            }
            else{
                //it's in bet
                int index = bet.indexOf(s.toLowerCase().charAt(i));
                if (isUpper)
                    chars[i] = alpha.toUpperCase().charAt(index);
                else
                    chars[i] = alpha.charAt(index);
            }
        }
        final StringBuilder sb = new StringBuilder();
        for (int j=0; j<chars.length; j++)
            sb.append(chars[j]);
        return sb.toString();
    }
    
    //returns the frequency of alphabet letters in a given string ignoring upper/lower case issues.
    public static String g(String s){
	    if (s == null || s.length() == 0) return s;
	    
        final Hashtable<String,Integer> hashtable = new Hashtable<>();
        final String alphabet = "abcdefghijklmopqrstuvwxyz";
        for (int i = 0; i < alphabet.length(); i++){
            hashtable.put(""+alphabet.charAt(i), 0);
        }

		//lower case everything first
        s = s.toLowerCase();
        for (int j = 0; j < s.length(); j++){
            if (alphabet.indexOf(s.charAt(j)) == -1) continue;

            int k = hashtable.get(""+s.charAt(j));
            k++;
            hashtable.remove(""+s.charAt(j));
            hashtable.put(""+s.charAt(j), k);
        }

        final StringBuilder result = new StringBuilder();
        result.append("{\n");
        for (int m = 0; m < alphabet.length(); m++){
            result.append(alphabet.charAt(m) + ":" + hashtable.get(""+alphabet.charAt(m)));
            if (m < alphabet.length()-1)
                result.append(",\n");
            else
                result.append("\n");
        }
        result.append("}");
        return result.toString();
    }
}
