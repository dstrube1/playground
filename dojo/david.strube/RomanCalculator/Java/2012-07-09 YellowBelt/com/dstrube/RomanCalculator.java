//RomanCalculator in java
//DS 2012-08-29

package com.dstrube;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

public class RomanCalculator {
	
	private static Map<String, String> _subtractions = new HashMap<String, String>(6);
	private static Map<String, String> _repeats = new HashMap<String, String>(6);
	private static String _numerals = "MDCLXVI";
	private static final boolean DEBUG = false;
	
	public static void main(String[] args) {
		setSubtractions();
		setRepeats();

		ArrayList<String> numerals = new ArrayList<String>();
		String total = "";
		
		numerals = getNumerals();

		System.out.println("Calculating total...");

		total = getNumeralTotal(numerals);
		
		for (int i = 0; i< numerals.size(); i++){
			System.out.print(numerals.get(i));
			if (i == numerals.size() - 1){
				System.out.println("=");	
			}
			else{
				System.out.print(" + ");
			}
		}
		
		//System.out.println(toRoman(total));
		System.out.println(total);
		
		if (DEBUG){
			System.out.println("Verifying...");
			if (verify(numerals, total)){
				System.out.println("Verified.");
			}
		}

	}

	private static void setSubtractions(){
		_subtractions.put("CM", "DCCCC");
		_subtractions.put("CD", "CCCC");
		_subtractions.put("XC", "LXXXX");
		_subtractions.put("XL", "XXXX");
		_subtractions.put("IX", "VIIII");
		_subtractions.put("IV", "IIII");
	}

	private static void setRepeats(){
		_repeats.put("DD", "M");
		_repeats.put("CCCCC", "D");
		_repeats.put("LL", "C");
		_repeats.put("XXXXX", "L");
		_repeats.put("VV", "X");
		_repeats.put("IIIII", "V");
	}

	private static ArrayList<String> getNumerals(){
		InputStreamReader isr = new InputStreamReader(System.in);  
		BufferedReader br = new BufferedReader(isr);
		String input = "";
		int i = 0;
		ArrayList<String> numerals = new ArrayList<String>();
		
		System.out.println("How many Roman numerals do you want to add?");
		
		try{
			input = br.readLine();
		} catch (IOException e){
			System.out.println(e.getMessage());
		}
		if (input == ""){
			System.out.println("You entered nothing.");
			try{
				br.close();
				isr.close();
			} catch (IOException e){
				System.out.println(e.getMessage());
			}
			return getNumerals();
		}
		try {
			i= Integer.parseInt(input); 
		}
		catch (NumberFormatException e){
			//System.out.println(e.getMessage());
		}
		
		if (i <= 0){ //-1, 0, whatever
			System.out.println("Invalid input.");
			try{
				br.close();
				isr.close();
			} catch (IOException e){
				System.out.println(e.getMessage());
			}
			return getNumerals();
		}
		

		for (int j=0; j < i; j++){
		
			System.out.println("Enter a Roman numeral: ");
			try{
				input = br.readLine();
			} catch (IOException e){
				System.out.println(e.getMessage());
			}
			if (!isRoman (input)){
				System.out.println("Invalid input. Please try again.");
				j--;
				continue;
			}
			numerals.add(input);
		}

		//wrap up
		try{
			br.close();
			isr.close();
		} catch (IOException e){
			System.out.println(e.getMessage());
		}
		
		return numerals;
	}

	public static boolean isRoman(String s){
		if (s == null || s.length() == 0){return false;}
		
		s = s.toUpperCase();
		//char c = Character.UNASSIGNED;
		for (int i = 0; i < s.length(); i++){
			//c = s.charAt(i);
			if (! _numerals.contains(s.substring(i,i+1))){ 
				//(c != 'i' && c != 'v' && c != 'x' && c != 'l' && c != 'c' && c != 'd' && c != 'm'){
				//System.out.println("Not Roman: " + s);
				return false;
            }
        }
		return true;
	}

