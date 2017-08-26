/*
From ~/java:

javac -d bin com/dstrube/line/Q3a.java
java -cp bin com.dstrube.line.Q3a

Imagine you are playing a board game. You roll a 6-faced dice and move forward the same
number of spaces that you rolled. If the finishing point is “n” spaces away from the starting
point, please implement a program that calculates how many possible ways are there to
arrive exactly at the finishing point.

If n=610, how many possible ways are there to arrive exactly at the finishing point?
*/

package com.dstrube.line;

//https://github.com/RaysonYeungHK/problem_solving/tree/master/ProblemSolving/src/com/codepicker/exercise/dice/gameboard

import java.math.BigInteger;
import java.util.LinkedList;

public class Q3a{

	private static final BigInteger[] PRE_CALCULATED_PROBABILITY = {
            BigInteger.valueOf(1)
            ,BigInteger.valueOf(2)
            ,BigInteger.valueOf(4)
            ,BigInteger.valueOf(8)
            ,BigInteger.valueOf(16)
            ,BigInteger.valueOf(32)
    };
    
    public BigInteger calculateRecursive(BigInteger number){
        if (number.compareTo(BigInteger.valueOf(0)) <= 0) {
            throw new IllegalArgumentException("number cannot be smaller than 1, found " + number);
        }

        if (number.compareTo(BigInteger.valueOf(6)) <= 0) {
            return PRE_CALCULATED_PROBABILITY[number.intValue()-1];
        }
        
        return calculateRecursive(number.subtract(BigInteger.valueOf(1)))
                .add(calculateRecursive(number.subtract(BigInteger.valueOf(2))))
                .add(calculateRecursive(number.subtract(BigInteger.valueOf(3))))
                .add(calculateRecursive(number.subtract(BigInteger.valueOf(4))))
                .add(calculateRecursive(number.subtract(BigInteger.valueOf(5))))
                .add(calculateRecursive(number.subtract(BigInteger.valueOf(6))));
    }
    
    public BigInteger calculateLoop(BigInteger number){
        if (number.compareTo(BigInteger.valueOf(0)) <= 0) {
            throw new IllegalArgumentException("number cannot be smaller than 1, found " + number);
        }

        if (number.compareTo(BigInteger.valueOf(6)) <= 0) {
            return PRE_CALCULATED_PROBABILITY[number.intValue()-1];
        }
        
        LinkedList<BigInteger> previousResult = new LinkedList<>();
        for( BigInteger probability :PRE_CALCULATED_PROBABILITY ){
            previousResult.add(probability);
        }
        
        for (BigInteger i = BigInteger.valueOf(7); i.compareTo(number) <= 0; i = i.add(BigInteger.valueOf(1))) {
            BigInteger current = BigInteger.ZERO;
            for (BigInteger reference : previousResult) {
                current = current.add(reference);
            }
            previousResult.poll();
            previousResult.add(current);
        }
        return previousResult.getLast();
    }

	public static void main(String[] args){
		try{
	        final int n = 3;

		}
		catch (Exception e){
			System.out.println("Exception: " + e);
		}
	}
	
}