//RomanCalculator2 in java
//DS 2012-07-10


package com.dstrube;

import java.util.ArrayList;

public class RomanCalculator2 {

	public static void main(String[] args) {
		if (args.length == 0) {
			System.out.println("Usage: RomanCalculator2 (Roman addend 1)+(Roman addend 2)[+Roman addend 3...]");
			//Example command line call:
			// \java\bin>java -cp . com.dstrube.RomanCalculator2 IX+I
			return;
		}
		String input = args[0]; //"I + I" = no good because that's arg0=I, arg1=+, arg2=I
		
		if (! isRoman(input)){
			System.out.println("Invalid numerals");
			return;
		}
		ArrayList<String> numerals = new ArrayList<String>();
		int total = 0;
		numerals = getNumerals(input);
		if (numerals == null || numerals.size() < 2){
			System.out.println("Invalid numerals");
			return;
		}
		System.out.println("Calculating total...");

		total = getNumeralTotal(numerals);
		if (total == 0){
			System.out.println("Invalid total");
			return;
		}

		printArray(numerals);
		System.out.println("= " + toRoman(total));
	}

	public static ArrayList<String> getNumerals(String input) {
		ArrayList<String> numerals = new ArrayList<String>();
		if (input == null || input.length()==0 || ! input.contains("+") || !isRoman(input)){
			return null;
		}
		//can't go this way:
//		String[] array = input.split("+");//this throws a runtime error: PatternSyntaxException; /p doesn't work either
//		for (int i=0; i < array.length; i++){
//			if (! isRoman(array[i])){
//				System.out.println("Invalid Roman addends");
//				return null;
//			}
//			numerals.add(array[i]);
//		}
		
		String numeral = "";
		while (input.contains("+")){
			numeral = input.substring(0, input.indexOf("+"));
			if (numeral.length() == 0){
				return null;
			}
			input = input.substring(input.indexOf("+")+1);
			numerals.add(numeral);
		}
		//add the last trailing addend
		if (input.length() > 0){ //this check catches sneaky attempts like "X+"
			numerals.add(input);
		}else{
			return null;
		}
		if (numerals.size() < 2){
			return null;
		}
		return numerals;
	}

	public static boolean isRoman(String s){
		if (s == null || s.length() == 0){return false;}
		
		s = s.toLowerCase();
		char c = Character.UNASSIGNED;
		for (int i = 0; i < s.length(); i++){
			c = s.charAt(i);
			if (c != 'i' && c != 'v' && c != 'x' && c != 'l' && c != 'c' && c != 'd' && c != 'm' && c != '+'){
				//System.out.println("Not Roman: " + s);
				return false;
            }
        }
		return true;
	}
	
	public static int getNumeralTotal(ArrayList<String> numerals) {
		int total = 0;
		if (numerals == null || numerals.size() == 0){
			return 0;
		}
		if (numerals.size() == 1){
			return toArabic(numerals.get(0));
		}
		
		for(int i=0; i<numerals.size(); i++){
			total += toArabic(numerals.get(i));
		}
		
		return total;
	}

	public static int toArabic(String s) {
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
	}

	private static void printArray(ArrayList<String> numerals){
		for (int i = 0; i< numerals.size(); i++){
			System.out.print(numerals.get(i));
			if (i == numerals.size() - 1){
				System.out.println(); //"=");	
			}
			else{
				System.out.print(" + ");
			}
		}
	}

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
