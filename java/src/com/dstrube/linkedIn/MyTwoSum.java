package com.dstrube.linkedIn;

/*
commands to compile and run:
from ~/workspace/java
javac -d C:\Users\Unbounded\workspace\java\bin com\dstrube\linkedIn\MyTwoSum.java 
java -cp C:\Users\Unbounded\workspace\java\bin com.dstrube.linkedIn.MyTwoSum
*/

import java.util.Hashtable;

public class MyTwoSum implements ITwoSum{
    Hashtable nums;
    
	public MyTwoSum(){
        nums = new Hashtable();
    }

    
    public void store(int input){
        int value = 1;
        if (nums.containsKey(input)){
            value = Integer.valueOf(nums.get(input).toString());
            value++;
            
        } 
        nums.put(input, value);
    }
    
    public boolean test(int val){
            for (int i = 0; i < nums.size(); i++){
                    int value = Integer.valueOf(nums.get(i).toString());
                    int looking4 = val - i;
                    if (nums.containsKey(looking4)) {
                        if (value == 1 && val == (i * 2)) continue;
                        return true;
                    }
            }
        return false;
    }
/*	
	public static void main(String[] args){
		store(0)
		store(1);
		store(2);
		store(3);

		test(4); // true
		test(5); // false
		test(2); // false
		store(1);
		test(2); // true

	}
*/
}