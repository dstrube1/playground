//RomanNumerals in java
//DS 2012-06-01

import java.io.*;
//import java.math.*;
//import org.apache.commons.lang3.math.NumberUtils;

public class RomanNumerals {

	public static void main(String[] args) {
		
		InputStreamReader isr = new InputStreamReader(System.in);  
		BufferedReader br = new BufferedReader(isr);
		String input = "";

		System.out.println("Enter a non-zero integer (like 14) or a Roman number (like XIV): ");
		
		try{
			input = br.readLine();
		} catch (IOException e){
			System.out.println(e.getMessage());
		}
		if (input == ""){
			System.out.println("You entered nothing");
		}
//		if (NumberUtils.isNumber(input)){ 
//			System.out.println("you entered number: " + input);
		//registers as true for strings like 5.1 or 5.f
//		}
		int i = 0;
		try {
			i= Integer.parseInt(input); 
		}
		catch (NumberFormatException e){}
		if (i != 0){
			toRoman(i);
		}
		else if (input.equals("0")){
			System.out.println("Invalid input");
		}
		else{
			toArabic(input);
		}
		
		//wrap up
		try{
			br.close();
			isr.close();
		} catch (IOException e){
			System.out.println(e.getMessage());
		}
	}
	private static void toRoman(int i){
		//good test: 3109
		String roman = "";
		int original = i;
		boolean isNegative = false;
		if (i < 0){
			isNegative = true;
			i = Math.abs(i);
		}
		
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
		if (isNegative){
			roman = "-"+roman; 
		}
		System.out.println(original + " converted to Roman: " + roman);
	}
	private static void toArabic(String s){
		//good test: MCMDCDCXCLXLXIXVIVI
		
		String sLower = s.toLowerCase();
		char c = Character.UNASSIGNED; //'\u0000'; //null / empty char
		char next = Character.UNASSIGNED; 
		char prev = Character.UNASSIGNED;
		int total = 0;
		
		//first, make sure this is the string we're looking for
		for (int i = 0; i < s.length(); i++){
			c = sLower.charAt(i);
			if (c != 'i' && c != 'v' && c != 'x' && c != 'l' && c != 'c' && c != 'd' && c != 'm'){
				System.out.println("Not Roman: " + s);
				return;
            }
        }
		
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

		System.out.println(s + " converted to Arabic: " + total);
	}//end toArabic
	
}//end class