	public static String getNumeralTotal(ArrayList<String> array){
		String total = "";
		if (array == null || array.size() == 0){
			return "";
		}
		
		if (array.size() == 1){
			return array.get(0);
		}
		
		String temp = "";
		for(int i=0; i<array.size(); i++){
			temp = array.get(i);
			
			if (!isRoman(temp)){
				//ignore invalids
				continue;
			}

			temp = removeSubtractions(temp);
			total += temp;
		}
		
		if (DEBUG){
			System.out.println("Sorting; before = " + total + " = " + toArabic(total));
		}
		total  = sortNumerals(total);
		if (DEBUG){
			System.out.println("After sorting, before collapse = " + total + " = " + toArabic(total));
		}
		total = collapseRepeats(total);
		if (DEBUG){
			System.out.println("After collapse, before apply subtractions = " + total + " = " + toArabic(total));
		}
		total = applySubtractions(total);
		return total;
	}

	private static String applySubtractions(String total) {
		if (total == null || total.length() == 0){
			return total;
		}
		
		//necessary for unit testing, apparently
		if (_subtractions.size()==0) setSubtractions();
		
		boolean replacementMade = false;
		
		do{
			replacementMade = false;
			Iterator<Entry<String, String>> it = _subtractions.entrySet().iterator();
		    while (it.hasNext()) {
		        Map.Entry<String, String> pairs = (Map.Entry<String, String>)it.next();
		        if (total.contains(pairs.getValue().toString())){
		        	total = total.replaceAll(pairs.getValue().toString(),pairs.getKey().toString());
		        	replacementMade = true;
		        }
		    }
		}while (replacementMade);
		return total;
	}

	private static String collapseRepeats(String total) {
		if (total == null || total.length() == 0){
			return total;
		}
		
		//necessary for unit testing, apparently
		if (_repeats.size()==0) setRepeats();
				
		Iterator<Entry<String, String>> it = _repeats.entrySet().iterator();
	    while (it.hasNext()) {
	        Map.Entry<String, String> pairs = (Map.Entry<String, String>)it.next();
	        if (total.contains(pairs.getKey().toString())){
	        	total = total.replaceAll(pairs.getKey().toString(), pairs.getValue().toString());
	        }
	    }
		return total;
	}

	private static String sortNumerals(String total) {
		if (total == null || total.length() == 0){
			return total;
		}
		StringBuilder sb = new StringBuilder();
		
		total = total.toUpperCase();
		for (int i = 0; i < _numerals.length(); i++){
			for (int j = 0; j < total.length(); j++){
				if (_numerals.charAt(i) == total.charAt(j)){
					sb.append(total.charAt(j));
				}
			}
			
        }
		return sb.toString();
	}

	private static String removeSubtractions(String temp) {
		if (temp == null || temp.length() == 0){
			return temp;
		}
		
		//necessary for unit testing, apparently
		if (_subtractions.size()==0) setSubtractions();
		
		Iterator<Entry<String, String>> it = _subtractions.entrySet().iterator();
	    while (it.hasNext()) {
	        Map.Entry<String, String> pairs = (Map.Entry<String, String>)it.next();
	        if (temp.contains(pairs.getKey().toString())){
	        	temp = temp.replace(pairs.getKey().toString(),pairs.getValue().toString());
	        }
	        
	    }
		return temp;
	}
	
	//Debug methods:
	private static boolean verify(ArrayList<String> numerals, String total) {
		//If we calculated correctly, keep it to yourself. If we didn't stand up and shout.
		if (numerals == null || numerals.size() == 0 || total == null || total.length() ==0){
			return false;
		}
		if (numerals.size() == 1){
			if (toArabic(numerals.get(0)) == toArabic(total)){
				////be quiet
			}else{
				System.out.println("Error in calculation!:");
				return false;
			}
		}
		
		int numericTotal = 0;
		for(int i=0; i<numerals.size(); i++){
			numericTotal += toArabic(numerals.get(i));
		}
		
		if (numericTotal == toArabic(total)){
			////be quiet
		}else{
			System.out.println("Error in calculation!");
			System.out.println(numericTotal +"!=" + toArabic(total));
			System.out.println("Correct answer is: " + toRoman(numericTotal));
			return false;
		}
		return true;
	}

