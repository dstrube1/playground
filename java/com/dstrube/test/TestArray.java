package com.dstrube.test;

/*
commands to compile and run:
from ~/Projects/java
javac -d ~/Projects/java/bin com/dstrube/test/TestArray.java 
java -cp ~/Projects/java/bin com.dstrube.test.TestArray
*/

public class TestArray {
	public static void main(String[] args){

		int[] array = null;
		System.out.println("Testing null:" + stringOfArray(array));
		
		array = new int[] {};
		System.out.println("Testing empty:" + stringOfArray(array));		
		
		System.out.println("Testing vaid arrays:");		
		
		array = new int[] {0,1,2,3,8};
		System.out.println(stringOfArray(array));
		
		array = new int[]{3,4,8};
		System.out.println(stringOfArray(array));
		
		array = new int[]{1,5,8,10};
		System.out.println(stringOfArray(array));
		
		array = new int[]{3,4,5,6,1021,1022};
		System.out.println(stringOfArray(array));
		
  	}
  
//Given an arbitrarily large array of integers, return a string detailing an ordered range for that array.

//[0, 1, 2, 3, 8] -> “0-3, 8”
//[3, 4, 8] -> “3-4, 8”
//[1, 5, 8, 10] -> “1, 5, 8, 10”
//[3, 4, 5, 6, 1021, 1022] -> “3-6, 1021-1022”

private static String stringOfArray(final int[] array){
    if (array == null || array.length == 0) return "";
    
    String result = "";
    int index = 0;
    boolean inAdjacentLoop = false;
    
    while (index < array.length){
        int value = array[index];
        
        //we don't want to compare this element to the next element if there is no next element
        if (index + 1 < array.length){
            //compare this value to the next
            //if the value is adjacent, then continue to search for next
            if (array[index + 1] == value + 1){
                if (!inAdjacentLoop){
                    result += value + "-";
                }
                inAdjacentLoop = true;
            } 
            //else end of adjacency
            else {
                result += value + ", "; 
                inAdjacentLoop = false;
            }
            
        } else{
            //append this value to the string
             result += value;
        }
        index++;
    }
    
    return result;
}


}