	public static int toArabic(String s){
		//good test: MCMDCDCXCLXLXIXVIVI
		
		int total = 0;
		
		//first, make sure this is the string we're looking for
		if (s == null || s.length() ==0 || !isRoman(s) ){
			return total;
		}
				
		String sLower = s.toLowerCase();
		char c = Character.UNASSIGNED; //'\u0000'; //null / empty char
		char next = Character.UNASSIGNED; 
		char prev = Character.UNASSIGNED;

		
		
		//next, process it
		for (int j = 0; j < s.length(); j++){

			c = sLower.charAt(j);
			
			if (j < s.length() -1){
				next = sLower.charAt(j+1);
			}
			else{
				next = Character.UNASSIGNED; 
			}
			
			if (j > 0){
				prev = sLower.charAt(j-1);
			}
			else{
				prev = Character.UNASSIGNED; 
			}
			
			if (c == 'i'){
				if (next == 'v'){
					total += 4;
				}
				else{
                    if (next == 'x'){
                            total += 9;
                    }
                    else{
                            total += 1;
                    }
				}
				continue;
			}
			
			if (c == 'v'){
				if (prev != 'i'){
                    total += 5;
				} //else handled elsewhere
            	continue;
            }
			
			if (c == 'x')
            {
            if (prev != 'i'){
                    if (next == 'l'){
                    	total += 40;
                    }
                    else{
                            if (next == 'c'){
                            	total += 90;
                            }
                            else{
                            	total += 10;
                            }
                    }
            	}
            continue;
            }
			
			if (c == 'l'){
				if (prev != 'x'){
					total += 50;
				}//else handled elsewhere
				continue;
            }
            
			if (c == 'c'){
				if (prev != 'x'){
                    if (next == 'd'){
                    	total += 400;
                    }
                    else{
                            if (next == 'm'){
                            	total += 900;
                            }
                            else{
                            	total += 100;
                            }
                    }
				}
				continue;
            }

			if (c == 'd'){
				if (prev != 'c'){
					total += 500;
				}//else handled elsewhere
            continue;
            }
    
			if (c == 'm'){
				if (prev != 'c'){
					total += 1000;
				}//else handled elsewhere
            continue;
            }//end if (c == 'm')
		}//end 2nd for

		//System.out.println(s + " converted to Arabic: " + total);
		return total;
	}//end toArabic

	public static String toRoman(int i){
		String roman = "";
		
		while (i > 0){
			if (i >=1000){
				roman += "M";
				i -= 1000;
				continue;
			}
			if (i >= 900){
				roman += "CM";
				i -= 900;
				continue;
			}
			if (i >= 500){
				roman += "D";
				i -= 500;
				continue;
			}
			if (i >= 400){
				roman += "CD";
				i -= 400;
				continue;
			}
			if (i >= 100){
				roman += "C";
				i -= 100;
				continue;
			}
			if (i >= 90){
				roman += "XC";
				i -= 90;
				continue;
			}
			if (i >= 50){
				roman += "L";
				i -= 50;
				continue;
			}
			if (i >= 40){
				roman += "XL";
				i -= 40;
				continue;
			}
			if (i >= 10){
				roman += "X";
				i -= 10;
				continue;
			}
			if (i >= 9){
				roman += "IX";
				i -= 9;
				continue;
			}
			if (i >= 5){
				roman += "V";
				i -= 5;
				continue;
			}
			if (i >= 4){
				roman += "IV";
				i -= 4;
				continue;
			}
			if (i >= 1){
				roman += "I";
				i -= 1;
				continue;
			}
		}
//		if (isNegative){
//			roman = "-"+roman; 
//		}
		//System.out.println(original + " converted to Roman: " + roman);
		return roman;
	}
	
}
